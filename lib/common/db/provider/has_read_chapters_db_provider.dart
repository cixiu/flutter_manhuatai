import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_manhuatai/common/db/sql_provider.dart';
import 'package:sqflite/sqflite.dart';

/// 漫画已阅章节表
class HasReadChaptersDbProvider extends BaseDbProvider {
  final String name = 'ChaptersHasRead';

  final String columnId = '_id';
  final String columnComicId = 'comicId';
  final String columnComicName = 'comicName';
  final String columnData = 'hasReadChapters';

  int comicId;
  String comicName;
  String data;

  HasReadChaptersDbProvider();

  Map<String, dynamic> toMap(
      int id, String comicName, String hasReadChaptersString) {
    Map<String, dynamic> map = {
      columnComicId: id,
      columnComicName: comicName,
      columnData: hasReadChaptersString,
    };
    if (comicId != null) {
      map[columnComicId] = comicId;
    }
    return map;
  }

  HasReadChaptersDbProvider.fromMap(Map map) {
    comicId = map[columnComicId];
    comicName = map[columnComicName];
    data = map[columnData];
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
        $columnComicId integer not null,
        $columnComicName text not null,
        $columnData text not null)
      ''';
  }

  @override
  tableName() {
    return name;
  }

  /// 根据comicId查找漫画信息
  Future<HasReadChaptersDbProvider> _getProvider(Database db, int id) async {
    List<Map> maps = await db.query(
      name,
      columns: [columnComicId, columnComicName, columnData],
      where: '$columnComicId = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return HasReadChaptersDbProvider.fromMap(maps.first);
    }
    return null;
  }

  /// 根据comicId获取查找到的漫画
  Future<List<int>> getHasReadChapters(int id) async {
    Database db = await getDataBase();
    var provider = await _getProvider(db, id);
    if (provider != null) {
      ///使用 compute 的 Isolate 优化 json decode
      List<int> dataMap =
          await compute((String data) => json.decode(data), provider.data);

      return dataMap.length > 0 ? dataMap : [];
    }
    return null;
  }

  /// 插入一条已阅读的漫画信息
  /// 如果存在则更新
  /// 否则插入一条新的数据
  void insertOrUpdate(
      int id, String comicName, String hasReadChaptersString) async {
    Database db = await getDataBase();
    var provider = await _getProvider(db, id);
    // 此时更新
    if (provider != null) {
      await db.update(
        name,
        toMap(id, comicName, hasReadChaptersString),
        where: '$columnId = ?',
        whereArgs: [id],
      );
      return;
    }
    // 插入
    await db.insert(
      name,
      toMap(id, comicName, hasReadChaptersString),
    );
  }
}
