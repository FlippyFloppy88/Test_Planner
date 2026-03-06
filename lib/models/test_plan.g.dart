// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestPlanImpl _$$TestPlanImplFromJson(Map<String, dynamic> json) =>
    _$TestPlanImpl(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      testCases: (json['testCases'] as List<dynamic>?)
              ?.map((e) => TestCase.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TestPlanImplToJson(_$TestPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'testCases': instance.testCases,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
