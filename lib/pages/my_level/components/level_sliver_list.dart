import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/model/level_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LevelSliverList extends StatefulWidget {
  final List<LevelInfo> levelList;
  final int currentLevel;

  LevelSliverList({
    this.levelList,
    this.currentLevel,
  });

  @override
  _LevelSliverListState createState() => _LevelSliverListState();
}

class _LevelSliverListState extends State<LevelSliverList> {
  ScrollController _scrollController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    double width = ScreenUtil().setWidth(180);
    double initialScrollOffset = 0.0;
    int currentIndex = widget.levelList.indexWhere((item) {
      return widget.currentLevel >= item.startLevel &&
          widget.currentLevel <= item.endLevel;
    });
    if (currentIndex >= 2) {
      initialScrollOffset = (currentIndex - 1) * width;
    }
    _scrollController =
        ScrollController(initialScrollOffset: initialScrollOffset);
    setState(() {
      _currentIndex = currentIndex;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BorderSide borderSide = BorderSide(
      color: Colors.blue[200],
      width: ScreenUtil().setWidth(1),
    );

    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          padding: EdgeInsets.all(
            ScreenUtil().setWidth(20),
          ),
          child: Text(
            '等级特权',
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(34),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: borderSide,
              bottom: borderSide,
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                height: ScreenUtil().setWidth(700),
                decoration: BoxDecoration(
                  border: Border(
                    right: borderSide,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    _buildColumnTextItem('等级'),
                    _buildColumnTextItem('回复上限'),
                    _buildColumnTextItem('发帖上限'),
                    _buildColumnTextItem('好友上限'),
                    _buildColumnTextItem('留言带图'),
                    _buildColumnTextItem('留言免审'),
                    _buildColumnTextItem('申请纪律委员'),
                    _buildColumnTextItem('赠萝卜'),
                    _buildColumnTextItem('赠月票'),
                    _buildColumnTextItem('赠萌币'),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: ScreenUtil().setWidth(700),
                  child: Stack(
                    children: <Widget>[
                      ListView(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        children: _buildLevelList(borderSide),
                      ),
                      IgnorePointer(
                        child: Opacity(
                          opacity: 0.2,
                          child: Container(
                            width: ScreenUtil().setWidth(180),
                            color: Colors.blue[50],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  List<Widget> _buildLevelList(BorderSide borderSide) {
    List<Widget> result = [];
    for (int i = 0; i < widget.levelList.length; i++) {
      var item = widget.levelList[i];
      result.add(Container(
        decoration: BoxDecoration(
          color: _currentIndex == i ? Colors.lightBlue[50] : null,
          border: Border(
            right: borderSide,
          ),
        ),
        child: Column(
          children: <Widget>[
            _buildColumnValueItem(
              text: 'LV${item.startLevel}+',
              primary: true,
            ),
            _buildColumnValueItem(
              text: item.limitComment != -1 ? '${item.limitComment}条/天' : '不限量',
            ),
            _buildColumnValueItem(
              text: item.limitSatellite != -1
                  ? '${item.limitSatellite}条/天'
                  : '不限量',
            ),
            _buildColumnValueItem(
              text: item.limitFriends != -1 ? '${item.limitFriends}人' : '不限量',
            ),
            _buildColumnValueItem(
              enable: item.isCommentPicture == 1,
            ),
            _buildColumnValueItem(
              enable: item.isCommentCheck == 1,
            ),
            _buildColumnValueItem(
              enable: item.isApplyAuditOfficer == 1,
            ),
            _buildColumnValueItem(
              text: '${item.giveRecommendTicket}个/日',
            ),
            _buildColumnValueItem(
              text: '${item.giveMonthTicket}张/月',
            ),
            _buildColumnValueItem(
              enable: item.giveCoin != 0,
              text: '${item.giveCoin}/月',
              isLast: true,
            ),
          ],
        ),
      ));
    }

    return result;
  }

  Widget _buildColumnTextItem(String text) {
    return Container(
      width: ScreenUtil().setWidth(180),
      height: ScreenUtil().setWidth(70),
      alignment: Alignment.center,
      child: Text(
        text,
        strutStyle: StrutStyle(
          forceStrutHeight: true,
          fontSize: ScreenUtil().setSp(26),
        ),
        style: TextStyle(
          color: Colors.blue,
          fontSize: ScreenUtil().setSp(26),
        ),
      ),
    );
  }

  Widget _buildColumnValueItem({
    String text,
    bool enable = true,
    bool primary = false,
    bool isLast = false,
  }) {
    return Container(
      width: ScreenUtil().setWidth(180),
      height: ScreenUtil().setWidth(70),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primary ? Colors.lightBlue[50] : null,
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(
                  color: Colors.blue[200],
                  width: ScreenUtil().setWidth(1),
                ),
        ),
      ),
      child: text != null && enable
          ? Text(
              text,
              strutStyle: StrutStyle(
                forceStrutHeight: true,
                fontSize: ScreenUtil().setSp(24),
              ),
              style: TextStyle(
                color: primary ? Colors.blue[400] : Colors.black87,
                fontSize: ScreenUtil().setSp(24),
              ),
            )
          : Image.asset(
              enable
                  ? 'lib/images/level/icon_level_gou.png'
                  : 'lib/images/level/icon_level_cha.png',
              width: enable
                  ? ScreenUtil().setWidth(28)
                  : ScreenUtil().setWidth(22),
            ),
    );
  }
}
