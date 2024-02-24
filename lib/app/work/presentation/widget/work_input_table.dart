import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:work_log/app/work/application/state/work_input_list.dart';

class WorkInputTable extends ConsumerWidget {
  static const header = <String>['ID', '時間', '商品名', '作業内容', '作業メモ'];
  static const flexRate = <int>[1, 2, 2, 4, 4];
  const WorkInputTable({super.key});

  Widget buildHeader() {
    return Row(
      children: header.asMap().entries.map((entry) {
        int idx = entry.key;
        String value = entry.value;
        return Expanded(
          flex: flexRate[idx],
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputWorkList = ref.watch(workInputListProvider);

    return inputWorkList.when(
      data: (workInputRows) {
        return Column(
          children: [
            buildHeader(),
            ...workInputRows,
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => const Text('Error'),
    );
  }
}
