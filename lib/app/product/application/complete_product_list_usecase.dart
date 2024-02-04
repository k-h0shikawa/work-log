import 'package:work_log/app/domain/entities/complete_product.dart';
import 'package:logger/logger.dart';
import 'package:work_log/app/product/infrastructure/complete_product_list_repository.dart';

class CompleteProductListUsecase {
  final _logger = Logger();
  final CompleteProductListRepository _repository;

  CompleteProductListUsecase(this._repository);

  Future<List<CompleteProduct>> fetchCompleteProductList() async {
    try {
      return await _repository.fetchCompleteProductList();
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
}