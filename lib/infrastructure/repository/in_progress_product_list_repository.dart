import 'package:sqflite/sqflite.dart';
import 'package:work_log/infrastructure/entities/product_entity.dart';

class InProgressProductListRepository {
  InProgressProductListRepository();

  Future<List<ProductEntity>> fetchInProgressProductList() async {
    final database = await openDatabase('WorkLog.db');

    List<Map<String, dynamic>> results =
        await database.query("product", where: "isCompleted = 0");

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

  Future<void> insertProduct(ProductEntity product) async {
    final database = await openDatabase('WorkLog.db');
    await database.insert(
      'product',
      toMap(product),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
    final database = await openDatabase('WorkLog.db');
    await database.update(
      'product',
      {'isCompleted': 1},
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
