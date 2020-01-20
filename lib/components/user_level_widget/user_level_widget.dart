import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum LevelSize {
  small,
  big,
}

class UserLevelWidget extends StatelessWidget {
  final UserInfo userInfo;
  final UserInfo guestInfo;
  final LevelSize size;

  UserLevelWidget({
    this.userInfo,
    this.guestInfo,
    this.size = LevelSize.big,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // 导航去等级详情
        Application.router.navigateTo(context, Routes.myLevel);
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            'lib/images/mine/icon_mine_lv.png',
            width: size == LevelSize.big
                ? ScreenUtil().setWidth(72)
                : ScreenUtil().setWidth(60),
            height: size == LevelSize.big
                ? ScreenUtil().setWidth(42)
                : ScreenUtil().setWidth(35),
          ),
          Container(
            margin: EdgeInsets.only(
              top: size == LevelSize.big
                  ? ScreenUtil().setWidth(10)
                  : ScreenUtil().setWidth(8),
            ),
            child: Text(
              'LV${userInfo?.ulevel ?? guestInfo.ulevel}',
              style: TextStyle(
                color: Colors.white,
                fontSize: size == LevelSize.big
                    ? ScreenUtil().setSp(24)
                    : ScreenUtil().setSp(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
