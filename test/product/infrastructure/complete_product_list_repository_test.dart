import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_log/app/product/infrastructure/complete_product_list_repository.dart';

import '../../database/test_database_helper.dart';

void main() {
  group('CompleteProductListRepository', () {
    late Database database;
    late CompleteProductListRepository repository;

    setUp(() async {
      await TestDatabaseHelper.instance.resetDatabase();
      database = await TestDatabaseHelper.instance.database;
      repository = CompleteProductListRepository(database);
    });

    tearDownAll(() async {
      await database.close();
    });

    test('fetchCompleteProductListで取得する件数確認', () async {
      final completeProductList = await repository.fetchCompleteProductList();

      expect(completeProductList.length, 1);
    });

    test('取得したすべての商品が完了状態であること', () async {
      final completeProductList = await repository.fetchCompleteProductList();

      for (final product in completeProductList) {
        expect(product.isCompleted, 1);
      }
    });
  });
}
