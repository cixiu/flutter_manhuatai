import 'dart:async';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/pages/comic_detail_page/components/comic_detail_header.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/components/comic_detail_heat.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/components/comic_detail_role.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/components/comic_detail_fans.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/components/comic_detail_chapter_title.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/components/comic_detail_chapter.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/components/comic_detail_book.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/components/comic_detail_chapter_bottom.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_manhuatai/models/comic_info_influence.dart';
import 'package:flutter_manhuatai/models/comic_comment_count.dart';
import 'package:flutter_manhuatai/models/comic_info_role.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/provider_store/user_info_model.dart';
import 'package:flutter_manhuatai/provider_store/user_record_model.dart';

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
  // 漫画的前100粉丝
  List<Insider_list> insiderFansList = [];
  // 漫画的总吐槽数量
  int comicCommentCount = 0;
  // 漫画的作者和角色
  ComicInfoRole comicInfoRole = ComicInfoRole.fromJson({});
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
  void dispose() {
    _scrollController.removeListener(_listScroll);
    super.dispose();
  }

  int get endChapterLength {
    int end = 5;
    if (comicInfoBody.comicChapter.length < 5) {
      end = comicInfoBody.comicChapter.length;
    }
    return end;
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
    if (this.mounted) {
      setState(() {
        comicInfoBody = _comicInfoBody;
        comicChapterList = _comicInfoBody.comicChapter
            .sublist(0, endChapterLength)
            .reversed
            .toList();
      });
    }
  }

  // 获取指定漫画的人气活跃数据
  Future<void> _getComicInfoInfluence() async {
    var response = await Api.getComicInfoInfluence(comicId: widget.comicId);
    var _comicInfoInfluence = ComicInfoInfluence.fromJson(response);
    if (this.mounted) {
      setState(() {
        influenceData = _comicInfoInfluence.data.callData;
        insiderFansList = _comicInfoInfluence.data.insiderList;
      });
    }
  }

  // 获取漫画的吐槽总数
  Future<void> _getComicCommentCount() async {
    var response = await Api.getComicCommentCount(comicId: widget.comicId);
    var _comicCommentCount = ComicCommentCount.fromJson(response);
    if (this.mounted) {
      setState(() {
        comicCommentCount = _comicCommentCount.data;
      });
    }
  }

  // 获取漫画的作者和角色信息
  Future<void> _getComicInfoRole() async {
    var response = await Api.getComicInfoRole(comicId: widget.comicId);
    var _comicInfoRole = ComicInfoRole.fromJson(response);
    if (this.mounted) {
      setState(() {
        comicInfoRole = _comicInfoRole;
      });
    }
  }

  // 获取用户的收藏和阅读记录
  Future<void> _getUserRecord() async {
    // 防止页面卸载后，导致后面的代码执行出错
    if (!this.mounted) {
      return;
    }
    // Store<AppState> store = StoreProvider.of(context);
    // await getUserRecordAsyncAction(store);
    var userRecordModel = Provider.of<UserRecordModel>(context, listen: false);
    var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
    await userRecordModel.getUserRecordAsyncAction(userInfoModel.user);
  }

  Future<void> onRefresh() async {
    await _getComicInfoBody();
    await _getComicInfoInfluence();
    await _getComicCommentCount();
    await _getComicInfoRole();
    await _getUserRecord();
    if (this.mounted) {
      setState(() {
        isFirstLoading = false;
      });
      // 观察主要内容渲染完成后，拿到漫画章节title距离屏幕的顶部距离
      WidgetsBinding.instance.addPostFrameCallback((_) {
        RenderBox renderBox = absKey.currentContext.findRenderObject();
        // 手机状态栏的高度
        double statusBarHeight = MediaQuery.of(context).padding.top;
        // kToolbarHeight默认的AppBar高度
        _chapterTitleTop = renderBox.localToGlobal(Offset.zero).dy -
            statusBarHeight -
            kToolbarHeight;
      });
    }
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
          comicChapterList = comicInfoBody.comicChapter
              .sublist(0, endChapterLength)
              .reversed
              .toList();
        } else {
          comicChapterList = comicInfoBody.comicChapter.reversed.toList();
        }
      } else {
        if (isShowAll) {
          comicChapterList =
              comicInfoBody.comicChapter.sublist(0, endChapterLength).toList();
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
                physics: ClampingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: expandedHeight,
                    iconTheme: IconThemeData(
                      color: _showTitle ? Colors.blue : Colors.white,
                    ),
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
                                color: Colors.grey[200],
                                width: ScreenUtil().setWidth(1),
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
                        // 总人气和周人气
                        ComicDetailHeat(
                          influenceData: influenceData,
                        ),
                        // 作者&角色
                        ComicDetailRole(
                          comicInfoRole: comicInfoRole.data,
                        ),
                        // 粉丝打call
                        ComicDetailFans(
                          influenceData: influenceData,
                          insiderFansList: insiderFansList,
                        ),
                      ],
                    ),
                  ),
                  // 漫画章节列表的title
                  isShowAll
                      ? SliverPersistentHeader(
                          pinned: true,
                          delegate: _SliverAppBarDelegate(
                            absKey: absKey,
                            comicInfoBody: comicInfoBody,
                            sortType: sortType,
                            onTap: _changeComicChapterSort,
                          ),
                        )
                      : SliverList(
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
                  // 漫画章节列表组件
                  ComicDetailChapter(
                    comicId: widget.comicId,
                    comicChapterList: comicChapterList,
                    isShowAll: isShowAll,
                    onTapShowAll: _onTapShowAll,
                  ),
                  ComicDetailBook(
                    comicId: widget.comicId,
                  ),
                ],
              ),
      ),
      bottomNavigationBar: isShowAll
          ? ComicDetailChapterBottom(
              collect: influenceData.collect,
              comicCommentCount: comicCommentCount.toString(),
              onTapCloseAll: _onTapShowAll,
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
