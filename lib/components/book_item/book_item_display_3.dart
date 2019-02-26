import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/models/recommend_list.dart' as RecommendList;
import 'package:flutter_manhuatai/utils/utils.dart';

/// displayType == 3 的 BookItem需要呈现的布局
class BookItemDisplay3 extends StatelessWidget {
  final RecommendList.Book book;
  final int count; // 布局需要显示的 comic 的数量
  final double horizontalPadding; // 左右2侧水平的padding总和

  BookItemDisplay3(
      {Key key,
      @required this.book,
      this.count = 4,
      this.horizontalPadding = 20.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizonratio = Utils.computedRatio(book.config.horizonratio);
    double spacing = book.config.interwidth == 1 ? 10.0 : 2.0;
    int crossAxisCount = horizonratio >= 1 ? 2 : 3;
    double screenWidth = MediaQuery.of(context).size.width;
    double width =
        (screenWidth - horizontalPadding - (crossAxisCount - 1) * spacing) /
            crossAxisCount;

    return Wrap(
      runSpacing: 10.0,
      spacing: spacing,
      children: book.comicInfo.take(this.count).map((item) {
        return Container(
            width: width,
            child: Column(
              children: <Widget>[
                ImageWrapper(
                    url: Utils.formatBookImgUrl(
                        comicInfo: item, config: book.config),
                    width: width,
                    height: width / horizonratio,
                    fit: BoxFit.fill),
                Container(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.comicName,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ));
      }).toList(),
    );
  }
}
