import 'package:get_it/get_it.dart';
import 'package:work_log/domain/types/in_progress_product.dart';
import 'package:work_log/infrastructure/repository/complete_product_list_repository.dart';

class CompleteProductListUsecase {
  CompleteProductListUsecase();

  Future<List<InProgressProduct>> fetchCompleteProductList() async {
    final inProgressProductEntities =
        await GetIt.I<CompleteProductListRepository>()
            .fetchCompleteProductList();

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

  Future<List<InProgressProduct>> convertProductToInProgress(int? id) async {
    await GetIt.I<CompleteProductListRepository>()
        .convertProductToInProgress(id: id);

    return fetchCompleteProductList();
  }
}
