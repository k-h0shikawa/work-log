import 'package:get_it/get_it.dart';
import 'package:work_log/domain/types/in_progress_product.dart';
import 'package:work_log/infrastructure/repository/in_progress_product_list_repository.dart';

class InProgressProductListUsecase {
  InProgressProductListUsecase();

  Future<List<InProgressProduct>> fetchInProgressProductList() async {
    print("use InProgressProductListUsecase");
    final inProgressProductEntities =
        await GetIt.I<InProgressProductListRepository>()
            .fetchInProgressProductList();
    final List<InProgressProduct> inProgressProducts = inProgressProductEntities
        .map((entity) => InProgressProduct(
            id: entity.id,
            productName: entity.productName,
            isCompleted: entity.isCompleted,
            createdOn: DateTime.parse(entity.createdOn),
            createdBy: entity.createdBy))
        .toList();
    print(inProgressProducts);
    return inProgressProducts;
  }
}
