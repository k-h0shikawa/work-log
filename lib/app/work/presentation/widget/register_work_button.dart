import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/app/domain/log/messages.dart';
import 'package:work_log/app/work/application/state/selected_product_id_notifier.dart';
import 'package:work_log/app/work/application/state/work_input_list.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
import 'package:work_log/app/work/presentation/widget/work_input_row.dart';

class RegisterButton extends ConsumerWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        // 登録対象の作業リストを作成
        final registerWorks = <Work>[];

        // 登録後の作業リストを作成
        final inputWorkListValue = <WorkInputRow>[];
        final workListNotifier = ref.read(workInputListProvider);

        workListNotifier.when(
            data: (data) async {
              final inputWorkList = data;

              // 登録対象の作業リストを作成
              for (final entry in inputWorkList.asMap().entries) {
                final index = entry.key;

                ref.read(selectedProductIdNotifierProvider(index)).when(
                    data: (data) {
                      final selectedProduct = data;

                      final value = entry.value;
                      final inputWork = Work(
                        id: value.workId,
                        workDateTime: value.workDateTime,
                        workDetail: value.workDetailController.text,
                        workMemo: value.workMemoController.text,
                        productId: selectedProduct,
                      );
                      registerWorks.add(inputWork);
                    },
                    error: (error, stackTrace) => const Text('Error'),
                    loading: () => const CircularProgressIndicator());
              }

              // 作業リストを登録
              final workList =
                  await GetIt.I<WorkListUsecase>().saveWork(registerWorks);

              // 登録後の作業リストを作成
              for (final entry in workList.asMap().entries) {
                final value = entry.value;
                final inputWork = WorkInputRow(
                  workId: value.id,
                  workDateTime: value.workDateTime,
                  workDetailController:
                      TextEditingController(text: value.workDetail),
                  workMemoController:
                      TextEditingController(text: value.workMemo),
                  selectedProductId: value.productId,
                  index: entry.key,
                );
                inputWorkListValue.add(inputWork);
              }

              final workInputListNotifier =
                  ref.read(workInputListProvider.notifier);
              workInputListNotifier.setState(inputWorkListValue);
            },
            error: (error, stackTrace) => const Text('Error'),
            loading: () => const CircularProgressIndicator());

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
