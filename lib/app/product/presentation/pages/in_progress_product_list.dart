import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/log/messages.dart';
import 'package:work_log/app/product/application/in_progress_product_list_usecase.dart';
import 'package:work_log/app/product/application/state/in_progress_product_list_notifier.dart';
import 'package:work_log/app/product/presentation/widgets/create_pdf_button.dart';

class InProgressProductList extends ConsumerWidget {
  const InProgressProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('進行中の商品一覧')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ListView(
            children: [
              _buildButtonBar(context),
              _buildProductList(context, ref),
              const SizedBox(height: 20),
              _buildAddProductRow(controller, context, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonBar(BuildContext context) {
    return ButtonBar(
      children: [
        ElevatedButton(
          onPressed: () async {
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            try {
              await context.push('/product/complete');
            } catch (e) {
              scaffoldMessenger.showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(Messages.failureFetch),
                ),
              );
            }
          },
          child: const Text('完了済み商品一覧画面'),
        ),
      ],
    );
  }

  Widget _buildProductList(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(inProgressProductListNotifierProvider.notifier);

    return ref.watch(inProgressProductListNotifierProvider).when(
        data: (inProgressProductList) {
          return Column(
            children: inProgressProductList.map((product) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Text(product.productName),
                    ),
                    Flexible(child: CreatePDFButton(productId: product.id!)),
                    const SizedBox(width: 8.0), // ボタン間のスペース
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {
                          () async {
                            final scaffoldMessenger =
                                ScaffoldMessenger.of(context);

                            try {
                              final updateProductList =
                                  await GetIt.I<InProgressProductListUsecase>()
                                      .finishProduct(product.id);
                              notifier.updateState(updateProductList);
                              // 成功時のフィードバック
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                      Messages.successConvertProductToComplete(
                                          product.productName)),
                                ),
                              );
                            } catch (e) {
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(Messages.failureUpdate),
                                ),
                              );
                            }
                          }();
                        },
                        child: const Text('完了'),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) {
          return const Text('Error');
        });
  }

  Widget _buildAddProductRow(
      TextEditingController controller, BuildContext context, WidgetRef ref) {
    final notifier = ref.read(inProgressProductListNotifierProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 6,
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(label: Text('新規商品')),
            maxLength: 20,
          ),
        ),
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              () async {
                final scaffoldMessenger = ScaffoldMessenger.of(context);

                try {
                  final productList =
                      await GetIt.I<InProgressProductListUsecase>()
                          .insertProduct(InProgressProduct(
                              productName: controller.text,
                              isCompleted: 0,
                              createdOn: DateTime.now(),
                              createdBy: 'user'));
                  notifier.updateState(productList);
                  // 成功時のフィードバック
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                          Messages.successRegisterProduct(controller.text)),
                    ),
                  );
                } catch (e) {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(Messages.failureUpdate),
                    ),
                  );
                }
              }();
            },
            child: const Text('登録'),
          ),
        ),
      ],
    );
  }
}
