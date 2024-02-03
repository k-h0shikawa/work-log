import 'package:sqflite/sqflite.dart';
import 'package:work_log/domain/entities/work.dart';

class WorkListRepository {
  final Database _database;

  WorkListRepository(this._database);
}
