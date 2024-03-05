import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:work_log/app/work/application/state/product_drop_down_button_item_list.dart';

import 'package:work_log/app/work/application/state/selected_product_notifier.dart';

class ProductDropDownButton extends ConsumerWidget {
  final bool before30Days;
  final int? initProductId;
  final String? initProductName;
  final int index;

  const ProductDropDownButton(
      {super.key,
      required this.before30Days,
      this.initProductId,
      this.initProductName,
      required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(selectedProductNotifierProvider(index).notifier);

    return ref.watch(ProductDropDownButtonItemListNotifierProvider(index)).when(
        data: (data) {
          final productList = data;
          return ref.watch(selectedProductNotifierProvider(index)).when(
              data: (data) {
                final selectedProduct = data;

                print('productList: $productList');
                print('selectedProduct: $selectedProduct');

                // 進行中の商品名のドロップダウンリストを作成
                final dropDownButtonMenu =
                    productList.entries.map<DropdownMenuItem<String>>((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key.toString(),
                    child: Text(
                      entry.value,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }).toList();

                // 進行中でないかつ、選択された商品がリストにない場合は、ドロップダウンリストに追加
                if (productList.entries
                    .where((entry) => entry.key == selectedProduct.id)
                    .isEmpty) {
                  dropDownButtonMenu.add(DropdownMenuItem<String>(
                    value: selectedProduct.id.toString(),
                    child: Text(
                      selectedProduct.productName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ));
                }

                // dropdownButtonMenuが空または、workDateTimeが1か月以上前の場合は、ドロップダウンリストを無効にする
                final isDropDownButtonEnabled =
                    dropDownButtonMenu.isNotEmpty && before30Days;

                return DropdownButton<String>(
                  isExpanded: true,
                  itemHeight: null,
                  iconSize: 0,
                  value: dropDownButtonMenu.isEmpty
                      ? null
                      : selectedProduct.id.toString(),
                  onChanged: isDropDownButtonEnabled
                      ? (String? value) {
                          if (value != null) {
                            notifier.updateState(int.parse(value));
                          }
                        }
                      : null,
                  items: dropDownButtonMenu,
                );
              },
              error: (error, stackTrace) => const Text('Error'),
              loading: () => const CircularProgressIndicator());
        },
        error: (error, stackTrace) => const Text('Error'),
        loading: () => const CircularProgressIndicator());
  }
}
