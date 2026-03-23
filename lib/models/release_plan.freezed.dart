// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'release_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
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
  String get id;
  int get order;

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReleasePlanItemCopyWith<ReleasePlanItem> get copyWith =>
      _$ReleasePlanItemCopyWithImpl<ReleasePlanItem>(
          this as ReleasePlanItem, _$identity);

  /// Serializes this ReleasePlanItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReleasePlanItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, order);

  @override
  String toString() {
    return 'ReleasePlanItem(id: $id, order: $order)';
  }
}

/// @nodoc
abstract mixin class $ReleasePlanItemCopyWith<$Res> {
  factory $ReleasePlanItemCopyWith(
          ReleasePlanItem value, $Res Function(ReleasePlanItem) _then) =
      _$ReleasePlanItemCopyWithImpl;
  @useResult
  $Res call({String id, int order});
}

/// @nodoc
class _$ReleasePlanItemCopyWithImpl<$Res>
    implements $ReleasePlanItemCopyWith<$Res> {
  _$ReleasePlanItemCopyWithImpl(this._self, this._then);

  final ReleasePlanItem _self;
  final $Res Function(ReleasePlanItem) _then;

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class ReleasePlanItemTestPlanRef implements ReleasePlanItem {
  const ReleasePlanItemTestPlanRef(
      {required this.id,
      required this.testPlanId,
      required this.testPlanName,
      this.order = 0,
      final String? $type})
      : $type = $type ?? 'testPlanRef';
  factory ReleasePlanItemTestPlanRef.fromJson(Map<String, dynamic> json) =>
      _$ReleasePlanItemTestPlanRefFromJson(json);

  @override
  final String id;
  final String testPlanId;
  final String testPlanName;
  @override
  @JsonKey()
  final int order;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReleasePlanItemTestPlanRefCopyWith<ReleasePlanItemTestPlanRef>
      get copyWith =>
          _$ReleasePlanItemTestPlanRefCopyWithImpl<ReleasePlanItemTestPlanRef>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReleasePlanItemTestPlanRefToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReleasePlanItemTestPlanRef &&
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

  @override
  String toString() {
    return 'ReleasePlanItem.testPlanRef(id: $id, testPlanId: $testPlanId, testPlanName: $testPlanName, order: $order)';
  }
}

/// @nodoc
abstract mixin class $ReleasePlanItemTestPlanRefCopyWith<$Res>
    implements $ReleasePlanItemCopyWith<$Res> {
  factory $ReleasePlanItemTestPlanRefCopyWith(ReleasePlanItemTestPlanRef value,
          $Res Function(ReleasePlanItemTestPlanRef) _then) =
      _$ReleasePlanItemTestPlanRefCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String testPlanId, String testPlanName, int order});
}

/// @nodoc
class _$ReleasePlanItemTestPlanRefCopyWithImpl<$Res>
    implements $ReleasePlanItemTestPlanRefCopyWith<$Res> {
  _$ReleasePlanItemTestPlanRefCopyWithImpl(this._self, this._then);

  final ReleasePlanItemTestPlanRef _self;
  final $Res Function(ReleasePlanItemTestPlanRef) _then;

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? testPlanId = null,
    Object? testPlanName = null,
    Object? order = null,
  }) {
    return _then(ReleasePlanItemTestPlanRef(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      testPlanId: null == testPlanId
          ? _self.testPlanId
          : testPlanId // ignore: cast_nullable_to_non_nullable
              as String,
      testPlanName: null == testPlanName
          ? _self.testPlanName
          : testPlanName // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class ReleasePlanItemOneOff implements ReleasePlanItem {
  const ReleasePlanItemOneOff(
      {required this.id,
      required this.testCase,
      this.order = 0,
      final String? $type})
      : $type = $type ?? 'oneOff';
  factory ReleasePlanItemOneOff.fromJson(Map<String, dynamic> json) =>
      _$ReleasePlanItemOneOffFromJson(json);

  @override
  final String id;
  final TestCase testCase;
  @override
  @JsonKey()
  final int order;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReleasePlanItemOneOffCopyWith<ReleasePlanItemOneOff> get copyWith =>
      _$ReleasePlanItemOneOffCopyWithImpl<ReleasePlanItemOneOff>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReleasePlanItemOneOffToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReleasePlanItemOneOff &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.testCase, testCase) ||
                other.testCase == testCase) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, testCase, order);

  @override
  String toString() {
    return 'ReleasePlanItem.oneOff(id: $id, testCase: $testCase, order: $order)';
  }
}

/// @nodoc
abstract mixin class $ReleasePlanItemOneOffCopyWith<$Res>
    implements $ReleasePlanItemCopyWith<$Res> {
  factory $ReleasePlanItemOneOffCopyWith(ReleasePlanItemOneOff value,
          $Res Function(ReleasePlanItemOneOff) _then) =
      _$ReleasePlanItemOneOffCopyWithImpl;
  @override
  @useResult
  $Res call({String id, TestCase testCase, int order});

  $TestCaseCopyWith<$Res> get testCase;
}

/// @nodoc
class _$ReleasePlanItemOneOffCopyWithImpl<$Res>
    implements $ReleasePlanItemOneOffCopyWith<$Res> {
  _$ReleasePlanItemOneOffCopyWithImpl(this._self, this._then);

  final ReleasePlanItemOneOff _self;
  final $Res Function(ReleasePlanItemOneOff) _then;

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? testCase = null,
    Object? order = null,
  }) {
    return _then(ReleasePlanItemOneOff(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      testCase: null == testCase
          ? _self.testCase
          : testCase // ignore: cast_nullable_to_non_nullable
              as TestCase,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of ReleasePlanItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TestCaseCopyWith<$Res> get testCase {
    return $TestCaseCopyWith<$Res>(_self.testCase, (value) {
      return _then(_self.copyWith(testCase: value));
    });
  }
}

/// @nodoc
mixin _$ReleasePlan {
  String get id;
  String get productName;
  String get description;
  List<ReleasePlanItem> get items;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of ReleasePlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReleasePlanCopyWith<ReleasePlan> get copyWith =>
      _$ReleasePlanCopyWithImpl<ReleasePlan>(this as ReleasePlan, _$identity);

  /// Serializes this ReleasePlan to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReleasePlan &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, productName, description,
      const DeepCollectionEquality().hash(items), createdAt, updatedAt);

  @override
  String toString() {
    return 'ReleasePlan(id: $id, productName: $productName, description: $description, items: $items, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $ReleasePlanCopyWith<$Res> {
  factory $ReleasePlanCopyWith(
          ReleasePlan value, $Res Function(ReleasePlan) _then) =
      _$ReleasePlanCopyWithImpl;
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
class _$ReleasePlanCopyWithImpl<$Res> implements $ReleasePlanCopyWith<$Res> {
  _$ReleasePlanCopyWithImpl(this._self, this._then);

  final ReleasePlan _self;
  final $Res Function(ReleasePlan) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _self.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReleasePlanItem>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ReleasePlan implements ReleasePlan {
  const _ReleasePlan(
      {required this.id,
      this.productName = '',
      this.description = '',
      final List<ReleasePlanItem> items = const [],
      required this.createdAt,
      required this.updatedAt})
      : _items = items;
  factory _ReleasePlan.fromJson(Map<String, dynamic> json) =>
      _$ReleasePlanFromJson(json);

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

  /// Create a copy of ReleasePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReleasePlanCopyWith<_ReleasePlan> get copyWith =>
      __$ReleasePlanCopyWithImpl<_ReleasePlan>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReleasePlanToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReleasePlan &&
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

  @override
  String toString() {
    return 'ReleasePlan(id: $id, productName: $productName, description: $description, items: $items, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$ReleasePlanCopyWith<$Res>
    implements $ReleasePlanCopyWith<$Res> {
  factory _$ReleasePlanCopyWith(
          _ReleasePlan value, $Res Function(_ReleasePlan) _then) =
      __$ReleasePlanCopyWithImpl;
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
class __$ReleasePlanCopyWithImpl<$Res> implements _$ReleasePlanCopyWith<$Res> {
  __$ReleasePlanCopyWithImpl(this._self, this._then);

  final _ReleasePlan _self;
  final $Res Function(_ReleasePlan) _then;

  /// Create a copy of ReleasePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? productName = null,
    Object? description = null,
    Object? items = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_ReleasePlan(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _self.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReleasePlanItem>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
