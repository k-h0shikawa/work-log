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

    test('insertWorkで正しい件数のWorkを追加する', () async {
      // Arrange
      final workList = [
        // id: 3が追加される
        Work(
          workDateTime: DateTime.now(),
          workName: 'Work 1',
          workDetail: 'Work 1 detail',
          workMemo: 'Work 1 memo',
          createdBy: 'User 1',
          createdOn: DateTime.now(),
          productId: 1,
        ),
        // id: 4が追加される
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

      // Act
      final result = await repository.insertWork(workList);

      // Assert
      expect(result, [3, 4]);
    });

    test('fetchWorksで正しい件数のWorkを取得する', () async {
      // Arrange
      final expectedWorks = <Work>[
        Work(
          id: 1,
          workDateTime: DateTime.parse('2024-01-30 00:00:00.000'),
          workName: 'Work1',
          workDetail: 'Detail1',
          workMemo: 'Memo1',
          productId: 1,
          createdOn: DateTime.parse('2024-01-30 00:00:00.000'),
          createdBy: 'User1',
          updatedOn: DateTime.parse('2024-01-30 00:00:00.000'),
          updatedBy: 'User1',
        ),
        Work(
          id: 2,
          workDateTime: DateTime.parse('2024-01-30 00:00:00.000'),
          workName: 'Work2',
          workDetail: 'Detail2',
          workMemo: 'Memo2',
          productId: 2,
          createdOn: DateTime.parse('2024-01-30 00:00:00.000'),
          createdBy: 'User1',
          updatedOn: DateTime.parse('2024-01-30 00:00:00.000'),
          updatedBy: 'User1',
        ),
      ];

      // Act
      final result = await repository.fetchWorks(<int>[1, 2]);

      // Assert
      expect(result.length, 2);
      expect(result, expectedWorks);
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
          createdBy: 'User1',
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
