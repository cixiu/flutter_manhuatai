import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RequestLoading extends StatelessWidget {
  final String message;

  RequestLoading({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setHeight(180),
        ),
        height: ScreenUtil().setWidth(80),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(
            ScreenUtil().setWidth(40),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SpinKitHourGlass(
              color: Colors.white,
              size: ScreenUtil().setWidth(50),
            ),
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
              ),
              child: Text(
                message ?? '正在接入萝卜星球...请稍后',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showLoading(BuildContext context, {String message}) {
  // 显示请求的loading
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Material(
        type: MaterialType.transparency,
        child: RequestLoading(message: message),
      );
    },
  );
}

hideLoading(BuildContext context) {
  return Navigator.of(context, rootNavigator: true).pop();
}
