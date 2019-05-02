import 'dart:convert';
import 'dart:async';

import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 统一处理 shared_preferences
class SpKey {
  static const String USER_INFO = 'userInfo';
  static const String GUEST_INFO = 'guestInfo';
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
}
