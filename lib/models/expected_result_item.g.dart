// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expected_result_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpectedResultItem _$ExpectedResultItemFromJson(Map<String, dynamic> json) =>
    _ExpectedResultItem(
      id: json['id'] as String,
      order: (json['order'] as num?)?.toInt() ?? 0,
      observation: json['observation'] as String? ?? '',
      answerType:
          $enumDecodeNullable(_$AnswerTypeEnumMap, json['answerType']) ??
              AnswerType.none,
      minValue: (json['minValue'] as num?)?.toDouble(),
      maxValue: (json['maxValue'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExpectedResultItemToJson(_ExpectedResultItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'observation': instance.observation,
      'answerType': _$AnswerTypeEnumMap[instance.answerType]!,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'unit': instance.unit,
      'attachments': instance.attachments,
    };

const _$AnswerTypeEnumMap = {
  AnswerType.none: 'none',
  AnswerType.passFail: 'passFail',
  AnswerType.value: 'value',
};
