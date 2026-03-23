// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestPlan _$TestPlanFromJson(Map<String, dynamic> json) => _TestPlan(
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

Map<String, dynamic> _$TestPlanToJson(_TestPlan instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'testCases': instance.testCases,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
