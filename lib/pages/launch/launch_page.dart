import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:redux/redux.dart';

import 'package:flutter_manhuatai/pages/home/home.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/utils/sp.dart';
import 'package:flutter_manhuatai/store/index.dart';
import 'package:flutter_manhuatai/store/user_info.dart';

/// 项目的启动页
class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  void initState() {
    super.initState();
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(),
        ),
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getUseroOrGuestInfo();
  }

  // 获取登录的用户信息或者游客信息
  _getUseroOrGuestInfo() async {
    Store<AppState> store = StoreProvider.of(context);
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Image.asset(
                  'lib/images/ic_logo_girl.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Image.asset(
              'lib/images/ic_logo.png',
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
