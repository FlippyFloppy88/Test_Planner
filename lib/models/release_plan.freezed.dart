// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'release_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReleasePlanItem _$ReleasePlanItemFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'testPlanRef':
      return ReleasePlanItemTestPlanRef.fromJson(json);
    case 'oneOff':
      return ReleasePlanItemOneOff.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ReleasePlanItem',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ReleasePlanItem {
  String get id => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String testPlanId, String testPlanName, int order)
        testPlanRef,
    required TResult Function(String id, TestCase testCase, int order) oneOff,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String testPlanId, String testPlanName, int order)?
        testPlanRef,
    TResult? Function(String id, TestCase testCase, int order)? oneOff,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id, String testPlanId, String testPlanName, int order)?
        testPlanRef,
    TResult Function(String id, TestCase testCase, int order)? oneOff,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ReleasePlanItemTestPlanRef value) testPlanRef,
    required TResult Function(ReleasePlanItemOneOff value) oneOff,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReleasePlanItemTestPlanRef value)? testPlanRef,
    TResult? Function(ReleasePlanItemOneOff value)? oneOff,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReleasePlanItemTestPlanRef value)? testPlanRef,
    TResult Function(ReleasePlanItemOneOff value)? oneOff,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ReleasePlanItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReleasePlanItemCopyWith<ReleasePlanItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReleasePlanItemCopyWith<$Res> {
  factory $ReleasePlanItemCopyWith(
          ReleasePlanItem value, $Res Function(ReleasePlanItem) then) =
      _$ReleasePlanItemCopyWithImpl<$Res, ReleasePlanItem>;
  @useResult
  $Res call({String id, int order});
}

/// @nodoc
class _$ReleasePlanItemCopyWithImpl<$Res, $Val extends ReleasePlanItem>
    implements $ReleasePlanItemCopyWith<$Res> {
  _$ReleasePlanItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReleasePlanItemTestPlanRefImplCopyWith<$Res>
    implements $ReleasePlanItemCopyWith<$Res> {
  factory _$$ReleasePlanItemTestPlanRefImplCopyWith(
          _$ReleasePlanItemTestPlanRefImpl value,
          $Res Function(_$ReleasePlanItemTestPlanRefImpl) then) =
      __$$ReleasePlanItemTestPlanRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String testPlanId, String testPlanName, int order});
}

/// @nodoc
class __$$ReleasePlanItemTestPlanRefImplCopyWithImpl<$Res>
    extends _$ReleasePlanItemCopyWithImpl<$Res,
        _$ReleasePlanItemTestPlanRefImpl>
    implements _$$ReleasePlanItemTestPlanRefImplCopyWith<$Res> {
  __$$ReleasePlanItemTestPlanRefImplCopyWithImpl(
      _$ReleasePlanItemTestPlanRefImpl _value,
      $Res Function(_$ReleasePlanItemTestPlanRefImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? testPlanId = null,
    Object? testPlanName = null,
    Object? order = null,
  }) {
    return _then(_$ReleasePlanItemTestPlanRefImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      testPlanId: null == testPlanId
          ? _value.testPlanId
          : testPlanId // ignore: cast_nullable_to_non_nullable
              as String,
      testPlanName: null == testPlanName
          ? _value.testPlanName
          : testPlanName // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReleasePlanItemTestPlanRefImpl implements ReleasePlanItemTestPlanRef {
  const _$ReleasePlanItemTestPlanRefImpl(
      {required this.id,
      required this.testPlanId,
      required this.testPlanName,
      this.order = 0,
      final String? $type})
      : $type = $type ?? 'testPlanRef';

  factory _$ReleasePlanItemTestPlanRefImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReleasePlanItemTestPlanRefImplFromJson(json);

  @override
  final String id;
  @override
  final String testPlanId;
  @override
  final String testPlanName;
  @override
  @JsonKey()
  final int order;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReleasePlanItem.testPlanRef(id: $id, testPlanId: $testPlanId, testPlanName: $testPlanName, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReleasePlanItemTestPlanRefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.testPlanId, testPlanId) ||
                other.testPlanId == testPlanId) &&
            (identical(other.testPlanName, testPlanName) ||
                other.testPlanName == testPlanName) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, testPlanId, testPlanName, order);

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReleasePlanItemTestPlanRefImplCopyWith<_$ReleasePlanItemTestPlanRefImpl>
      get copyWith => __$$ReleasePlanItemTestPlanRefImplCopyWithImpl<
          _$ReleasePlanItemTestPlanRefImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String testPlanId, String testPlanName, int order)
        testPlanRef,
    required TResult Function(String id, TestCase testCase, int order) oneOff,
  }) {
    return testPlanRef(id, testPlanId, testPlanName, order);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String testPlanId, String testPlanName, int order)?
        testPlanRef,
    TResult? Function(String id, TestCase testCase, int order)? oneOff,
  }) {
    return testPlanRef?.call(id, testPlanId, testPlanName, order);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id, String testPlanId, String testPlanName, int order)?
        testPlanRef,
    TResult Function(String id, TestCase testCase, int order)? oneOff,
    required TResult orElse(),
  }) {
    if (testPlanRef != null) {
      return testPlanRef(id, testPlanId, testPlanName, order);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ReleasePlanItemTestPlanRef value) testPlanRef,
    required TResult Function(ReleasePlanItemOneOff value) oneOff,
  }) {
    return testPlanRef(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReleasePlanItemTestPlanRef value)? testPlanRef,
    TResult? Function(ReleasePlanItemOneOff value)? oneOff,
  }) {
    return testPlanRef?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReleasePlanItemTestPlanRef value)? testPlanRef,
    TResult Function(ReleasePlanItemOneOff value)? oneOff,
    required TResult orElse(),
  }) {
    if (testPlanRef != null) {
      return testPlanRef(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ReleasePlanItemTestPlanRefImplToJson(
      this,
    );
  }
}

abstract class ReleasePlanItemTestPlanRef implements ReleasePlanItem {
  const factory ReleasePlanItemTestPlanRef(
      {required final String id,
      required final String testPlanId,
      required final String testPlanName,
      final int order}) = _$ReleasePlanItemTestPlanRefImpl;

  factory ReleasePlanItemTestPlanRef.fromJson(Map<String, dynamic> json) =
      _$ReleasePlanItemTestPlanRefImpl.fromJson;

  @override
  String get id;
  String get testPlanId;
  String get testPlanName;
  @override
  int get order;

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReleasePlanItemTestPlanRefImplCopyWith<_$ReleasePlanItemTestPlanRefImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReleasePlanItemOneOffImplCopyWith<$Res>
    implements $ReleasePlanItemCopyWith<$Res> {
  factory _$$ReleasePlanItemOneOffImplCopyWith(
          _$ReleasePlanItemOneOffImpl value,
          $Res Function(_$ReleasePlanItemOneOffImpl) then) =
      __$$ReleasePlanItemOneOffImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, TestCase testCase, int order});

  $TestCaseCopyWith<$Res> get testCase;
}

/// @nodoc
class __$$ReleasePlanItemOneOffImplCopyWithImpl<$Res>
    extends _$ReleasePlanItemCopyWithImpl<$Res, _$ReleasePlanItemOneOffImpl>
    implements _$$ReleasePlanItemOneOffImplCopyWith<$Res> {
  __$$ReleasePlanItemOneOffImplCopyWithImpl(_$ReleasePlanItemOneOffImpl _value,
      $Res Function(_$ReleasePlanItemOneOffImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? testCase = null,
    Object? order = null,
  }) {
    return _then(_$ReleasePlanItemOneOffImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      testCase: null == testCase
          ? _value.testCase
          : testCase // ignore: cast_nullable_to_non_nullable
              as TestCase,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TestCaseCopyWith<$Res> get testCase {
    return $TestCaseCopyWith<$Res>(_value.testCase, (value) {
      return _then(_value.copyWith(testCase: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ReleasePlanItemOneOffImpl implements ReleasePlanItemOneOff {
  const _$ReleasePlanItemOneOffImpl(
      {required this.id,
      required this.testCase,
      this.order = 0,
      final String? $type})
      : $type = $type ?? 'oneOff';

  factory _$ReleasePlanItemOneOffImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReleasePlanItemOneOffImplFromJson(json);

  @override
  final String id;
  @override
  final TestCase testCase;
  @override
  @JsonKey()
  final int order;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ReleasePlanItem.oneOff(id: $id, testCase: $testCase, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReleasePlanItemOneOffImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.testCase, testCase) ||
                other.testCase == testCase) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, testCase, order);

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReleasePlanItemOneOffImplCopyWith<_$ReleasePlanItemOneOffImpl>
      get copyWith => __$$ReleasePlanItemOneOffImplCopyWithImpl<
          _$ReleasePlanItemOneOffImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String testPlanId, String testPlanName, int order)
        testPlanRef,
    required TResult Function(String id, TestCase testCase, int order) oneOff,
  }) {
    return oneOff(id, testCase, order);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id, String testPlanId, String testPlanName, int order)?
        testPlanRef,
    TResult? Function(String id, TestCase testCase, int order)? oneOff,
  }) {
    return oneOff?.call(id, testCase, order);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id, String testPlanId, String testPlanName, int order)?
        testPlanRef,
    TResult Function(String id, TestCase testCase, int order)? oneOff,
    required TResult orElse(),
  }) {
    if (oneOff != null) {
      return oneOff(id, testCase, order);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ReleasePlanItemTestPlanRef value) testPlanRef,
    required TResult Function(ReleasePlanItemOneOff value) oneOff,
  }) {
    return oneOff(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ReleasePlanItemTestPlanRef value)? testPlanRef,
    TResult? Function(ReleasePlanItemOneOff value)? oneOff,
  }) {
    return oneOff?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ReleasePlanItemTestPlanRef value)? testPlanRef,
    TResult Function(ReleasePlanItemOneOff value)? oneOff,
    required TResult orElse(),
  }) {
    if (oneOff != null) {
      return oneOff(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ReleasePlanItemOneOffImplToJson(
      this,
    );
  }
}

abstract class ReleasePlanItemOneOff implements ReleasePlanItem {
  const factory ReleasePlanItemOneOff(
      {required final String id,
      required final TestCase testCase,
      final int order}) = _$ReleasePlanItemOneOffImpl;

  factory ReleasePlanItemOneOff.fromJson(Map<String, dynamic> json) =
      _$ReleasePlanItemOneOffImpl.fromJson;

  @override
  String get id;
  TestCase get testCase;
  @override
  int get order;

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReleasePlanItemOneOffImplCopyWith<_$ReleasePlanItemOneOffImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReleasePlan _$ReleasePlanFromJson(Map<String, dynamic> json) {
  return _ReleasePlan.fromJson(json);
}

/// @nodoc
mixin _$ReleasePlan {
  String get id => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<ReleasePlanItem> get items => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ReleasePlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReleasePlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReleasePlanCopyWith<ReleasePlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReleasePlanCopyWith<$Res> {
  factory $ReleasePlanCopyWith(
          ReleasePlan value, $Res Function(ReleasePlan) then) =
      _$ReleasePlanCopyWithImpl<$Res, ReleasePlan>;
  @useResult
  $Res call(
      {String id,
      String productName,
      String description,
      List<ReleasePlanItem> items,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$ReleasePlanCopyWithImpl<$Res, $Val extends ReleasePlan>
    implements $ReleasePlanCopyWith<$Res> {
  _$ReleasePlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReleasePlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productName = null,
    Object? description = null,
    Object? items = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReleasePlanItem>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReleasePlanImplCopyWith<$Res>
    implements $ReleasePlanCopyWith<$Res> {
  factory _$$ReleasePlanImplCopyWith(
          _$ReleasePlanImpl value, $Res Function(_$ReleasePlanImpl) then) =
      __$$ReleasePlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String productName,
      String description,
      List<ReleasePlanItem> items,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$ReleasePlanImplCopyWithImpl<$Res>
    extends _$ReleasePlanCopyWithImpl<$Res, _$ReleasePlanImpl>
    implements _$$ReleasePlanImplCopyWith<$Res> {
  __$$ReleasePlanImplCopyWithImpl(
      _$ReleasePlanImpl _value, $Res Function(_$ReleasePlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReleasePlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productName = null,
    Object? description = null,
    Object? items = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ReleasePlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReleasePlanItem>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReleasePlanImpl implements _ReleasePlan {
  const _$ReleasePlanImpl(
      {required this.id,
      this.productName = '',
      this.description = '',
      final List<ReleasePlanItem> items = const [],
      required this.createdAt,
      required this.updatedAt})
      : _items = items;

  factory _$ReleasePlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReleasePlanImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String productName;
  @override
  @JsonKey()
  final String description;
  final List<ReleasePlanItem> _items;
  @override
  @JsonKey()
  List<ReleasePlanItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ReleasePlan(id: $id, productName: $productName, description: $description, items: $items, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReleasePlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, productName, description,
      const DeepCollectionEquality().hash(_items), createdAt, updatedAt);

  /// Create a copy of ReleasePlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReleasePlanImplCopyWith<_$ReleasePlanImpl> get copyWith =>
      __$$ReleasePlanImplCopyWithImpl<_$ReleasePlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReleasePlanImplToJson(
      this,
    );
  }
}

abstract class _ReleasePlan implements ReleasePlan {
  const factory _ReleasePlan(
      {required final String id,
      final String productName,
      final String description,
      final List<ReleasePlanItem> items,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$ReleasePlanImpl;

  factory _ReleasePlan.fromJson(Map<String, dynamic> json) =
      _$ReleasePlanImpl.fromJson;

  @override
  String get id;
  @override
  String get productName;
  @override
  String get description;
  @override
  List<ReleasePlanItem> get items;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of ReleasePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReleasePlanImplCopyWith<_$ReleasePlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
