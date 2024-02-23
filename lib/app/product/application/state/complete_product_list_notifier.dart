import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:work_log/app/domain/entities/complete_product.dart';
import 'package:work_log/app/product/application/complete_product_list_usecase.dart';
part 'complete_product_list_notifier.g.dart';

@Riverpod()
class CompleteProductListNotifier extends _$CompleteProductListNotifier {
  @override
  Future<List<CompleteProduct>> build() async {
    return GetIt.I<CompleteProductListUsecase>().fetchCompleteProductList();
  }

  void updateState(List<CompleteProduct> inProgressProductList) {
    state = AsyncValue.data(inProgressProductList);
  }
}
