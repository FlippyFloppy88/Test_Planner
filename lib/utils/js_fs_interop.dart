import 'dart:async';
import 'dart:js_interop';

/// Dart bindings for the JS File System Access API helpers
/// defined in web/index.html.

@JS('pickDataFolder')
external JSPromise<JSAny?> _jsPickDataFolder();

@JS('getDataFolderName')
external JSString? _jsGetDataFolderName();

@JS('writeFolderFile')
external JSPromise<JSBoolean> _jsWriteFolderFile(
    JSString fileName, JSString content);

@JS('readFolderFile')
external JSPromise<JSAny?> _jsReadFolderFile(JSString fileName);

@JS('writeFolderFileBytes')
external JSPromise<JSBoolean> _jsWriteFolderFileBytes(
    JSString fileName, JSString base64);

@JS('downloadBytes')
external void _jsDownloadBytes(JSString base64, JSString fileName);

// ─────────────────────────────────────────────────────────────────────────────

/// Opens the native folder picker. Returns the folder name, or null on cancel.
Future<String?> pickDataFolder() async {
  final result = await _jsPickDataFolder().toDart;
  if (result == null) return null;
  return (result as JSString).toDart;
}

/// Returns the name of the currently held directory handle (or null).
String? getDataFolderName() {
  return _jsGetDataFolderName()?.toDart;
}

/// Writes [content] as a text file named [fileName] to the selected folder.
/// Returns true on success.
Future<bool> writeFolderFile(String fileName, String content) async {
  final ok = await _jsWriteFolderFile(fileName.toJS, content.toJS).toDart;
  return ok.toDart;
}

/// Reads a text file named [fileName] from the selected folder.
/// Returns null if the file doesn't exist or no folder is selected.
Future<String?> readFolderFile(String fileName) async {
  final result = await _jsReadFolderFile(fileName.toJS).toDart;
  if (result == null) return null;
  return (result as JSString).toDart;
}

/// Writes binary bytes (as base64) to a file in the selected folder.
Future<bool> writeFolderFileBytes(String fileName, String base64) async {
  final ok = await _jsWriteFolderFileBytes(fileName.toJS, base64.toJS).toDart;
  return ok.toDart;
}

/// Triggers a browser download (used as fallback when no folder is selected).
void downloadBytes(String base64, String fileName) {
  _jsDownloadBytes(base64.toJS, fileName.toJS);
}
