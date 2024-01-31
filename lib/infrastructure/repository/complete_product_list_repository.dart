import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_log/infrastructure/entities/product_entity.dart';

class CompleteProductListRepository {
  final _logger = Logger();
  // データベースを初期化
  late final Future<Database> _database;

  CompleteProductListRepository();

  Future<List<ProductEntity>> fetchCompleteProductList() async {
    try {
      final database = await _database;

      List<Map<String, dynamic>> products =
          await database.query("product", where: "isCompleted = 1");

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
      _logger.e(e);
      rethrow;
    }
  }

  Future<void> convertProductToInProgress({int? id}) async {
    try {
      final database = await _database;
      await database.update(
        'product',
        {'isCompleted': 0},
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
