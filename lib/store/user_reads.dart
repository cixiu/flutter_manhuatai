import 'dart:async';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:flutter_manhuatai/store/index.dart';
import 'package:flutter_manhuatai/store/user_collects.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:redux/redux.dart';

// 用户收藏和阅读历史记录
final userReadsReducer = combineReducers<List<User_read>>([
  TypedReducer(_updateUserReads),
  TypedReducer(_addUserRead),
  TypedReducer(_changeUserRead),
]);

List<User_read> _updateUserReads(
  List<User_read> userReads,
  UpdateUserReadsAction action,
) {
  return action.userReads;
}

class UpdateUserReadsAction {
  final List<User_read> userReads;

  UpdateUserReadsAction(this.userReads);
}

// 添加一条记录到阅读历史列表中
List<User_read> _addUserRead(
  List<User_read> userReads,
  AddUserReadAction action,
) {
  userReads.insert(0, action.userRead);
  return userReads;
}

class AddUserReadAction {
  final User_read userRead;

  AddUserReadAction(this.userRead);
}

// 修改一条阅读历史
List<User_read> _changeUserRead(
  List<User_read> userReads,
  ChangeUserReadAction action,
) {
  return userReads.map((item) {
    if (item.comicId == action.userRead.comicId) {
      return action.userRead;
    }
    return item;
  }).toList();
}

class ChangeUserReadAction {
  final User_read userRead;

  ChangeUserReadAction(this.userRead);
}

// 异步更新redux
// 获取用户的收藏和阅读记录
Future<void> getUserRecordAsyncAction(Store<AppState> store) async {
  if (store.state.userCollects != null) {
    return;
  }

  var guestInfo = store.state.guestInfo;
  var userInfo = store.state.userInfo;
  var user = userInfo.uid != null ? userInfo : guestInfo;

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

  store.dispatch(UpdateUserCollectsAction(userCollect));
  store.dispatch(UpdateUserReadsAction(userRead));
}
