import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:work_log/setup/database/database_helper.dart';
import 'package:work_log/setup/di/service_locator.dart';
// import 'package:flutter/rendering.dart';
import 'package:work_log/setup/router/app.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();

  // データベースを初期化
  final database = await DatabaseHelper.instance.database;

  // サービスロケーターを登録
  ServiceLocator.setupServiceLocator(database);

  const app = MyApp();
  const scope = ProviderScope(child: app);
  runApp(scope);
}
