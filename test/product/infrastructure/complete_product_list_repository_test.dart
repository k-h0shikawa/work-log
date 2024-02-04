import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:work_log/app/product/infrastructure/complete_product_list_repository.dart';

import '../../test_database_helper.dart';

Future<void> main() async {
  await TestDatabaseHelper.instance.database;
  final database = await openDatabase('WorkLogTest.db');
  final repository = CompleteProductListRepository(database);
  test('完了済み商品の一覧取得', () async {
    final completeProductList = await repository.fetchCompleteProductList();

    expect(completeProductList.length, 1);
  });
  test('すべての要素のisCompletedが1であること', () async {
    final completeProductList = await repository.fetchCompleteProductList();

    for (final product in completeProductList) {
      expect(product.isCompleted, 1);
    }
  });
}
