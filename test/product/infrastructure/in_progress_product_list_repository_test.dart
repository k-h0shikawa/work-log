import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_log/app/product/infrastructure/in_progress_product_list_repository.dart';
import 'package:work_log/setup/database/entities/product_entity.dart';

import '../../database/test_database_helper.dart';

void main() {
  group('InProgressProductListRepository', () {
    late Database database;
    late InProgressProductListRepository repository;

    setUp(() async {
      database = await TestDatabaseHelper.instance.database;
      repository = InProgressProductListRepository(database);
    });

    tearDownAll(() async {
      await database.close();
    });

    test('fetchInProgressProductListで取得する件数確認', () async {
      final inProgressProductList =
          await repository.fetchInProgressProductList();

      expect(inProgressProductList.length, 1);
    });

    test('取得したすべての商品が未完了状態であること', () async {
      final inProgressProductList =
          await repository.fetchInProgressProductList();

      for (final product in inProgressProductList) {
        expect(product.isCompleted, 0);
      }
    });

    test('商品を追加できること', () async {
      final product = ProductEntity(
        productName: 'Test Product',
        isCompleted: 0,
        createdOn: DateTime.now().toString(),
        createdBy: 'Test User',
      );

      await repository.insertProduct(product);

      final inProgressProductList =
          await repository.fetchInProgressProductList();

      expect(inProgressProductList.length, 2);
      expect(inProgressProductList.last.productName, 'Test Product');
    });

    test('商品を完了状態にできること', () async {
      final inProgressProductList =
          await repository.fetchInProgressProductList();
      final productId = inProgressProductList.first.id;

      await repository.finishProduct(id: productId);

      final updatedProductList = await repository.fetchInProgressProductList();

      expect(updatedProductList.length, inProgressProductList.length - 1);
    });
  });
}
