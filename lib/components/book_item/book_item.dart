import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'book_item_dispaly_6_8.dart';
import 'book_item_display_1.dart';
import 'book_item_display_3.dart';
import 'book_item_dispaly_29.dart';
import 'book_item_display_61.dart';
import 'book_item_display_72.dart';
import 'book_item_display_9.dart';

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

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      reverseDuration: Duration(milliseconds: 400),
    );

    setState(() {
      // 深克隆一份数据，以防后续的操作修改原数据
      book = RecommendList.Book.fromJson(
        json.decode(json.encode(widget.book.toJson())),
      );
    });
  }

  @override
  void didUpdateWidget(BookItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.book.title != widget.book.title) {
      setState(() {
        // 深克隆一份数据，以防后续的操作修改原数据
        book = RecommendList.Book.fromJson(
          json.decode(json.encode(widget.book.toJson())),
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _switchBookList() async {
    if (widget.needSwith) {
      await _controller.forward();
      _controller.reverse();

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
    if (widget.book.config.displayType == 6 ||
        widget.book.config.displayType == 8) {
      return BookItemDisplay6And8(
        book: book,
        horizontalPadding: totalHorizontalPadding,
      );
    } else if (widget.book.config.displayType == 9) {
      return BookItemDisplay9(
        book: book,
        horizontalPadding: totalHorizontalPadding,
      );
    } else if (widget.book.config.displayType == 29) {
      return BookItemDisplay29(
        book: book,
        horizontalPadding: totalHorizontalPadding,
      );
    } else if (book.config.displayType == 3 ||
        book.config.displayType == 0 ||
        book.config.displayType == 11) {
      // 展示的数量
      int count = (book.config.displayType == 11) ? 6 : 4;
      return BookItemDisplay3(
        book: book,
        count: count,
        horizontalPadding: totalHorizontalPadding,
      );
    } else if (book.config.displayType == 61) {
      return BookItemDisplay61(
        book: book,
        horizontalPadding: totalHorizontalPadding,
      );
    } else if (book.config.displayType == 72) {
      return BookItemDisplay72(
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
              Expanded(
                child: Text(
                  widget.book.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // BookItem 的主要内容
        FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.ease,
          )),
          child: buildBookItem(),
        ),
        // buildBookItem(),

        // 换一换 或者 更多
        buildActionWidget()
      ],
    );
  }

  Widget buildActionWidget() {
    var style = TextStyle(
      color: Colors.lightBlue[200],
      fontSize: ScreenUtil().setSp(28),
    );
    bool needSwith = widget.needSwith;
    bool showMore = widget.book.config.isshowmore == 1;

    if (!needSwith && !showMore) {
      return Container();
    }

    return Container(
      margin: EdgeInsets.all(
        ScreenUtil().setWidth(30),
      ),
      child: Row(
        mainAxisAlignment: (showMore && needSwith)
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: <Widget>[
          needSwith
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _switchBookList,
                  child: Container(
                    width: ScreenUtil().setWidth(300),
                    height: ScreenUtil().setWidth(60),
                    alignment: Alignment.center,
                    color: Colors.lightBlue[50],
                    child: Text(
                      '换一换(ノ>ω<)ノ',
                      style: style,
                    ),
                  ),
                )
              : Container(),
          showMore
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Application.router.navigateTo(
                      context,
                      '${Routes.bookDetail}?bookId=${book.bookId}',
                    );
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(300),
                    height: ScreenUtil().setWidth(60),
                    alignment: Alignment.center,
                    color: Colors.lightBlue[50],
                    child: Text(
                      '更多(つˊωˋ)つ',
                      style: style,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
