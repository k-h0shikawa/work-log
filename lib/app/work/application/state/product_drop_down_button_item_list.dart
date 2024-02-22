import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
part 'product_drop_down_button_item_list.g.dart';

@Riverpod()
class ProductDropDownButtonItemListNotifier
    extends _$ProductDropDownButtonItemListNotifier {
  @override
  Future<Map<int, String>> build(int index) async {
    final productList =
        await GetIt.I<WorkListUsecase>().fetchInProgressProductList();
    final dropDownButtonItems = <int, String>{};
    for (var e in productList) {
      dropDownButtonItems[e.id!] = e.productName;
    }
    // idを使用してproductListを降順にソート
    dropDownButtonItems.entries.toList().sort((a, b) => b.key.compareTo(a.key));
    return dropDownButtonItems;
  }

  void updateState(Map<int, String> productList) {
    state = AsyncValue.data(productList);
  }

  void updateItem(Map<int, String> newItem) {
    final productList = state as Map<int, String>;
    productList.addAll({newItem.keys.first: newItem.values.first});
    productList.entries.toList().sort((a, b) => b.key.compareTo(a.key));
    state = AsyncValue<Map<int, String>>.data(productList);
  }

  void removeItem(int productId) {
    final productList = state as Map<int, String>;
    productList.remove(productId);
    state = AsyncValue<Map<int, String>>.data(productList);
  }
}
