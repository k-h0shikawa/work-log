import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class WorkInputRow extends HookWidget {
  final int? workId;
  final DateTime workDateTime;
  final flexRate = [1, 3, 3, 3];
  final List<DropdownMenuItem<String>> dropDownButtonMenu;
  final TextEditingController workDetailController;
  final TextEditingController workMemoController;
  int? selectedProductId;
  final formatter = DateFormat('HH:mm');
  final String? productName;

  WorkInputRow({
    super.key,
    this.workId,
    required this.workDateTime,
    required this.workDetailController,
    required this.workMemoController,
    required this.dropDownButtonMenu,
    required this.selectedProductId,
    required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: dropDownButtonMenuが空の場合の処理を追加
    final selectedProductIdForDisplay = useState<int>(selectedProductId == null
        ? dropDownButtonMenu[0].value as int
        : selectedProductId!);

    return Row(
      children: <Widget>[
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
              value: selectedProductId.toString(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedProductId = int.parse(newValue);
                  selectedProductIdForDisplay.value = int.parse(newValue);
                }
              },
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
