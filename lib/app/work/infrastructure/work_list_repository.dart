import 'package:sqflite/sqflite.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/setup/database/entities/work_entity.dart';

class WorkListRepository {
  final Database _database;

  WorkListRepository(this._database);

  Future<List<Work>> insertWork(List<WorkEntity> workList) async {
    int insertCount = 0;
    try {
      for (var work in workList) {
        insertCount = await _database.insert(
          'work',
          work.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      if (insertCount != workList.length) {
        throw Exception("Failed to insert work");
        // TODO:logを追加する
      }

      return workList.map((e) => toWork(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _convertEntityToMap(WorkEntity work) {
    return <String, dynamic>{
      "id": work.id,
      "workDateTime": work.workDateTime.toString(),
      "workName": work.workName,
      "workDetail": work.workDetail,
      "workMemo": work.workMemo,
      "createdBy": work.createdBy,
      "createdOn": work.createdOn.toString(),
      "productId": work.productId,
    };
  }

  Work toWork(WorkEntity e) {
    return Work(
      id: e.id,
      workDateTime: e.workDateTime,
      workName: e.workName,
      workDetail: e.workDetail,
      workMemo: e.workMemo,
      createdBy: e.createdBy,
      createdOn: DateTime.parse(e.createdOn!),
      productId: e.productId,
    );
  }
}
