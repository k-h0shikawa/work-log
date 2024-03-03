import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
import 'package:work_log/app/work/presentation/widget/add_work_button.dart';
import 'package:work_log/app/work/presentation/widget/date_select_button.dart';
import 'package:work_log/app/work/presentation/widget/minus_work_button.dart';
import 'package:work_log/app/work/presentation/widget/register_work_button.dart';
import 'package:work_log/app/work/presentation/widget/work_input_table.dart';

class WorkList extends HookConsumerWidget {
  const WorkList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = useState(<InProgressProduct>[]);

    useEffect(() {
      () async {
        productList.value =
            await GetIt.I<WorkListUsecase>().fetchInProgressProductList();
      }();
      return null;
    }, []);

    const title = kReleaseMode ? '作業入力画面' : '作業入力画面（開発環境）';

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
              DateSelectButton(
                productList: productList,
              ),
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
