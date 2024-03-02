import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/app/work/application/state/product_drop_down_button_item_list.dart';
import 'package:work_log/app/work/application/state/selected_product_id_notifier.dart';
import 'package:work_log/app/work/application/state/work_date.dart';
import 'package:work_log/app/work/application/state/work_input_list.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
import 'package:work_log/app/work/presentation/widget/work_input_row.dart';

class DateSelectButton extends StatefulWidget {
  final ValueNotifier<List<InProgressProduct>> productList;

  const DateSelectButton({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  DateSelectButtonState createState() => DateSelectButtonState();
}

class DateSelectButtonState extends State<DateSelectButton>
    with AutomaticKeepAliveClientMixin {
  static final targetDateFormatter = DateFormat('yyyy/MM/dd');

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer(builder: (context, ref, child) {
      // providerを使ってtargetDateを取得
      final targetDate = ref.watch(workDateNotifierProvider);

      List<WorkInputRow> convertWorkListToInputWorkList(List<Work> workList) {
        return workList.asMap().entries.map((entry) {
          final index = entry.key;
          final work = entry.value;
          // 進行中の商品名のドロップダウンリストを作成
          final dropDownButtonMenu = <int, String>{};

          for (final product in widget.productList.value) {
            dropDownButtonMenu[product.id!] = product.productName;
          }

          // 未登録の商品をドロップダウンリストに追加
          if (widget.productList.value
              .where((element) => element.id == work.productId)
              .isEmpty) {
            dropDownButtonMenu[work.productId] = work.productName!;
          }

          // 商品IDのstateを更新
          final notifier =
              ref.read(selectedProductIdNotifierProvider(index).notifier);
          notifier.updateState(work.productId);

          // 商品IDのstateを更新
          final dropDownButtonNotifier = ref.read(
              ProductDropDownButtonItemListNotifierProvider(index).notifier);
          dropDownButtonNotifier.updateState(dropDownButtonMenu);

          return WorkInputRow(
            workId: work.id,
            workDateTime: work.workDateTime,
            workDetailController: work.workDetailController,
            workMemoController: work.workMemoController,
            productName: work.productName!,
            index: index,
          );
        }).toList();
      }

      // テストを実施しやすくするためメソッドを切り分け
      DateTime getFutureDate() {
        return DateTime.now().add(const Duration(days: 360));
      }

      Future<void> selectDate(BuildContext context) async {
        final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: targetDate,
            firstDate: DateTime(2016),
            lastDate: getFutureDate());
        if (picked != null && picked != targetDate) {
          final notifier = ref.read(workDateNotifierProvider.notifier);
          notifier.updateState(picked);

          // targetDateが更新されたら、inputWorkListも更新する
          final workList =
              await GetIt.I<WorkListUsecase>().fetchWorkListByDate(picked);

          // workListの内容をinputWorkListへ詰め替える
          final workInputListNotifier =
              ref.read(workInputListProvider.notifier);
          workInputListNotifier
              .setState(convertWorkListToInputWorkList(workList));
        }
      }

      return Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(targetDateFormatter.format(targetDate)),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () => selectDate(context),
                  child: const Text('日付選択')),
            ),
          ),
        ],
      );
    });
  }
}
