import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:work_log/app/domain/entities/complete_product.dart';
import 'package:work_log/app/domain/log/messages.dart';
import 'package:work_log/app/product/application/complete_product_list_usecase.dart';

class CompleteProductList extends HookWidget {
  const CompleteProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final completeProductList = useState(<CompleteProduct>[]);
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
      ValueNotifier<List<CompleteProduct>> completeProductList,
      ScaffoldMessengerState scaffoldMessenger) async {
    try {
      completeProductList.value = await GetIt.I<CompleteProductListUsecase>()
          .fetchCompleteProductList();
    } catch (e) {
      // データの取得に失敗した場合は、エラーを画面に表示する
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(Messages.failureFetch),
        ),
      );
    }
  }

  Widget buildProductRow(
      CompleteProduct product,
      ValueNotifier<List<CompleteProduct>> completeProductList,
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
      CompleteProduct product,
      ValueNotifier<List<CompleteProduct>> completeProductList,
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
              Messages.successConvertProductToInProgress(product.productName)),
        ),
      );
    } catch (e) {
      // データ更新に失敗した場合は、エラーを画面に表示する
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(Messages.failureUpdate),
        ),
      );
    }
  }
}