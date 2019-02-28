import 'package:flutter/material.dart';
import 'rank_title.dart';
import 'rank_item_img.dart';
import 'package:flutter_manhuatai/models/rank_list.dart' as RankList;
import 'package:flutter_manhuatai/utils/utils.dart';

// 排行榜 - 自制榜
class RankSelf extends StatefulWidget {
  final RankList.Data data;

  RankSelf({Key key, @required this.data}) : super(key: key);

  @override
  _RankSelfState createState() => _RankSelfState();
}

class _RankSelfState extends State<RankSelf> with WidgetsBindingObserver {
  final int _count = 5;

  final double _spacing = 10.0;

  final double _horizontalPadding = 20.0;

  double boxHeight;

  // 通过 GlobalKey 获取RankItemImg高度
  final key = GlobalKey<RankItemImgState>();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print(key.currentState.context.size);
      setState(() {
        boxHeight = key.currentState.context.size.height;
      });
    });
  }

  List<Widget> buildListWidget(
    BuildContext context,
  ) {
    List<Widget> _listChild = []; // Row中的2个盒子
    Widget _leftChild; // 左侧盒子
    Widget _rightChild; // 右侧盒子
    List<Widget> _rightListChild = []; // 右侧盒子的子盒子列表

    double boxWidth = MediaQuery.of(context).size.width - _horizontalPadding;
    double width;
    double height;

    // 计算宽高
    for (int i = 0; i < _count; i++) {
      String aspectRatio = '3:4';
      RankList.ListSub item = widget.data.list[i];
      String imgUrl = Utils.generateImgUrlFromId(
          id: item.comicId, aspectRatio: aspectRatio);

      // i = 0 单独排在左侧
      if (i == 0) {
        width = (boxWidth - 1 * _spacing) * 0.48;
        height = width / (3 / 4);
        _leftChild = RankItemImg(
          key: key, // 通过 GlobalKey 获取RankItemImg高度
          url: imgUrl,
          width: width,
          height: height,
          item: item,
          index: i,
        );
      } else { // i = 2 ~ 5 排在右侧， 并与第一个盒子的上下2侧对齐
        width = ((boxWidth - 1 * _spacing) * 0.52 - _spacing) / 2;
        height = width;
        _rightListChild.add(RankItemImg(
          url: imgUrl,
          width: width,
          height: height,
          item: item,
          index: i,
        ));
      }
    }

    _rightChild = Container(
      width: (boxWidth - 1 * _spacing) * 0.52,
      height: boxHeight, // 高度要与Row中的第一个盒子高度保持一致
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.end,
        runAlignment: WrapAlignment.spaceBetween,
        spacing: _spacing,
        runSpacing: 2.0,
        children: _rightListChild,
      ),
    );
    return _listChild..add(_leftChild)..add(_rightChild);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RankTitle(
            type: widget.data.type,
            name: widget.data.name,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildListWidget(context),
          ),
        ],
      ),
    );
  }
}
