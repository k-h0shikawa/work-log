import 'package:sqflite/sqflite.dart';
import 'package:work_log/app/domain/entities/complete_product.dart';

class CompleteProductListRepository {
  final Database _database;
  CompleteProductListRepository(this._database);

  Future<List<CompleteProduct>> fetchCompleteProductList() async {
    try {
      List<Map<String, dynamic>> products = await _database.query("product",
          where: "isCompleted = 1", orderBy: "id DESC");

      return products.map((Map<String, dynamic> m) {
        int id = m["id"];
        String productName = m["productName"];
        int isCompleted = m["isCompleted"];
        String createdOn = m["createdOn"];
        String createdBy = m["createdBy"];

        return CompleteProduct(
            id: id,
            productName: productName,
            isCompleted: isCompleted,
            createdOn: DateTime.parse(createdOn),
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
}
