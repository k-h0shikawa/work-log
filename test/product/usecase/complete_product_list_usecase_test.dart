import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:work_log/app/domain/entities/complete_product.dart';
import 'package:work_log/app/product/application/complete_product_list_usecase.dart';
import 'package:work_log/app/product/infrastructure/complete_product_list_repository.dart';

import 'complete_product_list_usecase_test.mocks.dart';

@GenerateMocks([CompleteProductListRepository])
void main() {
  late CompleteProductListUsecase usecase;
  late MockCompleteProductListRepository mockRepository;

  setUp(() {
    mockRepository = MockCompleteProductListRepository();
    usecase = CompleteProductListUsecase(mockRepository);
  });

  group('fetchCompleteProductList', () {
    test('完了済みの商品の一覧', () async {
      // Arrange
      final expectedList = [
        const CompleteProduct(id: 1, productName: 'Product 1', isCompleted: 0),
        const CompleteProduct(id: 2, productName: 'Product 2', isCompleted: 1),
      ];
      when(mockRepository.fetchCompleteProductList())
          .thenAnswer((_) async => expectedList);

      // Act
      final result = await usecase.fetchCompleteProductList();

      // Assert
      expect(result, expectedList);
      verify(mockRepository.fetchCompleteProductList()).called(1);
    });

    test('リポジトリがエラーをスローした場合、エラーをログに記録し、例外を再スローする', () async {
      // Arrange
      final exception = Exception('Test exception');
      when(mockRepository.fetchCompleteProductList()).thenThrow(exception);

      // Act & Assert
      expect(() => usecase.fetchCompleteProductList(), throwsA(exception));
    });
  });

  group('convertProductToInProgress', () {
    test('製品を進行中に変換し、更新されたリストを返す', () async {
      // Arrange
      const id = 1;
      final expectedList = [
        const CompleteProduct(id: 1, productName: 'Product 1', isCompleted: 0),
        const CompleteProduct(id: 2, productName: 'Product 2', isCompleted: 1),
      ];
      when(mockRepository.convertProductToInProgress(id: id))
          .thenAnswer((_) async => null);
      when(mockRepository.fetchCompleteProductList())
          .thenAnswer((_) async => expectedList);

      // Act
      final result = await usecase.convertProductToInProgress(id);

      // Assert
      expect(result, expectedList);
      verify(mockRepository.convertProductToInProgress(id: id)).called(1);
      verify(mockRepository.fetchCompleteProductList()).called(1);
    });

    test('idがNULLの場合、エラーをログに記録し、例外を再スローする', () async {
      // Arrange
      const id = null;

      // Act & Assert
      expect(() => usecase.convertProductToInProgress(id), throwsArgumentError);
    });

    test('リポジトリがエラーをスローした場合、エラーをログに記録し、例外を再スローする', () async {
      // Arrange
      const id = 1;
      final exception = Exception('Test exception');
      when(mockRepository.convertProductToInProgress(id: id))
          .thenThrow(exception);

      // Act & Assert
      expect(() => usecase.convertProductToInProgress(id), throwsA(exception));
    });
  });
}
