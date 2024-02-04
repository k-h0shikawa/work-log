import 'package:logger/logger.dart';
import 'package:work_log/app/work/infrastructure/work_list_repository.dart';

class WorkListUseCase {
  final _logger = Logger();
  final WorkListRepository _repository;
  WorkListUseCase(this._repository);
}
