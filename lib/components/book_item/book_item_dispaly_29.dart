import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/models/book_list.dart' as RecommendList;
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

/// displayType == 29 的 BookItem需要呈现的布局
class BookItemDisplay29 extends StatelessWidget {
  final RecommendList.Book book;
  final int count; // 布局需要显示的 comic 的数量
  final double horizontalPadding; // 左右2侧水平的padding总和

  BookItemDisplay29({
    Key key,
    @required this.book,
    this.count,
    this.horizontalPadding = 40,
  }) : super(key: key);

  // 构建BookItem的子项
  List<Widget> buildListWidget(
    BuildContext context,
    RecommendList.Book book, {
    double width,
    double horizonratio,
    double spacing,
  }) {
    List<Widget> _listChildren = [];
    double height = width / horizonratio;
    // 盒子的 width, 去除了左右 padding
    double boxWidth = MediaQuery.of(context).size.width -
        ScreenUtil().setWidth(horizontalPadding);
    int len = this.count != null ? count : this.book.comicInfo.length;

    for (int i = 0; i < len; i++) {
      // 排第一的width 和 height 要突出一些 分配的 width 为 0.38
      if (i == 0) {
        width = (boxWidth - 2 * spacing) * 0.38;
        height = width / horizonratio;
      }
      // 排第一和第三的width 和 height 分配的 width 为 0.38
      if (i == 1 || i == 2) {
        width = (boxWidth - 2 * spacing) * 0.31;
        height = width / horizonratio;
      }
      // 索引大于3后的漫画，每行排2个
      if (i >= 3) {
        width = (boxWidth - ScreenUtil().setWidth(20)) / 2;
        height = width / 2;
      }

      RecommendList.Comic_info item = book.comicInfo[i];
      String imgUrl = Utils.formatBookImgUrl(
        comicInfo: item,
        config: book.config,
        customHorizonratio: i >= 3 ? '2:1' : null,
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
              Stack(
                children: <Widget>[
                  ImageWrapper(
                    url: imgUrl,
                    width: width,
                    height: height,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(10),
                    child: ClipOval(
                      child: Container(
                        color: Colors.white,
                        width: ScreenUtil().setWidth(28),
                        height: ScreenUtil().setWidth(28),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(
                  ScreenUtil().setWidth(16),
                ),
                child: Text(
                  item.comicName,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      );
      _listChildren.add(child);
    }
    // 将索引为 0 和 1 的 Widget 对换位置
    _listChildren.insert(1, _listChildren.removeAt(0));
    return _listChildren;
  }

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
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: spacing,
      runSpacing: ScreenUtil().setWidth(4),
      children: buildListWidget(
        context,
        book,
        width: width,
        spacing: spacing,
        horizonratio: horizonratio,
      ),
    );
  }
}
