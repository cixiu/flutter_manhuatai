import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManhuataiSliverTitle extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  ManhuataiSliverTitle({
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setWidth(30),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(32),
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: onTap ?? () {},
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                Image.asset(
                  'lib/images/icon_special_details.png',
                  height: ScreenUtil().setWidth(46),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: ScreenUtil().setWidth(10),
                  ),
                  child: Text(
                    '更多',
                    style: TextStyle(
                      color: Colors.pink[200],
                      fontSize: ScreenUtil().setSp(20),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
