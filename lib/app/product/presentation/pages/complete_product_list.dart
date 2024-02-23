import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:work_log/app/domain/entities/complete_product.dart';
import 'package:work_log/app/domain/log/messages.dart';
import 'package:work_log/app/product/application/complete_product_list_usecase.dart';
import 'package:work_log/app/product/application/state/complete_product_list_notifier.dart';
import 'package:work_log/app/product/application/state/in_progress_product_list_notifier.dart';

class CompleteProductList extends ConsumerWidget {
  const CompleteProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(completeProductListNotifierProvider).when(
          data: (data) {
            final completeProductList = data;
            return Scaffold(
              appBar: AppBar(title: const Text('完了済みの案件一覧')),
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: ListView.builder(
                    itemCount: completeProductList.length,
                    itemBuilder: (context, index) {
                      final product = completeProductList[index];
                      return buildProductRow(
                          product, completeProductList, context, ref);
                    },
                  ),
                ),
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => const Text('Error'),
        );
  }

  Widget buildProductRow(
      CompleteProduct product,
      List<CompleteProduct> completeProductList,
      BuildContext context,
      WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(child: Text(product.productName)),
          Flexible(
            child: ElevatedButton(
              onPressed: () {
                convertProductToInProgress(product, context, ref);
              },
              child: const Text('進行中へ戻す'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> convertProductToInProgress(
      CompleteProduct product, BuildContext context, WidgetRef ref) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final completeProductNotifier =
        ref.read(completeProductListNotifierProvider.notifier);
    final inProgressProductNotifier =
        ref.read(inProgressProductListNotifierProvider.notifier);
    try {
      final completeProductList = await GetIt.I<CompleteProductListUsecase>()
          .convertProductToInProgress(product.id);
      completeProductNotifier.updateState(completeProductList);

      final inProgressProductList = await GetIt.I<CompleteProductListUsecase>()
          .fetchInProgressProductList();
      inProgressProductNotifier.updateState(inProgressProductList);
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
