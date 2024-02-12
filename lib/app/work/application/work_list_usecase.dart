import 'package:logger/logger.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/app/work/infrastructure/work_list_repository.dart';

class WorkListUsecase {
  final _logger = Logger();
  final WorkListRepository _repository;
  static const startWorkTime = 9;

  final defaultWorkList = <Work>[
    for (var i = 0; i < 20; i++)
      Work(
          workDateTime: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 9, 30)
              .add(Duration(minutes: 30 * i)),
          workDetail: '',
          workMemo: '',
          productId: 1, // TODO: 要修正
          createdOn: DateTime.now(),
          createdBy: 'user'),
  ];

  WorkListUsecase(this._repository);

  Future<List<Work>> initWorkList(DateTime workDateTime) async {
    var targetStartTime = DateTime(1966, 1, 1);
    var targetEndTime = DateTime(1966, 1, 1);

    final hour = workDateTime.hour;

    if (hour < startWorkTime) {
      // 9時より前の場合は前日の9時から当日の9時までの業務を表示
      targetStartTime = DateTime(
          workDateTime.year, workDateTime.month, workDateTime.day - 1, 9, 0, 0);
      targetEndTime = DateTime(
          workDateTime.year, workDateTime.month, workDateTime.day, 9, 0, 0);
    } else {
      // 9時以降の場合は当日の9時から翌日の9時までの業務を表示
      targetStartTime = DateTime(
          workDateTime.year, workDateTime.month, workDateTime.day, 9, 0, 0);
      targetEndTime = DateTime(
          workDateTime.year, workDateTime.month, workDateTime.day + 1, 9, 0, 0);
    }

    try {
      final targetWorkList = await _repository.getWorksWithinDateRange(
          targetStartTime, targetEndTime);
      // 対象日の業務がない場合はデフォルトの業務を返す
      if (targetWorkList.isEmpty) return defaultWorkList;
      return targetWorkList;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<List<Work>> saveWork(List<Work> workList) async {
    var insertList = <Work>[];
    var updateList = <Work>[];

    for (final work in workList) {
      if (work.id == null) {
        insertList.add(work);
      } else {
        updateList.add(work);
      }
    }

    try {
      final insertedIds = await _repository.saveWork(insertList, updateList);
      final savedWorks = _repository.fetchWorksById(insertedIds);
      return savedWorks;
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
