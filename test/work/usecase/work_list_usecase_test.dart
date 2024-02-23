import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/app/work/application/work_list_usecase.dart';
import 'package:work_log/app/work/infrastructure/work_list_repository.dart';

import 'work_list_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WorkListRepository>(as: #MockWorkListRepository)])
void main() {
  late WorkListUsecase usecase;
  late MockWorkListRepository mockRepository;

  setUp(() {
    mockRepository = MockWorkListRepository();
    usecase = WorkListUsecase(mockRepository);
  });

  group('fetchCompleteProductList', () {
    test('初期表示時に今日の業務が表示されること', () async {
      final expected = <Work>[
        Work(
          id: 1,
          workDateTime: DateTime.parse('2024-02-09 09:30:00.000'),
          workDetail: 'Detail1',
          workMemo: 'Memo1',
          productId: 1,
          productName: 'Product1',
          createdOn: DateTime.parse('2024-01-30 00:00:00.000'),
          createdBy: 'user',
          updatedOn: DateTime.parse('2024-01-30 00:00:00.000'),
          updatedBy: 'user',
        ),
      ];

      final dateTime = DateTime(2024, 02, 09, 10, 30, 00);
      when(mockRepository.getWorksWithinDateRange(
              DateTime(2024, 02, 09, 09, 00, 00),
              DateTime(2024, 02, 10, 09, 00, 00)))
          .thenAnswer((_) async => expected);

      final result = await usecase.initWorkList(dateTime);

      expect(result, expected);
    });

    test('Workが登録できることを確認する', () async {
      // Arrange
      final inputWorkList = <Work>[
        Work(
          workDateTime: DateTime(2023, 2, 12),
          workDetail: 'Work 1 detail',
          workMemo: 'Work 1 memo',
          createdBy: 'User 1',
          createdOn: DateTime(2023, 2, 12),
          productId: 1,
        ),
        Work(
          id: 1,
          workDateTime: DateTime(2023, 2, 12),
          workDetail: 'Work 2 detail',
          workMemo: 'Work 2 memo',
          createdBy: 'User 2',
          createdOn: DateTime(2023, 2, 12),
          productId: 1,
        ),
      ];

      final expectedWorkList = <Work>[
        Work(
          id: 3,
          workDateTime: DateTime(2023, 2, 12),
          workDetail: 'Work 1 detail',
          workMemo: 'Work 1 memo',
          createdBy: 'User 1',
          createdOn: DateTime(2023, 2, 12),
          productId: 1,
        ),
        Work(
          id: 1,
          workDateTime: DateTime(2023, 2, 12),
          workDetail: 'Work 2 detail',
          workMemo: 'Work 2 memo',
          createdBy: 'User 2',
          createdOn: DateTime(2023, 2, 12),
          productId: 1,
        ),
      ];

      var ids = <int>[1, 3];

      when(mockRepository.saveWork(any, any)).thenAnswer((_) async => ids);

      when(mockRepository.fetchWorksById(ids))
          .thenAnswer((_) async => expectedWorkList);

      // Act
      final result = await usecase.saveWork(inputWorkList);

      // Assert
      expect(result, expectedWorkList);
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
