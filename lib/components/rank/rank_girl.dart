import 'package:flutter/material.dart';
import 'rank_title.dart';
import 'rank_item_img.dart';
import 'package:flutter_manhuatai/models/rank_list.dart' as RankList;
import 'package:flutter_manhuatai/utils/utils.dart';

// 排行榜 - 付费榜
class RankGirl extends StatelessWidget {
  final RankList.Data data;
  final int _count = 5;
  final double _spacing = 10.0;
  final double _horizontalPadding = 20.0;

  RankGirl({Key key, @required this.data}) : super(key: key);

  List<Widget> buildListWidget(
    BuildContext context,
  ) {
    List<Widget> _listChildren = [];
    double boxWidth = MediaQuery.of(context).size.width - _horizontalPadding;
    double width;
    double height;

    // 计算宽高
    for (int i = 0; i < _count; i++) {
      String aspectRatio = '2:1';

      if (i == 0) {
        width = boxWidth - 1 * _spacing;
        height = width / 2;
      } else {
        width = (boxWidth - 3 * _spacing) / 4;
        height = width / (3 / 4);
        aspectRatio = '3:4';

      }

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
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
