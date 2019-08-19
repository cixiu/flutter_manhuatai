import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './book_item_display_1.dart';
import './book_item_display_3.dart';
import './book_item_dispaly_29.dart';
import './book_item_display_61.dart';

import 'package:flutter_manhuatai/models/book_list.dart' as RecommendList;

class BookItem extends StatefulWidget {
  final RecommendList.Book book;
  final double horizontalPadding;
  final bool needSwith;

  BookItem({
    Key key,
    @required this.book,
    this.horizontalPadding = 20,
    this.needSwith = false,
  }) : super(key: key);

  _BookItemState createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> with TickerProviderStateMixin {
  RecommendList.Book book;

  int start = 0;
  int end = 4;
  int switchNumber = 0;
  int diff = 4;

  @override
  void initState() {
    super.initState();
    setState(() {
      // 深克隆一份数据，以防后续的操作修改原数据
      book = RecommendList.Book.fromJson(
        json.decode(json.encode(widget.book.toJson())),
      );
    });
  }

  void _switchBookList() {
    if (widget.needSwith) {
      double totalSwitchNumber = widget.book.comicInfo.length / this.diff;
      this.switchNumber++;

      if (this.switchNumber == totalSwitchNumber) {
        this.start = 0;
        this.end = this.diff;
        this.switchNumber = 0;
      } else {
        this.start = this.end;
        this.end = this.end + this.diff;
      }

      setState(() {
        book.comicInfo = widget.book.comicInfo.sublist(this.start, this.end);
      });
    }
  }

  /// 根据不同的 book.displayType 呈现不同的布局
  Widget buildBookItem() {
    double totalHorizontalPadding = widget.horizontalPadding * 2;
    if (widget.book.config.displayType == 29) {
      return BookItemDisplay29(
        book: book,
        horizontalPadding: totalHorizontalPadding,
      );
    } else if (book.config.displayType == 0) {
      return BookItemDisplay3(
        book: book,
        horizontalPadding: totalHorizontalPadding,
      );
    } else if (book.config.displayType == 3) {
      return BookItemDisplay3(
        book: book,
        horizontalPadding: totalHorizontalPadding,
      );
    } else if (book.config.displayType == 11) {
      return BookItemDisplay3(
        book: book,
        count: 6,
        horizontalPadding: totalHorizontalPadding,
      );
    } else if (book.config.displayType == 61) {
      return BookItemDisplay61(
        book: book,
        horizontalPadding: totalHorizontalPadding,
      );
    } else {
      return BookItemDisplay1(
        book: book,
        horizontalPadding: totalHorizontalPadding,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // double horizonratio = Utils.computedRatio(widget.book.config.horizonratio);
    // print('${widget.book.title} $horizonratio');

    return Column(
      children: <Widget>[
        // BookItem的标题
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setWidth(30),
            horizontal: ScreenUtil().setWidth(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: _switchBookList,
                child: Row(
                  children: <Widget>[
                    Text(
                      widget.book.title,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(40),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    widget.needSwith
                        ? Container(
                            margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(10),
                            ),
                            child: Image.asset(
                              'lib/images/book_switch.png',
                              height: ScreenUtil().setWidth(42),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              widget.book.config.isshowmore == 1
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Application.router.navigateTo(
                          context,
                          '${Routes.bookDetail}?bookId=${book.bookId}',
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(10),
                          top: ScreenUtil().setWidth(10),
                          bottom: ScreenUtil().setWidth(10),
                        ),
                        child: Text(
                          '更多',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  : Text('')
            ],
          ),
        ),

        // BookItem 的主要内容
        buildBookItem(),
      ],
    );
  }
}
