import 'package:freezed_annotation/freezed_annotation.dart';
part 'work_entity.freezed.dart';

@freezed
class WorkEntity with _$WorkEntity {
  const factory WorkEntity(
      {required int id,
      required DateTime workDateTime,
      required String workName,
      required String workDetail,
      required String workMemo,
      required int productId,
      required String createdOn,
      required String createdBy,
      @Default(null) DateTime? updatedOn,
      @Default(null) String? updatedBy}) = _WorkEntity;
}
