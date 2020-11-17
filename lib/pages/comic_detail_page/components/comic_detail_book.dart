import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/components/book_item/book_item.dart';
import 'package:flutter_manhuatai/provider_store/user_info_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/book_list_by_comic_id.dart';
import 'package:provider/provider.dart';

class ComicDetailBook extends StatefulWidget {
  final String comicId;

  ComicDetailBook({
    Key key,
    @required this.comicId,
  }) : super(key: key);

  @override
  _ComicDetailBookState createState() => _ComicDetailBookState();
}

class _ComicDetailBookState extends State<ComicDetailBook>
    with WidgetsBindingObserver {
  List<Book> bookList;
  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getBookByComicId();
    });
    super.initState();
  }

  void _getBookByComicId() async {
    var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
    var user = userInfoModel.user;
    String userauth = user.taskData.authcode;

    var bookListMap = await Api.getBookByComicId(
      comicId: widget.comicId,
      userauth: userauth,
    );

    var _bookListData = BookListByComicId.fromJson(bookListMap);
    if (this.mounted) {
      setState(() {
        bookList = _bookListData.data
            .where((book) => book.config.displayType != 20)
            .toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: Colors.grey,
      fontSize: ScreenUtil().setSp(28),
    );

    return isLoading
        ? SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(
                    ScreenUtil().setWidth(40),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            right: ScreenUtil().setWidth(20),
                          ),
                          width: ScreenUtil().setWidth(40),
                          height: ScreenUtil().setWidth(40),
                          child: CircularProgressIndicator(
                            strokeWidth: ScreenUtil().setWidth(4),
                          ),
                        ),
                        Text(
                          '正在加载...',
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == bookList.length) {
                  return Container(
                    padding: EdgeInsets.all(20.0),
                    margin: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey[200],
                          width: ScreenUtil().setWidth(1),
                        ),
                      ),
                    ),
                    child: Container(
                      height: ScreenUtil().setWidth(40),
                      child: Center(
                        child: Text(
                          '小主没有更多了呢！',
                          style: textStyle,
                        ),
                      ),
                    ),
                  );
                }
                var bookItem = bookList[index];
                return BookItem(
                  book: bookItem,
                  horizontalPadding: 0,
                  needSwith: true,
                );
              },
              childCount: bookList.length + 1,
            ),
          );
  }
}
