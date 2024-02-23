import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
import 'package:work_log/app/work/presentation/widget/work_input_row.dart';
part 'work_input_list.g.dart';

@Riverpod()
class WorkInputList extends _$WorkInputList {
  List<WorkInputRow> convertWorkListToInputWorkList(List<Work> workList) {
    return workList.asMap().entries.map((entry) {
      final index = entry.key;
      final work = entry.value;

      return WorkInputRow(
        workId: work.id,
        workDateTime: work.workDateTime,
        workDetailController: work.workDetailController,
        workMemoController: work.workMemoController,
        selectedProductId: work.productId,
        productName: work.productName!,
        index: index,
      );
    }).toList();
  }

  @override
  Future<List<WorkInputRow>> build() async {
    final workList =
        await GetIt.I<WorkListUsecase>().initWorkList(DateTime.now());
    final inputWorkList = convertWorkListToInputWorkList(workList);

    return inputWorkList;
  }

  void setState(List<WorkInputRow> inputWorkList) {
    state = AsyncValue.data(inputWorkList);
  }
}
