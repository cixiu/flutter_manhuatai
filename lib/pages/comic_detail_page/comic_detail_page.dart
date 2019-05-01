import 'dart:async';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_manhuatai/pages/comic_detail_page/components/comic_detail_chapter.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/components/comic_detail_chapter_title.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter_manhuatai/components/radius_container/radius_container.dart';

import 'package:flutter_manhuatai/models/comic_comment_count.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/components/comic_detail_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/comic_info_influence.dart';
import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

/// 漫画详情
class ComicDetailPage extends StatefulWidget {
  final String comicId;

  ComicDetailPage({
    @required this.comicId,
  });

  @override
  _ComicDetailPageState createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage>
    with RefreshCommonState, WidgetsBindingObserver {
  var absKey = GlobalKey();
  // 漫画的主体信息
  ComicInfoBody comicInfoBody = ComicInfoBody.fromJson({});
  // 展示的漫画章节
  List<Comic_chapter> comicChapterList = [];
  // 漫画章节的排序方式 'DES' => 降序 || 'ASC' => 升序
  String sortType = 'ASC';
  // 是否展开全部的漫画章节
  bool isShowAll = false;
  // 漫画的详细数据信息
  Call_data influenceData = Call_data.fromJson({});
  // 漫画的总吐槽数量
  int comicCommentCount = 0;
  // 漫画章节title距离顶部的距离
  double _chapterTitleTop = 0.0;
  ScrollController _scrollController = ScrollController();
  bool isFirstLoading = true;
  bool _showTitle = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
    _scrollController.addListener(_listScroll);
    super.initState();
  }

  @override
  void didUpdateWidget(ComicDetailPage oldWidget) {
    // RenderBox renderBox = absKey.currentContext.findRenderObject();
    // print(renderBox.localToGlobal(Offset.zero));
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    // RenderBox renderBox = absKey.currentContext.findRenderObject();
    // print(renderBox.localToGlobal(Offset.zero));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listScroll);
    super.dispose();
  }

  // 监听滚动设置 appBar 的 title
  void _listScroll() {
    if (_scrollController.position.pixels > 200) {
      if (!_showTitle) {
        setState(() {
          _showTitle = true;
        });
      }
    } else {
      if (_showTitle) {
        setState(() {
          _showTitle = false;
        });
      }
    }
  }

  // 获取指定漫画的主体信息
  Future<void> _getComicInfoBody() async {
    var response = await Api.getComicInfoBody(comicId: widget.comicId);
    var _comicInfoBody = ComicInfoBody.fromJson(response);
    setState(() {
      comicInfoBody = _comicInfoBody;
      comicChapterList =
          _comicInfoBody.comicChapter.sublist(0, 5).reversed.toList();
    });
  }

  // 获取指定漫画的人气活跃数据
  Future<void> _getComicInfoInfluence() async {
    var response = await Api.getComicInfoInfluence(comicId: widget.comicId);
    var _comicInfoInfluence = ComicInfoInfluence.fromJson(response);
    setState(() {
      influenceData = _comicInfoInfluence.data.callData;
    });
  }

  Future<void> _getComicCommentCount() async {
    var response = await Api.getComicCommentCount(comicId: widget.comicId);
    var _comicCommentCount = ComicCommentCount.fromJson(response);
    setState(() {
      comicCommentCount = _comicCommentCount.data;
    });
  }

  Future<void> onRefresh() async {
    await _getComicInfoBody();
    await _getComicInfoInfluence();
    await _getComicCommentCount();
    setState(() {
      isFirstLoading = false;
    });
    // 观察主要内容渲染完成后，拿到漫画章节title距离屏幕的顶部距离
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = absKey.currentContext.findRenderObject();
      _chapterTitleTop = renderBox.localToGlobal(Offset.zero).dy - 80.0;
    });
  }

  // 改变漫画章节的排序方式
  void _changeComicChapterSort() {
    setState(() {
      comicChapterList = comicChapterList.reversed.toList();
      if (sortType == 'ASC') {
        sortType = 'DES';
      } else {
        sortType = 'ASC';
      }
    });
  }

  // 全部章节的展示切换
  void _onTapShowAll() {
    setState(() {
      if (sortType == 'ASC') {
        if (isShowAll) {
          comicChapterList =
              comicInfoBody.comicChapter.sublist(0, 5).reversed.toList();
        } else {
          comicChapterList = comicInfoBody.comicChapter.reversed.toList();
        }
      } else {
        if (isShowAll) {
          comicChapterList = comicInfoBody.comicChapter.sublist(0, 5).toList();
        } else {
          comicChapterList = comicInfoBody.comicChapter.toList();
        }
      }
      isShowAll = !isShowAll;
    });

    _scrollController.jumpTo(
      _chapterTitleTop,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    // 为了保持在各个设备上图片显示一致，根据宽度去适配
    var expandedHeight = ScreenUtil().setWidth(552) - statusBarHeight;

    return Scaffold(
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: onRefresh,
        child: isFirstLoading
            ? Container()
            : CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: expandedHeight,
                    title: Text(_showTitle ? comicInfoBody.comicName : ''),
                    centerTitle: true,
                    elevation: 0.0,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: ComicDetailHeader(
                        comicId: widget.comicId,
                        comicInfoBody: comicInfoBody,
                        influenceData: influenceData,
                        comicCommentCount: comicCommentCount,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(20),
                            ScreenUtil().setWidth(10),
                            ScreenUtil().setWidth(20),
                            ScreenUtil().setWidth(20),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[100],
                              ),
                            ),
                          ),
                          child: Text(
                            comicInfoBody.comicDesc,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            strutStyle: StrutStyle(
                              forceStrutHeight: true,
                              fontSize: ScreenUtil().setSp(24),
                            ),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenUtil().setSp(24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  isShowAll
                      ? SliverPersistentHeader(
                          // key: absKey,
                          pinned: true,
                          delegate: _SliverAppBarDelegate(
                            absKey: absKey,
                            comicInfoBody: comicInfoBody,
                            sortType: sortType,
                            onTap: _changeComicChapterSort,
                          ),
                        )
                      : SliverList(
                          // key: absKey,
                          delegate: SliverChildListDelegate(
                            [
                              ComicDetailChapterTitle(
                                absKey: absKey,
                                comicInfoBody: comicInfoBody,
                                sortType: sortType,
                                onTap: _changeComicChapterSort,
                              ),
                            ],
                          ),
                        ),
                  ComicDetailChapter(
                    comicChapterList: comicChapterList,
                    isShowAll: isShowAll,
                    onTapShowAll: _onTapShowAll,
                  ),
                  // SliverList(
                  //   delegate: SliverChildBuilderDelegate(
                  //     (context, index) {
                  //       return Container(
                  //         height: 30.0,
                  //         child: Text('$index'),
                  //       );
                  //     },
                  //     childCount: 100,
                  //   ),
                  // ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          color: Colors.green,
                          height: 30.0,
                          child: Text('$index'),
                        );
                      },
                      childCount: 20,
                    ),
                  )
                ],
              ),
      ),
      bottomNavigationBar: isShowAll
          ? GestureDetector(
              onTap: _onTapShowAll,
              child: Container(
                height: 40,
                color: Colors.red,
                child: Text('小主，请收起'),
              ),
            )
          : null,
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final GlobalKey absKey;
  final ComicInfoBody comicInfoBody;
  final String sortType;
  final VoidCallback onTap;

  _SliverAppBarDelegate({
    this.absKey,
    this.comicInfoBody,
    this.sortType,
    this.onTap,
  });

  @override
  double get minExtent => ScreenUtil().setWidth(96);

  @override
  double get maxExtent => ScreenUtil().setWidth(96);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ComicDetailChapterTitle(
      absKey: absKey,
      comicInfoBody: comicInfoBody,
      sortType: sortType,
      onTap: onTap,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
