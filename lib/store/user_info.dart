import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:flutter_manhuatai/store/index.dart';
import 'package:flutter_manhuatai/utils/sp.dart';
import 'package:redux/redux.dart';

// 用户信息
final userInfoReducer = combineReducers<UserInfo>([
  TypedReducer(_updateUserInfo),
]);

UserInfo _updateUserInfo(UserInfo user, UpdateUserInfoAction action) {
  return action.userInfo;
}

class UpdateUserInfoAction {
  final UserInfo userInfo;

  UpdateUserInfoAction(this.userInfo);
}

// 游客信息
final guestInfoReducer = combineReducers<UserInfo>([
  TypedReducer(_updateGuestInfo),
]);

UserInfo _updateGuestInfo(UserInfo guest, UpdateGuestInfoAction action) {
  return action.guestInfo;
}

class UpdateGuestInfoAction {
  final UserInfo guestInfo;

  UpdateGuestInfoAction(this.guestInfo);
}

// 获取登录的用户信息或者游客信息
Future<void> getUseroOrGuestInfo(Store<AppState> store) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String token = '';
  var userInfo = store.state.userInfo;
  var guestInfo = store.state.guestInfo;

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    token = androidInfo.androidId;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    token = iosInfo.identifierForVendor;
  }
  print('------------------------------------');
  print('设备的id $token');
  print('游客的id ${guestInfo.uid}');
  print('用户的id ${userInfo.uid}');
  print('------------------------------------');

  // 如果是既没有使用用户登录也没有使用游客登录（即第一次使用该应用或者清空的缓存）
  // 则进入应用时先使用游客进行登录
  if (userInfo.uid == null && guestInfo.uid == null) {
    var guestInfoMap = await Api.getUserInfo(
      type: 'device',
      token: token,
    );
    print('用户或者游客都没有登录');
    var newGuestInfo = await SpUtils.saveGuestInfo(guestInfoMap);
    store.dispatch(UpdateGuestInfoAction(newGuestInfo));
  }
  // 如果已经使用了游客登录了，则更新每次进入应用是的游客信息
  if (userInfo.uid == null && guestInfo.uid != null) {
    var guestInfoMap = await Api.getUserInfo(
      type: 'device',
      deviceid: token,
      openid: guestInfo.openid,
      myuid: guestInfo.uid,
      autologo: '1',
    );
    print('游客登录了，更新游客信息');
    var newGuestInfo = await SpUtils.saveGuestInfo(guestInfoMap);
    store.dispatch(UpdateGuestInfoAction(newGuestInfo));
  }
  // 如果已经使用用户登录过了，则更新登录用户的信息
  if (userInfo.uid != null) {
    var userInfoMap = await Api.getUserInfo(
      type: 'mkxq',
      deviceid: token,
      openid: userInfo.openid,
      myuid: userInfo.uid,
      autologo: '1',
    );
    print('用户登录了，更新用户信息');
    var newUserInfo = await SpUtils.saveUserInfo(userInfoMap);
    store.dispatch(UpdateUserInfoAction(newUserInfo));
  }
}
