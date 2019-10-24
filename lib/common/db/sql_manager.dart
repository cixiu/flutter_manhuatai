import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// 数据库管理
class SqlManager {
  static const _VERSION = 1;

  static const _NAME = 'flutter_manhuatai.db';

  static Database _database;

  /// 初始化
  static init() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    // 构造完整的数据库路径
    String dbName = _NAME;
    String path = join(databasesPath, dbName);
    print(path);
    // open the database
    _database = await openDatabase(path, version: _VERSION,
        onCreate: (Database db, int version) async {
      print('数据库open成功');
      // When creating the db, create the table
      // await db.execute(
      //     'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    });
  }

  /// 表是否存在
  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;
  }

  /// 获取当前数据库对象
  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  /// 关闭
  static close() {
    _database?.close();
    _database = null;
  }
}
