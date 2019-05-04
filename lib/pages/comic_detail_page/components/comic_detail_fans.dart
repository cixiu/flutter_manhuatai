import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/models/comic_info_influence.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

class ComicDetailFans extends StatelessWidget {
  final Call_data influenceData;
  final List<Insider_list> insiderFansList;

  ComicDetailFans({
    this.influenceData,
    this.insiderFansList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: ScreenUtil().setWidth(1),
            color: Colors.grey[200],
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '粉丝打call',
                  style: TextStyle(
                    fontSize: ScreenUtil().setWidth(32),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        right: ScreenUtil().setWidth(10),
                      ),
                      child: Stack(
                        children: _buildFansListAvatar(),
                      ),
                    ),
                    Icon(
                      Icons.navigate_next,
                      size: ScreenUtil().setSp(28),
                      color: Colors.grey,
                    ),
                  ],
                )
              ],
            ),
          ),
          _buildInfluenceWidget(),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(20),
              horizontal: ScreenUtil().setWidth(22),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(250),
                  child: Text(
                    '作者大大需要您的支持(●ﾟωﾟ●)',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenUtil().setSp(24),
                    ),
                  ),
                ),
                Container(
                  height: ScreenUtil().setWidth(66),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: ScreenUtil().setWidth(1),
                    ),
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setWidth(66),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'lib/images/icon_detail_jt281.png',
                        width: ScreenUtil().setWidth(44),
                        height: ScreenUtil().setWidth(44),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(12),
                        ),
                        child: Text(
                          '给作者加油打call',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 前3的粉丝
  List<Widget> _buildFansListAvatar() {
    List<Widget> children = [];
    for (int i = 0; i < 3; i++) {
      var fan = insiderFansList[i];
      children.add(
        Transform.translate(
          offset: Offset(ScreenUtil().setWidth(-36.0 * (3 - i - 1)), 0.0),
          // : Offset(0.0, 0.0),
          child: Stack(
            alignment: Alignment.bottomRight,
            overflow: Overflow.visible,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(46),
                ),
                child: ImageWrapper(
                  url: Utils.generateImgUrlFromId(
                    id: fan.uid,
                    aspectRatio: '1:1',
                    type: 'head',
                  ),
                  width: ScreenUtil().setWidth(46),
                  height: ScreenUtil().setWidth(46),
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(16),
                ),
                child: Container(
                  width: ScreenUtil().setWidth(16),
                  height: ScreenUtil().setWidth(16),
                  color: i == 0
                      ? Color(0xfffdb60a)
                      : i == 1 ? Color(0xff909090) : Color(0xff08a0ff),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setWidth(12),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    return children.reversed.toList();
  }

  // 漫画的具体数据
  Widget _buildInfluenceWidget() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(12),
        horizontal: ScreenUtil().setWidth(22),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: ScreenUtil().setWidth(1),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  ScreenUtil().setWidth(16),
                ),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setWidth(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildInfluneceItem(
                        text: '阅读',
                        count: Utils.formatNumber(influenceData.pv),
                      ),
                      _buildInflunenceItemDivider(),
                      _buildInfluneceItem(
                        text: '日活',
                        count: Utils.formatNumber(influenceData.uv),
                      ),
                      _buildInflunenceItemDivider(),
                      _buildInfluneceItem(
                        text: '收藏',
                        count: Utils.formatNumber(influenceData.collect),
                      ),
                      _buildInflunenceItemDivider(),
                      _buildInfluneceItem(
                        text: '分享',
                        count: Utils.formatNumber(influenceData.share),
                      ),
                      _buildInflunenceItemDivider(),
                      _buildInfluneceItem(
                        text: '留言',
                        count: Utils.formatNumber(influenceData.comment),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setWidth(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildInfluneceItem(
                        text: '赞赏',
                        count: Utils.formatNumber(influenceData.reward),
                      ),
                      _buildInflunenceItemDivider(),
                      _buildInfluneceItem(
                        text: '礼物',
                        count: Utils.formatNumber(influenceData.gift),
                      ),
                      _buildInflunenceItemDivider(),
                      _buildInfluneceItem(
                        text: '月票',
                        count: Utils.formatNumber(influenceData.ticket),
                      ),
                      _buildInflunenceItemDivider(),
                      _buildInfluneceItem(
                        text: '萝卜',
                        count: Utils.formatNumber(influenceData.recommend),
                      ),
                      _buildInflunenceItemDivider(),
                      _buildInfluneceItem(
                        text: '评分',
                        count: influenceData.score,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: ScreenUtil().setWidth(1),
            color: Colors.grey[350],
          ),
          Positioned(
            left: ScreenUtil().setWidth(-11),
            child: Container(
              width: ScreenUtil().setWidth(21),
              height: ScreenUtil().setWidth(21),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: ScreenUtil().setWidth(1),
                ),
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(20),
                ),
              ),
            ),
          ),
          Positioned(
            right: ScreenUtil().setWidth(-11),
            child: Container(
              width: ScreenUtil().setWidth(21),
              height: ScreenUtil().setWidth(21),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: ScreenUtil().setWidth(1),
                ),
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfluneceItem({
    String text,
    String count,
  }) {
    return Container(
      width: ScreenUtil().setWidth(130),
      child: Column(
        children: <Widget>[
          Text(
            '$count',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(20),
              color: Color.fromRGBO(0, 0, 0, 0.7),
            ),
          ),
          Text(
            '$text',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(20),
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInflunenceItemDivider() {
    return Container(
      width: ScreenUtil().setWidth(1),
      height: ScreenUtil().setWidth(50),
      color: Colors.grey[350],
    );
  }
}
