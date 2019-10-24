import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/db/provider/has_read_chapters_db_provider.dart';
import 'package:flutter_manhuatai/components/custom_router/custom_router.dart';
import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_manhuatai/pages/comic_read/comic_read.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComicDetailChapter extends StatefulWidget {
  final String comicId;
  final List<Comic_chapter> comicChapterList;
  final bool isShowAll;
  final VoidCallback onTapShowAll;

  ComicDetailChapter({
    Key key,
    this.comicId,
    this.comicChapterList,
    this.isShowAll,
    this.onTapShowAll,
  }) : super(key: key);

  @override
  _ComicDetailChapterState createState() => _ComicDetailChapterState();
}

class _ComicDetailChapterState extends State<ComicDetailChapter> {
  List<dynamic> hasReadChapterList = [];

  @override
  void initState() {
    super.initState();
    _getHasReadChapters();
  }

  // 获取漫画的阅读章节
  Future<void> _getHasReadChapters() async {
    var provider = HasReadChaptersDbProvider();
    var dbList =
        await provider.getHasReadChapters(int.tryParse(widget.comicId));
    if (dbList != null) {
      setState(() {
        hasReadChapterList = dbList;
      });
    }
    print('漫画已读章节 $dbList');
  }

  void _navigateToComicReadPage(Comic_chapter chapter) async {
    await Navigator.of(context).push(
      CustomRouter(
        ComicReadPage(
          comicId: widget.comicId,
          chapterTopicId: chapter.chapterTopicId,
          chapterName: chapter.chapterName,
        ),
      ),
    );
    await _getHasReadChapters();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == widget.comicChapterList.length) {
            return widget.isShowAll
                ? Container()
                : Container(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setWidth(32),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[100],
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(604),
                          height: ScreenUtil().setWidth(76),
                          child: FlatButton(
                            onPressed: widget.onTapShowAll,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(38),
                              ),
                            ),
                            child: Text(
                              '小主，点这里',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(28),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          }

          var chapter = widget.comicChapterList[index];
          bool hasRead = hasReadChapterList.contains(chapter.chapterTopicId);

          return InkResponse(
            highlightShape: BoxShape.rectangle,
            containedInkWell: true,
            onTap: () {
              _navigateToComicReadPage(chapter);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setWidth(32),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[100],
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  // 为了隐藏 Container 的左 border，而使用 Transform.translate
                  // 详情见Flutter/issue: https://github.com/flutter/flutter/issues/12583
                  Transform.translate(
                    offset: Offset(-1.0, 0.0),
                    child: Container(
                      width: ScreenUtil().setWidth(50),
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(8),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: hasRead ? Colors.grey[400] : Color(0xffd57100),
                        ),
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(16.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          hasRead ? '已读' : '未读',
                          strutStyle: StrutStyle(
                            forceStrutHeight: true,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            color:
                                hasRead ? Colors.grey[400] : Color(0xffd57100),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(30),
                      ),
                      child: Text(
                        '${chapter.chapterName}',
                        overflow: TextOverflow.ellipsis,
                        strutStyle: StrutStyle(
                          forceStrutHeight: true,
                          fontSize: ScreenUtil().setSp(28),
                        ),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        childCount: widget.comicChapterList.length + 1,
      ),
    );
  }
}
