import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/store/index.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

import 'package:flutter_manhuatai/models/book_list.dart' as BookList;
import 'package:flutter_manhuatai/models/recommend_stars.dart'
    as RecommendStars;
import 'package:flutter_manhuatai/models/topic_hot_list.dart' as TopicHotList;

import 'recommend_banner_sliver_list.dart';
import 'recommend_stars_sliver_list.dart';
import 'recommend_topic_sliver_list.dart';

class ManhuataiRecommend extends StatefulWidget {
  @override
  _ManhuataiRecommendState createState() => _ManhuataiRecommendState();
}

class _ManhuataiRecommendState extends State<ManhuataiRecommend>
    with
        AutomaticKeepAliveClientMixin,
        RefreshCommonState,
        WidgetsBindingObserver {
  bool _isLoading = true;
  ScrollController _scrollController = ScrollController();
  List<BookList.Book> _bannerList = [];
  List<RecommendStars.Data> _recommendStars = [];
  List<TopicHotList.List_List> _topicHotList = [];

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
    Store<AppState> store = StoreProvider.of(context);
    var guestInfo = store.state.guestInfo;
    var userInfo = store.state.userInfo;
    var type = userInfo.uid != null ? 'mkxq' : 'device';
    var openid = userInfo.uid != null ? userInfo.openid : guestInfo.openid;
    var authorization = userInfo.uid != null
        ? userInfo.authData.authcode
        : guestInfo.authData.authcode;

    List<Future<dynamic>> futures = List()
      ..add(Api.getBookByPosition())
      ..add(Api.getRecommendStars(
        type: type,
        openid: openid,
        authorization: authorization,
      ))
      ..add(Api.getTopicHotList(
        type: type,
        openid: openid,
        authorization: authorization,
        page: 1,
      ));
    var result = await Future.wait(futures);

    if (!this.mounted) {
      return;
    }

    var getBookByPositionRes = result[0] as BookList.BookList;
    var getRecommendStarsRes = result[1] as RecommendStars.RecommendStars;
    var getTopicHotListRes = result[2] as TopicHotList.TopicHotList;

    setState(() {
      _isLoading = false;
      _bannerList = getBookByPositionRes.data.book;
      _recommendStars = getRecommendStarsRes.data;
      _topicHotList = getTopicHotListRes.data.list;
    });
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
      child: _isLoading
          ? Container()
          : CustomScrollView(
              physics: ClampingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              controller: _scrollController,
              slivers: <Widget>[
                RecommendBannerSliverList(
                  bannerList: _bannerList,
                ),
                RecommendStarsSliverList(
                  dataList: _recommendStars,
                ),
                RecommendTopicSliverList(
                  topicHotList: _topicHotList,
                ),
              ],
            ),
    );
  }
}
