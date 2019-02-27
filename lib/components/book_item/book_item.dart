import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import './book_item_display_1.dart';
import './book_item_display_3.dart';
import './book_item_dispaly_29.dart';
import './book_item_display_61.dart';

import 'package:flutter_manhuatai/models/recommend_list.dart' as RecommendList;
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

class BookItem extends StatefulWidget {
  final RecommendList.Book book;

  BookItem({Key key, @required this.book}) : super(key: key);

  _BookItemState createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {

  /// 根据不同的 book.displayType 呈现不同的布局
  Widget buildBookItem() {
    if (widget.book.config.displayType == 29) {
      return BookItemDisplay29(book: widget.book,);
    } else if (widget.book.config.displayType == 3) {
      return BookItemDisplay3(book: widget.book,);
    } else if (widget.book.config.displayType == 11) {
      return BookItemDisplay3(book: widget.book, count: 6,);
    } else if (widget.book.config.displayType == 61) {
      return BookItemDisplay61(book: widget.book,);
    } else {
      return BookItemDisplay1(book: widget.book,);
    }
  }

  @override
  Widget build(BuildContext context) {
    double horizonratio = Utils.computedRatio(widget.book.config.horizonratio);
    print('${widget.book.title} $horizonratio');

    return Column(
      children: <Widget>[
        // BookItem的标题
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.book.title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              widget.book.config.isshowmore == 1
                  ? Text(
                      '更多',
                      style: TextStyle(color: Colors.grey),
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
