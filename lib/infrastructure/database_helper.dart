import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "WorkLog.db";
  static const _databaseVersion = 1;

  static const productTable = 'product';
  static const workTable = 'work';

  static const columnId = 'id';
  static const columnName = 'productName';
  static const columnIsCompleted = 'isCompleted';
  static const columnCreatedOn = 'createdOn';
  static const columnCreatedBy = 'createdBy';
  static const columnUpdatedOn = 'updatedOn';
  static const columnUpdatedBy = 'updatedBy';

  static const columnWorkDateTime = 'workDateTime';
  static const columnWorkName = 'workName';
  static const columnWorkDetail = 'workDetail';
  static const columnWorkMemo = 'workMemo';
  static const columnProductId = 'productId';

  // Singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Database reference
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onConfigure: _onConfigure,
        onCreate: _onCreate);
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON;');
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $productTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnIsCompleted INTEGER NOT NULL,
            $columnCreatedOn TEXT,
            $columnCreatedBy TEXT,
            $columnUpdatedOn TEXT,
            $columnUpdatedBy TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE $workTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnWorkDateTime TEXT NOT NULL,
            $columnWorkName TEXT NOT NULL,
            $columnWorkDetail TEXT NOT NULL,
            $columnWorkMemo TEXT NOT NULL,
            $columnProductId INTEGER NOT NULL,
            $columnCreatedOn TEXT,
            $columnCreatedBy TEXT,
            $columnUpdatedOn TEXT,
            $columnUpdatedBy TEXT,
            foreign key ($columnProductId) references $productTable($columnId)
          )
          ''');

    // ダミーデータ
    await db.execute('''
INSERT INTO product (productName, isCompleted, createdOn, createdBy, updatedOn, updatedBy)
VALUES ('Product1', 0, '2024-01-30', 'User1', '2024-01-30', 'User1'),
       ('Product2', 1, '2024-01-30', 'User1', '2024-01-30', 'User1');
      ''');
    // ダミーデータ
    await db.execute('''
INSERT INTO work (workDateTime, workName, workDetail, workMemo, productId, createdOn, createdBy, updatedOn, updatedBy)
VALUES ('2024-01-30', 'Work1', 'Detail1', 'Memo1', 1, '2024-01-30', 'User1', '2024-01-30', 'User1'),
       ('2024-01-30', 'Work2', 'Detail2', 'Memo2', 2, '2024-01-30', 'User1', '2024-01-30', 'User1');
      ''');
  }
}
