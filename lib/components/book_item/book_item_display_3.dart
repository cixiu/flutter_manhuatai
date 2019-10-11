import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/models/book_list.dart' as RecommendList;
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

import 'book_item_content.dart';

/// displayType == 3 的 BookItem需要呈现的布局
class BookItemDisplay3 extends StatelessWidget {
  final RecommendList.Book book;
  final int count; // 布局需要显示的 comic 的数量
  final double horizontalPadding; // 左右2侧水平的padding总和

  BookItemDisplay3({
    Key key,
    @required this.book,
    this.count = 4,
    this.horizontalPadding = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizonratio = Utils.computedRatio(book.config.horizonratio);
    double spacing = book.config.interwidth == 1
        ? ScreenUtil().setWidth(20)
        : ScreenUtil().setWidth(4);
    int crossAxisCount = horizonratio >= 1 ? 2 : 3;
    double screenWidth = MediaQuery.of(context).size.width;
    double width = (screenWidth -
            ScreenUtil().setWidth(horizontalPadding) -
            (crossAxisCount - 1) * spacing) /
        crossAxisCount;

    return Wrap(
      runSpacing: ScreenUtil().setWidth(20),
      spacing: spacing,
      children: book.comicInfo.take(count).map((item) {
        return GestureDetector(
          onTap: () {
            Application.router.navigateTo(
              context,
              '/comic/detail/${item.comicId}',
            );
          },
          child: BookItemContent(
            width: width,
            horizonratio: horizonratio,
            item: item,
            config: book.config,
          ),
        );
      }).toList(),
    );
  }
}
