import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:work_log/app/work/application/state/work_input_list.dart';

class MinusWorkButton extends ConsumerWidget {
  const MinusWorkButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        ref.read(workInputListProvider).when(
            data: (data) {
              final workList = data;
              if (workList.last.workDateTime.hour == 9 &&
                  workList.last.workDateTime.minute == 0) {
                return;
              }
              ref.read(workInputListProvider.notifier).minusWorkInputRow();
            },
            error: (error, stackTrace) => const Text('Error'),
            loading: () => const CircularProgressIndicator());
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
      ),
      child: const Text(
        "ー",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
