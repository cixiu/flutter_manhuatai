import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComicDetailChapter extends StatefulWidget {
  final List<Comic_chapter> comicChapterList;
  final bool isShowAll;
  final VoidCallback onTapShowAll;

  ComicDetailChapter({
    Key key,
    this.comicChapterList,
    this.isShowAll,
    this.onTapShowAll,
  }) : super(key: key);

  @override
  _ComicDetailChapterState createState() => _ComicDetailChapterState();
}

class _ComicDetailChapterState extends State<ComicDetailChapter> {
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

          return Container(
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
                        color: Color(0xffd57100),
                      ),
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(16.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '未读',
                        strutStyle: StrutStyle(
                          forceStrutHeight: true,
                          fontSize: ScreenUtil().setSp(16),
                        ),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          color: Color(0xffd57100),
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
                      '${widget.comicChapterList[index].chapterName}',
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
          );
        },
        childCount: widget.comicChapterList.length + 1,
      ),
    );
  }
}
