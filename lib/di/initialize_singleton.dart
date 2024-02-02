import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_log/product/application/complete_product_list_usecase.dart';
import 'package:work_log/product/application/in_progress_product_list_usecase.dart';
import 'package:work_log/product/infrastructure/complete_product_list_repository.dart';
import 'package:work_log/product/infrastructure/in_progress_product_list_repository.dart';

class InitializeSingleton {
  static Future<void> registerSingletons() async {
    final database = await openDatabase('WorkLog.db');

    registerSingletonIfNotRegistered<InProgressProductListUsecase>(
        InProgressProductListUsecase());
    registerSingletonIfNotRegistered<InProgressProductListRepository>(
        InProgressProductListRepository(database));
    registerSingletonIfNotRegistered<CompleteProductListUsecase>(
        CompleteProductListUsecase());
    registerSingletonIfNotRegistered<CompleteProductListRepository>(
        CompleteProductListRepository(database));
  }

  // 登録されていない場合、シングルトンを登録する
  static void registerSingletonIfNotRegistered<T extends Object>(T instance) {
    if (!GetIt.I.isRegistered<T>()) {
      GetIt.I.registerSingleton<T>(instance);
    }
  }
}
