import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadiusContainer extends StatelessWidget {
  final String text;

  RadiusContainer({
    Key key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(32),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(14),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(32)),
      ),
      child: Center(
        child: Text(
          text,
          strutStyle: StrutStyle(
            forceStrutHeight: true,
            fontSize: ScreenUtil().setSp(20),
          ),
          style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
