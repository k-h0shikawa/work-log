import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_log/app/domain/entities/daily_work_for_pdf.dart';
part 'daily_work_for_pdf_entity.freezed.dart';

@freezed
abstract class DailyWorkForPDFEntity implements _$DailyWorkForPDFEntity {
  const DailyWorkForPDFEntity._();

  const factory DailyWorkForPDFEntity({
    required String workDate,
    required String workDetail,
    required String productName,
    required int workCount,
  }) = _DailyWorkForPDFEntity;

  DailyWorkForPDF toDailyWorkForPDFEntity() {
    return DailyWorkForPDF(
      workDate: DateTime.parse(workDate),
      productName: productName,
      workDetail: workDetail,
      workTimeByWorkDetail: workCount * 5,
    );
  }
}
