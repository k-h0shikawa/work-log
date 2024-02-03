import 'package:sqflite/sqflite.dart';
import 'package:work_log/app/domain/entities/work.dart';

class WorkListRepository {
  final Database _database;

  WorkListRepository(this._database);
}
