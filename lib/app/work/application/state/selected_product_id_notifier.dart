import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:work_log/app/product/application/in_progress_product_list_usecase.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
part 'selected_product_id_notifier.g.dart';

@Riverpod()
class SelectedProductIdNotifier extends _$SelectedProductIdNotifier {
  @override
  Future<int> build(int index) async {
    // すでに作業リストがある場合は、その商品IDを返す
    final workList =
        await GetIt.I<WorkListUsecase>().initWorkList(DateTime.now());
    if (index < workList.length && workList[index].id != null) {
      return workList[index].productId;
    }

    // 作業リストがない場合は、進行中の商品リストから最初の商品IDを返す
    final productIdList = await GetIt.I<InProgressProductListUsecase>()
        .fetchInProgressProductList();
    if (productIdList.isEmpty) {
      return -1;
    }
    return productIdList.first.id!;
  }

  void updateState(int productId) {
    state = AsyncValue.data(productId);
  }
}
