import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:work_log/domain/types/product.dart';
import 'package:work_log/presentation/widgets/create_pdf_button.dart';

class ProductList extends HookWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final productList = useState(<Product>[
      const Product(id: 0, productName: 'ダミー案件', status: 0),
      const Product(id: 1, productName: 'ぽしぇっと', status: 0)
    ]);

    final _controller = useTextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('進行中の商品一覧')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              ButtonBar(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => context.push('/product/complete'),
                    label: const Text('完了済み商品一覧画面'),
                    icon: Icon(Icons.check_circle_outline),
                  ),
                ],
              ),
              Column(
                children: productList.value.map((product) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(product.productName),
                            const Spacer(),
                            const CreatePDFButton(),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('完了'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(label: Text('新規商品')),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      productList.value = [
                        ...productList.value,
                        Product(
                          id: 2,
                          productName: _controller.text,
                          status: 0,
                        )
                      ];
                    },
                    child: const Text('登録'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
