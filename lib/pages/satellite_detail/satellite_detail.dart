import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/components/common_sliver_persistent_header_delegate.dart/common_sliver_persistent_header_delegate.dart.dart';
import 'package:flutter_manhuatai/pages/satellite_detail/components/satellite_detail_comment_sliver_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';

import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/store/index.dart';

import 'package:flutter_manhuatai/components/satellite_content/satellite_content.dart';
import 'package:flutter_manhuatai/components/satellite_header/satellite_header.dart';

import 'components/satellite_detail_content_sliver_list.dart';

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
  bool _isLoadingError = false;
  int page = 1;

  ScrollController _scrollController = ScrollController();
  Satellite _satellite;
  int _satelliteCommentCount;
  List<SatelliteComment> _fatherCommentList;
  List<SatelliteComment> _childrenCommentList;
  UserRoleInfo.Data _roleInfo;

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

      var getSatelliteDetail = result[0] as Satellite;
      var getSatelliteCommentCount = result[1] as int;
      var getSatelliteFatherComments = result[2] as List<SatelliteComment>;

      List<int> commentIds =
          getSatelliteFatherComments.map((item) => item.id).toList();

      // 获取帖子的一级评论下需要显示的二级评论
      var getSatelliteChildrenCommentsRes =
          await Api.getSatelliteChildrenComments(
        type: type,
        openid: openid,
        authorization: authorization,
        commentIds: commentIds,
      );

      // 获取帖子的作者的角色信息
      var userRoleInfo = await Api.getUserroleInfoByUserids(
        userids: [getSatelliteDetail.useridentifier],
        authorization: authorization,
      );

      var roleInfo = userRoleInfo.data.firstWhere(
        (userRole) {
          return getSatelliteDetail.useridentifier == userRole.userId;
        },
        orElse: () => null,
      );

      if (!this.mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _satellite = getSatelliteDetail;
        _satelliteCommentCount = getSatelliteCommentCount;
        _fatherCommentList = getSatelliteFatherComments;
        _childrenCommentList = getSatelliteChildrenCommentsRes;
        _roleInfo = roleInfo;
      });
      // print(_satellite.title);
      // print(_satelliteCommentCount);
      // print(_fatherCommentList.length);
      // print(_childrenCommentList.length);
    } catch (e) {
      if (this.mounted) {
        setState(() {
          _isLoadingError = true;
        });
        print(e);
      }
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

  // 点赞帖子
  Future<void> _supportSatellite() async {
    Store<AppState> store = StoreProvider.of(context);
    var guestInfo = store.state.guestInfo;
    var userInfo = store.state.userInfo;
    var type = userInfo.uid != null ? 'mkxq' : 'device';
    var openid = userInfo.uid != null ? userInfo.openid : guestInfo.openid;
    var authorization = userInfo.uid != null
        ? userInfo.authData.authcode
        : guestInfo.authData.authcode;

    var success = await Api.supportSatellite(
      type: type,
      openid: openid,
      authorization: authorization,
      satelliteId: _satellite.id,
      status: _satellite.issupport == 1 ? 0 : 1,
    );

    if (success) {
      setState(() {
        if (_satellite.issupport == 1) {
          _satellite.issupport = 0;
          _satellite.supportnum -= 1;
        } else {
          _satellite.issupport = 1;
          _satellite.supportnum += 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _satellite);
        return false;
      },
      child: Scaffold(
        body: _isLoadingError
            ? Center(
                child: Container(
                  width: 200,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _isLoadingError = false;
                      });
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showRefreshLoading();
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '加载失败，点击重试',
                        ),
                        Icon(Icons.refresh),
                      ],
                    ),
                  ),
                ),
              )
            : RefreshIndicator(
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
                            elevation: 0.0,
                            centerTitle: true,
                            title: Text('帖子详情'),
                            pinned: true,
                          ),
                          SatelliteDetailContentSliverList(
                            satellite: _satellite,
                            roleInfo: _roleInfo,
                            supportSatellite: _supportSatellite,
                          ),
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: CommonSliverPersistentHeaderDelegate(
                              height: ScreenUtil().setWidth(80),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(30),
                                ),
                                color: Colors.white,
                                height: ScreenUtil().setWidth(80),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '评论 （$_satelliteCommentCount）',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: ScreenUtil().setWidth(32),
                                      ),
                                    ),
                                    Text(
                                      '最热',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: ScreenUtil().setWidth(24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SatelliteDetailCommentSliverList(
                            fatherCommentList: _fatherCommentList,
                            hasMore: _hasMore,
                          ),
                        ],
                      ),
              ),
      ),
    );
  }
}
