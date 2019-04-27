import 'dart:async';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_manhuatai/components/score_star/score_star.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/components/comic_detail_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/comic_info_influence.dart';
import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
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

  Future<void> _getComicInfoBody() async {
    var response = await Api.getComicInfoBody(comicId: widget.comicId);
    var _comicInfoBody = ComicInfoBody.fromJson(response);
    setState(() {
      comicInfoBody = _comicInfoBody;
    });
  }

  Future<void> _getComicInfoInfluence() async {
    var response = await Api.getComicInfoInfluence(comicId: widget.comicId);
    var _comicInfoInfluence = ComicInfoInfluence.fromJson(response);
    setState(() {
      influenceData = _comicInfoInfluence.data.callData;
    });
  }

  Future<void> onRefresh() async {
    await _getComicInfoBody();
    await _getComicInfoInfluence();
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
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == 0) {
                          return Container(
                            height: 40.0,
                            color: Colors.cyan,
                            child: Stack(
                              overflow: Overflow.visible,
                              // alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  color: Colors.blue,
                                  height: 40.0,
                                  child: Text('滴滴滴滴滴哒哒多多多多多多多多多多'),
                                ),
                                Positioned(
                                  // top: -20.0,
                                  child: Container(
                                    color: Colors.red,
                                    height: 40.0,
                                    child: Text('jkddddddddddddddddddddddd'),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return Container(
                          color: Colors.red,
                          height: 30.0,
                          child: Text('$index'),
                        );
                      },
                      childCount: 20,
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
                              height: 50.0,
                              color: Colors.grey,
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
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey,
      height: 50.0,
      child: Text('连载'),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
