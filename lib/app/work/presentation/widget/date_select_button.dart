import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:work_log/app/work/application/state/work_date.dart';

class DateSelectButton extends ConsumerWidget {
  const DateSelectButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetDateFormatter = DateFormat('yyyy/MM/dd');

    // providerを使ってtargetDateを取得
    final targetDate = ref.watch(workDateNotifierProvider);

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: targetDate,
          firstDate: DateTime(2016),
          lastDate: DateTime.now().add(const Duration(days: 360)));
      if (picked != null && picked != targetDate) {
        final notifier = ref.read(workDateNotifierProvider.notifier);
        notifier.updateState(picked);

        // targetDateが更新されたら、inputWorkListも更新する
        // workList.value =
        //     await GetIt.I<WorkListUsecase>().fetchWorkListByDate(picked);

        // workListの内容をinputWorkListへ詰め替える
        // inputWorkList.value.clear();
        // inputWorkList.value = convertWorkListToInputWorkList(workList.value);

        // removeInputWorkList.clear();
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
  }
}
