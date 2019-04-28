import 'dart:async';
import 'package:flutter/material.dart' hide NestedScrollView;

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
  ScrollController _scrollController = ScrollController();
  ComicInfoBody comicInfoBody = ComicInfoBody.fromJson({});
  Call_data influenceData = Call_data.fromJson({});
  int comicCommentCount = 0;
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
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    // 为了保持在各个设备上图片显示一致，根据宽度去适配
    var expandedHeight = ScreenUtil().setWidth(552) - statusBarHeight;
    var isShowAll = true;

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
                                color: Colors.grey[200],
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
                          pinned: true,
                          delegate: _SliverAppBarDelegate(),
                        )
                      : SliverList(
                          delegate: SliverChildListDelegate([
                            Container(
                              height: ScreenUtil().setWidth(96),
                              padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setWidth(20),
                              ),
                              color: Colors.white,
                              child: Text('连载'),
                            )
                          ]),
                        ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          height: 30.0,
                          child: Text('$index'),
                        );
                      },
                      childCount: 100,
                    ),
                  ),
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
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
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
    return Container(
        height: ScreenUtil().setWidth(96),
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200],
            ),
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '连载',
                  style: TextStyle(
                    fontSize: ScreenUtil().setWidth(32),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Container(
              height: ScreenUtil().setWidth(32),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(14),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(32)),
              ),
              child: Center(
                child: Text(
                  '选集',
                  strutStyle: StrutStyle(
                    forceStrutHeight: true,
                    fontSize: ScreenUtil().setSp(20),
                  ),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(20),
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ));
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
