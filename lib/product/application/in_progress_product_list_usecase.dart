import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:work_log/database/entities/product_entity.dart';
import 'package:work_log/domain/entities/in_progress_product.dart';
import 'package:work_log/product/infrastructure/in_progress_product_list_repository.dart';

class InProgressProductListUsecase {
  final _logger = Logger();

  InProgressProductListUsecase();

  Future<List<InProgressProduct>> fetchInProgressProductList() async {
    try {
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
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<List<InProgressProduct>> finishProduct(int? id) async {
    if (id == null) {
      _logger.e('id is null');
      throw ArgumentError.notNull('id');
    }
    try {
      await GetIt.I<InProgressProductListRepository>().finishProduct(id: id);
      return fetchInProgressProductList();
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<List<InProgressProduct>> insertProduct(
      InProgressProduct product) async {
    try {
      await GetIt.I<InProgressProductListRepository>().insertProduct(
          ProductEntity(
              id: product.id,
              productName: product.productName,
              isCompleted: product.isCompleted,
              createdOn: product.createdOn.toString(),
              createdBy: product.createdBy));

      return fetchInProgressProductList();
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}
