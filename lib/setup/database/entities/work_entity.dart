import 'package:freezed_annotation/freezed_annotation.dart';
part 'work_entity.freezed.dart';
part 'work_entity.g.dart';

@freezed
class WorkEntity with _$WorkEntity {
  const factory WorkEntity(
      {@Default(null) int? id,
      required DateTime workDateTime,
      required String workName,
      required String workDetail,
      required String workMemo,
      required int productId,
      @Default(null) String? createdOn,
      @Default(null) String? createdBy,
      @Default(null) String? updatedOn,
      @Default(null) String? updatedBy}) = _WorkEntity;

  factory WorkEntity.fromJson(Map<String, Object?> json) =>
      _$WorkEntityFromJson(json);
}
