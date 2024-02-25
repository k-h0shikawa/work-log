// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_work_for_pdf.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DailyWorkForPDF {
  String get productName => throw _privateConstructorUsedError;
  DateTime get workDate => throw _privateConstructorUsedError;
  String get workDetail => throw _privateConstructorUsedError;
  int get workTimeByWorkDetail => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DailyWorkForPDFCopyWith<DailyWorkForPDF> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyWorkForPDFCopyWith<$Res> {
  factory $DailyWorkForPDFCopyWith(
          DailyWorkForPDF value, $Res Function(DailyWorkForPDF) then) =
      _$DailyWorkForPDFCopyWithImpl<$Res, DailyWorkForPDF>;
  @useResult
  $Res call(
      {String productName,
      DateTime workDate,
      String workDetail,
      int workTimeByWorkDetail});
}

/// @nodoc
class _$DailyWorkForPDFCopyWithImpl<$Res, $Val extends DailyWorkForPDF>
    implements $DailyWorkForPDFCopyWith<$Res> {
  _$DailyWorkForPDFCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? workDate = null,
    Object? workDetail = null,
    Object? workTimeByWorkDetail = null,
  }) {
    return _then(_value.copyWith(
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      workDate: null == workDate
          ? _value.workDate
          : workDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      workDetail: null == workDetail
          ? _value.workDetail
          : workDetail // ignore: cast_nullable_to_non_nullable
              as String,
      workTimeByWorkDetail: null == workTimeByWorkDetail
          ? _value.workTimeByWorkDetail
          : workTimeByWorkDetail // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyWorkForPDFImplCopyWith<$Res>
    implements $DailyWorkForPDFCopyWith<$Res> {
  factory _$$DailyWorkForPDFImplCopyWith(_$DailyWorkForPDFImpl value,
          $Res Function(_$DailyWorkForPDFImpl) then) =
      __$$DailyWorkForPDFImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productName,
      DateTime workDate,
      String workDetail,
      int workTimeByWorkDetail});
}

/// @nodoc
class __$$DailyWorkForPDFImplCopyWithImpl<$Res>
    extends _$DailyWorkForPDFCopyWithImpl<$Res, _$DailyWorkForPDFImpl>
    implements _$$DailyWorkForPDFImplCopyWith<$Res> {
  __$$DailyWorkForPDFImplCopyWithImpl(
      _$DailyWorkForPDFImpl _value, $Res Function(_$DailyWorkForPDFImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? workDate = null,
    Object? workDetail = null,
    Object? workTimeByWorkDetail = null,
  }) {
    return _then(_$DailyWorkForPDFImpl(
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      workDate: null == workDate
          ? _value.workDate
          : workDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      workDetail: null == workDetail
          ? _value.workDetail
          : workDetail // ignore: cast_nullable_to_non_nullable
              as String,
      workTimeByWorkDetail: null == workTimeByWorkDetail
          ? _value.workTimeByWorkDetail
          : workTimeByWorkDetail // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DailyWorkForPDFImpl implements _DailyWorkForPDF {
  const _$DailyWorkForPDFImpl(
      {required this.productName,
      required this.workDate,
      required this.workDetail,
      required this.workTimeByWorkDetail});

  @override
  final String productName;
  @override
  final DateTime workDate;
  @override
  final String workDetail;
  @override
  final int workTimeByWorkDetail;

  @override
  String toString() {
    return 'DailyWorkForPDF(productName: $productName, workDate: $workDate, workDetail: $workDetail, workTimeByWorkDetail: $workTimeByWorkDetail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyWorkForPDFImpl &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.workDate, workDate) ||
                other.workDate == workDate) &&
            (identical(other.workDetail, workDetail) ||
                other.workDetail == workDetail) &&
            (identical(other.workTimeByWorkDetail, workTimeByWorkDetail) ||
                other.workTimeByWorkDetail == workTimeByWorkDetail));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, productName, workDate, workDetail, workTimeByWorkDetail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyWorkForPDFImplCopyWith<_$DailyWorkForPDFImpl> get copyWith =>
      __$$DailyWorkForPDFImplCopyWithImpl<_$DailyWorkForPDFImpl>(
          this, _$identity);
}

abstract class _DailyWorkForPDF implements DailyWorkForPDF {
  const factory _DailyWorkForPDF(
      {required final String productName,
      required final DateTime workDate,
      required final String workDetail,
      required final int workTimeByWorkDetail}) = _$DailyWorkForPDFImpl;

  @override
  String get productName;
  @override
  DateTime get workDate;
  @override
  String get workDetail;
  @override
  int get workTimeByWorkDetail;
  @override
  @JsonKey(ignore: true)
  _$$DailyWorkForPDFImplCopyWith<_$DailyWorkForPDFImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
