import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:work_log/domain/types/project.dart';
import 'package:work_log/presentation/widgets/create_pdf_button.dart';

class ProductList extends HookWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final productList = useState(<Project>[
      const Project(id: 0, projectName: 'ダミー案件', status: 0),
      const Project(id: 1, projectName: 'ぽしぇっと', status: 0)
    ]);

    final _controller = useTextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('WORK LOG')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '進行中の商品一覧',
                style: TextStyle(fontSize: 24),
              ),
              Column(
                children: productList.value.map((project) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(project.projectName),
                            const CreatePDFButton()
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
                      decoration: const InputDecoration(label: Text('新規案件')),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      productList.value = [
                        ...productList.value,
                        Project(
                          id: 2,
                          projectName: _controller.text,
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
