import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:flutter_manhuatai/utils/sp.dart';

class UserInfoModel extends ChangeNotifier {
  /// 用户信息
  UserInfo _userInfo;
  UserInfo get userInfo => _userInfo;

  /// 游客信息
  UserInfo _guestInfo;
  UserInfo get guestInfo => _guestInfo;

  bool get hasLogin => _userInfo.uid != null;
  UserInfo get user => (hasLogin ? userInfo : guestInfo);

  // 初始化 model 数据
  Future<void> initModel() async {
    print('初始化 UserInfoModel 数据');
    var userAndGuest = await Future.wait([
      SpUtils.loadUserInfo(),
      SpUtils.loadGuestInfo(),
    ]);
    print(userAndGuest[1]);
    _userInfo = userAndGuest[0];
    _guestInfo = userAndGuest[1];
    notifyListeners();
  }

  // 设置 userInfo
  void setUserInfo(UserInfo userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }

  // 设置 guestInfo
  void setGuestInfo(UserInfo guestInfo) {
    _guestInfo = guestInfo;
    notifyListeners();
  }

  // 获取登录的用户信息或者游客信息
  Future<void> getUseroOrGuestInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String token = '';
    var userInfo = _userInfo;
    var guestInfo = _guestInfo;

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
      _guestInfo = newGuestInfo;
      notifyListeners();
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
      _guestInfo = newGuestInfo;
      notifyListeners();
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
      _userInfo = newUserInfo;
      notifyListeners();
    }
  }
}
