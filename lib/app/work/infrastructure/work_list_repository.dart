import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/setup/database/entities/product_entity.dart';
import 'package:work_log/setup/database/entities/work_entity.dart';

class WorkListRepository {
  final Logger _logger = Logger();
  final Database _database;

  WorkListRepository(this._database);

  Future<List<Work>> fetchWorks(List<int> workIds) async {
    try {
      final result = await _database.query(
        'work',
        where: 'id IN (${workIds.map((id) => '?').join(', ')})',
        whereArgs: workIds,
      );

      // DBから受け取ったデータをEntityを経由してドメインモデルに変換
      return result.map((Map<String, dynamic> m) {
        return WorkEntity.fromMap(m).toWork();
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<int>> insertWork(List<Work> workList) async {
    try {
      var insertTaskIds = <int>[];

      await _database.transaction((txn) async {
        await Future.forEach(workList, (work) async {
          final id = await txn.insert(
            'work',
            work.toWorkEntity().toJson(),
            conflictAlgorithm: ConflictAlgorithm.fail,
          );
          if (id == 0) {
            _logger.e("work : $work のINSERTに失敗しました");
            throw Exception("work : $work のINSERTに失敗しました");
          }
          insertTaskIds.add(id);
        });

        if (insertTaskIds.length != workList.length) {
          _logger.e(
              "insertCount : ${insertTaskIds.length}, workList.length : ${workList.length} のため、INSERT時の件数が一致しません");
          throw Exception("INSERT時の件数が一致しません");
        }
      });

      return insertTaskIds;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<InProgressProduct>> fetchInProgressProductList() async {
    try {
      List<Map<String, dynamic>> products = await _database.query("product",
          where: "isCompleted = 0", orderBy: "id DESC");

      // DBから受け取ったデータをEntityに変換
      final productEntityList = products.map((Map<String, dynamic> m) {
        return ProductEntity(
            id: m["id"],
            productName: m["productName"],
            isCompleted: m["isCompleted"],
            createdOn: m["createdOn"],
            createdBy: m["createdBy"]);
      }).toList();

      // Entityをドメインモデルに変換
      return productEntityList
          .map((entity) => entity.toInProgressProduct())
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
