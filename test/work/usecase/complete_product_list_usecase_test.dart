import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
import 'package:work_log/app/work/infrastructure/work_list_repository.dart';

import 'complete_product_list_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WorkListRepository>(as: #MockWorkListRepository)])
void main() {
  late WorkListUsecase usecase;
  late MockWorkListRepository mockRepository;

  setUp(() {
    mockRepository = MockWorkListRepository();
    usecase = WorkListUsecase(mockRepository);
  });

  group('fetchCompleteProductList', () {
    test('Workが登録できることを確認する', () async {
      // Arrange
      final workList = [
        Work(
          workDateTime: DateTime.now(),
          workName: 'Work 1',
          workDetail: 'Work 1 detail',
          workMemo: 'Work 1 memo',
          createdBy: 'User 1',
          createdOn: DateTime.now(),
          productId: 1,
        ),
        Work(
          workDateTime: DateTime.now(),
          workName: 'Work 2',
          workDetail: 'Work 2 detail',
          workMemo: 'Work 2 memo',
          createdBy: 'User 2',
          createdOn: DateTime.now(),
          productId: 2,
        ),
      ];

      when(mockRepository.insertWork(workList)).thenAnswer((_) async => [1, 2]);

      var ids = <int>[1, 2];
      when(mockRepository.fetchWorks(ids)).thenAnswer((_) async => workList);

      // Act
      final result = await usecase.insertWork(workList);

      // Assert
      expect(result, workList);
    });
  });

  group('商品関連', () {
    test('進行中の商品を取得できること', () async {
      // Arrange
      final inProgressProductList = [
        InProgressProduct(
          id: 1,
          productName: 'Product 1',
          isCompleted: 0,
          createdOn: DateTime(2024, 01, 30),
          createdBy: 'User 1',
        ),
        InProgressProduct(
          id: 2,
          productName: 'Product 2',
          isCompleted: 0,
          createdOn: DateTime(2024, 01, 30),
          createdBy: 'User 2',
        ),
      ];
      when(mockRepository.fetchInProgressProductList())
          .thenAnswer((_) async => inProgressProductList);

      // Act
      final result = await usecase.fetchInProgressProductList();

      // Assert
      expect(result.length, 2);
    });
  });
}
