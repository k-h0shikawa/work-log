import 'package:flutter/material.dart';
import 'package:work_log/setup/database/database_helper.dart';
// import 'package:flutter/rendering.dart';
import 'package:work_log/setup/router/app.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();

  // データベースを初期化
  await DatabaseHelper.instance.database;
  runApp(const MyApp());
}
