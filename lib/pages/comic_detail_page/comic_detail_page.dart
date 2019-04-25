import 'dart:async';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/api/api.dart';
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
  ComicInfoBody comicInfoBody = ComicInfoBody.fromJson({});
  bool isFirstLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
    super.initState();
  }

  Future<void> _getComicInfoBody() async {
    var response = await Api.getComicInfoBody(comicId: widget.comicId);
    var _comicInfoBody = ComicInfoBody.fromJson(response);
    setState(() {
      comicInfoBody = _comicInfoBody;
    });
  }

  Future<void> onRefresh() async {
    await _getComicInfoBody();
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
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: expandedHeight,
                    title: Text(comicInfoBody?.comicName ?? ''),
                    elevation: 0.0,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Stack(
                        children: <Widget>[
                          Image.network(
                            Utils.generateImgUrlFromId(
                              id: int.parse(widget.comicId),
                              aspectRatio: '2:1',
                            ),
                            height: ScreenUtil().setWidth(488),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            bottom: 0,
                            left: 0,
                            child: Container(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            left: 0,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                Image.asset(
                                  'lib/images/pic_detail_hx1.png',
                                  height: ScreenUtil().setWidth(128),
                                  fit: BoxFit.fill,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: ScreenUtil().setWidth(200),
                                      height: ScreenUtil().setWidth(64),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: <Widget>[
                                          Image.asset(
                                            'lib/images/icon_detail_collect.png',
                                            width: ScreenUtil().setWidth(200),
                                            height: ScreenUtil().setWidth(64),
                                          ),
                                          Text('收藏'),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(248),
                                      height: ScreenUtil().setWidth(102),
                                      child: Stack(
                                        overflow: Overflow.visible,
                                        alignment: Alignment.bottomCenter,
                                        children: <Widget>[
                                          Positioned(
                                            top: ScreenUtil().setWidth(-10),
                                            child: Image.asset(
                                              'lib/images/icon_detail_reed.png',
                                              width: ScreenUtil().setWidth(248),
                                              height:
                                                  ScreenUtil().setWidth(102),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: ScreenUtil().setWidth(20),
                                            child: Text('开始阅读'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(200),
                                      height: ScreenUtil().setWidth(64),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: <Widget>[
                                          Image.asset(
                                            'lib/images/icon_detail_comt.png',
                                            width: ScreenUtil().setWidth(200),
                                            height: ScreenUtil().setWidth(64),
                                          ),
                                          Text('吐槽'),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
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
