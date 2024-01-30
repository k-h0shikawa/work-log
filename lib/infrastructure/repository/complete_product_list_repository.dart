import 'package:sqflite/sqflite.dart';
import 'package:work_log/infrastructure/entities/product_entity.dart';

class CompleteProductListRepository {
  CompleteProductListRepository();

  Future<List<ProductEntity>> fetchCompleteProductList() async {
    final database = await openDatabase('WorkLog.db');

    List<Map<String, dynamic>> results =
        await database.query("product", where: "isCompleted = 1");

    final result = results.map((Map<String, dynamic> m) {
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

    return result;
  }

  Future<void> convertProductToInProgress({int? id}) async {
    final database = await openDatabase('WorkLog.db');
    await database.update(
      'product',
      {'isCompleted': 0},
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
