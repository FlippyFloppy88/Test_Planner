// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleasePlanItemTestPlanRef _$ReleasePlanItemTestPlanRefFromJson(
        Map<String, dynamic> json) =>
    ReleasePlanItemTestPlanRef(
      id: json['id'] as String,
      testPlanId: json['testPlanId'] as String,
      testPlanName: json['testPlanName'] as String,
      order: (json['order'] as num?)?.toInt() ?? 0,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ReleasePlanItemTestPlanRefToJson(
        ReleasePlanItemTestPlanRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'testPlanId': instance.testPlanId,
      'testPlanName': instance.testPlanName,
      'order': instance.order,
      'runtimeType': instance.$type,
    };

ReleasePlanItemOneOff _$ReleasePlanItemOneOffFromJson(
        Map<String, dynamic> json) =>
    ReleasePlanItemOneOff(
      id: json['id'] as String,
      testCase: TestCase.fromJson(json['testCase'] as Map<String, dynamic>),
      order: (json['order'] as num?)?.toInt() ?? 0,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ReleasePlanItemOneOffToJson(
        ReleasePlanItemOneOff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'testCase': instance.testCase,
      'order': instance.order,
      'runtimeType': instance.$type,
    };

_ReleasePlan _$ReleasePlanFromJson(Map<String, dynamic> json) => _ReleasePlan(
      id: json['id'] as String,
      productName: json['productName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => ReleasePlanItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ReleasePlanToJson(_ReleasePlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'description': instance.description,
      'items': instance.items,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
