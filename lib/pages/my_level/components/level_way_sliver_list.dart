import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LevelWaySliverList extends StatefulWidget {
  @override
  _LevelWaySliverListState createState() => _LevelWaySliverListState();
}

class _LevelWaySliverListState extends State<LevelWaySliverList> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          padding: EdgeInsets.all(
            ScreenUtil().setWidth(20),
          ),
          child: Text(
            '升级宝典',
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(34),
            ),
          ),
        ),
      ]),
    );
  }
}
