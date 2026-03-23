// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procedure_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProcedureItem _$ProcedureItemFromJson(Map<String, dynamic> json) =>
    _ProcedureItem(
      id: json['id'] as String,
      order: (json['order'] as num?)?.toInt() ?? 0,
      text: json['text'] as String? ?? '',
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProcedureItemToJson(_ProcedureItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'text': instance.text,
      'attachments': instance.attachments,
    };
