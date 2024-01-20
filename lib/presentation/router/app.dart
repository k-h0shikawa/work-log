import 'package:flutter/material.dart';
import 'package:work_log/presentation/pages/product_list.dart';
import 'package:work_log/presentation/pages/work_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Log',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const ProductList(),
      home: const WorkList(),
    );
  }
}
