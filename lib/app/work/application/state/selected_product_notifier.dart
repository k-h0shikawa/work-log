import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:work_log/app/domain/config/no_product_status.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/product/application/in_progress_product_list_usecase.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
part 'selected_product_notifier.g.dart';

@Riverpod()
class SelectedProductNotifier extends _$SelectedProductNotifier {
  @override
  Future<InProgressProduct> build(int index) async {
    // すでに作業リストがある場合は、その商品IDを返す
    final workList =
        await GetIt.I<WorkListUsecase>().initWorkList(DateTime.now());
    if (index < workList.length && workList[index].id != null) {
      return InProgressProduct(
          id: workList[index].productId,
          productName: workList[index].productName!);
    }

    // 作業リストがない場合は、進行中の商品リストから最初の商品IDを返す
    final productIdList = await GetIt.I<InProgressProductListUsecase>()
        .fetchInProgressProductList();
    if (productIdList.isNotEmpty) {
      return productIdList.last;
    }
    // 進行中の商品がない場合は、ダミーの商品IDを返す
    return const InProgressProduct(
        id: NoProductStatus.productId,
        productName: NoProductStatus.productName);
  }

  Future<void> updateState(int productId) async {
    if (productId == NoProductStatus.productId) {
      state = const AsyncValue.data(InProgressProduct(
          id: NoProductStatus.productId,
          productName: NoProductStatus.productName));
      return;
    }
    state = AsyncValue.data(await GetIt.I<WorkListUsecase>()
        .fetchInProgressProductByWorkId(productId));
  }
}
