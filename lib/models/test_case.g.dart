// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_case.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestCaseImpl _$$TestCaseImplFromJson(Map<String, dynamic> json) =>
    _$TestCaseImpl(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      preconditions: (json['preconditions'] as List<dynamic>?)
              ?.map((e) => ProcedureItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      jiraLinks: (json['jiraLinks'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) => TestStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TestCaseImplToJson(_$TestCaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'preconditions': instance.preconditions,
      'jiraLinks': instance.jiraLinks,
      'steps': instance.steps,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
