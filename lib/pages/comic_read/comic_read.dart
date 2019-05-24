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
  List<Image> imageViews = [];
  // 章节高度的集合
  List<int> _listHeight = [0];
  int _chapterIndex = 0;
  // 正在阅读的漫画在漫画列表中的索引
  int _readerChapterIndex;
  // 正在阅读的漫画
  Comic_chapter _readerChapter;
  bool _isLoading = true;
  ScrollController _scrollController = ScrollController();

  // 是否正在加载更多
  bool _isLoadingMore = false;

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
    _chapterIndex = _readerChapterIndex;
    print(_chapterIndex);
    var readerChapter = _comicInfoBody.comicChapter[_readerChapterIndex];
    // 将章节对应的漫画图片插入数组
    int len = readerChapter.startNum + readerChapter.endNum;
    String imgHost = 'https://mhpic.manhualang.com';

    if (this.mounted) {
      setState(() {
        for (var i = 1; i < len; i++) {
          String imgUrl = readerChapter.chapterImage.middle
              .replaceAll(RegExp(r'\$\$'), '$i');
          var _image = Image.network(
            '$imgHost$imgUrl',
          );
          imageViews.add(_image);
        }
        comicInfoBody = _comicInfoBody;
        // _isLoading = false;
      });
      int queueLen = imageViews.length;
      int chapterTotalHeight = 0;
      double screenWidth = MediaQuery.of(context).size.width;

      for (int i = 0; i < len - 1; i++) {
        imageViews[i].image.resolve(ImageConfiguration()).addListener(
          (info, __) {
            // 图片在屏幕中的高度
            int height = screenWidth * info.image.height ~/ info.image.width;
            // 将整个章节的所有图片相加得出这个章节的高度
            chapterTotalHeight += height;
            queueLen--;
            // 等所有图片都加载完后在显示漫画图片
            if (queueLen == 0) {
              setState(() {
                _isLoading = false;
                _listHeight.add(chapterTotalHeight);
                _readerChapter = readerChapter;
              });
            }
          },
        );
      }
    }
  }

  void _scrollListener() {
    if (_isLoadingMore) {
      return;
    }
    // 判断当前滑动位置是不是到达底部，触发加载更多回调
    var position = _scrollController.position;
    // print('${position.pixels} ${position.maxScrollExtent}');
    if (position.pixels == position.maxScrollExtent) {
      if (_readerChapterIndex == 0) {
        return;
      }
      _isLoadingMore = true;
      print('触底了');

      _readerChapterIndex--;
      var readerChapter = comicInfoBody.comicChapter[_readerChapterIndex];
      print(readerChapter.chapterName);
      // 将章节对应的漫画图片插入数组
      int len = readerChapter.startNum + readerChapter.endNum;
      String imgHost = 'https://mhpic.manhualang.com';
      List<Image> _imageViews = [];

      for (var i = 1; i < len; i++) {
        String imgUrl =
            readerChapter.chapterImage.middle.replaceAll(RegExp(r'\$\$'), '$i');
        _imageViews.add(Image.network(
          '$imgHost$imgUrl',
        ));
      }

      int queueLen = _imageViews.length;
      int chapterTotalHeight = 0;
      double screenWidth = MediaQuery.of(context).size.width;

      for (int i = 0; i < len - 1; i++) {
        _imageViews[i].image.resolve(ImageConfiguration()).addListener(
          (info, __) {
            // 图片在屏幕中的高度
            int height = screenWidth * info.image.height ~/ info.image.width;
            // 将整个章节的所有图片相加得出这个章节的高度
            chapterTotalHeight += height;
            queueLen--;
            // 等所有图片都加载完后在显示漫画图片
            if (queueLen == 0) {
              int totalHeight =
                  _listHeight[_listHeight.length - 1] + chapterTotalHeight;
              setState(() {
                _listHeight.add(totalHeight);
                imageViews.addAll(_imageViews);
                // _readerChapter = readerChapter;
              });
              _isLoadingMore = false;
              print(_listHeight);
            }
          },
        );
      }
    }

    double scrollTop = position.pixels;
    int halfScreenHeight = (MediaQuery.of(context).size.height / 2).floor();
    for (int i = 0; i < _listHeight.length - 1; i++) {
      int height1 = _listHeight[i];
      int height2 = _listHeight[i + 1];

      // 如果滚动距离落在某一个章节的高度区间，则将导航的标题设置成章节的名字
      if (scrollTop >= height1 - halfScreenHeight &&
          scrollTop < height2 - halfScreenHeight) {
        int readingChapterIndex = _chapterIndex - i;
        if (_readerChapterIndex != readingChapterIndex) {
          print(readingChapterIndex);
        }
        setState(() {
          _readerChapter = comicInfoBody.comicChapter[readingChapterIndex];
        });
      }
    }
  }

  // 计算章节的高度
  // _calculateHeight() {
  //   List<double> listHeight = [];
  //   double height = 0;
  //   listHeight.add(height);
  // }

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
      body: comicInfoBody != null && !_isLoading
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
                        return imageViews[index];
                      },
                      childCount: imageViews.length,
                    ),
                    // cacheExtent: 0.0,
                    // itemExtent: 50.0,
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
                                '${_readerChapter.chapterName}',
                                strutStyle: strutStyle,
                                style: textStyle,
                              ),
                            ),
                            Text(
                              '1/${_readerChapter.endNum}',
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
          : Center(
              child: Text('加载中...'),
            ),
    );
  }
}
