import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/components/load_more_widget/load_more_widget.dart';
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
import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/models/user_follow_line.dart'
    as UserFollowLine;
import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;

import 'manhuatai_focus_empty.dart';
import 'manhuatai_sliver_title.dart';
import 'satellite_content.dart';
import 'satellite_header.dart';

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
  List<UserFollowLine.Data> _followTimeLineList = [];
  List<UserRoleInfo.Data> _userRoleInfoList = [];

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
    var authorization = userInfo.uid != null
        ? userInfo.authData.authcode
        : guestInfo.authData.authcode;
    var userids = [
      2573857,
      3062527,
      23410185,
      24950958,
      1336170,
      3468809,
      47726095,
      3145539,
      3218465
    ];

    List<Future<dynamic>> futures = List()
      ..add(Api.getRecommendUsers(
        type: type,
        openid: openid,
        authorization: authorization,
      ))
      ..add(Api.getUsergFollowList(
        type: type,
        openid: openid,
        myuid: userInfo.uid ?? guestInfo.uid,
      ))
      ..add(Api.getUserFollowLine(
        type: type,
        openid: openid,
        authorization: authorization,
      ))
      ..add(Api.getUserroleInfoByUserids(
        userids: userids,
        authorization: authorization,
      ));
    var result = await Future.wait(futures);

    if (!this.mounted) {
      return;
    }

    var getRecommendUsersRes = result[0] as RecommendUsers.RecommendUsers;
    var getUsergFollowListRes = result[1] as FollowList.FollowList;
    var getUserFollowLineRes = result[2] as UserFollowLine.UserFollowLine;
    var getUserroleInfoByUseridsRes = result[3] as UserRoleInfo.UserRoleInfo;

    setState(() {
      _isLoading = false;
      _recommendUsers = getRecommendUsersRes.data;
      _followList = getUsergFollowListRes.data;
      _followTimeLineList =
          getUserFollowLineRes.data != null ? getUserFollowLineRes.data : [];
      _userRoleInfoList = getUserroleInfoByUseridsRes.data;
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
    var getUserFollowLineRes = await Api.getUserFollowLine(
      type: type,
      openid: openid,
      authorization: authorization,
      createTime: _followTimeLineList.last.satellite.createtime,
      dataType: 2,
      targetId: _followTimeLineList.last.targetId,
    );
    _isLoadingMore = false;

    var followTimeLineList = getUserFollowLineRes.data;
    if (followTimeLineList == null || followTimeLineList.length == 0) {
      setState(() {
        _hasMore = false;
      });
    } else {
      setState(() {
        _followTimeLineList.addAll(followTimeLineList);
      });
    }
  }

  Future<void> _supportSatellite(int index) async {
    var item = _followTimeLineList[index].satellite;
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
      satelliteId: item.id,
      status: item.issupport == 1 ? 0 : 1,
    );

    if (success) {
      setState(() {
        if (item.issupport == 1) {
          item.issupport = 0;
          item.supportnum -= 1;
        } else {
          item.issupport = 1;
          item.supportnum += 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    StrutStyle strutStyle = StrutStyle(
      forceStrutHeight: true,
      fontSize: ScreenUtil().setSp(24),
    );
    TextStyle style = TextStyle(
      color: Colors.black87,
      fontSize: ScreenUtil().setSp(24),
    );

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
              slivers: _followList.length == 0 ||
                      _followTimeLineList.length == 0
                  ? <Widget>[
                      ManhuataiFocusEmpty(
                        recommendUsers: _recommendUsers,
                      ),
                    ]
                  : <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            height: ScreenUtil().setWidth(144),
                            margin: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setWidth(30),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(30),
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                if (index == 0) {
                                  return Container(
                                    width: ScreenUtil().setWidth(110),
                                    margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(30),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          // margin: EdgeInsets.only(
                                          //   right: ScreenUtil().setWidth(30),
                                          // ),
                                          child: Image.asset(
                                            'lib/images/icon_myflowing_red.png',
                                            width: ScreenUtil().setWidth(110),
                                            height: ScreenUtil().setWidth(110),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Container(
                                          height: ScreenUtil().setWidth(24),
                                          margin: EdgeInsets.only(
                                            top: ScreenUtil().setWidth(10),
                                          ),
                                          child: Text(
                                            '我的关注',
                                            strutStyle: strutStyle,
                                            style: style,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                var item = _followList[index - 1];
                                return Container(
                                  width: ScreenUtil().setWidth(110),
                                  margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(30),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: ScreenUtil().setWidth(110),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            ScreenUtil().setWidth(55),
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(
                                            Utils.generateImgUrlFromId(
                                              id: item.uid,
                                              aspectRatio: '1:1',
                                              type: 'head',
                                            ),
                                          ),
                                          radius: ScreenUtil().setWidth(55),
                                        ),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(110),
                                        height: ScreenUtil().setWidth(24),
                                        margin: EdgeInsets.only(
                                          top: ScreenUtil().setWidth(10),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${item.uname}',
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          strutStyle: strutStyle,
                                          style: style,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: _followList.length + 1,
                            ),
                          )
                        ]),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            if (index == _followTimeLineList.length) {
                              return LoadMoreWidget(
                                hasMore: _hasMore,
                              );
                            }

                            var item = _followTimeLineList[index];
                            UserRoleInfo.Data roleInfo;
                            roleInfo = _userRoleInfoList.firstWhere(
                              (userRole) {
                                return item.satellite.useridentifier ==
                                    userRole.userId;
                              },
                              orElse: () => null,
                            );

                            return Column(
                              children: <Widget>[
                                SatelliteHeader(
                                  item: item.satellite,
                                  roleInfo: roleInfo,
                                  showFollowBtn: false,
                                ),
                                SatelliteContent(
                                  item: item.satellite,
                                  supportSatellite: () {
                                    _supportSatellite(index);
                                  },
                                ),
                              ],
                            );
                          },
                          childCount: _followTimeLineList.length + 1,
                        ),
                      ),
                    ],
            ),
    );
  }
}
