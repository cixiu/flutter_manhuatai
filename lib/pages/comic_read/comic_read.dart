import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
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
  List<Widget> imageViews = [];
  CustomImageListState _customImageListState = CustomImageListState();
  // 章节高度的集合
  List<int> _listHeight = [0];
  // List<int> _listLength = [0];
  int _chapterIndex = 0;
  // 正在阅读的漫画在漫画列表中的索引
  int _readerChapterIndex;
  // 正在阅读的漫画
  Comic_chapter _readerChapter;
  int _readerNum = 1;
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

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
    var readerChapter = _comicInfoBody.comicChapter[_readerChapterIndex];
    // 将章节对应的漫画图片插入数组
    int len = readerChapter.startNum + readerChapter.endNum;
    String imgHost = 'https://mhpic.manhualang.com';

    if (this.mounted) {
      int queueLen = 0;
      int chapterTotalHeight = 0;
      double screenWidth = MediaQuery.of(context).size.width;
      Map<int, int> imageHashMap = Map();

      for (var i = 1; i < len; i++) {
        String imgUrl = '$imgHost' +
            readerChapter.chapterImage.middle.replaceAll(RegExp(r'\$\$'), '$i');
        var _imageStream =
            Image.network(imgUrl).image.resolve(ImageConfiguration());

        _imageStream.addListener(
          (info, _) {
            if (imageHashMap[info.hashCode] != null) {
              return;
            }
            if (queueLen < 0) {
              return;
            }
            imageHashMap[info.hashCode] = i;
            // 图片在屏幕中的高度
            int height = screenWidth * info.image.height ~/ info.image.width;
            // 将整个章节的所有图片相加得出这个章节的高度
            chapterTotalHeight += height;
            queueLen++;
            setState(() {
              _customImageListState
                ..imageViews[i] = ImageWrapper(
                  url: imgUrl,
                  width: screenWidth,
                  height: height.toDouble(),
                  placeholder: (context, url) {
                    return Container(
                      width: screenWidth,
                      height: height.toDouble(),
                      color: Colors.black87,
                      child: Center(
                        child: Text(
                          '$i',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                          ),
                        ),
                      ),
                    );
                  },
                )
                ..imageNum.add(i);
              _customImageListState.imageNum.sort();
            });

            // 等所有图片都加载完后在显示漫画图片
            if (queueLen == len - 1) {
              _listHeight.add(chapterTotalHeight);
              print(_listHeight);
              setState(() {
                _isLoading = false;
                _readerChapter = readerChapter;
                comicInfoBody = _comicInfoBody;
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
    double scrollTop = position.pixels;
    double screenWidth = MediaQuery.of(context).size.width;
    int halfScreenHeight = (screenWidth / 2).floor();

    if (position.pixels > position.maxScrollExtent - halfScreenHeight) {
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
      List<int> _imageNum = [];
      Map<int, int> imageHashMap = Map();
      int queueLen = 0;
      int chapterTotalHeight = 0;
      int lastImageNumLength = _customImageListState.imageNum.length;

      for (var i = 1; i < len; i++) {
        String imgUrl = '$imgHost' +
            readerChapter.chapterImage.middle.replaceAll(RegExp(r'\$\$'), '$i');
        var _imageStream =
            Image.network(imgUrl).image.resolve(ImageConfiguration());
        _imageStream.addListener(
          (info, _) {
            if (imageHashMap[info.hashCode] != null) {
              return;
            }
            if (queueLen < 0) {
              return;
            }
            imageHashMap[info.hashCode] = i;
            // 图片在屏幕中的高度
            int height = screenWidth * info.image.height ~/ info.image.width;
            // 将整个章节的所有图片相加得出这个章节的高度
            chapterTotalHeight += height;
            queueLen++;
            _imageNum.add(i);
            setState(() {
              _customImageListState
                ..imageViews[i + lastImageNumLength] = ImageWrapper(
                  url: imgUrl,
                  width: screenWidth,
                  height: height.toDouble(),
                  placeholder: (context, url) {
                    return Container(
                      width: screenWidth,
                      height: height.toDouble(),
                      color: Colors.black87,
                      child: Center(
                        child: Text(
                          '$i',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                          ),
                        ),
                      ),
                    );
                  },
                );
                // ..imageNum.add(i);
            });

            // 等所有图片都加载完后在显示漫画图片
            if (queueLen == len - 1) {
              _listHeight.add(chapterTotalHeight);
              _listHeight[_listHeight.length - 1] =
                  _listHeight.reduce((val, ele) => val + ele);
              _isLoadingMore = false;
              // 需要先排序
              _imageNum.sort();
              setState(() {
                _customImageListState.imageNum.addAll(_imageNum);
              });
              print(_listHeight);
              print(_customImageListState.imageNum);
              // setState(() {
              //   _isLoading = false;
              //   _readerChapter = readerChapter;
              // });
            }
          },
        );
      }
      // _listHeight.add(0);
      // _listHeight[_listHeight.length - 1] =
      //     _listHeight.reduce((val, ele) => val + ele);

      // int queueLen = _imageViews.length;

      // for (int i = 0; i < len - 1; i++) {
      //   _imageViews[i].image.resolve(ImageConfiguration()).addListener(
      //     (info, __) {
      //       if (queueLen < 0) {
      //         return;
      //       }
      //       // 图片在屏幕中的高度
      //       int height = screenWidth * info.image.height ~/ info.image.width;
      //       // 这个章节的高度累加以前的高度
      //       _listHeight[_listHeight.length - 1] += height;
      //       // setState(() {
      //       //   imageViews.add(
      //       //     Container(
      //       //       height: height.toDouble(),
      //       //       child: _customImageListState.imageViews[i],
      //       //     ),
      //       //   );
      //       // });
      //       queueLen--;
      //       // 等所有图片都加载完后在显示漫画图片
      //       if (queueLen == 0) {
      //         print(_listHeight);
      //         _isLoadingMore = false;
      //         setState(() {
      //           _customImageListState
      //             ..imageViews.addAll(_imageViews)
      //             ..imageNum.addAll(_imageNum);
      //         });
      //       }
      //     },
      //   );
      // }
    }

    for (int i = 0; i < _listHeight.length - 1; i++) {
      int height1 = _listHeight[i];
      int height2 = _listHeight[i + 1];

      // 如果滚动距离落在某一个章节的高度区间，则将导航的标题设置成章节的名字
      if (scrollTop >= height1 - halfScreenHeight &&
          scrollTop < height2 - halfScreenHeight) {
        int readingChapterIndex = _chapterIndex - i;
        if (_readerChapterIndex != readingChapterIndex) {
          // print(readingChapterIndex);
        }
        setState(() {
          _readerChapter = comicInfoBody.comicChapter[readingChapterIndex];
        });
      }
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
      body: comicInfoBody != null && !_isLoading
          ? GestureDetector(
              // 点击中间区域，呼起菜单
              onTapUp: openMenu,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  ListView.custom(
                    physics: ClampingScrollPhysics(),
                    controller: _scrollController,
                    childrenDelegate: CustomSliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return _customImageListState.imageViews[index + 1];
                      },
                      childCount: _customImageListState.imageNum.length,
                      itemShow: (int index) {
                        Future.delayed(Duration(seconds: 0), () {
                          setState(() {
                            _readerNum = _customImageListState.imageNum[index];
                          });
                        });
                      },
                    ),
                    cacheExtent: MediaQuery.of(context).size.height / 2,
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
                                '${_readerChapter.chapterName.length >= 5 ? _readerChapter.chapterName.substring(0, 5) : _readerChapter.chapterName}',
                                strutStyle: strutStyle,
                                style: textStyle,
                              ),
                            ),
                            Text(
                              '${_readerNum}/${_readerChapter.endNum}',
                              // '共${_readerChapter.endNum}张',
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

class CustomImageListState {
  Map<int, Widget> imageViews = Map();
  List<int> imageNum = [];
}
