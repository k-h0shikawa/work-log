import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:work_log/domain/entities/in_progress_product.dart';
import 'package:work_log/product/application/in_progress_product_list_usecase.dart';
import 'package:work_log/domain/log/Messages.dart';
import 'package:work_log/product/presentation/widgets/create_pdf_button.dart';

class InProgressProductList extends HookWidget {
  const InProgressProductList({super.key});

  @override
  Widget build(BuildContext context) {
    var inProgressProductList = useState<List<InProgressProduct>>([]);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    useEffect(() {
      () async {
        try {
          inProgressProductList.value =
              await GetIt.I<InProgressProductListUsecase>()
                  .fetchInProgressProductList();
        } catch (e) {
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(Messages.failureUpdate),
            ),
          );
        }
      }();
      return null;
    }, []);

    final controller = useTextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('進行中の商品一覧')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ListView(
            children: [
              _buildButtonBar(context, inProgressProductList),
              _buildProductList(inProgressProductList, context),
              const SizedBox(height: 20),
              _buildAddProductRow(controller, inProgressProductList, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonBar(BuildContext context,
      ValueNotifier<List<InProgressProduct>> inProgressProductList) {
    return ButtonBar(
      children: [
        ElevatedButton(
          onPressed: () async {
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            try {
              await context.push('/product/complete');
              // 上記のpushされた画面で戻るボタンを押したときに、最新のリストを取得する
              inProgressProductList.value =
                  await GetIt.I<InProgressProductListUsecase>()
                      .fetchInProgressProductList();
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

  Widget _buildProductList(
      ValueNotifier<List<InProgressProduct>> inProgressProductList,
      BuildContext context) {
    return Column(
      children: inProgressProductList.value.map((product) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Text(product.productName),
              ),
              const Flexible(child: CreatePDFButton()),
              const SizedBox(width: 8.0), // ボタン間のスペース
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    () async {
                      final scaffoldMessenger = ScaffoldMessenger.of(context);

                      try {
                        inProgressProductList.value =
                            await GetIt.I<InProgressProductListUsecase>()
                                .finishProduct(product.id);
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
  }

  Widget _buildAddProductRow(
      TextEditingController controller,
      ValueNotifier<List<InProgressProduct>> inProgressProductList,
      BuildContext context) {
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
                  inProgressProductList.value =
                      await GetIt.I<InProgressProductListUsecase>()
                          .insertProduct(InProgressProduct(
                              productName: controller.text,
                              isCompleted: 0,
                              createdOn: DateTime.now(),
                              createdBy: 'user'));
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
