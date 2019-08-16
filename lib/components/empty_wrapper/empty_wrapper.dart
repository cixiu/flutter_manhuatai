import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyWrapper extends StatelessWidget {
  final String title;
  final String subTitle;

  EmptyWrapper({
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            height: ScreenUtil().setWidth(100),
            width: ScreenUtil().setWidth(450),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(50),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.lightBlue[50],
                  offset: Offset(0, -ScreenUtil().setWidth(1)),
                ),
                BoxShadow(
                  color: Colors.lightBlue[50],
                  offset: Offset(0, ScreenUtil().setWidth(4)),
                  blurRadius: ScreenUtil().setWidth(1),
                  spreadRadius: ScreenUtil().setWidth(2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title ?? '没有发现数据哦',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setWidth(28),
                  ),
                ),
                Text(
                  subTitle ?? '赶紧去做点相关的事情来充实下吧~',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil().setWidth(24),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -ScreenUtil().setWidth(78),
            child: Image.asset(
              'lib/images/ico_update_footer.png',
              height: ScreenUtil().setWidth(88),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
