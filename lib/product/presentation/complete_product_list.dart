import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:work_log/domain/entities/in_progress_product.dart';
import 'package:work_log/product/application/complete_product_list_usecase.dart';
import 'package:work_log/domain/log/messages.dart';

class CompleteProductList extends HookWidget {
  const CompleteProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final completeProductList = useState(<InProgressProduct>[]);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    useEffect(() {
      fetchAndSetCompleteProductList(completeProductList, scaffoldMessenger);
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('完了済みの案件一覧')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ListView.builder(
            itemCount: completeProductList.value.length,
            itemBuilder: (context, index) {
              final product = completeProductList.value[index];
              return buildProductRow(product, completeProductList, context);
            },
          ),
        ),
      ),
    );
  }

  Future<void> fetchAndSetCompleteProductList(
      ValueNotifier<List<InProgressProduct>> completeProductList,
      ScaffoldMessengerState scaffoldMessenger) async {
    try {
      completeProductList.value = await GetIt.I<CompleteProductListUsecase>()
          .fetchCompleteProductList();
    } catch (e) {
      // データの取得に失敗した場合は、エラーを画面に表示する
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(messages.failureFetch),
        ),
      );
    }
  }

  Widget buildProductRow(
      InProgressProduct product,
      ValueNotifier<List<InProgressProduct>> completeProductList,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(child: Text(product.productName)),
          Flexible(
            child: ElevatedButton(
              onPressed: () {
                convertProductToInProgress(
                    product, completeProductList, context);
              },
              child: const Text('進行中へ戻す'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> convertProductToInProgress(
      InProgressProduct product,
      ValueNotifier<List<InProgressProduct>> completeProductList,
      BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      completeProductList.value = await GetIt.I<CompleteProductListUsecase>()
          .convertProductToInProgress(product.id);
      // 成功時のフィードバックを追加
      scaffoldMessenger.showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
              messages.successConvertProductToInProgress(product.productName)),
        ),
      );
    } catch (e) {
      // データ更新に失敗した場合は、エラーを画面に表示する
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(messages.failureUpdate),
        ),
      );
    }
  }
}
