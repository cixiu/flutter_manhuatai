import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/models/topic_hot_list.dart' as TopicHotList;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'manhuatai_sliver_title.dart';

class RecommendTopicSliverList extends StatelessWidget {
  final List<TopicHotList.List_List> topicHotList;

  RecommendTopicSliverList({
    this.topicHotList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        ManhuataiSliverTitle(
          title: '热门话题',
          onTap: () {
            print('跳转至热门话题页面');
          },
        ),
        Container(
          height: ScreenUtil().setWidth(50),
          margin: EdgeInsets.symmetric(
            vertical: ScreenUtil().setWidth(30),
          ),
          child: ListView(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(30),
            ),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: _buildChildren(),
          ),
        )
      ]),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> _children = [];

    for (int i = 0; i < topicHotList.length; i++) {
      var item = topicHotList[i];

      _children.add(Container(
        height: ScreenUtil().setWidth(50),
        margin: EdgeInsets.only(
          right: ScreenUtil().setWidth(20),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300],
            width: ScreenUtil().setWidth(1),
          ),
          borderRadius: BorderRadius.circular(
            ScreenUtil().setWidth(4),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          '#${item.name}#',
          style: TextStyle(
            color: Colors.black87,
            fontSize: ScreenUtil().setSp(24),
          ),
        ),
      ));
    }

    return _children;
  }
}
