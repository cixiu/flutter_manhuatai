import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef void SelectChapter(Comic_chapter selectedComicChapter);

class ComicReadDrawer extends StatefulWidget {
  final ComicInfoBody comicInfoBody;
  final Comic_chapter readingComicChapter;
  final SelectChapter selectChapter;

  ComicReadDrawer({
    Key key,
    this.comicInfoBody,
    this.readingComicChapter,
    this.selectChapter,
  }) : super(key: key);

  @override
  _ComicReadDrawerState createState() => _ComicReadDrawerState();
}

class _ComicReadDrawerState extends State<ComicReadDrawer> {
  List<Comic_chapter> _comicChapterList;
  ScrollController _scrollController;
  bool _isTop = true;
  // 漫画章节的排序方式 'DES' => 降序 || 'ASC' => 升序
  String sortType = 'DES';

  @override
  void initState() {
    setState(() {
      _comicChapterList = widget.comicInfoBody.comicChapter;
    });

    int index = _comicChapterList.indexWhere((item) =>
        item.chapterTopicId == widget.readingComicChapter.chapterTopicId);
    double initialScrollOffset = index * 50.0;
    _scrollController =
        ScrollController(initialScrollOffset: initialScrollOffset);

    super.initState();
  }

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

  // 改变漫画章节的排序方式
  void _changeComicChapterSort() {
    setState(() {
      _comicChapterList = _comicChapterList.reversed.toList();
      if (sortType == 'ASC') {
        sortType = 'DES';
      } else {
        sortType = 'ASC';
      }
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
                      onTap: _changeComicChapterSort,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setWidth(8),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              sortType == 'ASC'
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: Colors.grey,
                              size: ScreenUtil().setSp(30),
                            ),
                            Text(
                              sortType == 'ASC' ? '倒序' : '正序',
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
                  itemCount: _comicChapterList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = _comicChapterList[index];

                    return GestureDetector(
                      onTap: () {
                        if (widget.selectChapter != null) {
                          widget.selectChapter(item);
                        }
                      },
                      child: Container(
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
                            color: widget.readingComicChapter.chapterTopicId ==
                                    item.chapterTopicId
                                ? Colors.orangeAccent
                                : Colors.white70,
                            fontSize: ScreenUtil().setSp(28),
                          ),
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
