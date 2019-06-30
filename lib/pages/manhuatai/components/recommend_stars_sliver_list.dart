import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_manhuatai/models/recommend_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendStarsSliverList extends StatelessWidget {
  final List<Data> dataList;

  RecommendStarsSliverList({
    this.dataList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(30),
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Wrap(
            spacing: ScreenUtil().setWidth(40),
            runSpacing: ScreenUtil().setWidth(30),
            children: _buildChildren(),
          )
        ]),
      ),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> _children = [];

    dataList.take(9).forEach((item) {
      String url = '${AppConst.commentImgHost}/${item.image}';
      _children.add(_buildItem(
        backgroundImage: NetworkImage(url),
        name: item.targetName,
      ));
    });

    _children.add(
      _buildItem(
        backgroundImage: AssetImage('lib/images/icon_chakan_all.png'),
        name: '全部',
        needBorder: false,
      ),
    );
    return _children;
  }

  Widget _buildItem({
    ImageProvider<dynamic> backgroundImage,
    String name,
    bool needBorder = true,
  }) {
    return Column(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(106),
          height: ScreenUtil().setWidth(106),
          decoration: BoxDecoration(
            border: needBorder
                ? Border.all(
                    color: Colors.grey,
                    width: ScreenUtil().setWidth(1),
                  )
                : null,
            borderRadius: BorderRadius.circular(
              ScreenUtil().setWidth(53),
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: backgroundImage,
            radius: ScreenUtil().setWidth(53),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: ScreenUtil().setWidth(10),
          ),
          child: Text(
            '$name',
            style: TextStyle(
              color: Colors.black87,
              fontSize: ScreenUtil().setSp(24),
            ),
          ),
        )
      ],
    );
  }
}
