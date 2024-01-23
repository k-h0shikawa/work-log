import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:work_log/domain/types/product.dart';

class CompleteProductList extends HookWidget {
  const CompleteProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final productList = useState(<Product>[
      const Product(id: 0, productName: 'パジャマ', isCompleted: false),
      const Product(id: 1, productName: '討伐', isCompleted: false)
    ]);

    return Scaffold(
      appBar: AppBar(title: const Text('完了済みの案件一覧')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Column(
                children: productList.value.map((product) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(child: Text(product.productName)),
                            Flexible(
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('進行中へ戻す')))
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
