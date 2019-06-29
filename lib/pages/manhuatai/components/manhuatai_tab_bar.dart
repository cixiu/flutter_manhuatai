import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef void ChangeIndex(int index);

class ManhuataiTabBar extends StatelessWidget {
  final int currentIndex;
  final ChangeIndex onChangeIndex;

  ManhuataiTabBar(
    this.currentIndex,
    this.onChangeIndex,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildTab(
          text: '推荐',
          index: 0,
        ),
        _buildTab(
          text: '关注',
          index: 1,
        ),
      ],
    );
  }

  Widget _buildTab({
    String text,
    int index,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onChangeIndex(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(30),
          vertical: ScreenUtil().setWidth(25),
        ),
        child: Text(
          '$text',
          strutStyle: StrutStyle(
            forceStrutHeight: true,
            fontSize: currentIndex == index
                ? ScreenUtil().setSp(34)
                : ScreenUtil().setSp(28),
          ),
          style: currentIndex == index
              ? TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(34),
                )
              : TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenUtil().setSp(28),
                ),
        ),
      ),
    );
  }
}
