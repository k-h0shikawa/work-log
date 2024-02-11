import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:work_log/setup/database/entities/work_entity.dart';
part 'work.freezed.dart';

@freezed
abstract class Work implements _$Work {
  const Work._();
  const factory Work({
    @Default(null) int? id,
    required DateTime workDateTime,
    required String workDetail,
    required String workMemo,
    required int productId,
    @Default(null) DateTime? createdOn,
    @Default(null) String? createdBy,
    @Default(null) DateTime? updatedOn,
    @Default(null) String? updatedBy,
  }) = _Work;

  WorkEntity toWorkEntity() {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return WorkEntity(
      id: id,
      workDateTime: formatter.format(workDateTime),
      workDetail: workDetail,
      workMemo: workMemo,
      createdBy: createdBy,
      createdOn: createdOn.toString(),
      productId: productId,
    );
  }
}
