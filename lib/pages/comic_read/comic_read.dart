import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_manhuatai/common/db/provider/has_read_chapters_db_provider.dart';
import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:flutter_manhuatai/provider_store/user_info_model.dart';
import 'package:flutter_manhuatai/provider_store/user_record_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_manhuatai/pages/comic_read/components/custom_sliver_child_builder.dart';

import 'components/comic_read_bottom_bar.dart';
import 'components/comic_read_drawer.dart';
import 'components/comic_read_status_bar.dart';

class ComicReadPage extends StatefulWidget {
  final String comicId;
  final int chapterTopicId;
  final String chapterName;

  ComicReadPage({
    Key key,
    this.comicId,
    this.chapterTopicId,
    this.chapterName,
  }) : super(key: key);

  @override
  _ComicReadPageState createState() => _ComicReadPageState();
}

class _ComicReadPageState extends State<ComicReadPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  ComicInfoBody comicInfoBody;
  List<Widget> imageViews = [];
  CustomImageListState _customImageListState = CustomImageListState();
  // 章节高度的集合
  List<int> _listHeight = [0];
  // List<int> _listLength = [0];
  int _chapterIndex = 0;
  // 视图滚动时作为一个标记位
  int _lastIndex = 0;
  // 正在阅读的漫画在漫画列表中的索引
  int _readerChapterIndex;
  // 正在阅读的漫画
  Comic_chapter _readerChapter;
  // int _readerNum = 1;
  bool _isLoading = true;
  ScrollController _scrollController = ScrollController();

  AnimationController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 是否正在加载更多
  bool _isLoadingMore = false;
  // 是否显示菜单栏
  bool _isShowStatusBar = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller = new AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      );
      // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      _scrollController.addListener(_scrollListener);
      _getComicInfoBody();
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    // TODO:退出时获取正在屏幕中的漫画章节中的第x张
    // 退出阅读时，也需要加入历史记录
    if (comicInfoBody == null) {
      return;
    }
    _addUserRead(
      chapterId: _readerChapter?.chapterTopicId ?? widget.chapterTopicId,
      chapterName: _readerChapter?.chapterName ?? widget.chapterName,
      comicInfoBody: comicInfoBody,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  // 将chapterId加入对应漫画的数据中
  _insertOrUpdateHasReadChapters(int chapterId, String comicName) async {
    var provider = HasReadChaptersDbProvider();
    int id = int.tryParse(widget.comicId);
    var dbList = await provider.getHasReadChapters(id);
    if (dbList != null) {
      print('当前需要加入的chapterTopicId: $chapterId');
      if (!dbList.contains(chapterId)) {
        dbList.add(chapterId);
        var newDbList =
            await provider.insertOrUpdate(id, comicName, json.encode(dbList));
        print('更新数据完成后： $newDbList');
      }
    } else {
      dbList = [];
      dbList.add(chapterId);
      var newDbList =
          await provider.insertOrUpdate(id, comicName, json.encode(dbList));
      print('插入数据后： $newDbList');
    }
  }

  // 获取指定漫画的主体信息
  Future<void> _getComicInfoBody() async {
    var response = await Api.getComicInfoBody(comicId: widget.comicId);
    var _comicInfoBody = ComicInfoBody.fromJson(response);

    if (!this.mounted) {
      return;
    }

    setState(() {
      comicInfoBody = _comicInfoBody;
    });
    await _insertOrUpdateHasReadChapters(
      widget.chapterTopicId,
      _comicInfoBody.comicName,
    );
    await _addUserRead(
      chapterId: widget.chapterTopicId,
      chapterName: widget.chapterName,
      comicInfoBody: comicInfoBody,
    );
    _setComicChapter(widget.chapterTopicId);
  }

  Future<void> _addUserRead({
    int chapterId,
    String chapterName,
    int chapterPage = 1,
    ComicInfoBody comicInfoBody,
  }) async {
    var user = Provider.of<UserInfoModel>(context, listen: false).user;
    var userRecordModel = Provider.of<UserRecordModel>(context, listen: false);
    var deviceid = await Utils.getDeviceId();

    // 进入漫画阅读页时，将要阅读的漫画的章节的第一张添加到用户的阅读历史
    await Api.addUserRead(
      type: user.type,
      openid: user.openid,
      deviceid: deviceid,
      myUid: user.uid,
      authorization: user.authData.authcode,
      comicId: int.tryParse(widget.comicId),
      chapterId: chapterId,
      chapterName: chapterName,
      chapterPage: chapterPage,
    );

    int index = userRecordModel.userReads.indexWhere((comicRead) {
      return comicRead.comicId == int.tryParse(widget.comicId);
    });

    if (index > -1) {
      var userRead = userRecordModel.userReads[index];
      userRead.readTime = DateTime.now().millisecondsSinceEpoch;
      userRead.chapterId = chapterId;
      userRead.chapterName = chapterName;
      userRecordModel.changeUserRead(userRead);
    } else {
      var userRead = User_read.fromJson({
        "comic_id": int.tryParse(widget.comicId),
        "comic_newid": '',
        "comic_name": comicInfoBody.comicName,
        "chapter_page": chapterPage,
        "chapter_name": chapterName,
        "chapter_newid": '',
        "read_time": DateTime.now().millisecondsSinceEpoch,
        "last_chapter_name": comicInfoBody.lastChapterName,
        "update_time": comicInfoBody.updateTime,
        "copyright_type": comicInfoBody.copyrightType,
        "chapter_id": chapterId,
        "last_chapter_newid": comicInfoBody.lastChapterId,
      });
      userRecordModel.addUserRead(userRead);
    }
  }

  void _scrollListener() async {
    if (_isLoadingMore) {
      return;
    }
    // var statusHeight = MediaQuery.of(context).padding.top;
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
      await _insertOrUpdateHasReadChapters(
        readerChapter.chapterTopicId,
        comicInfoBody.comicName,
      );
      await _addUserRead(
        chapterId: readerChapter.chapterTopicId,
        chapterName: readerChapter.chapterName,
        comicInfoBody: comicInfoBody,
      );
      print(readerChapter.chapterName);
      // 将章节对应的漫画图片插入数组
      int len = readerChapter.startNum + readerChapter.endNum;
      // String imgHost = 'https://mhpic.isamanhua.com';
      String imgHost = AppConst.mhImgHost;
      List<int> _imageNum = [];
      Map<int, int> imageHashMap = Map();
      int queueLen = 0;
      int chapterTotalHeight = 0;
      int lastImageNumLength = _customImageListState.imageNum.length;

      for (var i = 1; i < len; i++) {
        String imgUrl = '$imgHost' +
            readerChapter.chapterImage.middle.replaceAll(RegExp(r'\$\$'), '$i');
        var _imageStream = Image(
          image: CachedNetworkImageProvider(imgUrl),
        ).image.resolve(ImageConfiguration.empty);
        // var _imageStream =
        //     Image.network(imgUrl).image.resolve(ImageConfiguration.empty);
        _imageStream.addListener(ImageStreamListener(
          (info, _) {
            if (!this.mounted) {
              return;
            }
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

            filterLoadMoreChapterHeight(
              lastImageNumLength: lastImageNumLength,
              imageNum: _imageNum,
              chapterTotalHeight: chapterTotalHeight,
              height: height,
              screenWidth: screenWidth,
              len: len,
              queueLen: queueLen,
              i: i,
              imgUrl: imgUrl,
              readerChapter: readerChapter,
            );
          },
          onError: (e, stack) {
            // 图片在屏幕中的高度
            int height = 300;
            // 将整个章节的所有图片相加得出这个章节的高度
            chapterTotalHeight += height;
            queueLen++;
            _imageNum.add(i);
            print('第$i 图片加载失败');

            filterLoadMoreChapterHeight(
              lastImageNumLength: lastImageNumLength,
              imageNum: _imageNum,
              chapterTotalHeight: chapterTotalHeight,
              height: height,
              screenWidth: screenWidth,
              len: len,
              queueLen: queueLen,
              i: i,
              imgUrl: imgUrl,
              readerChapter: readerChapter,
            );
          },
        ));
      }
    }

    for (int i = 0; i < _listHeight.length - 1; i++) {
      int height1 = _listHeight[i];
      int height2 = _listHeight[i + 1];

      // 如果滚动距离落在某一个章节的高度区间，则将导航的标题设置成章节的名字
      if (scrollTop >= height1 - halfScreenHeight &&
          scrollTop < height2 - halfScreenHeight) {
        if (_lastIndex != i) {
          // print('$_lastIndex $i');
          int readingChapterIndex = _chapterIndex - i;
          setState(() {
            // _readerNum = 1;
            _readerChapter = comicInfoBody.comicChapter[readingChapterIndex];
          });
          _lastIndex = i;
        }
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
      if (_isShowStatusBar) {
        controller.reverse();
        _isShowStatusBar = false;
      } else {
        controller.forward();
        _isShowStatusBar = true;
      }
      print('点击了中间区域 $tapPosition');
    }
  }

  // 在侧边栏中选择漫画章节
  void _selectChapter(Comic_chapter selectedComicChapter) {
    Navigator.pop(context);
    // 重置一些数据
    _listHeight = [0];
    _lastIndex = 0;
    setState(() {
      _isLoading = true;
      _customImageListState = CustomImageListState();
    });
    _setComicChapter(selectedComicChapter.chapterTopicId);
  }

  void _setComicChapter(int chapterTopicId) {
    // 获取阅读的章节
    _readerChapterIndex = comicInfoBody.comicChapter.indexWhere((chapter) {
      return chapter.chapterTopicId == chapterTopicId;
    });
    _chapterIndex = _readerChapterIndex;
    var readerChapter = comicInfoBody.comicChapter[_readerChapterIndex];
    // 将章节对应的漫画图片插入数组
    int len = readerChapter.startNum + readerChapter.endNum;
    // String imgHost = 'https://mhpic.isamanhua.com';
    String imgHost = AppConst.mhImgHost;

    if (this.mounted) {
      int queueLen = 0;
      int chapterTotalHeight = 0;
      double screenWidth = MediaQuery.of(context).size.width;
      Map<int, int> imageHashMap = Map();
      for (var i = 1; i < len; i++) {
        String imgUrl = '$imgHost' +
            readerChapter.chapterImage.middle.replaceAll(RegExp(r'\$\$'), '$i');
        var _imageStream = Image(
          image: CachedNetworkImageProvider(imgUrl),
        ).image.resolve(ImageConfiguration.empty);
        // Image.network(imgUrl).image.resolve(ImageConfiguration());

        _imageStream.addListener(ImageStreamListener((info, _) {
          if (!this.mounted) {
            return;
          }
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

          filterChapterHeight(
            chapterTotalHeight: chapterTotalHeight,
            height: height,
            screenWidth: screenWidth,
            len: len,
            queueLen: queueLen,
            i: i,
            imgUrl: imgUrl,
            readerChapter: readerChapter,
          );
        }, onError: (e, stack) {
          int height = 300;
          chapterTotalHeight += height;
          queueLen++;
          print('第$i 图片加载失败');
          filterChapterHeight(
            chapterTotalHeight: chapterTotalHeight,
            height: height,
            screenWidth: screenWidth,
            len: len,
            queueLen: queueLen,
            i: i,
            imgUrl: imgUrl,
            readerChapter: readerChapter,
          );
        }));
      }
    }
  }

  void filterChapterHeight({
    int chapterTotalHeight,
    int height,
    double screenWidth,
    int len,
    int queueLen,
    int i,
    String imgUrl,
    Comic_chapter readerChapter,
  }) {
    setState(() {
      _customImageListState
        ..imageViews[i] = _buildImageWidget(
          imgUrl: imgUrl,
          width: screenWidth,
          height: height.toDouble(),
          index: i,
        )
        ..imageNum.add(i);
    });

    // 等所有图片都加载完后在显示漫画图片
    if (queueLen == len - 1) {
      _listHeight.add(chapterTotalHeight);
      print(_listHeight);
      setState(() {
        _isLoading = false;
        _readerChapter = readerChapter;
        _customImageListState.imageNum.sort();
      });
    }
  }

  void filterLoadMoreChapterHeight({
    int lastImageNumLength,
    List<int> imageNum,
    int chapterTotalHeight,
    int height,
    double screenWidth,
    int len,
    int queueLen,
    int i,
    String imgUrl,
    Comic_chapter readerChapter,
  }) {
    setState(() {
      _customImageListState
        ..imageViews[i + lastImageNumLength] = _buildImageWidget(
          imgUrl: imgUrl,
          width: screenWidth,
          height: height.toDouble(),
          index: i,
        );
    });
    // 等所有图片都加载完后在显示漫画图片
    if (queueLen == len - 1) {
      chapterTotalHeight += _listHeight[_listHeight.length - 1];
      _listHeight.add(chapterTotalHeight);
      _isLoadingMore = false;
      // 需要先排序
      imageNum.sort();
      setState(() {
        _customImageListState.imageNum.addAll(imageNum);
      });
      print(_listHeight);
      print(_customImageListState.imageNum);
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
      key: _scaffoldKey,
      endDrawer: _isLoading
          ? Container()
          : ComicReadDrawer(
              comicInfoBody: comicInfoBody,
              readingComicChapter: _readerChapter,
              selectChapter: _selectChapter,
            ),
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
                      // itemShow: (int index) {
                      //   Future.delayed(Duration(seconds: 0), () {
                      //     setState(() {
                      //       if (index == 0) {
                      //         _readerNum = 1;
                      //         return;
                      //       }
                      //       _readerNum =
                      //           _customImageListState.imageNum[index - 1];
                      //     });
                      //   });
                      // },
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
                              // '$_readerNum/${_readerChapter.endNum}',
                              '共${_readerChapter.endNum}张',
                              strutStyle: strutStyle,
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: SlideTransition(
                      position: Tween(
                        begin: Offset(0.0, -1.0),
                        end: Offset(0.0, 0.0),
                      ).animate(
                        CurvedAnimation(
                          parent: controller,
                          curve: Curves.easeIn,
                        ),
                      ),
                      child: ComicReadStatusBar(
                        chapterName: _readerChapter.chapterName,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: SlideTransition(
                      position: Tween(
                        begin: Offset(0.0, 1.0),
                        end: Offset(0.0, 0.0),
                      ).animate(
                        CurvedAnimation(
                          parent: controller,
                          curve: Curves.easeIn,
                        ),
                      ),
                      child: ComicReadBottomBar(
                        scaffoldKey: _scaffoldKey,
                        closeMenu: () {
                          controller.reverse();
                          _isShowStatusBar = false;
                        },
                      ),
                    ),
                  ),
                ],
              ))
          : Center(
              child: Text('加载中...'),
            ),
    );
  }

  Widget _buildImageWidget({
    String imgUrl,
    double width,
    double height,
    int index,
  }) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        ImageWrapper(
          url: imgUrl,
          width: width,
          height: height.toDouble(),
          placeholder: (context, url) {
            return Container(
              width: width,
              height: height.toDouble(),
              color: Colors.black87,
              child: Center(
                child: Text(
                  '$index',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                  ),
                ),
              ),
            );
          },
        ),
        Text(
          '$index',
          style: TextStyle(
            color: Colors.grey[200],
            fontSize: 42.0,
          ),
        ),
      ],
    );
  }
}

class CustomImageListState {
  Map<int, Widget> imageViews = Map();
  List<int> imageNum = [];
}
