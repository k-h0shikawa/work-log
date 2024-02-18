import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/app/domain/log/messages.dart';
import 'package:work_log/app/work/application/state/selected_product_id_notifier.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
import 'package:work_log/app/work/presentation/widget/work_input_row.dart';

class RegisterButton extends ConsumerWidget {
  final ValueNotifier<List<WorkInputRow>> inputWorkList;
  final ValueNotifier<List<Work>> workList;

  const RegisterButton({
    Key? key,
    required this.inputWorkList,
    required this.workList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        // 登録対象の作業リストを作成
        final registerWorks = <Work>[];
        for (final entry in inputWorkList.value.asMap().entries) {
          final index = entry.key;
          final selectedProduct =
              ref.read(selectedProductIdNotifierProvider(index));

          final value = entry.value;
          final inputWork = Work(
            id: value.workId,
            workDateTime: value.workDateTime,
            workDetail: value.workDetailController.text,
            workMemo: value.workMemoController.text,
            productId: selectedProduct,
          );
          registerWorks.add(inputWork);
        }

        // 作業リストを登録
        workList.value =
            await GetIt.I<WorkListUsecase>().saveWork(registerWorks);

        // 登録後の作業リストを作成
        final inputWorkListValue = <WorkInputRow>[];
        final workListValue = workList.value;

        for (final entry in workListValue.asMap().entries) {
          final value = entry.value;
          final inputWork = WorkInputRow(
            workId: value.id,
            workDateTime: value.workDateTime,
            workDetailController: TextEditingController(text: value.workDetail),
            workMemoController: TextEditingController(text: value.workMemo),
            dropDownButtonMenu: const [],
            selectedProductId: value.productId,
            index: entry.key,
          );
          inputWorkListValue.add(inputWork);
        }

        inputWorkList.value = inputWorkListValue;

        scaffoldMessenger.showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(Messages.successRegisterWork),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
      ),
      child: const Text(
        "登録",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
