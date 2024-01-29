import 'package:freezed_annotation/freezed_annotation.dart';
part 'work.freezed.dart';

@freezed
class Work with _$Work {
  const factory Work(
      {required int id,
      required DateTime workDateTime,
      required String workName,
      required String workDetail,
      required String workMemo,
      required int productId,
      required DateTime createdOn,
      required String createdBy,
      @Default(null) DateTime? updatedOn,
      @Default(null) String? updatedBy}) = _Work;
}
