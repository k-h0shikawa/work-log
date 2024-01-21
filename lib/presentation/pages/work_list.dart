import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:work_log/domain/types/product.dart';
import 'package:work_log/domain/types/work.dart';
import 'package:intl/intl.dart';

class WorkList extends HookWidget {
  const WorkList({super.key});

  @override
  Widget build(BuildContext context) {
    const header = <String>['時間', '商品名', '作業内容', '作業メモ'];
    final formatter = DateFormat('HH:mm');
    final targetDateFormatter = DateFormat('yyyy/MM/dd');
    final targetDate = useState(DateTime.now());
    const maxWorkListLength = 1;
    final workList = useState(<Work>[
      for (var i = 0; i < 20; i++)
        Work(
          id: i,
          workDateTime:
              DateTime(2024, 1, 1, 9, 30).add(Duration(minutes: 30 * i)),
          workName: 'ダミー案件',
          workDetail: 'Detail $i',
          workMemo: 'Memo $i',
          productId: i,
        ),
    ]);

    final productList = useState(<Product>[
      const Product(id: 0, productName: 'ダミー案件', status: 0),
      const Product(id: 1, productName: 'ぽしぇっと', status: 0),
      const Product(id: 2, productName: '２０文字の長さの商品名のてすとなのですよ', status: 0)
    ]);

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: targetDate.value,
          firstDate: DateTime(2016),
          lastDate: DateTime.now().add(const Duration(days: 360)));
      if (picked != null && picked != targetDate.value) {
        targetDate.value = picked;
      }
    }

    Widget buildHeader() {
      return Row(
        children: header.map((title) {
          return Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          );
        }).toList(),
      );
    }

    List<Widget> buildTaskList() {
      return workList.value.map((work) {
        final workDetailController =
            useTextEditingController(text: work.workDetail);
        final workMemoController =
            useTextEditingController(text: work.workMemo);
        var selectedProduct = useState<String>(work.workName);

        return Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(formatter.format(work.workDateTime)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  isExpanded: false,
                  value: selectedProduct.value,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      selectedProduct.value = newValue;
                      workList.value = workList.value.map((tmpWork) {
                        if (work.id == tmpWork.id) {
                          return tmpWork.copyWith(workName: newValue);
                        }
                        return tmpWork;
                      }).toList();
                    }
                  },
                  items: productList.value
                      .map<DropdownMenuItem<String>>((Product product) {
                    return DropdownMenuItem<String>(
                      value: product.productName,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(product.productName),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
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
              flex: 2,
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
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('作業入力画面')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ListView(
            children: [
              ButtonBar(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => context.push('/product'),
                    label: const Text('商品一覧画面'),
                    icon: Icon(Icons.toys),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(targetDateFormatter.format(targetDate.value)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () => selectDate(context),
                        child: const Text('日付選択')),
                  ),
                ],
              ),
              buildHeader(),
              ...buildTaskList(),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (workList.value.last.workDateTime.hour == 9) {
                            return;
                          }
                          workList.value = [
                            ...workList.value,
                            Work(
                              id: workList.value.length,
                              workDateTime: workList.value.last.workDateTime
                                  .add(const Duration(minutes: 30)),
                              workName: 'ぽしぇっと',
                              workDetail: 'Detail',
                              workMemo: 'Memo',
                              productId: 5,
                            )
                          ];
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
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (workList.value.length > maxWorkListLength) {
                            List<Work> tmpList =
                                List<Work>.from(workList.value);
                            tmpList.removeLast();
                            workList.value = tmpList;
                          }
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
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child: const Text(
                          "登録",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
