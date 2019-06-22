import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RelatedHeader extends StatelessWidget {
  final String title;
  final bool showAll;
  final VoidCallback onTap;

  RelatedHeader({
    this.title,
    this.showAll = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(32),
            ),
          ),
          showAll
              ? GestureDetector(
                  onTap: () {
                    if (onTap != null) {
                      onTap();
                    }
                  },
                  child: Container(
                    height: ScreenUtil().setWidth(32),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(10),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: ScreenUtil().setWidth(1),
                      ),
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(14),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '全部',
                      strutStyle: StrutStyle(
                        forceStrutHeight: true,
                        fontSize: ScreenUtil().setSp(20),
                      ),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: ScreenUtil().setSp(20),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
