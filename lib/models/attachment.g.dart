// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttachmentImpl _$$AttachmentImplFromJson(Map<String, dynamic> json) =>
    _$AttachmentImpl(
      id: json['id'] as String,
      fileName: json['fileName'] as String,
      mimeType: json['mimeType'] as String,
      filePath: json['filePath'] as String? ?? '',
      base64Content: json['base64Content'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$AttachmentImplToJson(_$AttachmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'mimeType': instance.mimeType,
      'filePath': instance.filePath,
      'base64Content': instance.base64Content,
      'description': instance.description,
    };
