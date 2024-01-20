import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:work_log/domain/types/work.dart';
import 'package:intl/intl.dart';

class WorkList extends HookWidget {
  const WorkList({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = useTextEditingController();
    final header = <String>['時間', '商品名', '作業内容', '作業メモ'];
    final formatter = DateFormat('HH:mm');
    final taskList = useState(<Work>[
      for (var i = 0; i < 20; i++)
        Work(
          id: i,
          workDateTime:
              DateTime(2024, 1, 1, 9, 30).add(Duration(minutes: 30 * i)),
          workName: 'Work $i',
          workDetail: 'Detail $i',
          workMemo: 'Memo $i',
          projectId: i,
        ),
    ]);

    return Scaffold(
      appBar: AppBar(title: const Text('WORK LOG')),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              Text('2024/01/01'),
              Row(
                children: header.map((title) {
                  return Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  );
                }).toList(),
              ),
            ]..addAll(
                taskList.value.map((task) {
                  final workNameController = useTextEditingController();
                  final workDetailController = useTextEditingController();
                  final workMemoController = useTextEditingController();

                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(formatter.format(task.workDateTime)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: TextFormField(
                            controller: workNameController,
                            style: TextStyle(fontSize: 10),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: TextFormField(
                            controller: workDetailController,
                            style: TextStyle(fontSize: 10),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: TextFormField(
                            controller: workMemoController,
                            style: TextStyle(fontSize: 10),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5)),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
          ),
        ),
      ),
    );
  }
}
