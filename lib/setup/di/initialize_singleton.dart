import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_log/app/product/application/complete_product_list_usecase.dart';
import 'package:work_log/app/product/application/in_progress_product_list_usecase.dart';
import 'package:work_log/app/product/infrastructure/complete_product_list_repository.dart';
import 'package:work_log/app/product/infrastructure/in_progress_product_list_repository.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
import 'package:work_log/app/work/infrastructure/work_list_repository.dart';

class InitializeSingleton {
  static Future<void> registerSingletons() async {
    final database = await openDatabase('WorkLog.db');

    // InProgressProductListUseCaseとInProgressProductListRepositoryを登録
    registerSingletonIfNotRegistered<InProgressProductListUsecase>(
        InProgressProductListUsecase());
    registerSingletonIfNotRegistered<InProgressProductListRepository>(
        InProgressProductListRepository(database));

    // CompleteProductListUseCaseとCompleteProductListRepositoryを登録
    registerSingletonIfNotRegistered<CompleteProductListUsecase>(
        CompleteProductListUsecase());
    registerSingletonIfNotRegistered<CompleteProductListRepository>(
        CompleteProductListRepository(database));

    // WorkListUseCaseとWorkListRepositoryを登録
    registerSingletonIfNotRegistered<WorkListUseCase>(WorkListUseCase());
    registerSingletonIfNotRegistered<WorkListRepository>(
        WorkListRepository(database));
  }

  // 登録されていない場合、シングルトンを登録する
  static void registerSingletonIfNotRegistered<T extends Object>(T instance) {
    if (!GetIt.I.isRegistered<T>()) {
      GetIt.I.registerSingleton<T>(instance);
    }
  }
}
