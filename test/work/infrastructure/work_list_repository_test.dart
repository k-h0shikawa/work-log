import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/entities/work.dart';
import 'package:work_log/app/work/infrastructure/work_list_repository.dart';
import '../../database/test_database_helper.dart';
import 'work_list_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Database>()])
void main() {
  group('mockを使用しない動作確認', () {
    late Database mockDatabase;
    late Database database;
    late WorkListRepository repository;

    setUp(() async {
      mockDatabase = MockDatabase();
      await TestDatabaseHelper.instance.resetDatabase();
      database = await TestDatabaseHelper.instance.database;

      repository = WorkListRepository(database);
    });

    tearDownAll(() async {
      await mockDatabase.close();
      await database.close();
    });

    test('fetchWorksで正しい件数のWorkを取得する', () async {
      // Arrange
      final expectedWorks = <Work>[
        Work(
          id: 1,
          workDateTime: DateTime.parse('2024-02-09 09:30:00'),
          workDetail: 'Detail1',
          workMemo: 'Memo1',
          productId: 1,
          createdOn: DateTime.parse('2024-01-30 00:00:00.000'),
          createdBy: 'user',
          updatedOn: DateTime.parse('2024-01-30 00:00:00.000'),
          updatedBy: 'user',
        ),
        Work(
          id: 2,
          workDateTime: DateTime.parse('2024-02-10 09:30:00'),
          workDetail: 'Detail2',
          workMemo: 'Memo2',
          productId: 2,
          createdOn: DateTime.parse('2024-01-30 00:00:00.000'),
          createdBy: 'user',
          updatedOn: DateTime.parse('2024-01-30 00:00:00.000'),
          updatedBy: 'user',
        ),
      ];

      // Act
      final result = await repository.fetchWorksById(<int>[1, 2]);

      // Assert
      expect(result.length, 2);
      expect(result, expectedWorks);
    });

    test('業務内容を取得できること', () async {
      final startDateTime = DateTime(2024, 02, 9, 9, 0, 0);
      final endDateTime = DateTime(2024, 02, 10, 9, 0, 0);

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

      final works =
          await repository.getWorksWithinDateRange(startDateTime, endDateTime);

      expect(works.length, 1);
      expect(works, expected);
    });

    test("業務内容の保存ができること", () async {
      // Arrange
      final insertWork = <Work>[
        Work(
          workDateTime: DateTime.parse('2024-02-09 09:30:00.000'),
          workDetail: 'Detail1',
          workMemo: 'Memo1',
          productId: 1,
          createdOn: DateTime.parse('2024-01-30 00:00:00.000'),
          createdBy: 'user',
          updatedOn: DateTime.parse('2024-02-10 00:00:00.000'),
          updatedBy: 'user',
        )
      ];

      final updateWork = <Work>[
        Work(
          id: 2,
          workDateTime: DateTime.parse('2024-02-10 09:30:00.000'),
          workDetail: 'Detail2',
          workMemo: 'Memo2',
          productId: 2,
          createdOn: DateTime.parse('2024-01-30 00:00:00.000'),
          createdBy: 'user',
          updatedOn: DateTime.parse('2024-02-10 00:00:00.000'),
          updatedBy: 'user',
        )
      ];

      // Act
      final result = await repository.saveWork(
          insertWork, updateWork, DateTime.now(), DateTime.now());

      // Assert
      expect(result.length, 2);
      expect(result, [3, 2]);
    });
  });

  group('商品関連', () {
    late Database mockDatabase;
    late Database database;
    late WorkListRepository repository;

    setUp(() async {
      mockDatabase = MockDatabase();
      await TestDatabaseHelper.instance.resetDatabase();
      database = await TestDatabaseHelper.instance.database;

      repository = WorkListRepository(database);
    });

    tearDownAll(() async {
      await mockDatabase.close();
      await database.close();
    });

    test("進行中の商品の一覧を取得できる", () async {
      // Arrange
      final expectedProducts = <InProgressProduct>[
        InProgressProduct(
          id: 1,
          productName: 'Product1',
          isCompleted: 0,
          createdOn: DateTime.parse('2024-01-30 00:00:00.000'),
          createdBy: 'user',
          updatedOn: null,
          updatedBy: null,
        ),
      ];

      // Act
      final result = await repository.fetchInProgressProductList();

      // Assert
      expect(result.length, 1);
      expect(result, expectedProducts);
    });
  });
}
