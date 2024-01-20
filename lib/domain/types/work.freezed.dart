// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Work {
  int get id => throw _privateConstructorUsedError;
  DateTime get workDateTime => throw _privateConstructorUsedError;
  String get workName => throw _privateConstructorUsedError;
  String get workDetail => throw _privateConstructorUsedError;
  String get workMemo => throw _privateConstructorUsedError;
  int get projectId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WorkCopyWith<Work> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkCopyWith<$Res> {
  factory $WorkCopyWith(Work value, $Res Function(Work) then) =
      _$WorkCopyWithImpl<$Res, Work>;
  @useResult
  $Res call(
      {int id,
      DateTime workDateTime,
      String workName,
      String workDetail,
      String workMemo,
      int projectId});
}

/// @nodoc
class _$WorkCopyWithImpl<$Res, $Val extends Work>
    implements $WorkCopyWith<$Res> {
  _$WorkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workDateTime = null,
    Object? workName = null,
    Object? workDetail = null,
    Object? workMemo = null,
    Object? projectId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      workDateTime: null == workDateTime
          ? _value.workDateTime
          : workDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      workName: null == workName
          ? _value.workName
          : workName // ignore: cast_nullable_to_non_nullable
              as String,
      workDetail: null == workDetail
          ? _value.workDetail
          : workDetail // ignore: cast_nullable_to_non_nullable
              as String,
      workMemo: null == workMemo
          ? _value.workMemo
          : workMemo // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkImplCopyWith<$Res> implements $WorkCopyWith<$Res> {
  factory _$$WorkImplCopyWith(
          _$WorkImpl value, $Res Function(_$WorkImpl) then) =
      __$$WorkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime workDateTime,
      String workName,
      String workDetail,
      String workMemo,
      int projectId});
}

/// @nodoc
class __$$WorkImplCopyWithImpl<$Res>
    extends _$WorkCopyWithImpl<$Res, _$WorkImpl>
    implements _$$WorkImplCopyWith<$Res> {
  __$$WorkImplCopyWithImpl(_$WorkImpl _value, $Res Function(_$WorkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workDateTime = null,
    Object? workName = null,
    Object? workDetail = null,
    Object? workMemo = null,
    Object? projectId = null,
  }) {
    return _then(_$WorkImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      workDateTime: null == workDateTime
          ? _value.workDateTime
          : workDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      workName: null == workName
          ? _value.workName
          : workName // ignore: cast_nullable_to_non_nullable
              as String,
      workDetail: null == workDetail
          ? _value.workDetail
          : workDetail // ignore: cast_nullable_to_non_nullable
              as String,
      workMemo: null == workMemo
          ? _value.workMemo
          : workMemo // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$WorkImpl implements _Work {
  const _$WorkImpl(
      {required this.id,
      required this.workDateTime,
      required this.workName,
      required this.workDetail,
      required this.workMemo,
      required this.projectId});

  @override
  final int id;
  @override
  final DateTime workDateTime;
  @override
  final String workName;
  @override
  final String workDetail;
  @override
  final String workMemo;
  @override
  final int projectId;

  @override
  String toString() {
    return 'Work(id: $id, workDateTime: $workDateTime, workName: $workName, workDetail: $workDetail, workMemo: $workMemo, projectId: $projectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workDateTime, workDateTime) ||
                other.workDateTime == workDateTime) &&
            (identical(other.workName, workName) ||
                other.workName == workName) &&
            (identical(other.workDetail, workDetail) ||
                other.workDetail == workDetail) &&
            (identical(other.workMemo, workMemo) ||
                other.workMemo == workMemo) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, workDateTime, workName, workDetail, workMemo, projectId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkImplCopyWith<_$WorkImpl> get copyWith =>
      __$$WorkImplCopyWithImpl<_$WorkImpl>(this, _$identity);
}

abstract class _Work implements Work {
  const factory _Work(
      {required final int id,
      required final DateTime workDateTime,
      required final String workName,
      required final String workDetail,
      required final String workMemo,
      required final int projectId}) = _$WorkImpl;

  @override
  int get id;
  @override
  DateTime get workDateTime;
  @override
  String get workName;
  @override
  String get workDetail;
  @override
  String get workMemo;
  @override
  int get projectId;
  @override
  @JsonKey(ignore: true)
  _$$WorkImplCopyWith<_$WorkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
