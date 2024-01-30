import 'package:get_it/get_it.dart';
import 'package:work_log/domain/types/in_progress_product.dart';
import 'package:work_log/infrastructure/entities/product_entity.dart';
import 'package:work_log/infrastructure/repository/in_progress_product_list_repository.dart';

class InProgressProductListUsecase {
  InProgressProductListUsecase();

  Future<List<InProgressProduct>> fetchInProgressProductList() async {
    final inProgressProductEntities =
        await GetIt.I<InProgressProductListRepository>()
            .fetchInProgressProductList();

    return inProgressProductEntities
        .map((entity) => InProgressProduct(
            id: entity.id,
            productName: entity.productName,
            isCompleted: entity.isCompleted,
            createdOn: entity.createdOn != null
                ? DateTime.parse(entity.createdOn!)
                : null,
            createdBy: entity.createdBy))
        .toList();
  }

  Future<List<InProgressProduct>> insertProduct(
      InProgressProduct product) async {
    await GetIt.I<InProgressProductListRepository>().insertProduct(
        ProductEntity(
            id: product.id,
            productName: product.productName,
            isCompleted: product.isCompleted,
            createdOn: product.createdOn.toString(),
            createdBy: product.createdBy));
    final inProgressProductEntities =
        await GetIt.I<InProgressProductListRepository>()
            .fetchInProgressProductList();

    return inProgressProductEntities
        .map((entity) => InProgressProduct(
            id: entity.id,
            productName: entity.productName,
            isCompleted: entity.isCompleted,
            createdOn: entity.createdOn != null
                ? DateTime.parse(entity.createdOn!)
                : null,
            createdBy: entity.createdBy))
        .toList();
  }
}
