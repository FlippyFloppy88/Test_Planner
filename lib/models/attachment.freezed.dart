// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Attachment {
  String get id;
  String get fileName;
  String get mimeType;

  /// Path relative to the storage folder root.
  String get filePath;

  /// Legacy base64 content (kept for back-compat; empty for new attachments).
  String get base64Content;
  String get description;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AttachmentCopyWith<Attachment> get copyWith =>
      _$AttachmentCopyWithImpl<Attachment>(this as Attachment, _$identity);

  /// Serializes this Attachment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Attachment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.base64Content, base64Content) ||
                other.base64Content == base64Content) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, fileName, mimeType, filePath,
      base64Content, description);

  @override
  String toString() {
    return 'Attachment(id: $id, fileName: $fileName, mimeType: $mimeType, filePath: $filePath, base64Content: $base64Content, description: $description)';
  }
}

/// @nodoc
abstract mixin class $AttachmentCopyWith<$Res> {
  factory $AttachmentCopyWith(
          Attachment value, $Res Function(Attachment) _then) =
      _$AttachmentCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String fileName,
      String mimeType,
      String filePath,
      String base64Content,
      String description});
}

/// @nodoc
class _$AttachmentCopyWithImpl<$Res> implements $AttachmentCopyWith<$Res> {
  _$AttachmentCopyWithImpl(this._self, this._then);

  final Attachment _self;
  final $Res Function(Attachment) _then;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fileName = null,
    Object? mimeType = null,
    Object? filePath = null,
    Object? base64Content = null,
    Object? description = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _self.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _self.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      base64Content: null == base64Content
          ? _self.base64Content
          : base64Content // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Attachment implements Attachment {
  const _Attachment(
      {required this.id,
      required this.fileName,
      required this.mimeType,
      this.filePath = '',
      this.base64Content = '',
      this.description = ''});
  factory _Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  @override
  final String id;
  @override
  final String fileName;
  @override
  final String mimeType;

  /// Path relative to the storage folder root.
  @override
  @JsonKey()
  final String filePath;

  /// Legacy base64 content (kept for back-compat; empty for new attachments).
  @override
  @JsonKey()
  final String base64Content;
  @override
  @JsonKey()
  final String description;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AttachmentCopyWith<_Attachment> get copyWith =>
      __$AttachmentCopyWithImpl<_Attachment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AttachmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Attachment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.base64Content, base64Content) ||
                other.base64Content == base64Content) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, fileName, mimeType, filePath,
      base64Content, description);

  @override
  String toString() {
    return 'Attachment(id: $id, fileName: $fileName, mimeType: $mimeType, filePath: $filePath, base64Content: $base64Content, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$AttachmentCopyWith<$Res>
    implements $AttachmentCopyWith<$Res> {
  factory _$AttachmentCopyWith(
          _Attachment value, $Res Function(_Attachment) _then) =
      __$AttachmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String fileName,
      String mimeType,
      String filePath,
      String base64Content,
      String description});
}

/// @nodoc
class __$AttachmentCopyWithImpl<$Res> implements _$AttachmentCopyWith<$Res> {
  __$AttachmentCopyWithImpl(this._self, this._then);

  final _Attachment _self;
  final $Res Function(_Attachment) _then;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? fileName = null,
    Object? mimeType = null,
    Object? filePath = null,
    Object? base64Content = null,
    Object? description = null,
  }) {
    return _then(_Attachment(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _self.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _self.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      base64Content: null == base64Content
          ? _self.base64Content
          : base64Content // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
