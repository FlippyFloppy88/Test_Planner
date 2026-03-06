// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_run.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StepResultImpl _$$StepResultImplFromJson(Map<String, dynamic> json) =>
    _$StepResultImpl(
      stepId: json['stepId'] as String,
      stepName: json['stepName'] as String,
      testCaseId: json['testCaseId'] as String,
      testCaseName: json['testCaseName'] as String,
      status: $enumDecodeNullable(_$StepResultStatusEnumMap, json['status']) ??
          StepResultStatus.notRun,
      procedure: (json['procedure'] as List<dynamic>?)
              ?.map((e) => ProcedureItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      actualValue: json['actualValue'] as String?,
      actualPassFail: json['actualPassFail'] as bool?,
      failureDescription: json['failureDescription'] as String? ?? '',
      jiraBugLink: json['jiraBugLink'] as String? ?? '',
      bugRecordedInJira: json['bugRecordedInJira'] as bool? ?? false,
      storyLink: json['storyLink'] as String?,
      expectedResult: ExpectedResult.fromJson(
          json['expectedResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StepResultImplToJson(_$StepResultImpl instance) =>
    <String, dynamic>{
      'stepId': instance.stepId,
      'stepName': instance.stepName,
      'testCaseId': instance.testCaseId,
      'testCaseName': instance.testCaseName,
      'status': _$StepResultStatusEnumMap[instance.status]!,
      'procedure': instance.procedure,
      'actualValue': instance.actualValue,
      'actualPassFail': instance.actualPassFail,
      'failureDescription': instance.failureDescription,
      'jiraBugLink': instance.jiraBugLink,
      'bugRecordedInJira': instance.bugRecordedInJira,
      'storyLink': instance.storyLink,
      'expectedResult': instance.expectedResult,
    };

const _$StepResultStatusEnumMap = {
  StepResultStatus.notRun: 'notRun',
  StepResultStatus.passed: 'passed',
  StepResultStatus.failed: 'failed',
  StepResultStatus.skipped: 'skipped',
};

_$TestRunImpl _$$TestRunImplFromJson(Map<String, dynamic> json) =>
    _$TestRunImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      sourceType: json['sourceType'] as String? ?? 'test_plan',
      sourceName: json['sourceName'] as String,
      releaseVersion: json['releaseVersion'] as String?,
      executedAt: DateTime.parse(json['executedAt'] as String),
      stepResults: (json['stepResults'] as List<dynamic>?)
              ?.map((e) => StepResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isComplete: json['isComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$$TestRunImplToJson(_$TestRunImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sourceType': instance.sourceType,
      'sourceName': instance.sourceName,
      'releaseVersion': instance.releaseVersion,
      'executedAt': instance.executedAt.toIso8601String(),
      'stepResults': instance.stepResults,
      'isComplete': instance.isComplete,
    };
