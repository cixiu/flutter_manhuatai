import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/models/book_list.dart' as RecommendList;
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'book_item_content.dart';

/// displayType == 9 的 BookItem需要呈现的布局
class BookItemDisplay9 extends StatelessWidget {
  final RecommendList.Book book;
  final double horizontalPadding; // 左右2侧水平的padding总和
  final int count;

  BookItemDisplay9({
    Key key,
    @required this.book,
    this.horizontalPadding = 40,
    this.count = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizonratio = Utils.computedRatio(book.config.horizonratio);
    double width = MediaQuery.of(context).size.width -
        ScreenUtil().setWidth(horizontalPadding);

    return Wrap(
      runSpacing: ScreenUtil().setWidth(20),
      spacing: 10,
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
