import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_log/app/product/application/complete_product_list_usecase.dart';
import 'package:work_log/app/product/application/in_progress_product_list_usecase.dart';
import 'package:work_log/app/product/infrastructure/complete_product_list_repository.dart';
import 'package:work_log/app/product/infrastructure/in_progress_product_list_repository.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
import 'package:work_log/app/work/infrastructure/work_list_repository.dart';

class ServiceLocator {
  static Future<void> setupServiceLocator(Database database) async {
    // InProgressProductList関連
    registerSingletonIfNotRegistered<InProgressProductListRepository>(
        InProgressProductListRepository(database));
    registerSingletonIfNotRegistered<InProgressProductListUsecase>(
        InProgressProductListUsecase(
            InProgressProductListRepository(database)));

    // CompleteProductList関連
    registerSingletonIfNotRegistered<CompleteProductListRepository>(
        CompleteProductListRepository(database));
    registerSingletonIfNotRegistered<CompleteProductListUsecase>(
        CompleteProductListUsecase(CompleteProductListRepository(database)));

    // WorkList関連
    registerSingletonIfNotRegistered<WorkListRepository>(
        WorkListRepository(database));
    registerSingletonIfNotRegistered<WorkListUseCase>(
        WorkListUseCase(WorkListRepository(database)));
  }

  // 登録されていない場合、シングルトンを登録する
  static void registerSingletonIfNotRegistered<T extends Object>(T instance) {
    if (!GetIt.I.isRegistered<T>()) {
      GetIt.I.registerLazySingleton<T>(() => instance);
    }
  }
}
