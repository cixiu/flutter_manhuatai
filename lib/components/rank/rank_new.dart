import 'package:flutter/material.dart';
import 'rank_title.dart';
import 'rank_item_img.dart';
import 'package:flutter_manhuatai/models/rank_list.dart' as RankList;
import 'package:flutter_manhuatai/utils/utils.dart';

// 排行榜 - 新作榜
class RankNew extends StatelessWidget {
  final RankList.Data data;
  final int _count = 6;
  final double _spacing = 10.0;
  final double _horizontalPadding = 20.0;

  RankNew({Key key, @required this.data}) : super(key: key);

  List<Widget> buildListWidget(
    BuildContext context,
  ) {
    List<Widget> _listChildren = [];
    double boxWidth = MediaQuery.of(context).size.width - _horizontalPadding;
    double width;
    double height;

    // 计算宽高
    for (int i = 0; i < _count; i++) {
      String aspectRatio = '3:4';
      width = ((boxWidth - 2 * _spacing) / 3) * 0.999999;
      height = width;

      RankList.ListSub item = data.list[i];
      String imgUrl = Utils.generateImgUrlFromId(
          id: item.comicId, aspectRatio: aspectRatio);

      Widget child = RankItemImg(
        url: imgUrl,
        width: width,
        height: height,
        item: item,
        index: i,
      );

      _listChildren.add(child);
    }

    return _listChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RankTitle(
            type: data.type,
            name: data.name,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: _spacing,
            runSpacing: 2.0,
            children: buildListWidget(context),
          ),
        ],
      ),
    );
  }
}
