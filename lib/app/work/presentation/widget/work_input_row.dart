import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class WorkInputRow extends HookWidget {
  final int? workId;
  final DateTime workDateTime;
  final List<int> flexRate = [1, 3, 3, 3];
  final List<DropdownMenuItem<String>> dropDownButtonMenu;
  final TextEditingController workDetailController;
  final TextEditingController workMemoController;
  int? selectedProductId;
  final DateFormat formatter = DateFormat('HH:mm');
  final String productName;

  WorkInputRow({
    Key? key,
    this.workId,
    required this.workDateTime,
    required this.workDetailController,
    required this.workMemoController,
    required this.dropDownButtonMenu,
    required this.selectedProductId,
    required this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: dropDownButtonMenuが空の場合の処理を追加
    final selectedProductIdForDisplay = useState<int?>(selectedProductId);

    final before30Days =
        workDateTime.isAfter(DateTime.now().subtract(const Duration(days: 30)));
    // dropdownButtonMenuが空または、workDateTimeが1か月以上前の場合は、ドロップダウンリストを無効にする
    final isDropDownButtonEnabled =
        dropDownButtonMenu.isNotEmpty && before30Days;

    return Row(
      children: <Widget>[
        // TODO : IDは最後に消す
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Text(workId == null ? 'null' : workId.toString()),
          ),
        ),
        Expanded(
          flex: flexRate[0],
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Text(formatter.format(workDateTime)),
          ),
        ),
        Expanded(
          flex: flexRate[1],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: DropdownButton<String>(
              isExpanded: true,
              itemHeight: null,
              iconSize: 0,
              value: dropDownButtonMenu.isEmpty
                  ? null
                  : selectedProductId.toString(),
              onChanged: isDropDownButtonEnabled
                  ? (String? value) {
                      if (value != null) {
                        selectedProductId = int.parse(value);
                        selectedProductIdForDisplay.value = int.parse(value);
                      }
                    }
                  : null,
              items: dropDownButtonMenu,
            ),
          ),
        ),
        Expanded(
          flex: flexRate[2],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextFormField(
              controller: workDetailController,
              style: const TextStyle(fontSize: 10),
              enabled: before30Days,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5)),
            ),
          ),
        ),
        Expanded(
          flex: flexRate[3],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextFormField(
              controller: workMemoController,
              style: const TextStyle(fontSize: 10),
              enabled: before30Days,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5)),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
        ),
      ],
    );
  }
}
