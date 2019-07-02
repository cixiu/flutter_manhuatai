import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadMoreWidget extends StatelessWidget {
  final bool hasMore;

  LoadMoreWidget({this.hasMore = true});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: Colors.grey,
      fontSize: ScreenUtil().setSp(28),
    );
    // 根据是否需要加载更多控制底部的显示 widget
    Widget bottomWidget = hasMore
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  right: ScreenUtil().setWidth(20),
                ),
                width: ScreenUtil().setWidth(40),
                height: ScreenUtil().setWidth(40),
                child: CircularProgressIndicator(
                  strokeWidth: ScreenUtil().setWidth(4),
                ),
              ),
              Text(
                '正在加载...',
                style: textStyle,
              ),
            ],
          )
        : Container(
            height: ScreenUtil().setWidth(40),
            child: Text(
              '小主没有更多了呢！',
              style: textStyle,
            ),
          );

    return Padding(
      padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
      child: Center(
        child: bottomWidget,
      ),
    );
  }
}
