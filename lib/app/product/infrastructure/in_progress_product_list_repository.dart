import 'package:sqflite/sqflite.dart';
import 'package:work_log/app/domain/entities/daily_work_for_pdf.dart';
import 'package:work_log/setup/database/entities/daily_work_for_pdf_entity.dart';
import 'package:work_log/setup/database/entities/product_entity.dart';

class InProgressProductListRepository {
  // データベースを初期化
  final Database _database;
  InProgressProductListRepository(this._database);

  Future<List<ProductEntity>> fetchInProgressProductList() async {
    try {
      List<Map<String, dynamic>> results = await _database.query("product",
          where: "isCompleted = 0", orderBy: "id");

      return results.map((Map<String, dynamic> m) {
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
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertProduct(ProductEntity product) async {
    try {
      await _database.insert(
        'product',
        toMap(product),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toMap(ProductEntity product) {
    return <String, dynamic>{
      "id": product.id,
      "productName": product.productName,
      "isCompleted": product.isCompleted,
      "createdOn": product.createdOn.toString(),
      "createdBy": product.createdBy,
    };
  }

  Future<void> finishProduct({int? id}) async {
    try {
      await _database.update(
        'product',
        {'isCompleted': 1},
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DailyWorkForPDF>> fetchDailyWorkForPDF(int productId) async {
    final result = await _database.rawQuery('''
      SELECT 
        DATE(work.workDateTime) as workDate
        , work.workDetail as workDetail
        , MAX(product.productName) as productName
		    , COUNT(work.workDateTime) as workCount
      FROM work
      INNER JOIN product ON work.productId = product.id
      WHERE product.id = ?
	  GROUP BY DATE(work.workDateTime), work.workDetail
    ''', [productId]);

    return result.map((Map<String, dynamic> m) {
      return DailyWorkForPDFEntity(
              workDate: m["workDate"],
              workDetail: m["workDetail"],
              productName: m["productName"],
              workCount: m["workCount"])
          .toDailyWorkForPDFEntity();
    }).toList();
  }
}
