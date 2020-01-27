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
          margin: EdgeInsets.only(
            top: ScreenUtil().setWidth(20),
          ),
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
        Padding(
          padding: EdgeInsets.only(
            bottom: ScreenUtil().setWidth(80),
          ),
          child: Column(
            children: <Widget>[
              _buildLevelWay(
                assetName: 'lib/images/level/icon_level_renwu.png',
                nextAssetName: 'lib/images/level/icon_level_go_violet.png',
                text: '去做任务',
              ),
              _buildLevelWay(
                assetName: 'lib/images/level/icon_level_jingyan.png',
                nextAssetName: 'lib/images/level/icon_level_go_red.png',
                text: '购买经验瓶',
              ),
              _buildLevelWay(
                assetName: 'lib/images/level/icon_level_ka.png',
                nextAssetName: 'lib/images/level/icon_level_go_blue.png',
                text: '购买翻倍卡',
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildLevelWay({
    String assetName,
    String nextAssetName,
    String text,
  }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(40),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          Image.asset(assetName),
          Container(
            margin: EdgeInsets.only(
              right: ScreenUtil().setWidth(40),
              bottom: ScreenUtil().setWidth(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    right: ScreenUtil().setWidth(10),
                  ),
                  child: Text(
                    text,
                    strutStyle: StrutStyle(
                      forceStrutHeight: true,
                      fontSize: ScreenUtil().setSp(38),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(38),
                    ),
                  ),
                ),
                Image.asset(
                  nextAssetName,
                  width: ScreenUtil().setWidth(50),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
