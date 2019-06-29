import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManhuataiRecommend extends StatefulWidget {
  @override
  _ManhuataiRecommendState createState() => _ManhuataiRecommendState();
}

class _ManhuataiRecommendState extends State<ManhuataiRecommend>
    with
        AutomaticKeepAliveClientMixin,
        RefreshCommonState,
        WidgetsBindingObserver {
  ScrollController _scrollController = ScrollController();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_listenenScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
  }

  void _listenenScroll() {
    bool isBottom = _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
    // 判断当前滑动位置是不是到达底部，触发加载更多回调
    if (isBottom) {
      loadMore();
    }
  }

  // 上拉加载更多
  Future<void> loadMore() async {
    print('加载更多');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: _handleRefresh,
      child: CustomScrollView(
        physics: ClampingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: _scrollController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: ScreenUtil().setWidth(200),
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                color: Colors.redAccent,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
