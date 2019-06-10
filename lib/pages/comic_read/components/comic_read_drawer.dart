import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComicReadDrawer extends StatefulWidget {
  final ComicInfoBody comicInfoBody;

  ComicReadDrawer({
    Key key,
    this.comicInfoBody,
  }) : super(key: key);

  @override
  _ComicReadDrawerState createState() => _ComicReadDrawerState();
}

class _ComicReadDrawerState extends State<ComicReadDrawer> {
  ScrollController _scrollController = ScrollController();
  bool _isTop = true;

  /// 回到顶部或者回到底部
  void _backToTopOrBottom() {
    if (_isTop == true) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    } else {
      _scrollController.jumpTo(0.0);
    }
    setState(() {
      _isTop = !_isTop;
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusHeight = MediaQuery.of(context).padding.top;

    return Stack(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(650),
          color: Colors.grey[900],
          child: Column(
            children: <Widget>[
              Container(
                height: statusHeight,
              ),
              Container(
                height: ScreenUtil().setWidth(80),
                alignment: Alignment.center,
                child: Text(
                  widget.comicInfoBody.comicName,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: ScreenUtil().setSp(32),
                  ),
                ),
              ),
              Container(
                height: ScreenUtil().setWidth(60),
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(30),
                ),
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '共${widget.comicInfoBody.lastChapterId}话 ${widget.comicInfoBody.comicStatus == 2 ? '已完结' : '连载中'}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: ScreenUtil().setSp(24),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('切换排序规则');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setWidth(8),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.grey,
                              size: ScreenUtil().setSp(30),
                            ),
                            Text(
                              '倒序',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil().setSp(24),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(0.0),
                  itemCount: widget.comicInfoBody.comicChapter.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = widget.comicInfoBody.comicChapter[index];

                    return Container(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(30),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[850],
                            width: ScreenUtil().setWidth(1),
                          ),
                        ),
                      ),
                      child: Text(
                        item.chapterName,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: ScreenUtil().setSp(28),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          child: GestureDetector(
            onTap: _backToTopOrBottom,
            child: Container(
              width: ScreenUtil().setWidth(50),
              height: ScreenUtil().setWidth(50),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Icon(
                _isTop ? Icons.arrow_downward : Icons.arrow_upward,
                color: Colors.white70,
                size: ScreenUtil().setSp(32),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
