import 'package:sqflite/sqflite.dart';
import 'package:work_log/setup/database/entities/product_entity.dart';

class CompleteProductListRepository {
  final Database _database;
  CompleteProductListRepository(this._database);

  Future<List<ProductEntity>> fetchCompleteProductList() async {
    try {
      List<Map<String, dynamic>> products = await _database.query("product",
          where: "isCompleted = 1", orderBy: "id DESC");

      return products.map((Map<String, dynamic> m) {
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

  Future<void> convertProductToInProgress({int? id}) async {
    try {
      await _database.update(
        'product',
        {'isCompleted': 0},
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

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
}
