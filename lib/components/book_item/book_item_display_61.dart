import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/models/recommend_list.dart' as RecommendList;
import 'package:flutter_manhuatai/utils/utils.dart';

/// displayType == 61 的 BookItem需要呈现的布局
class BookItemDisplay61 extends StatelessWidget {
  final RecommendList.Book book;
  final int count; // 布局需要显示的 comic 的数量
  final double horizontalPadding; // 左右2侧水平的padding总和

  BookItemDisplay61(
      {Key key,
      @required this.book,
      this.count = 4,
      this.horizontalPadding = 20.0})
      : super(key: key);

  List<Widget> buildListWidget(BuildContext context, RecommendList.Book book,
      {double width, double horizonratio, double spacing}) {
    List<Widget> _listChildren = [];
    String customHorizonratio;
    double height;
    // 盒子的 width, 去除了左右 padding
    double boxWidth = MediaQuery.of(context).size.width - horizontalPadding;
    int len = this.count != null ? count : this.book.comicInfo.length;

    for (int i = 0; i < len; i++) {
      // 占11份中的8份 -- 通过计算得来
      if (i == 0 || i == 3) {
        width = (boxWidth - spacing) * (8 / 11);
        height = width / 2;
        customHorizonratio = '2:1';
      }
      // 占11份中的3份 -- 通过计算得来
      if (i == 1 || i == 2) {
        width = (boxWidth - spacing) * (3 / 11);
        height = width * (4 / 3);
        customHorizonratio = '3:4';
      }

      RecommendList.Comic_info item = book.comicInfo[i];
      String imgUrl = Utils.formatBookImgUrl(
          comicInfo: item,
          config: book.config,
          customHorizonratio: customHorizonratio);

      Widget child = Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ImageWrapper(
                url: imgUrl, width: width, height: height, fit: BoxFit.fill),
            Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: i.isEven
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      item.comicName,
                      overflow: TextOverflow.ellipsis,
                    ),
                    book.config.isshowdetail != 0
                        ? Text(
                            item.content,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey, fontSize: 10.0),
                          )
                        : Text(''),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
      _listChildren.add(child);
    }

    return _listChildren;
  }

  @override
  Widget build(BuildContext context) {
    double horizonratio = Utils.computedRatio(book.config.horizonratio);
    double spacing = book.config.interwidth == 1 ? 10.0 : 2.0;
    int crossAxisCount = horizonratio >= 1 ? 2 : 3;
    double screenWidth = MediaQuery.of(context).size.width;
    double width =
        (screenWidth - horizontalPadding - (crossAxisCount - 1) * spacing) /
            crossAxisCount;

    // width = (screenWidth - horizontalPadding) * 0.7;
    return Wrap(
      runSpacing: 10.0,
      spacing: spacing,
      children: buildListWidget(context, book,
          width: width, horizonratio: horizonratio, spacing: spacing),
    );
  }
}
