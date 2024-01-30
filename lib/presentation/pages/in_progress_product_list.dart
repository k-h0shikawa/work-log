import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:work_log/application/usecases/in_progress_product_list_usecase.dart';
import 'package:work_log/domain/types/in_progress_product.dart';
import 'package:work_log/presentation/widgets/create_pdf_button.dart';

class InProgressProductList extends HookWidget {
  const InProgressProductList({super.key});

  @override
  Widget build(BuildContext context) {
    var inProgressProductList = useState<List<InProgressProduct>>([]);
    useEffect(() {
      () async {
        inProgressProductList.value =
            await GetIt.I<InProgressProductListUsecase>()
                .fetchInProgressProductList();
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
              _buildButtonBar(context),
              _buildProductList(inProgressProductList),
              const SizedBox(height: 20),
              _buildAddProductRow(controller, inProgressProductList),
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
          onPressed: () => context.push('/product/complete'),
          child: const Text('完了済み商品一覧画面'),
        ),
      ],
    );
  }

  Widget _buildProductList(
      ValueNotifier<List<InProgressProduct>> inProgressProductList) {
    return Column(
      children: inProgressProductList.value.map((product) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(flex: 1, child: Text(product.productName)),
              const Spacer(flex: 3),
              const Flexible(flex: 1, child: CreatePDFButton()),
              Flexible(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('完了'),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAddProductRow(TextEditingController controller,
      ValueNotifier<List<InProgressProduct>> inProgressProductList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(label: Text('新規商品')),
          ),
        ),
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              () async {
                inProgressProductList.value =
                    await GetIt.I<InProgressProductListUsecase>().insertProduct(
                        InProgressProduct(
                            productName: controller.text,
                            isCompleted: 0,
                            createdOn: DateTime.now(),
                            createdBy: 'user'));
              }();
              /*
              inProgressProductList.value = [
                ...inProgressProductList.value,
                InProgressProduct(
                    id: inProgressProductList.value.length,
                    productName: controller.text,
                    isCompleted: 0,
                    createdOn: DateTime.now(),
                    createdBy: 'hoshikawa')
              ];
              */
            },
            child: const Text('登録'),
          ),
        ),
      ],
    );
  }
}
