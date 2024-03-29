import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/setup/database/entities/product_entity.dart';
import 'package:work_log/setup/database/entities/work_entity.dart';

class WorkListRepository {
  final Logger _logger = Logger();
  final Database _database;
  final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  WorkListRepository(this._database);

  Future<List<Work>> fetchWorksById(List<int> workIds) async {
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
      _logger.e(e);
      rethrow;
    }
  }

  Future<List<int>> saveWork(List<Work> insertWorkList,
      List<Work> updateWorkList, DateTime startDate, DateTime endDate) async {
    try {
      var insertIds = <int>[];
      var updateIds = <int>[];
      await _database.transaction((txn) async {
        if (insertWorkList.isNotEmpty) {
          insertIds = await _insertWork(insertWorkList, txn);
        }
        if (updateWorkList.isNotEmpty) {
          updateIds = await _updateWork(updateWorkList, txn);
        }
        _deleteWork(insertIds + updateIds, startDate, endDate);
      });
      return insertIds + updateIds;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<int>> _insertWork(List<Work> workList, Transaction txn) async {
    try {
      var insertTaskIds = <int>[];

      await Future.forEach(workList, (work) async {
        final id = await txn.insert(
          'work',
          {
            'workDateTime': formatter.format(work.workDateTime),
            'workDetail': work.workDetail,
            'workMemo': work.workMemo,
            'productId': work.productId,
            'createdBy': work.createdBy,
            'createdOn': formatter.format(work.createdOn!),
          },
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
            "エラー: 期待される挿入数は ${workList.length} ですが、実際の挿入数は ${insertTaskIds.length} です。これは、一部の作業項目がデータベースの制約により挿入に失敗した可能性があります。");
        throw Exception("INSERT時の件数が一致しません");
      }

      return insertTaskIds;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<int>> _updateWork(List<Work> workList, Transaction txn) async {
    try {
      await Future.forEach(workList, (work) async {
        final id = await txn.update(
          'work',
          {
            'workDateTime': formatter.format(work.workDateTime),
            'workDetail': work.workDetail,
            'workMemo': work.workMemo,
            'productId': work.productId,
            'updatedBy': work.updatedBy,
            'updatedOn': formatter.format(work.updatedOn!),
          },
          where: 'id = ?',
          whereArgs: [work.id],
          conflictAlgorithm: ConflictAlgorithm.fail,
        );
        if (id == 0) {
          _logger.e("work : $work のUPDATEに失敗しました");
          throw Exception("work : $work のUPDATEに失敗しました");
        }
      });

      return workList.map((work) => work.id!).toList();
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
      _logger.e(e);
      rethrow;
    }
  }

  Future<List<Work>> getWorksWithinDateRange(
      DateTime startDateTime, DateTime endDateTime) async {
    final result = await _database.rawQuery('''
      SELECT 
        work.id
        , work.workDateTime
        , work.workDetail
        , work.workMemo
        , work.productId
        , work.createdOn
        , work.createdBy
        , work.updatedOn
        , work.updatedBy
        , product.productName
        , product.isCompleted
      FROM work
      INNER JOIN product ON work.productId = product.id
      WHERE work.workDateTime BETWEEN ? AND ?
    ''', [formatter.format(startDateTime), formatter.format(endDateTime)]);

    // DBから受け取ったデータをEntityを経由してドメインモデルに変換
    return result.map((Map<String, dynamic> m) {
      return WorkEntity.fromMap(m).toWork();
    }).toList();
  }

  void _deleteWork(List<int> notTargetWork, DateTime startDateTime,
      DateTime endDateTime) async {
    try {
      // workDateTimeが対象日であるかつ、notTargetWorkに含まれないworkを削除
      await _database.delete('work',
          where:
              'workDateTime BETWEEN ? AND ? AND id NOT IN (${notTargetWork.map((id) => '?').join(', ')})',
          whereArgs: [
            formatter.format(startDateTime),
            formatter.format(endDateTime),
            ...notTargetWork
          ]);
    } catch (e) {
      rethrow;
    }
  }

  Future<InProgressProduct> fetchInProgressProductByWorkId(
      int productId) async {
    try {
      final result = await _database.query('product',
          where: 'id = ?', whereArgs: [productId], limit: 1);

      return result
          .map((Map<String, dynamic> m) {
            int id = m["id"];
            String productName = m["productName"];
            int isCompleted = m["isCompleted"];
            String createdOn = m["createdOn"];
            String createdBy = m["createdBy"];

            return ProductEntity(
                id: id,
                productName: productName,
                isCompleted: isCompleted,
                createdOn: createdOn,
                createdBy: createdBy);
          })
          .toList()
          .first
          .toInProgressProduct();
    } catch (e) {
      rethrow;
    }
  }
}
