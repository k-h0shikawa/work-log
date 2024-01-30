import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:work_log/application/usecases/complete_product_list_usecase.dart';
import 'package:work_log/domain/types/in_progress_product.dart';

class CompleteProductList extends HookWidget {
  const CompleteProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final completeProductList = useState(<InProgressProduct>[]);

    useEffect(() {
      fetchAndSetCompleteProductList(completeProductList);
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('完了済みの案件一覧')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Column(
                children: completeProductList.value.map((product) {
                  return buildProductRow(product, completeProductList);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchAndSetCompleteProductList(
      ValueNotifier<List<InProgressProduct>> completeProductList) async {
    completeProductList.value =
        await GetIt.I<CompleteProductListUsecase>().fetchCompleteProductList();
  }

  Widget buildProductRow(InProgressProduct product,
      ValueNotifier<List<InProgressProduct>> completeProductList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(child: Text(product.productName)),
          Flexible(
            child: ElevatedButton(
              onPressed: () =>
                  convertProductToInProgress(product, completeProductList),
              child: const Text('進行中へ戻す'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> convertProductToInProgress(InProgressProduct product,
      ValueNotifier<List<InProgressProduct>> completeProductList) async {
    completeProductList.value = await GetIt.I<CompleteProductListUsecase>()
        .convertProductToInProgress(product.id);
  }
}
