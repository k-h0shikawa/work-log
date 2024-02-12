import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:intl/intl.dart';
import 'package:work_log/app/domain/log/messages.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
import 'package:work_log/app/work/presentation/input/input_work.dart';

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
    final workList = useState(<Work>[]);
    // 入力された作業情報を保持するリスト
    final inputWorkList = useState(<InputWork>[]);

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: targetDate.value,
          firstDate: DateTime(2016),
          lastDate: DateTime.now().add(const Duration(days: 360)));
      if (picked != null && picked != targetDate.value) {
        targetDate.value = picked;

        // targetDateが更新されたら、inputWorkListも更新する
        workList.value =
            await GetIt.I<WorkListUsecase>().fetchWorkListByDate(picked);

        // workListの内容をinputWorkListへ詰め替える
        inputWorkList.value.clear();
        for (final work in workList.value) {
          inputWorkList.value.add(InputWork(
              workId: work.id,
              workDateTime: work.workDateTime,
              workDetailController: work.workDetailController,
              workMemoController: work.workMemoController,
              selectedProductId: work.productId,
              productName: work.productName!));
        }
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
          workList.value =
              await GetIt.I<WorkListUsecase>().initWorkList(DateTime.now());

          // workListの内容をinputWorkListへ詰め替える
          for (final work in workList.value) {
            inputWorkList.value.add(InputWork(
                workId: work.id,
                workDateTime: work.workDateTime,
                workDetailController: work.workDetailController,
                workMemoController: work.workMemoController,
                selectedProductId: work.productId,
                productName: work.productName!));
          }
        }();
        return null;
      }, []);

      // 追加
      return inputWorkList.value.map((inputWork) {
        var selectedProductIdForDisplay =
            useState<int>(inputWork.selectedProductId);
        final dropDownButtonMenu =
            productList.value.map<DropdownMenuItem<String>>(
          (InProgressProduct product) {
            return DropdownMenuItem<String>(
              value: product.id.toString(),
              child: Text(
                product.productName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10),
              ),
            );
          },
        ).toList();

        // 未登録の商品をドロップダウンリストに追加
        if (productList.value
            .where((element) => element.id == inputWork.selectedProductId)
            .isEmpty) {
          dropDownButtonMenu.add(DropdownMenuItem<String>(
            value: inputWork.selectedProductId.toString(),
            child: Text(
              inputWork.productName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10),
            ),
          ));
        }

        return Row(
          children: <Widget>[
            Expanded(
              flex: flexRate[0],
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(formatter.format(inputWork.workDateTime)),
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
                  value: inputWork.selectedProductId.toString(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      inputWork.selectedProductId = int.parse(newValue);
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
                  controller: inputWork.workDetailController,
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
                  controller: inputWork.workMemoController,
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
                      onPressed: () async {
                        context.push('/product');
                        // TODO: 画面遷移後に最新の進行中商品リストを取得する。
                      },
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
                                    workDetail: '',
                                    workMemo: '',
                                    productId: 1,
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
                              // 登録対象の作業リストを作成
                              var registerWorks = inputWorkList.value
                                  .map((inputWork) => Work(
                                        id: inputWork.workId,
                                        workDateTime: inputWork.workDateTime,
                                        workDetail:
                                            inputWork.workDetailController.text,
                                        workMemo:
                                            inputWork.workMemoController.text,
                                        productId: inputWork.selectedProductId,
                                      ))
                                  .toList();

                              workList.value = await GetIt.I<WorkListUsecase>()
                                  .saveWork(registerWorks);

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
