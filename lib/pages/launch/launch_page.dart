import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';

import 'package:flutter_manhuatai/pages/home/home.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getUseroOrGuestInfo();
      Future.delayed(Duration(milliseconds: 3000), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage(),
          ),
        );
      });
    });
  }

  // 获取登录的用户信息或者游客信息
  Future<void> _getUseroOrGuestInfo() async {
    Store<AppState> store = StoreProvider.of(context);
    await getUseroOrGuestInfo(store);
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
