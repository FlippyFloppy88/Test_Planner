// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestStep _$TestStepFromJson(Map<String, dynamic> json) => _TestStep(
      id: json['id'] as String,
      order: (json['order'] as num?)?.toInt() ?? 1,
      name: json['name'] as String? ?? '',
      procedure: (json['procedure'] as List<dynamic>?)
              ?.map((e) => ProcedureItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      expectedResult: ExpectedResult.fromJson(
          json['expectedResult'] as Map<String, dynamic>),
      storyLink: json['storyLink'] as String? ?? '',
      subSteps: (json['subSteps'] as List<dynamic>?)
              ?.map((e) => TestStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TestStepToJson(_TestStep instance) => <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'name': instance.name,
      'procedure': instance.procedure,
      'expectedResult': instance.expectedResult,
      'storyLink': instance.storyLink,
      'subSteps': instance.subSteps,
    };
