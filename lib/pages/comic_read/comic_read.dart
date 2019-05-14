import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_manhuatai/pages/comic_read/components/custom_sliver_child_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComicReadPage extends StatefulWidget {
  final String comicId;
  final int chapterTopicId;

  ComicReadPage({
    Key key,
    this.comicId,
    this.chapterTopicId,
  }) : super(key: key);

  @override
  _ComicReadPageState createState() => _ComicReadPageState();
}

class _ComicReadPageState extends State<ComicReadPage>
    with WidgetsBindingObserver {
  ComicInfoBody comicInfoBody;
  List<String> imageViews = [];
  int _readerChapterIndex;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays ([]);
    _scrollController.addListener(_scrollListener);
    _getComicInfoBody();
  }

  // 获取指定漫画的主体信息
  Future<void> _getComicInfoBody() async {
    var response = await Api.getComicInfoBody(comicId: widget.comicId);
    var _comicInfoBody = ComicInfoBody.fromJson(response);
    // 获取阅读的章节
    _readerChapterIndex = _comicInfoBody.comicChapter.indexWhere((chapter) {
      return chapter.chapterTopicId == widget.chapterTopicId;
    });
    var readerChapter = _comicInfoBody.comicChapter[_readerChapterIndex];
    // 将章节对应的漫画图片插入数组
    int len = readerChapter.startNum + readerChapter.endNum;
    String imgHost = 'https://mhpic.manhualang.com';

    setState(() {
      for (var i = 1; i < len; i++) {
        String imgUrl =
            readerChapter.chapterImage.middle.replaceAll(RegExp(r'\$\$'), '$i');
        imageViews.add('$imgHost$imgUrl');
      }
      comicInfoBody = _comicInfoBody;
    });
  }

  void _scrollListener() {
    // 判断当前滑动位置是不是到达底部，触发加载更多回调
    var position = _scrollController.position;
    if (position.pixels == position.maxScrollExtent) {
      if (_readerChapterIndex == 0) {
        return;
      }

      _readerChapterIndex--;
      var readerChapter = comicInfoBody.comicChapter[_readerChapterIndex];
      // 将章节对应的漫画图片插入数组
      int len = readerChapter.startNum + readerChapter.endNum;
      String imgHost = 'https://mhpic.manhualang.com';

      setState(() {
        for (var i = 1; i < len; i++) {
          String imgUrl = readerChapter.chapterImage.middle
              .replaceAll(RegExp(r'\$\$'), '$i');
          imageViews.add('$imgHost$imgUrl');
        }
      });
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        print(position.maxScrollExtent);
      });
    }
  }

  // 点击中间区域，呼起菜单
  void openMenu(TapUpDetails details) {
    double midPosition = MediaQuery.of(context).size.height / 2;
    double diff = ScreenUtil().setWidth(350);
    double top = midPosition - diff;
    double bottom = midPosition + diff;
    double tapPosition = details.globalPosition.dy;

    if (tapPosition > top && tapPosition < bottom) {
      print('点击了中间区域 $tapPosition');
    }
  }

  @override
  Widget build(BuildContext context) {
    StrutStyle strutStyle = StrutStyle(
      forceStrutHeight: true,
      fontSize: ScreenUtil().setSp(24),
    );
    TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: ScreenUtil().setSp(24),
    );

    return Scaffold(
      body: comicInfoBody != null
          ? GestureDetector(
              // 点击中间区域，呼起菜单
              onTapUp: openMenu,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  ListView.custom(
                    controller: _scrollController,
                    childrenDelegate: CustomSliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Image.network(
                          imageViews[index],
                        );
                      },
                      childCount: imageViews.length,
                    ),
                    // cacheExtent: 1.0,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(40),
                          vertical: ScreenUtil().setWidth(12),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                              ScreenUtil().setWidth(8),
                            ),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(12),
                              ),
                              child: Text(
                                '第3话',
                                strutStyle: strutStyle,
                                style: textStyle,
                              ),
                            ),
                            Text(
                              '1/8',
                              strutStyle: strutStyle,
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ))
          : Container(),
    );
  }
}
