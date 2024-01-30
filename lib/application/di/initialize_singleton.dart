import 'package:get_it/get_it.dart';
import 'package:work_log/application/usecases/in_progress_product_list_usecase.dart';
import 'package:work_log/infrastructure/repository/in_progress_product_list_repository.dart';

class InitializeSingleton {
  static void registerSingletons() {
    if (!GetIt.I.isRegistered<InProgressProductListUsecase>()) {
      GetIt.I.registerSingleton<InProgressProductListUsecase>(
          InProgressProductListUsecase());
    }
    if (!GetIt.I.isRegistered<InProgressProductListRepository>()) {
      GetIt.I.registerSingleton<InProgressProductListRepository>(
          InProgressProductListRepository());
    }
  }
}
