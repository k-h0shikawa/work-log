import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_log/application/usecases/complete_product_list_usecase.dart';
import 'package:work_log/application/usecases/in_progress_product_list_usecase.dart';
import 'package:work_log/infrastructure/repository/complete_product_list_repository.dart';
import 'package:work_log/infrastructure/repository/in_progress_product_list_repository.dart';

class InitializeSingleton {
  static Future<void> registerSingletons() async {
    final database = await openDatabase('WorkLog.db');

    if (!GetIt.I.isRegistered<InProgressProductListUsecase>()) {
      GetIt.I.registerSingleton<InProgressProductListUsecase>(
          InProgressProductListUsecase());
    }
    if (!GetIt.I.isRegistered<InProgressProductListRepository>()) {
      GetIt.I.registerSingleton<InProgressProductListRepository>(
          InProgressProductListRepository(database));
    }
    if (!GetIt.I.isRegistered<CompleteProductListUsecase>()) {
      GetIt.I.registerSingleton<CompleteProductListUsecase>(
          CompleteProductListUsecase());
    }
    if (!GetIt.I.isRegistered<CompleteProductListRepository>()) {
      GetIt.I.registerSingleton<CompleteProductListRepository>(
          CompleteProductListRepository(database));
    }
  }
}
