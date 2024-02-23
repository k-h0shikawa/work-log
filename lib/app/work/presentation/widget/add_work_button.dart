import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:work_log/app/work/application/state/work_input_list.dart';

class AddWorkButton extends ConsumerWidget {
  const AddWorkButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        ref.read(workInputListProvider).when(
            data: (data) {
              final workList = data;
              if (workList.last.workDateTime.hour == 8 &&
                  workList.last.workDateTime.minute == 30) {
                return;
              }
              ref.read(workInputListProvider.notifier).addDefaultWorkInputRow();
            },
            error: (error, stackTrace) => const Text('Error'),
            loading: () => const CircularProgressIndicator());
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
      ),
      child: const Text(
        "＋",
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}
