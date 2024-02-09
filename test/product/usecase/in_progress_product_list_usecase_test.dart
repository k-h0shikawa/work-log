import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/product/application/in_progress_product_list_usecase.dart';
import 'package:work_log/app/product/infrastructure/in_progress_product_list_repository.dart';
import 'package:work_log/setup/database/entities/product_entity.dart';

import 'in_progress_product_list_usecase_test.mocks.dart';

@GenerateMocks([InProgressProductListRepository])
void main() {
  group('InProgressProductListUsecase', () {
    late InProgressProductListUsecase usecase;
    late MockInProgressProductListRepository repository;

    setUp(() {
      repository = MockInProgressProductListRepository();
      usecase = InProgressProductListUsecase(repository);
    });

    test('fetchInProgressProductListで取得する件数確認', () async {
      // Arrange
      final inProgressProductList = [
        const ProductEntity(
          id: 1,
          productName: 'Product 1',
          isCompleted: 0,
          createdOn: '2024-01-30',
          createdBy: 'User 1',
        ),
        const ProductEntity(
          id: 2,
          productName: 'Product 2',
          isCompleted: 0,
          createdOn: '2024-01-30',
          createdBy: 'User 2',
        ),
      ];
      when(repository.fetchInProgressProductList())
          .thenAnswer((_) async => inProgressProductList);

      // Act
      final result = await usecase.fetchInProgressProductList();

      // Assert
      expect(result.length, 2);
    });
  });
}
