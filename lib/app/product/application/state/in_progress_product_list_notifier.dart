import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
part 'in_progress_product_list_notifier.g.dart';

@Riverpod()
class InProgressProductListNotifier extends _$InProgressProductListNotifier {
  @override
  Future<List<InProgressProduct>> build() async {
    return GetIt.I<WorkListUsecase>().fetchInProgressProductList();
  }

  void updateState(List<InProgressProduct> inProgressProductList) {
    state = inProgressProductList as AsyncValue<List<InProgressProduct>>;
  }
}
