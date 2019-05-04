import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_manhuatai/models/comic_info_influence.dart';

class ComicDetailHeat extends StatelessWidget {
  final Call_data influenceData;

  ComicDetailHeat({
    this.influenceData,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle heatTextStyle = TextStyle(
      color: Colors.black87,
      fontSize: ScreenUtil().setSp(24),
    );

    StrutStyle heatStrutStyle = StrutStyle(
      forceStrutHeight: true,
      fontSize: ScreenUtil().setSp(20),
    );

    TextStyle heatCountStyle = TextStyle(
      color: Color.fromRGBO(0, 0, 0, 0.7),
      fontSize: ScreenUtil().setSp(20),
    );

    TextStyle heatRankStyle = TextStyle(
      color: Colors.grey,
      fontSize: ScreenUtil().setSp(20),
    );

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(30),
        horizontal: ScreenUtil().setWidth(20),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200],
            width: ScreenUtil().setWidth(1),
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '总人气',
                strutStyle: StrutStyle(
                  forceStrutHeight: true,
                  fontSize: ScreenUtil().setSp(24),
                ),
                style: heatTextStyle,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(10),
                ),
                child: Text(
                  '${Utils.formatNumber(influenceData.thistotalHeat)}',
                  strutStyle: heatStrutStyle,
                  style: heatCountStyle,
                ),
              ),
              Text(
                '${Utils.formatNumber(influenceData.thistotalHeatRank.toString())}位',
                strutStyle: heatStrutStyle,
                style: heatRankStyle,
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(60),
          ),
          Row(
            children: <Widget>[
              Text(
                '周人气',
                strutStyle: StrutStyle(
                  forceStrutHeight: true,
                  fontSize: ScreenUtil().setSp(24),
                ),
                style: heatTextStyle,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(10),
                ),
                child: Text(
                  '${Utils.formatNumber(influenceData.thisweekHeat)}',
                  strutStyle: heatStrutStyle,
                  style: heatCountStyle,
                ),
              ),
              Text(
                '${Utils.formatNumber(influenceData.thisweekHeatRank.toString())}位',
                strutStyle: heatStrutStyle,
                style: heatRankStyle,
              ),
              influenceData.upriseRank != 0
                  ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(5),
                      ),
                      child: Image.asset(
                        influenceData.upriseRank < 0
                            ? 'lib/images/icon_detail_sssj1.png'
                            : 'lib/images/icon_detail_sssj2.png',
                        width: ScreenUtil().setWidth(16),
                        height: ScreenUtil().setWidth(20),
                      ),
                    )
                  : Container(),
              influenceData.upriseRank != 0
                  ? Text(
                      '${influenceData.upriseRank.abs()}',
                      style: heatCountStyle,
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
