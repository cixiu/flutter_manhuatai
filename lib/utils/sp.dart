import 'dart:convert';
import 'dart:async';

import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SEARCH_MAX_LENGTH = 10;

/// 统一处理 shared_preferences
class SpKey {
  static const String USER_INFO = 'userInfo';
  static const String GUEST_INFO = 'guestInfo';
  static const String SEARCH_HISTORY = 'searchHistory';
}

class SpUtils {
  /// 存储用户登录信息
  static Future<UserInfo> saveUserInfo(Map userInfoMap) async {
    var spf = await SharedPreferences.getInstance();
    spf.setString(SpKey.USER_INFO, json.encode(userInfoMap));
    print('登录用户存入缓存中成功，$userInfoMap');
    return UserInfo.fromJson(userInfoMap);
  }

  /// 读取登录的用户信息
  static Future<UserInfo> loadUserInfo() async {
    // clearUserInfo();
    var spf = await SharedPreferences.getInstance();
    var userInfoStr = spf.getString(SpKey.USER_INFO);
    if (userInfoStr == null) {
      return UserInfo.fromJson({});
    }
    Map userInfoMap = json.decode(userInfoStr);
    print('读取用户信息 $userInfoMap');

    return UserInfo.fromJson(userInfoMap);
  }

  /// 清空登录的用户信息 => 退出登录
  static Future<void> clearUserInfo() async {
    var spf = await SharedPreferences.getInstance();
    spf.remove(SpKey.USER_INFO);
  }

  /// 存储游客信息
  static Future<UserInfo> saveGuestInfo(Map guestInfoMap) async {
    var spf = await SharedPreferences.getInstance();
    spf.setString(SpKey.GUEST_INFO, json.encode(guestInfoMap));
    print('游客用户存入缓存中成功，$guestInfoMap');
    return UserInfo.fromJson(guestInfoMap);
  }

  /// 读取游客信息
  static Future<UserInfo> loadGuestInfo() async {
    // clearUserInfo();
    var spf = await SharedPreferences.getInstance();
    var guestInfoStr = spf.getString(SpKey.GUEST_INFO);
    if (guestInfoStr == null) {
      return UserInfo.fromJson({});
    }
    Map guestInfoMap = json.decode(guestInfoStr);
    print('读取游客信息 $guestInfoMap');

    return UserInfo.fromJson(guestInfoMap);
  }

  // 存储搜索历史
  static Future<List<String>> saveSearchHistory(String searchVal) async {
    var spf = await SharedPreferences.getInstance();

    var searchHistoryList = spf.getStringList(SpKey.SEARCH_HISTORY) ?? [];
    insertArray<String>(
      searchHistoryList,
      searchVal,
      (item) {
        return item == searchVal;
      },
      SEARCH_MAX_LENGTH,
    );

    await spf.setStringList(SpKey.SEARCH_HISTORY, searchHistoryList);
    return searchHistoryList;
  }

  /// 读取搜索历史
  static Future<List<String>> loadSearchHistory() async {
    var spf = await SharedPreferences.getInstance();

    return spf.getStringList(SpKey.SEARCH_HISTORY) ?? [];
  }

  /// 删除一条搜索历史
  static Future<void> deleteOneSearchHistory(String searchVal) async {
    var spf = await SharedPreferences.getInstance();
    var searchHistoryList = spf.getStringList(SpKey.SEARCH_HISTORY) ?? [];

    deleteFromArray(searchHistoryList, (item) => item == searchVal);
    await spf.setStringList(SpKey.SEARCH_HISTORY, searchHistoryList);
    return searchHistoryList;
  }

  /// 清空搜索历史
  static Future<void> clearSearchHistory() async {
    var spf = await SharedPreferences.getInstance();
    await spf.remove(SpKey.SEARCH_HISTORY);
  }
}

typedef bool Compare<T>(T item);

// 将数据插入一个已经存在的数值中
void insertArray<T>(List<T> arr, T val, Compare<T> compare, int maxLen) {
  // arr.indexWhere(test)
  int index = arr.indexWhere(compare);
  // 如果已经存在 则需要更新一下已经存在的数据
  if (index == 0) {
    arr[index] = val;
    return;
  }
  if (index > 0) {
    arr.removeAt(index);
  }
  arr.insert(0, val);
  if (maxLen != null && arr.length > maxLen) {
    arr.removeLast();
  }
}

void deleteFromArray<T>(List<T> arr, Compare<T> compare) {
  int index = arr.indexWhere(compare);
  if (index > -1) {
    arr.removeAt(index);
  }
}
