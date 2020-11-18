import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

class UserRecordModel extends ChangeNotifier {
  /// 用户收藏
  List<User_collect> _userCollects;
  List<User_collect> get userCollects => _userCollects;

  /// 用户阅读历史记录
  List<User_read> _userReads;
  List<User_read> get userReads => _userReads;

  /// 设置用户收藏
  void setUserCollects(List<User_collect> userCollects) {
    _userCollects = userCollects;
    notifyListeners();
  }

  /// 删除一条阅读历史
  void deleteOneUserRead(User_read userRead) {
    _userReads.removeWhere((comicRead) {
      return comicRead.comicId == userRead.comicId;
    });
    notifyListeners();
  }

  /// 插入一条阅读历史
  void addUserRead(User_read userRead) {
    _userReads.insert(0, userRead);
    notifyListeners();
  }

  /// 修改一条阅读历史
  void changeUserRead(User_read userRead) {
    _userReads = _userReads.map((item) {
      if (item.comicId == userRead.comicId) {
        return userRead;
      }
      return item;
    }).toList();
    notifyListeners();
  }

  /// 异步更新
  /// 获取用户的收藏和阅读记录
  Future<void> getUserRecordAsyncAction(UserInfo user,
      [bool isRefresh = false]) async {
    if (_userCollects != null && !isRefresh) {
      return;
    }

    var deviceid = await Utils.getDeviceId();

    var getUserRecordRes = await Api.getUserRecord(
      type: user.type,
      openid: user.openid,
      deviceid: deviceid,
      myUid: user.uid,
    );
    var userCollect = getUserRecordRes?.userCollect ?? [];
    var userRead = getUserRecordRes?.userRead ?? [];

    if (userCollect.length >= 2) {
      userCollect.sort((collectA, collectB) {
        return collectB.updateTime - collectA.updateTime;
      });
    }
    _userCollects = userCollect;
    _userReads = userRead;
    notifyListeners();
  }
}
