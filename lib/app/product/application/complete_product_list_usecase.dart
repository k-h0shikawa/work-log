import 'package:work_log/app/domain/entities/complete_product.dart';
import 'package:logger/logger.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/product/infrastructure/complete_product_list_repository.dart';

class CompleteProductListUsecase {
  final _logger = Logger();
  final CompleteProductListRepository _repository;

  CompleteProductListUsecase(this._repository);

  Future<List<CompleteProduct>> fetchCompleteProductList() async {
    try {
      final inProgressProductEntities =
          await _repository.fetchCompleteProductList();

      return inProgressProductEntities
          .map((entity) => CompleteProduct(
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

  Future<List<CompleteProduct>> convertProductToInProgress(int? id) async {
    if (id == null) {
      _logger.e('id is null');
      throw ArgumentError.notNull('id');
    }
    try {
      await _repository.convertProductToInProgress(id: id);

      return fetchCompleteProductList();
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<List<InProgressProduct>> fetchInProgressProductList() async {
    try {
      final inProgressProductEntities =
          await _repository.fetchInProgressProductList();

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
}
