import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/pages/manhuatai/components/manhuatai_focus_empty.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/store/index.dart';

import 'package:flutter_manhuatai/models/recommend_users.dart'
    as RecommendUsers;
import 'package:flutter_manhuatai/models/follow_list.dart' as FollowList;

import 'manhuatai_focus_empty.dart';
import 'manhuatai_sliver_title.dart';

class ManhuataiFocus extends StatefulWidget {
  @override
  _ManhuataiFocusState createState() => _ManhuataiFocusState();
}

class _ManhuataiFocusState extends State<ManhuataiFocus>
    with
        AutomaticKeepAliveClientMixin,
        RefreshCommonState,
        WidgetsBindingObserver {
  bool _isLoading = true;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  int page = 1;

  ScrollController _scrollController = ScrollController();
  List<RecommendUsers.Data> _recommendUsers = [];
  List<FollowList.Data> _followList = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_listenenScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  @override
  bool get wantKeepAlive => true;

  void _listenenScroll() {
    bool isBottom = _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
    // 判断当前滑动位置是不是到达底部，触发加载更多回调
    if (isBottom) {
      loadMore();
    }
  }

  Future<void> _handleRefresh() async {
    page = 1;
    Store<AppState> store = StoreProvider.of(context);
    var guestInfo = store.state.guestInfo;
    var userInfo = store.state.userInfo;
    var type = userInfo.uid != null ? 'mkxq' : 'device';
    var openid = userInfo.uid != null ? userInfo.openid : guestInfo.openid;
    // var deviceid = userInfo.uid != null ? userInfo.openid : guestInfo.openid;
    var authorization = userInfo.uid != null
        ? userInfo.authData.authcode
        : guestInfo.authData.authcode;

    List<Future<dynamic>> futures = List()
      ..add(Api.getRecommendUsers(
        type: type,
        openid: openid,
        authorization: authorization,
      ))
      ..add(Api.getUsergFollowList(
        type: type,
        openid: openid,
        // deviceid:
        myuid: userInfo.uid ?? guestInfo.uid,
      ));
    var result = await Future.wait(futures);

    if (!this.mounted) {
      return;
    }

    var getRecommendUsersRes = result[0] as RecommendUsers.RecommendUsers;
    var getUsergFollowListRes = result[1] as FollowList.FollowList;

    setState(() {
      _isLoading = false;
      _recommendUsers = getRecommendUsersRes.data;
      _followList = getUsergFollowListRes.data;
    });
  }

  // 上拉加载更多
  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) {
      return;
    }
    _isLoadingMore = true;

    page++;
    Store<AppState> store = StoreProvider.of(context);
    var guestInfo = store.state.guestInfo;
    var userInfo = store.state.userInfo;
    var type = userInfo.uid != null ? 'mkxq' : 'device';
    var openid = userInfo.uid != null ? userInfo.openid : guestInfo.openid;
    var authorization = userInfo.uid != null
        ? userInfo.authData.authcode
        : guestInfo.authData.authcode;

    print('加载更多');
    // var getRecommendSatelliteRes = await Api.getRecommendUsers(
    //   type: type,
    //   openid: openid,
    //   authorization: authorization,
    // );
    // _isLoadingMore = false;

    // var recommendSatelliteList = getRecommendSatelliteRes.data.list;
    // if (recommendSatelliteList.length == 0) {
    //   setState(() {
    //     _hasMore = false;
    //   });
    // }

    // setState(() {
    //   _recommendSatelliteList.addAll(recommendSatelliteList);
    // });
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
              slivers: _followList.length == 0
                  ? <Widget>[
                      ManhuataiFocusEmpty(
                        recommendUsers: _recommendUsers,
                      ),
                    ]
                  : <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            color: Colors.green,
                          )
                        ]),
                      )
                    ],
            ),
    );
  }
}
