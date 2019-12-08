import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/models/book_list.dart' as RecommendList;
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

/// displayType == 6 || 8 的 BookItem需要呈现的布局
class BookItemDisplay6And8 extends StatelessWidget {
  final RecommendList.Book book;
  final int count; // 布局需要显示的 comic 的数量
  final double horizontalPadding; // 左右2侧水平的padding总和

  BookItemDisplay6And8({
    Key key,
    @required this.book,
    this.count,
    this.horizontalPadding = 40,
  }) : super(key: key);

  // 构建BookItem的子项
  List<Widget> buildListWidget(
    BuildContext context,
    RecommendList.Book book, {
    double horizonratio,
    double spacing,
  }) {
    List<Widget> _listChildren = [];
    int bigImgNum = 0;
    // 盒子的 width, 去除了左右 padding
    double boxWidth = MediaQuery.of(context).size.width -
        ScreenUtil().setWidth(horizontalPadding);
    int len = this.count != null ? count : this.book.comicInfo.length;
    if (len > 5) {
      len = 5;
    }

    if (book.config.displayType == 8) {
      bigImgNum = 2;
    }

    for (int i = 0; i < len; i++) {
      double width;
      double height;
      RecommendList.Comic_info item = book.comicInfo[i];

      if (i == bigImgNum) {
        width = boxWidth;
        height = width / horizonratio;
      } else {
        width = (boxWidth - spacing) / 2;
        height = width / 2;
      }

      String imgUrl = Utils.formatBookImgUrl(
        comicInfo: item,
        config: book.config,
        customHorizonratio: '2:1',
      );

      Widget child = GestureDetector(
        onTap: () {
          Application.router.navigateTo(
            context,
            '/comic/detail/${item.comicId}',
          );
        },
        child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ImageWrapper(
                url: imgUrl,
                width: width,
                height: height,
              ),
              Container(
                margin: EdgeInsets.only(
                  right: ScreenUtil().setWidth(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(16),
                      ),
                      child: Text(
                        item.comicName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(28),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(10),
                      ),
                      child: Text(
                        item.lastComicChapterName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: ScreenUtil().setSp(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      _listChildren.add(child);
    }

    return _listChildren;
  }

  @override
  Widget build(BuildContext context) {
    double horizonratio = Utils.computedRatio(book.config.horizonratio);
    double spacing = book.config.interwidth == 1
        ? ScreenUtil().setWidth(20)
        : ScreenUtil().setWidth(4);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: spacing,
      runSpacing: ScreenUtil().setWidth(4),
      children: buildListWidget(
        context,
        book,
        spacing: spacing,
        horizonratio: horizonratio,
      ),
    );
  }
}
