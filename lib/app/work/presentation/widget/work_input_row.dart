import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_log/app/domain/config/work_config.dart';
import 'package:work_log/app/work/presentation/widget/product_drop_down_button.dart';

class WorkInputRow extends StatefulWidget {
  final int? workId;
  final DateTime workDateTime;
  final List<int> flexRate = [1, 3, 3, 3];
  final TextEditingController workDetailController;
  final TextEditingController workMemoController;
  final DateFormat formatter = DateFormat('HH:mm');
  final String? productName;
  final int index;

  WorkInputRow({
    Key? key,
    this.workId,
    required this.workDateTime,
    required this.workDetailController,
    required this.workMemoController,
    this.productName,
    required this.index,
  }) : super(key: key);

  // AutomaticKeepAliveClientMixinするために必要
  @override
  WorkInputRowState createState() => WorkInputRowState();
}

class WorkInputRowState extends State<WorkInputRow>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final before30Days = widget.workDateTime
        .isAfter(DateTime.now().subtract(const Duration(days: 30)));

    return Row(
      children: <Widget>[
        // TODO : IDは最後に消す
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            child:
                Text(widget.workId == null ? 'null' : widget.workId.toString()),
          ),
        ),
        Expanded(
          flex: widget.flexRate[0],
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Text(widget.formatter.format(widget.workDateTime)),
          ),
        ),
        Expanded(
          flex: widget.flexRate[1],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ProductDropDownButton(
                before30Days: widget.workDateTime
                    .isAfter(DateTime.now().subtract(const Duration(days: 30))),
                index: widget.index),
          ),
        ),
        Expanded(
          flex: widget.flexRate[2],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextFormField(
              controller: widget.workDetailController,
              maxLength: WorkConfig.workDetailLength,
              style: const TextStyle(fontSize: 10),
              enabled: before30Days,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5)),
            ),
          ),
        ),
        Expanded(
          flex: widget.flexRate[3],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextFormField(
              controller: widget.workMemoController,
              maxLength: WorkConfig.workMemoLength,
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
