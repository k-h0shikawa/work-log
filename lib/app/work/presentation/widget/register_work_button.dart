import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/app/domain/log/messages.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
import 'package:work_log/app/work/presentation/widget/work_input_row.dart';

class RegisterButton extends HookWidget {
  final List<WorkInputRow> inputWorkList;
  final ValueNotifier<List<Work>> workList;

  const RegisterButton({
    Key? key,
    required this.inputWorkList,
    required this.workList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        // 登録対象の作業リストを作成
        final registerWorks = inputWorkList
            .map((inputWork) => Work(
                  id: inputWork.workId,
                  workDateTime: inputWork.workDateTime,
                  workDetail: inputWork.workDetailController.text,
                  workMemo: inputWork.workMemoController.text,
                  productId: inputWork.selectedProductId!,
                ))
            .toList();

        workList.value =
            await GetIt.I<WorkListUsecase>().saveWork(registerWorks);

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
