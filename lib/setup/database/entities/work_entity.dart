import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_log/app/domain/entities/work.dart';
part 'work_entity.freezed.dart';
part 'work_entity.g.dart';

@freezed
abstract class WorkEntity implements _$WorkEntity {
  const WorkEntity._();

  const factory WorkEntity(
      {@Default(null) int? id,
      required String workDateTime,
      required String workDetail,
      required String workMemo,
      required int productId,
      @Default(null) String? createdOn,
      @Default(null) String? createdBy,
      @Default(null) String? updatedOn,
      @Default(null) String? updatedBy}) = _WorkEntity;

  factory WorkEntity.fromJson(Map<String, Object?> json) =>
      _$WorkEntityFromJson(json);

  factory WorkEntity.fromMap(Map<String, dynamic> json) =>
      _$WorkEntityFromJson(json);

  Work toWork() {
    return Work(
      id: id,
      workDateTime: DateTime.parse(workDateTime),
      workDetail: workDetail,
      workMemo: workMemo,
      productId: productId,
      createdOn: createdOn != null ? DateTime.parse(createdOn!) : null,
      createdBy: createdBy,
      updatedOn: updatedOn != null ? DateTime.parse(updatedOn!) : null,
      updatedBy: updatedBy,
    );
  }
}
