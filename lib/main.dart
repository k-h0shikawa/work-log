import 'package:flutter/material.dart';
import 'package:work_log/database/database_helper.dart';
// import 'package:flutter/rendering.dart';
import 'package:work_log/router/app.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();

  // データベースを初期化
  await DatabaseHelper.instance.database;
  runApp(const MyApp());
}
