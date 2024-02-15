import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:intl/intl.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
import 'package:work_log/app/work/presentation/widget/register_work_button.dart';
import 'package:work_log/app/work/presentation/widget/work_input_row.dart';

class WorkList extends HookWidget {
  const WorkList({super.key});

  @override
  Widget build(BuildContext context) {
    const header = <String>['ID', '時間', '商品名', '作業内容', '作業メモ'];
    final targetDateFormatter = DateFormat('yyyy/MM/dd');
    final targetDate = useState(DateTime.now());
    const maxInputWorkListLength = 1;
    const flexRate = [1, 1, 3, 3, 3];
    final workList = useState(<Work>[]);
    // 入力された作業情報を保持するリスト
    final inputWorkList = useState(<WorkInputRow>[]);
    final productList = useState(<InProgressProduct>[]);
    final removeInputWorkList = <WorkInputRow>[];

    List<WorkInputRow> convertWorkListToInputWorkList(List<Work> workList) {
      return workList.map((work) {
        // 進行中の商品名のドロップダウンリストを作成
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
            .where((element) => element.id == work.productId)
            .isEmpty) {
          dropDownButtonMenu.add(DropdownMenuItem<String>(
            value: work.productId.toString(),
            child: Text(
              work.productName!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10),
            ),
          ));
        }

        return WorkInputRow(
          workId: work.id,
          workDateTime: work.workDateTime,
          workDetailController: work.workDetailController,
          workMemoController: work.workMemoController,
          dropDownButtonMenu: dropDownButtonMenu,
          selectedProductId: work.productId,
          productName: work.productName!,
        );
      }).toList();
    }

    useEffect(() {
      () async {
        productList.value =
            await GetIt.I<WorkListUsecase>().fetchInProgressProductList();
        workList.value =
            await GetIt.I<WorkListUsecase>().initWorkList(DateTime.now());
        inputWorkList.value = convertWorkListToInputWorkList(workList.value);
      }();
      return null;
    }, []);

    List<WorkInputRow> convertInputWorkListToInputWorkList(
        List<Work> workList) {
      return inputWorkList.value.map((work) {
        // 進行中の商品名のドロップダウンリストを作成
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
            .where((element) => element.id == work.selectedProductId)
            .isEmpty) {
          dropDownButtonMenu.add(DropdownMenuItem<String>(
            value: work.selectedProductId.toString(),
            child: Text(
              work.productName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10),
            ),
          ));
        }

        return WorkInputRow(
          workId: work.workId,
          workDateTime: work.workDateTime,
          workDetailController: work.workDetailController,
          workMemoController: work.workMemoController,
          dropDownButtonMenu: dropDownButtonMenu,
          selectedProductId: work.selectedProductId,
          productName: work.productName,
        );
      }).toList();
    }

    useEffect(() {
      () async {
        productList.value =
            await GetIt.I<WorkListUsecase>().fetchInProgressProductList();
        workList.value =
            await GetIt.I<WorkListUsecase>().initWorkList(DateTime.now());
        inputWorkList.value = convertWorkListToInputWorkList(workList.value);
      }();
      return null;
    }, []);

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
        inputWorkList.value = convertWorkListToInputWorkList(workList.value);

        removeInputWorkList.clear();
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
                        // productページから戻ってきたときに最新の進行中商品リストを取得する。
                        productList.value = await GetIt.I<WorkListUsecase>()
                            .fetchInProgressProductList();
                        inputWorkList.value =
                            convertInputWorkListToInputWorkList(workList.value);
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
              ...inputWorkList.value,
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
                              print("press ＋ button");
                              print("inputWorkList: $inputWorkList");
                              print(
                                  "removeInputWorkList: $removeInputWorkList");
                              if (workList.value.last.workDateTime.hour == 9) {
                                return;
                              }

                              if (removeInputWorkList.isNotEmpty) {
                                inputWorkList.value = [
                                  ...inputWorkList.value,
                                  removeInputWorkList.removeAt(0)
                                ];
                                print("inputWorkList: $inputWorkList");
                                print(
                                    "removeInputWorkList: $removeInputWorkList");
                                return;
                              }

                              inputWorkList.value = [
                                ...inputWorkList.value,
                                WorkInputRow(
                                  workDateTime: inputWorkList
                                      .value.last.workDateTime
                                      .add(const Duration(minutes: 30)),
                                  workDetailController: TextEditingController(),
                                  workMemoController: TextEditingController(),
                                  dropDownButtonMenu: productList.value
                                      .map<DropdownMenuItem<String>>(
                                          (InProgressProduct product) {
                                    return DropdownMenuItem<String>(
                                      value: product.id.toString(),
                                      child: Text(
                                        product.productName,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    );
                                  }).toList(),
                                  selectedProductId: productList.value.first.id,
                                  productName:
                                      productList.value.first.productName,
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
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: () {
                              print("press ー button");
                              print(
                                  "removeInputWorkList: $removeInputWorkList");
                              if (inputWorkList.value.length >
                                  maxInputWorkListLength) {
                                List<WorkInputRow> tmpList =
                                    List<WorkInputRow>.from(
                                        inputWorkList.value);
                                removeInputWorkList.add(tmpList.removeLast());
                                inputWorkList.value = tmpList;
                              }
                              print(
                                  "removeInputWorkList: $removeInputWorkList");
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
                          child: RegisterButton(
                              inputWorkList: inputWorkList.value,
                              workList: workList),
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
