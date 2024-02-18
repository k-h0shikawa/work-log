import 'package:flutter/material.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/product/application/state/in_progress_product_list_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:work_log/app/work/application/state/selected_product_id_notifier.dart';

class ProductDropDownButton extends ConsumerWidget {
  final DateTime workDateTime;
  final int? initProductId;
  final String? initProductName;
  final int index;

  const ProductDropDownButton(
      {super.key,
      required this.workDateTime,
      this.initProductId,
      this.initProductName,
      required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(inProgressProductListNotifierProvider.future);
    final selectedProduct = ref.watch(selectedProductIdNotifierProvider(index));

    final notifier =
        ref.read(selectedProductIdNotifierProvider(index).notifier);

    return FutureBuilder(
      future: ref.watch(inProgressProductListNotifierProvider.future),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final productList = snapshot.data ?? [];

          // 進行中の商品名のドロップダウンリストを作成
          final dropDownButtonMenu = productList.map<DropdownMenuItem<String>>(
            (InProgressProduct product) {
              return DropdownMenuItem<String>(
                value: product.id.toString(),
                child: Text(
                  product.productName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10),
                ),
              );
            },
          ).toList();

          // 進行中でないかつ、選択された商品がリストにない場合は、ドロップダウンリストに追加
          if (initProductId != null &&
              productList
                  .where((element) => element.id == initProductId)
                  .isEmpty) {
            dropDownButtonMenu.add(DropdownMenuItem<String>(
              value: initProductId.toString(),
              child: Text(
                initProductName!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10),
              ),
            ));
          }

          final before30Days = workDateTime
              .isAfter(DateTime.now().subtract(const Duration(days: 30)));
          // dropdownButtonMenuが空または、workDateTimeが1か月以上前の場合は、ドロップダウンリストを無効にする
          final isDropDownButtonEnabled =
              dropDownButtonMenu.isNotEmpty && before30Days;

          return DropdownButton<String>(
            isExpanded: true,
            itemHeight: null,
            iconSize: 0,
            value:
                dropDownButtonMenu.isEmpty ? null : selectedProduct.toString(),
            onChanged: isDropDownButtonEnabled
                ? (String? value) {
                    if (value != null) {
                      notifier.updateState(int.parse(value));
                    }
                  }
                : null,
            items: dropDownButtonMenu,
          );
        }
      },
    );
  }
}
