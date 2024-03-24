import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_log/app/work/presentation/widget/add_work_button.dart';
import 'package:work_log/app/work/presentation/widget/date_select_button.dart';
import 'package:work_log/app/work/presentation/widget/minus_work_button.dart';
import 'package:work_log/app/work/presentation/widget/register_work_button.dart';
import 'package:work_log/app/work/presentation/widget/work_input_table.dart';

class WorkList extends StatelessWidget {
  const WorkList({super.key});

  @override
  Widget build(BuildContext context) {
    const title = kDebugMode ? '作業入力画面（デバッグ環境）' : '作業入力画面';

    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      floatingActionButton: const RegisterButton(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ListView(
            addAutomaticKeepAlives: true,
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
                      },
                      child: const Text('商品一覧画面'),
                    ),
                  ))
                ],
              ),
              const DateSelectButton(),
              const WorkInputTable(),
              const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AddWorkButton(),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: MinusWorkButton(),
                        ),
                      ),
                      Spacer(),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
