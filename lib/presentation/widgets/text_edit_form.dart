import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextEditForm extends HookWidget {
  const TextEditForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = useTextEditingController();
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(label: Text('新規案件')),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            print('text : $_controller.text');
          },
          child: const Text('登録'),
        ),
      ],
    );
  }
}
