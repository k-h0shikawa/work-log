import 'package:sqflite/sqflite.dart';
import 'package:work_log/domain/types/in_progress_product.dart';
import 'package:work_log/infrastructure/entities/product_entity.dart';

class InProgressProductListRepository {
  InProgressProductListRepository();

  Future<List<ProductEntity>> fetchInProgressProductList() async {
    final database = await openDatabase('WorkLog.db');

    List<Map<String, dynamic>> results = await database.query("product");

    print("results");
    print(results);
    // map to account list
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
          createdOn: createdOn, // 動作確認のため、一時的にコメントアウト
          createdBy: createdBy);
    }).toList();
    print("result");
    print(result);
    return result;

    // final List<InProgressProduct> products = await database.query('product');
    // print(products);
/*
    final inProgressProductList = <InProgressProduct>[
      const InProgressProduct(id: 0, productName: 'ダミー案件', isCompleted: 0),
      const InProgressProduct(id: 1, productName: 'ぽしぇっと1', isCompleted: 0)
    ];
    print("use InProgressProductListRepository");
    return inProgressProductList;
    */
  }
}
