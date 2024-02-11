import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:intl/intl.dart';
import 'package:work_log/app/domain/log/messages.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';

class WorkList extends HookWidget {
  const WorkList({super.key});

  @override
  Widget build(BuildContext context) {
    const header = <String>['時間', '商品名', '作業内容', '作業メモ'];
    final formatter = DateFormat('HH:mm');
    final targetDateFormatter = DateFormat('yyyy/MM/dd');
    final targetDate = useState(DateTime.now());
    const maxWorkListLength = 1;
    const flexRate = [1, 3, 3, 3];
    final workList = useState(<Work>[
      for (var i = 0; i < 20; i++)
        Work(
            workDateTime:
                DateTime(2024, 1, 1, 9, 30).add(Duration(minutes: 30 * i)),
            workName: '商品123',
            workDetail: '',
            workMemo: '',
            productId: 1,
            createdOn: DateTime.now(),
            createdBy: 'hoshikawa'),
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
        children: header.asMap().entries.map((entry) {
          int idx = entry.key;
          String value = entry.value;
          return Expanded(
            flex: flexRate[idx],
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                value,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }).toList(),
      );
    }

    List<Widget> buildTaskList() {
      final productList = useState(<InProgressProduct>[]);
      useEffect(() {
        () async {
          productList.value =
              await GetIt.I<WorkListUsecase>().fetchInProgressProductList();
        }();
        return null;
      }, []);

      return workList.value.map((work) {
        final workDetailController =
            useTextEditingController(text: work.workDetail);
        final workMemoController =
            useTextEditingController(text: work.workMemo);
        var selectedProduct = useState<String>(work.workName);

        return Row(
          children: <Widget>[
            Expanded(
              flex: flexRate[0],
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(formatter.format(work.workDateTime)),
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
                    items: productList.value.map<DropdownMenuItem<String>>(
                        (InProgressProduct product) {
                      return DropdownMenuItem<String>(
                          value: product.productName,
                          child: Text(
                            product.productName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 10),
                          ));
                    }).toList()),
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
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('作業入力画面')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () => context.push('/product'),
                      child: const Text('商品一覧画面'),
                    ),
                  ))
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(targetDateFormatter.format(targetDate.value)),
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
              ),
              buildHeader(),
              ...buildTaskList(),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: () {
                              if (workList.value.last.workDateTime.hour == 9) {
                                return;
                              }
                              workList.value = [
                                ...workList.value,
                                Work(
                                    id: workList.value.length,
                                    workDateTime: workList
                                        .value.last.workDateTime
                                        .add(const Duration(minutes: 30)),
                                    workName: '',
                                    workDetail: '',
                                    workMemo: '',
                                    productId: 5,
                                    createdOn: DateTime.now(),
                                    createdBy: 'user')
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
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
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
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () async {
                              final scaffoldMessenger =
                                  ScaffoldMessenger.of(context);
                              workList.value = await GetIt.I<WorkListUsecase>()
                                  .insertWork(workList.value);
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
