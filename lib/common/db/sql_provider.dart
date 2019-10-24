import 'dart:async';
import 'package:meta/meta.dart';

import 'package:sqflite/sqflite.dart';

import './sql_manager.dart';

abstract class BaseDbProvider {
  bool isTableExits = false;

  tableSqlString();

  tableName();

  tableBaseString(String name, String columnId) {
    return '''
      create table $name (
        $columnId integer primary key autoincrement,
    ''';
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  Future<Database> open() async {
    if (!isTableExits) {
      await prepare(tableName(), tableSqlString());
    }
    return await SqlManager.getCurrentDatabase();
  }

  @mustCallSuper
  Future<void> prepare(String name, String createSql) async {
    isTableExits = await SqlManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await SqlManager.getCurrentDatabase();
      await db.execute(createSql);
    }
  }
}
