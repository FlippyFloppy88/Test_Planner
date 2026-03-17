import 'dart:convert' show jsonDecode, jsonEncode, utf8;
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import 'excel_service.dart';

/// Manages all data persistence.
///
/// The user selects a local folder via [pickFolder]. All data is read from
/// and written to JSON files inside that folder:
///   test_plans.json, release_plans.json, test_runs.json
///
/// The folder path is remembered across sessions in SharedPreferences.
/// SharedPreferences is also used as an in-memory fallback when no folder
/// has been selected yet.
class StorageService {
  static const _prefKeyFolder = 'data_folder_path';
  static const _prefKeyBookmark = 'data_folder_bookmark';
  static const _prefKeyTestPlans = 'test_plans';
  static const _prefKeyReleasePlans = 'release_plans';
  static const _prefKeyTestRuns = 'test_runs';

  static const _fileTestPlans = 'test_plans.json';
  static const _fileReleasePlans = 'release_plans.json';
  static const _fileTestRuns = 'test_runs.json';

  // Only initialised on macOS; null on other platforms.
  final SecureBookmarks? _bookmarks =
      Platform.isMacOS ? SecureBookmarks() : null;
  SharedPreferences? _prefs;
  String _folderPath = '';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    // macOS: restore sandbox access via a security-scoped bookmark.
    // Windows/Linux: the plain path in SharedPreferences is sufficient.
    if (Platform.isMacOS) {
      final bookmarkStr = _prefs?.getString(_prefKeyBookmark);
      if (bookmarkStr != null) {
        try {
          final resolved = await _bookmarks!
              .resolveBookmark(bookmarkStr, isDirectory: true);
          await _bookmarks.startAccessingSecurityScopedResource(resolved);
          _folderPath = resolved.path;
          dev.log('[StorageService] init() restored via bookmark: $_folderPath');
          return;
        } catch (e) {
          dev.log('[StorageService] bookmark restore failed: $e — falling back to path');
        }
      }
    }

    // Fall back to plain path (Windows, Linux, or first macOS launch).
    _folderPath = _prefs?.getString(_prefKeyFolder) ?? '';
    dev.log('[StorageService] init() path: "$_folderPath"');
  }

  // ── Folder ─────────────────────────────────────────────────────────────────

  String get folderPath =>
      _folderPath.isNotEmpty ? _folderPath : 'No folder selected';

  bool get hasFolderOpen => _folderPath.isNotEmpty;

  /// Opens the native macOS folder picker.
  /// Returns the selected path, or null if cancelled.
  Future<String?> pickFolder() async {
    final result = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select data folder for Test Planner',
    );
    if (result != null) {
      _folderPath = result;
      await _prefs?.setString(_prefKeyFolder, result);

      // macOS only: create a security-scoped bookmark so sandbox access
      // persists across app launches. Not needed on Windows/Linux.
      if (Platform.isMacOS) {
        try {
          final bookmarkStr = await _bookmarks!.bookmark(Directory(result));
          await _prefs?.setString(_prefKeyBookmark, bookmarkStr);
          dev.log('[StorageService] bookmark created for $result');
        } catch (e) {
          dev.log('[StorageService] bookmark creation failed: $e');
        }
      }

      await _syncPrefsToFolder();
    }
    return result;
  }

  /// After a new folder is chosen, write any prefs-cached data into it so
  /// existing data is immediately available from the new location.
  Future<void> _syncPrefsToFolder() async {
    for (final entry in {
      _prefKeyTestPlans: _fileTestPlans,
      _prefKeyReleasePlans: _fileReleasePlans,
      _prefKeyTestRuns: _fileTestRuns,
    }.entries) {
      final raw = _prefs?.getString(entry.key);
      if (raw != null && raw.isNotEmpty) {
        await _writeFile(entry.value, raw);
      }
    }
  }

  // ── Read / Write helpers ───────────────────────────────────────────────────

  Future<String?> _readFile(String fileName) async {
    if (!hasFolderOpen) return null;
    final file = File(p.join(_folderPath, fileName));
    if (!await file.exists()) return null;
    return file.readAsString();
  }

  Future<void> _writeFile(String fileName, String content) async {
    if (!hasFolderOpen) {
      dev.log(
          '[StorageService] _writeFile skipped — no folder open (fileName=$fileName)');
      return;
    }
    final dir = Directory(_folderPath);
    if (!await dir.exists()) await dir.create(recursive: true);
    final path = p.join(_folderPath, fileName);
    dev.log('[StorageService] writing $path (${content.length} bytes)');
    await File(path).writeAsString(content);
  }

  Future<String?> _read(String prefKey, String fileName) async {
    // Folder file takes priority; fall back to SharedPreferences.
    final fromFile = await _readFile(fileName);
    if (fromFile != null) return fromFile;
    return _prefs?.getString(prefKey);
  }

  Future<void> _write(String prefKey, String fileName, String json) async {
    // Write to SharedPreferences always (session backup).
    await _prefs?.setString(prefKey, json);
    // Write to folder file when one is open.
    await _writeFile(fileName, json);
  }

  // ── Test Plans ──────────────────────────────────────────────────────────────

  Future<List<TestPlan>> loadTestPlans() async {
    final raw = await _read(_prefKeyTestPlans, _fileTestPlans);
    if (raw == null || raw.isEmpty) return [];
    return (jsonDecode(raw) as List)
        .map((e) => TestPlan.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveTestPlans(List<TestPlan> plans) async {
    await _write(_prefKeyTestPlans, _fileTestPlans,
        jsonEncode(plans.map((p) => p.toJson()).toList()));
  }

  // ── Release Plans ───────────────────────────────────────────────────────────

  Future<List<ReleasePlan>> loadReleasePlans() async {
    final raw = await _read(_prefKeyReleasePlans, _fileReleasePlans);
    if (raw == null || raw.isEmpty) return [];
    return (jsonDecode(raw) as List)
        .map((e) => ReleasePlan.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveReleasePlans(List<ReleasePlan> plans) async {
    await _write(_prefKeyReleasePlans, _fileReleasePlans,
        jsonEncode(plans.map((p) => p.toJson()).toList()));
  }

  // ── Test Runs ───────────────────────────────────────────────────────────────

  Future<List<TestRun>> loadTestRuns() async {
    final raw = await _read(_prefKeyTestRuns, _fileTestRuns);
    if (raw == null || raw.isEmpty) return [];
    return (jsonDecode(raw) as List)
        .map((e) => TestRun.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveTestRuns(List<TestRun> runs) async {
    await _write(_prefKeyTestRuns, _fileTestRuns,
        jsonEncode(runs.map((r) => r.toJson()).toList()));
  }

  // ── Excel Export ─────────────────────────────────────────────────────────────

  Future<void> exportTestRunToExcel(TestRun run) async {
    final bytes = ExcelService.generateTestRunExcel(run);
    final fileName = '${run.name}.xlsx';
    if (hasFolderOpen) {
      final file = File(p.join(_folderPath, fileName));
      await file.writeAsBytes(bytes);
    } else {
      // Prompt user to save via file picker
      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Excel export',
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );
      if (savePath != null) {
        await File(savePath).writeAsBytes(bytes);
      }
    }
  }

  // ── Excel Import ─────────────────────────────────────────────────────────────

  Future<TestRun?> importTestRunFromExcel() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      withData: true,
    );
    if (result == null || result.files.single.bytes == null) return null;
    return ExcelService.parseTestRunExcel(result.files.single.bytes!);
  }

  // ── JSON Bundle Export/Import ─────────────────────────────────────────────────

  Future<void> exportBundle({
    required List<TestPlan> testPlans,
    required List<ReleasePlan> releasePlans,
    required List<TestRun> testRuns,
  }) async {
    final bundle = jsonEncode({
      'testPlans': testPlans.map((p) => p.toJson()).toList(),
      'releasePlans': releasePlans.map((p) => p.toJson()).toList(),
      'testRuns': testRuns.map((r) => r.toJson()).toList(),
    });
    const fileName = 'test_data_backup.json';
    if (hasFolderOpen) {
      await _writeFile(fileName, bundle);
    } else {
      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save data backup',
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      if (savePath != null) {
        await File(savePath).writeAsString(bundle);
      }
    }
  }

  Future<void> importBundle() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );
    if (result == null || result.files.single.bytes == null) return;
    final bundle = jsonDecode(utf8.decode(result.files.single.bytes!))
        as Map<String, dynamic>;
    await saveTestPlans((bundle['testPlans'] as List)
        .map((e) => TestPlan.fromJson(e as Map<String, dynamic>))
        .toList());
    await saveReleasePlans((bundle['releasePlans'] as List)
        .map((e) => ReleasePlan.fromJson(e as Map<String, dynamic>))
        .toList());
    await saveTestRuns((bundle['testRuns'] as List)
        .map((e) => TestRun.fromJson(e as Map<String, dynamic>))
        .toList());
  }

  /// Delete a folder under the storage root given its relative path.
  Future<void> deleteRelativeFolder(String relativePath) async {
    if (!hasFolderOpen) return;
    final dir = Directory(p.join(_folderPath, relativePath));
    if (await dir.exists()) {
      await dir.delete(recursive: true);
      dev.log('[StorageService] deleted folder: ${dir.path}');
    }
  }

  /// Delete a file under the storage root if it exists.
  Future<void> deleteFileIfExists(String relativeFilePath) async {
    if (!hasFolderOpen) return;
    final file = File(p.join(_folderPath, relativeFilePath));
    if (await file.exists()) {
      await file.delete();
      dev.log('[StorageService] deleted file: ${file.path}');
    }
  }
}
