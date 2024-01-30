import 'package:freezed_annotation/freezed_annotation.dart';
part 'work.freezed.dart';

@freezed
class Work with _$Work {
  const factory Work(
      {@Default(null) int? id,
      required DateTime workDateTime,
      required String workName,
      required String workDetail,
      required String workMemo,
      required int productId,
      @Default(null) DateTime? createdOn,
      @Default(null) String? createdBy,
      @Default(null) DateTime? updatedOn,
      @Default(null) String? updatedBy}) = _Work;
}
