import 'package:flutter/material.dart';
import 'rank_title.dart';
import 'rank_item_img.dart';
import 'package:flutter_manhuatai/models/rank_list.dart' as RankList;
import 'package:flutter_manhuatai/utils/utils.dart';

// 排行榜 - 免费榜
class RankFree extends StatelessWidget {
  final RankList.Data data;
  final int _count = 6;
  final double _spacing = 10.0;
  final double _horizontalPadding = 20.0;

  RankFree({Key key, @required this.data}) : super(key: key);

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
      // i = 0 ~ 2的宽高比是3:4
      if (i == 0) {
        width = (boxWidth - 2 * _spacing) * 0.38;
        height = width / (3 / 4);
      }

      if (i == 1 || i == 2) {
        width = (boxWidth - 2 * _spacing) * 0.31;
        height = width / (3 / 4);
      }

      // 索引大于3后的漫画，每行排2个
      if (i >= 3) {
        width = (boxWidth - 2 * _spacing) / 3;
        height = width;
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
    // 将索引为 0 和 1 的Widget对换位置
    _listChildren.insert(1, _listChildren.removeAt(0));
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
