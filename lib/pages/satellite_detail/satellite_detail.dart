import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/store/index.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

/// 帖子详情页
class SatelliteDetailPage extends StatefulWidget {
  final int satelliteId;

  SatelliteDetailPage({
    Key key,
    this.satelliteId,
  }) : super(key: key);

  @override
  _SatelliteDetailPageState createState() => _SatelliteDetailPageState();
}

class _SatelliteDetailPageState extends State<SatelliteDetailPage>
    with RefreshCommonState, WidgetsBindingObserver {
  bool _isLoading = true;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  int page = 1;

  ScrollController _scrollController = ScrollController();
  Satellite _satellite;
  int _satelliteCommentCount;
  List<SatelliteComment> _fatherCommentList;
  List<SatelliteComment> _childrenCommentList;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_listenenScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
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

  Future<void> _handleRefresh() async {
    try {
      page = 1;
      Store<AppState> store = StoreProvider.of(context);

      var guestInfo = store.state.guestInfo;
      var userInfo = store.state.userInfo;
      var type = userInfo.uid != null ? 'mkxq' : 'device';
      var openid = userInfo.uid != null ? userInfo.openid : guestInfo.openid;
      var authorization = userInfo.uid != null
          ? userInfo.authData.authcode
          : guestInfo.authData.authcode;

      List<Future<dynamic>> futures = List()
        ..add(Api.getSatelliteDetail(
          type: type,
          openid: openid,
          authorization: authorization,
          satelliteId: widget.satelliteId,
        ))
        ..add(Api.getSatelliteCommentCount(
          ssid: widget.satelliteId,
        ))
        ..add(Api.getSatelliteFatherComments(
          authorization: authorization,
          page: page,
          ssid: widget.satelliteId,
        ));
      var result = await Future.wait(futures);

      if (!this.mounted) {
        return;
      }

      var getSatelliteDetail = result[0] as Satellite;
      var getSatelliteCommentCount = result[1] as int;
      var getSatelliteFatherComments = result[2] as List<SatelliteComment>;

      List<int> commentIds =
          getSatelliteFatherComments.map((item) => item.id).toList();

      var getSatelliteChildrenCommentsRes =
          await Api.getSatelliteChildrenComments(
        type: type,
        openid: openid,
        authorization: authorization,
        commentIds: commentIds,
      );

      setState(() {
        _isLoading = false;
        _satellite = getSatelliteDetail;
        _satelliteCommentCount = getSatelliteCommentCount;
        _fatherCommentList = getSatelliteFatherComments;
        _childrenCommentList = getSatelliteChildrenCommentsRes;
      });
      print(_satellite.title);
      print(_satelliteCommentCount);
      print(_fatherCommentList.length);
      print(_childrenCommentList.length);
    } catch (e) {
      print(e);
    }
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
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
                  SliverAppBar(
                    centerTitle: true,
                    title: Text('帖子详情'),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Text(_satellite.title),
                    ]),
                  ),
                ],
              ),
      ),
    );
  }
}
