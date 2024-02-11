import 'package:logger/logger.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/app/work/infrastructure/work_list_repository.dart';

class WorkListUsecase {
  final _logger = Logger();
  final WorkListRepository _repository;
  WorkListUsecase(this._repository);

  Future<List<Work>> insertWork(List<Work> workList) async {
    try {
      final insertedIds = await _repository.insertWork(workList);
      final insertedWorks = _repository.fetchWorks(insertedIds);
      return insertedWorks;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<List<InProgressProduct>> fetchInProgressProductList() async {
    try {
      return await _repository.fetchInProgressProductList();
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}
