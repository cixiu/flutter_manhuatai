import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:flutter_manhuatai/pages/home/home.dart';
import 'package:flutter_manhuatai/provider_store/user_info_model.dart';

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
    var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
    await userInfoModel.getUseroOrGuestInfo();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(750, 1334),
      allowFontScaling: false,
    );

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
