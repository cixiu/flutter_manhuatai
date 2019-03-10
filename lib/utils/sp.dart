import 'dart:convert';
import 'dart:async';

import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 统一处理 shared_preferences
class SpKey {
  static const String USER_INFO = 'userInfo';
}

class SpUtils {
  /// 存储用户登录信息
  static Future<UserInfo> saveUserInfo(Map userInfoMap) async {
    var spf = await SharedPreferences.getInstance();
    spf.setString(SpKey.USER_INFO, json.encode(userInfoMap));

    return UserInfo.fromJson(userInfoMap);
  }

  /// 读取登录的用户信息
  static Future<UserInfo> loadUserInfo() async {
    var spf = await SharedPreferences.getInstance();
    String userInfoStr = spf.getString(SpKey.USER_INFO);
    Map userInfoMap = json.decode(userInfoStr);

    return UserInfo.fromJson(userInfoMap);
  }

  /// 清空登录的用户信息 => 退出登录
  static Future<void> clearUserInfo() async {
    var spf = await SharedPreferences.getInstance();
    spf.remove(SpKey.USER_INFO);
  }
}
