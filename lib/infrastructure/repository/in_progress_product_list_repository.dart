import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_log/infrastructure/entities/product_entity.dart';

class InProgressProductListRepository {
  final _logger = Logger();
  // データベースを初期化
  late final Future<Database> _database;
  InProgressProductListRepository();

  Future<List<ProductEntity>> fetchInProgressProductList() async {
    try {
      final database = await _database;

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
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<void> insertProduct(ProductEntity product) async {
    try {
      final database = await _database;
      await database.insert(
        'product',
        toMap(product),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      _logger.e(e);
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
      final database = await _database;
      await database.update(
        'product',
        {'isCompleted': 1},
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}
