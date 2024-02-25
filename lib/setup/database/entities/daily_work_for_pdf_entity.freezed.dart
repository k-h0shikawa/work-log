// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_work_for_pdf_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DailyWorkForPDFEntity {
  String get workDate => throw _privateConstructorUsedError;
  String get workDetail => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  int get workCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DailyWorkForPDFEntityCopyWith<DailyWorkForPDFEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyWorkForPDFEntityCopyWith<$Res> {
  factory $DailyWorkForPDFEntityCopyWith(DailyWorkForPDFEntity value,
          $Res Function(DailyWorkForPDFEntity) then) =
      _$DailyWorkForPDFEntityCopyWithImpl<$Res, DailyWorkForPDFEntity>;
  @useResult
  $Res call(
      {String workDate, String workDetail, String productName, int workCount});
}

/// @nodoc
class _$DailyWorkForPDFEntityCopyWithImpl<$Res,
        $Val extends DailyWorkForPDFEntity>
    implements $DailyWorkForPDFEntityCopyWith<$Res> {
  _$DailyWorkForPDFEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workDate = null,
    Object? workDetail = null,
    Object? productName = null,
    Object? workCount = null,
  }) {
    return _then(_value.copyWith(
      workDate: null == workDate
          ? _value.workDate
          : workDate // ignore: cast_nullable_to_non_nullable
              as String,
      workDetail: null == workDetail
          ? _value.workDetail
          : workDetail // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      workCount: null == workCount
          ? _value.workCount
          : workCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyWorkForPDFEntityImplCopyWith<$Res>
    implements $DailyWorkForPDFEntityCopyWith<$Res> {
  factory _$$DailyWorkForPDFEntityImplCopyWith(
          _$DailyWorkForPDFEntityImpl value,
          $Res Function(_$DailyWorkForPDFEntityImpl) then) =
      __$$DailyWorkForPDFEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String workDate, String workDetail, String productName, int workCount});
}

/// @nodoc
class __$$DailyWorkForPDFEntityImplCopyWithImpl<$Res>
    extends _$DailyWorkForPDFEntityCopyWithImpl<$Res,
        _$DailyWorkForPDFEntityImpl>
    implements _$$DailyWorkForPDFEntityImplCopyWith<$Res> {
  __$$DailyWorkForPDFEntityImplCopyWithImpl(_$DailyWorkForPDFEntityImpl _value,
      $Res Function(_$DailyWorkForPDFEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workDate = null,
    Object? workDetail = null,
    Object? productName = null,
    Object? workCount = null,
  }) {
    return _then(_$DailyWorkForPDFEntityImpl(
      workDate: null == workDate
          ? _value.workDate
          : workDate // ignore: cast_nullable_to_non_nullable
              as String,
      workDetail: null == workDetail
          ? _value.workDetail
          : workDetail // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      workCount: null == workCount
          ? _value.workCount
          : workCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DailyWorkForPDFEntityImpl extends _DailyWorkForPDFEntity {
  const _$DailyWorkForPDFEntityImpl(
      {required this.workDate,
      required this.workDetail,
      required this.productName,
      required this.workCount})
      : super._();

  @override
  final String workDate;
  @override
  final String workDetail;
  @override
  final String productName;
  @override
  final int workCount;

  @override
  String toString() {
    return 'DailyWorkForPDFEntity(workDate: $workDate, workDetail: $workDetail, productName: $productName, workCount: $workCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyWorkForPDFEntityImpl &&
            (identical(other.workDate, workDate) ||
                other.workDate == workDate) &&
            (identical(other.workDetail, workDetail) ||
                other.workDetail == workDetail) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.workCount, workCount) ||
                other.workCount == workCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, workDate, workDetail, productName, workCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyWorkForPDFEntityImplCopyWith<_$DailyWorkForPDFEntityImpl>
      get copyWith => __$$DailyWorkForPDFEntityImplCopyWithImpl<
          _$DailyWorkForPDFEntityImpl>(this, _$identity);
}

abstract class _DailyWorkForPDFEntity extends DailyWorkForPDFEntity {
  const factory _DailyWorkForPDFEntity(
      {required final String workDate,
      required final String workDetail,
      required final String productName,
      required final int workCount}) = _$DailyWorkForPDFEntityImpl;
  const _DailyWorkForPDFEntity._() : super._();

  @override
  String get workDate;
  @override
  String get workDetail;
  @override
  String get productName;
  @override
  int get workCount;
  @override
  @JsonKey(ignore: true)
  _$$DailyWorkForPDFEntityImplCopyWith<_$DailyWorkForPDFEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
