import 'package:get_it/get_it.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/product/infrastructure/complete_product_list_repository.dart';
import 'package:logger/logger.dart';

class CompleteProductListUsecase {
  final _logger = Logger();

  CompleteProductListUsecase();

  Future<List<InProgressProduct>> fetchCompleteProductList() async {
    try {
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
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<List<InProgressProduct>> convertProductToInProgress(int? id) async {
    if (id == null) {
      _logger.e('id is null');
      throw ArgumentError.notNull('id');
    }
    try {
      await GetIt.I<CompleteProductListRepository>()
          .convertProductToInProgress(id: id);

      return fetchCompleteProductList();
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}
