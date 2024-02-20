import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:work_log/app/product/application/in_progress_product_list_usecase.dart';
part 'selected_product_id_notifier.g.dart';

@Riverpod()
class SelectedProductIdNotifier extends _$SelectedProductIdNotifier {
  @override
  Future<int> build(int index) async {
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
