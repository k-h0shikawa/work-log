import 'package:sqflite/sqflite.dart';
import 'package:work_log/database/entities/product_entity.dart';

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
}
