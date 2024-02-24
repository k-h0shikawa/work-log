import 'package:freezed_annotation/freezed_annotation.dart';
part 'daily_work_for_pdf.freezed.dart';

@freezed
class DailyWorkForPDF with _$DailyWorkForPDF {
  const factory DailyWorkForPDF({
    required String productName,
    required DateTime workDate,
    required String workDetail,
    required int workTimeByWorkDetail,
  }) = _DailyWorkForPDF;
}
