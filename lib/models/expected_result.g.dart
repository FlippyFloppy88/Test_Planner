// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expected_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpectedResultImpl _$$ExpectedResultImplFromJson(Map<String, dynamic> json) =>
    _$ExpectedResultImpl(
      description: json['description'] as String? ?? '',
      answerType:
          $enumDecodeNullable(_$AnswerTypeEnumMap, json['answerType']) ??
              AnswerType.none,
      minValue: (json['minValue'] as num?)?.toDouble(),
      maxValue: (json['maxValue'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$$ExpectedResultImplToJson(
        _$ExpectedResultImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'answerType': _$AnswerTypeEnumMap[instance.answerType]!,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'unit': instance.unit,
    };

const _$AnswerTypeEnumMap = {
  AnswerType.none: 'none',
  AnswerType.passFail: 'passFail',
  AnswerType.value: 'value',
};
