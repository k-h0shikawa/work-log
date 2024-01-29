// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProductEntity {
  int get id => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  int get isCompleted => throw _privateConstructorUsedError;
  String get createdOn => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime? get updatedOn => throw _privateConstructorUsedError;
  String? get updatedBy => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductEntityCopyWith<ProductEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductEntityCopyWith<$Res> {
  factory $ProductEntityCopyWith(
          ProductEntity value, $Res Function(ProductEntity) then) =
      _$ProductEntityCopyWithImpl<$Res, ProductEntity>;
  @useResult
  $Res call(
      {int id,
      String productName,
      int isCompleted,
      String createdOn,
      String createdBy,
      DateTime? updatedOn,
      String? updatedBy});
}

/// @nodoc
class _$ProductEntityCopyWithImpl<$Res, $Val extends ProductEntity>
    implements $ProductEntityCopyWith<$Res> {
  _$ProductEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productName = null,
    Object? isCompleted = null,
    Object? createdOn = null,
    Object? createdBy = null,
    Object? updatedOn = freezed,
    Object? updatedBy = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      updatedOn: freezed == updatedOn
          ? _value.updatedOn
          : updatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductEntityImplCopyWith<$Res>
    implements $ProductEntityCopyWith<$Res> {
  factory _$$ProductEntityImplCopyWith(
          _$ProductEntityImpl value, $Res Function(_$ProductEntityImpl) then) =
      __$$ProductEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String productName,
      int isCompleted,
      String createdOn,
      String createdBy,
      DateTime? updatedOn,
      String? updatedBy});
}

/// @nodoc
class __$$ProductEntityImplCopyWithImpl<$Res>
    extends _$ProductEntityCopyWithImpl<$Res, _$ProductEntityImpl>
    implements _$$ProductEntityImplCopyWith<$Res> {
  __$$ProductEntityImplCopyWithImpl(
      _$ProductEntityImpl _value, $Res Function(_$ProductEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productName = null,
    Object? isCompleted = null,
    Object? createdOn = null,
    Object? createdBy = null,
    Object? updatedOn = freezed,
    Object? updatedBy = freezed,
  }) {
    return _then(_$ProductEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      updatedOn: freezed == updatedOn
          ? _value.updatedOn
          : updatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ProductEntityImpl implements _ProductEntity {
  const _$ProductEntityImpl(
      {required this.id,
      required this.productName,
      required this.isCompleted,
      required this.createdOn,
      required this.createdBy,
      this.updatedOn = null,
      this.updatedBy = null});

  @override
  final int id;
  @override
  final String productName;
  @override
  final int isCompleted;
  @override
  final String createdOn;
  @override
  final String createdBy;
  @override
  @JsonKey()
  final DateTime? updatedOn;
  @override
  @JsonKey()
  final String? updatedBy;

  @override
  String toString() {
    return 'ProductEntity(id: $id, productName: $productName, isCompleted: $isCompleted, createdOn: $createdOn, createdBy: $createdBy, updatedOn: $updatedOn, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.updatedOn, updatedOn) ||
                other.updatedOn == updatedOn) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, productName, isCompleted,
      createdOn, createdBy, updatedOn, updatedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductEntityImplCopyWith<_$ProductEntityImpl> get copyWith =>
      __$$ProductEntityImplCopyWithImpl<_$ProductEntityImpl>(this, _$identity);
}

abstract class _ProductEntity implements ProductEntity {
  const factory _ProductEntity(
      {required final int id,
      required final String productName,
      required final int isCompleted,
      required final String createdOn,
      required final String createdBy,
      final DateTime? updatedOn,
      final String? updatedBy}) = _$ProductEntityImpl;

  @override
  int get id;
  @override
  String get productName;
  @override
  int get isCompleted;
  @override
  String get createdOn;
  @override
  String get createdBy;
  @override
  DateTime? get updatedOn;
  @override
  String? get updatedBy;
  @override
  @JsonKey(ignore: true)
  _$$ProductEntityImplCopyWith<_$ProductEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
