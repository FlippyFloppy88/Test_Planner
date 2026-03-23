import 'dart:typed_data';
import 'package:excel/excel.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../models/models.dart';

class ExcelService {
  static final _dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  /// Generates an Excel workbook for a completed TestRun.
  static Uint8List generateTestRunExcel(TestRun run) {
    final excel = Excel.createExcel();

    // ── Summary Sheet ─────────────────────────────────────────────────────
    final summarySheet = excel['Summary'];
    excel.setDefaultSheet('Summary');

    _writeHeader(summarySheet, ['Test Run Summary'], 0);
    _writeRow(summarySheet, ['Run Name', run.name], 1);
    _writeRow(
        summarySheet, ['Source', '${run.sourceType}: ${run.sourceName}'], 2);
    if (run.releaseVersion != null) {
      _writeRow(summarySheet, ['Release Version', run.releaseVersion!], 3);
    }
    _writeRow(
        summarySheet, ['Executed At', _dateFormat.format(run.executedAt)], 4);
    _writeRow(summarySheet, ['Total Steps', run.totalSteps.toString()], 5);
    _writeRow(
        summarySheet, ['Steps Run', '${run.runSteps} / ${run.totalSteps}'], 6);
    _writeRow(summarySheet, ['Passed', run.passedSteps.toString()], 7);
    _writeRow(summarySheet, ['Failed', run.failedSteps.toString()], 8);
    _writeRow(summarySheet, ['Skipped', run.skippedSteps.toString()], 9);

    final passRate = run.runSteps > 0
        ? (run.passedSteps / run.runSteps * 100).toStringAsFixed(1)
        : 'N/A';
    _writeRow(summarySheet, ['Pass Rate', '$passRate%'], 10);

    // Jira bugs created
    int row = 12;
    _writeHeader(summarySheet, ['Jira Bugs Created / Referenced'], row++);
    if (run.uniqueJiraBugs.isEmpty) {
      _writeRow(summarySheet, ['None'], row++);
    } else {
      for (final bug in run.uniqueJiraBugs) {
        _writeRow(summarySheet, [bug], row++);
      }
    }

    // Failed steps
    row++;
    _writeHeader(summarySheet, ['Failed Steps'], row++);
    _writeRow(
        summarySheet,
        [
          'Test Case',
          'Step Name',
          'Expected',
          'Actual',
          'Failure Description',
          'Jira Bug',
          'Bug Recorded'
        ],
        row++);
    for (final f in run.failures) {
      _writeRow(
          summarySheet,
          [
            f.testCaseName,
            f.stepName,
            f.expectedResult.description,
            _formatActual(f),
            f.failureDescription,
            f.jiraBugLink,
            f.bugRecordedInJira ? 'Yes' : 'No',
          ],
          row++);
    }

    // ── Step Results Sheet ────────────────────────────────────────────────
    final stepsSheet = excel['Step Results'];
    _writeRow(
        stepsSheet,
        [
          'Test Case',
          'Step Name',
          'Status',
          'Answer Type',
          'Expected',
          'Min',
          'Max',
          'Actual Value',
          'Pass/Fail',
          'Failure Description',
          'Story Link',
          'Jira Bug Link',
          'Bug Recorded',
        ],
        0);

    for (int i = 0; i < run.stepResults.length; i++) {
      final r = run.stepResults[i];
      _writeRow(
          stepsSheet,
          [
            r.testCaseName,
            r.stepName,
            r.status.name,
            r.expectedResult.answerType.name,
            r.expectedResult.description,
            r.expectedResult.minValue?.toString() ?? '',
            r.expectedResult.maxValue?.toString() ?? '',
            r.actualValue ?? '',
            r.actualPassFail != null
                ? (r.actualPassFail! ? 'Pass' : 'Fail')
                : '',
            r.failureDescription,
            r.storyLink ?? '',
            r.jiraBugLink,
            r.bugRecordedInJira ? 'Yes' : 'No',
          ],
          i + 1);
    }

    // Widen columns
    _autoWidth(summarySheet);
    _autoWidth(stepsSheet);

    final bytes = excel.encode();
    return Uint8List.fromList(bytes!);
  }

  /// Parses a previously exported Excel file back into a TestRun summary.
  static TestRun? parseTestRunExcel(Uint8List bytes) {
    try {
      final excel = Excel.decodeBytes(bytes);
      final sheet = excel['Summary'];

      String runName = '';
      String sourceName = '';
      String sourceType = 'test_plan';
      String? releaseVersion;
      DateTime executedAt = DateTime.now();

      for (final row in sheet.rows.skip(1)) {
        if (row.isEmpty) continue;
        final label = row[0]?.value?.toString() ?? '';
        final value = row[1]?.value?.toString() ?? '';
        switch (label) {
          case 'Run Name':
            runName = value;
          case 'Source':
            final parts = value.split(': ');
            if (parts.length == 2) {
              sourceType = parts[0];
              sourceName = parts[1];
            }
          case 'Release Version':
            releaseVersion = value;
          case 'Executed At':
            try {
              executedAt = DateFormat('yyyy-MM-dd HH:mm').parse(value);
            } catch (_) {}
        }
      }

      // Parse step results
      final stepsSheet = excel['Step Results'];
      final stepResults = <StepResult>[];
      for (final row in stepsSheet.rows.skip(1)) {
        if (row.isEmpty || (row[0]?.value == null)) continue;
        final statusStr = row[2]?.value?.toString() ?? 'notRun';
        final answerTypeStr = row[3]?.value?.toString() ?? 'none';
        final sr = StepResult(
          stepId: '',
          stepName: row[1]?.value?.toString() ?? '',
          testCaseId: '',
          testCaseName: row[0]?.value?.toString() ?? '',
          status: StepResultStatus.values.firstWhere(
            (s) => s.name == statusStr,
            orElse: () => StepResultStatus.notRun,
          ),
          actualValue: row[7]?.value?.toString(),
          failureDescription: row[9]?.value?.toString() ?? '',
          storyLink: row[10]?.value?.toString(),
          jiraBugLink: row[11]?.value?.toString() ?? '',
          bugRecordedInJira: row[12]?.value?.toString() == 'Yes',
          expectedResult: ExpectedResult(
            description: row[4]?.value?.toString() ?? '',
            answerType: AnswerType.values.firstWhere(
              (a) => a.name == answerTypeStr,
              orElse: () => AnswerType.none,
            ),
            minValue: double.tryParse(row[5]?.value?.toString() ?? ''),
            maxValue: double.tryParse(row[6]?.value?.toString() ?? ''),
          ),
        );
        stepResults.add(sr);
      }
    
      return TestRun(
        id: 'imported_${DateTime.now().millisecondsSinceEpoch}',
        name: runName,
        sourceType: sourceType,
        sourceName: sourceName,
        releaseVersion: releaseVersion,
        executedAt: executedAt,
        stepResults: stepResults,
        isComplete: true,
      );
    } catch (e) {
      return null;
    }
  }

  static void _writeHeader(Sheet sheet, List<String> values, int rowIndex) {
    for (int col = 0; col < values.length; col++) {
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
      );
      cell.value = TextCellValue(values[col]);
      cell.cellStyle = CellStyle(bold: true);
    }
  }

  static void _writeRow(Sheet sheet, List<String> values, int rowIndex) {
    for (int col = 0; col < values.length; col++) {
      sheet
          .cell(
              CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex))
          .value = TextCellValue(values[col]);
    }
  }

  static void _autoWidth(Sheet sheet) {
    for (int col = 0; col < 15; col++) {
      sheet.setColumnWidth(col, 25);
    }
  }

  static String _formatActual(StepResult r) {
    if (r.actualValue != null) return r.actualValue!;
    if (r.actualPassFail != null) return r.actualPassFail! ? 'Pass' : 'Fail';
    return '';
  }
}
