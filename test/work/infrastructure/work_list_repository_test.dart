import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_log/app/work/infrastructure/work_list_repository.dart';
import 'package:work_log/setup/database/entities/work_entity.dart';

import '../../database/test_database_helper.dart';
import 'work_list_repository_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  group('WorkListRepository', () {
    late Database database;
    late WorkListRepository repository;

    setUp(() async {
      await TestDatabaseHelper.instance.resetDatabase();
      database = MockDatabase();
      repository = WorkListRepository(database);
    });

    tearDownAll(() async {
      await database.close();
    });

    test('insertWorkで正しい件数のWorkを追加する', () async {
      // Arrange
      final workList = [
        WorkEntity(
          id: 1,
          workDateTime: DateTime.now(),
          workName: 'Work 1',
          workDetail: 'Work 1 detail',
          workMemo: 'Work 1 memo',
          createdBy: 'User 1',
          createdOn: DateTime.now().toString(),
          productId: 1,
        ),
        WorkEntity(
          id: 2,
          workDateTime: DateTime.now(),
          workName: 'Work 2',
          workDetail: 'Work 2 detail',
          workMemo: 'Work 2 memo',
          createdBy: 'User 2',
          createdOn: DateTime.now().toString(),
          productId: 2,
        ),
      ];

      for (var work in workList) {
        when(database.insert(
          'work',
          work.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        )).thenAnswer((_) async => 2);
      }

      // Act
      final result = await repository.insertWork(workList);

      // Assert
      expect(result.length, 2);
    });
  });
}
