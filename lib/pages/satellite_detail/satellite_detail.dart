import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

import 'package:flutter_manhuatai/common/dao/comment.dart';
import 'package:flutter_manhuatai/common/model/common_satellite_comment.dart';
import 'package:flutter_manhuatai/components/comment_sliver_list/comment_sliver_list.dart';
import 'package:flutter_manhuatai/components/comment_type_header/comment_type_header.dart';
import 'package:flutter_manhuatai/components/request_loading/request_loading.dart';
import 'package:flutter_manhuatai/provider_store/user_info_model.dart';
import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;
import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';

import 'package:flutter_manhuatai/components/common_sliver_persistent_header_delegate.dart/common_sliver_persistent_header_delegate.dart.dart';
import 'package:flutter_manhuatai/components/comment_text_input/comment_text_input.dart';
import 'package:provider/provider.dart';
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
  int pageSize = 20;
  double _maxFirstScrollTop; // 加装第一页的评论后的最大滚动距离，用于切换评论列表的类型后，需要将页面滚动至初始位置的基准距离
  WhyFarther _commentType = WhyFarther.hot; // 评论的类型（最新，最热）

  ScrollController _scrollController = ScrollController();
  Satellite _satellite;
  int _satelliteCommentCount;
  List<CommonSatelliteComment> _fatherCommentList;
  UserRoleInfo.Data _roleInfo;

  GlobalKey<CommentTextInputState> _inputKey;

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
    if (page == 1 && _maxFirstScrollTop == null) {
      _maxFirstScrollTop = _scrollController.position.maxScrollExtent;
    }
    // 判断当前滑动位置是不是到达底部，触发加载更多回调
    if (isBottom) {
      loadMore();
    }
  }

  Future<void> _handleRefresh() async {
    try {
      page = 1;
      _hasMore = true;
      _maxFirstScrollTop = null;
      var user = Provider.of<UserInfoModel>(context, listen: false).user;
      var userType = user.type;
      var openid = user.openid;
      var authorization = user.authData.authcode;

      List<Future<dynamic>> futures = List()
        ..add(Api.getSatelliteDetail(
          type: userType,
          openid: openid,
          authorization: authorization,
          satelliteId: widget.satelliteId,
        ))
        ..add(Api.getCommentCount(
          ssid: widget.satelliteId,
        ));
      var result = await Future.wait(futures);

      var getSatelliteDetail = result[0] as Satellite;
      var getSatelliteCommentCount = result[1] as int;

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

      var fatherCommentList = await getCommentListInfo(
        type: _commentType == WhyFarther.hot ? 'hot' : 'new',
        userType: userType,
        openid: openid,
        authorization: authorization,
        ssid: widget.satelliteId,
        ssidtype: 1,
        page: page,
      );

      if (!this.mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _satellite = getSatelliteDetail;
        _satelliteCommentCount = getSatelliteCommentCount ?? 0;
        _fatherCommentList = fatherCommentList;
        _roleInfo = roleInfo;
        _inputKey = GlobalKey<CommentTextInputState>();
        if (fatherCommentList.length < pageSize) {
          _hasMore = false;
        }
      });
    } catch (e) {
      if (this.mounted) {
        setState(() {
          _isLoadingError = true;
        });
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
    var user = Provider.of<UserInfoModel>(context, listen: false).user;
    var userType = user.type;
    var openid = user.openid;
    var authorization = user.authData.authcode;

    var fatherCommentList = await getCommentListInfo(
      type: _commentType == WhyFarther.hot ? 'hot' : 'new',
      userType: userType,
      openid: openid,
      authorization: authorization,
      ssid: widget.satelliteId,
      ssidtype: 1,
      page: page,
    );
    _isLoadingMore = false;

    if (!this.mounted) {
      return;
    }

    setState(() {
      if (fatherCommentList.length < pageSize) {
        _hasMore = false;
      }
      _fatherCommentList.addAll(fatherCommentList);
    });

    print('加载更多');
  }

  // 点赞帖子
  Future<void> _supportSatellite() async {
    var user = Provider.of<UserInfoModel>(context, listen: false).user;

    var success = await Api.supportSatellite(
      type: user.type,
      openid: user.openid,
      authorization: user.authData.authcode,
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
    } else {
      showToast('点赞失败，请稍后再试。');
    }
  }

  // 发表评论
  Future<void> _submitComment({
    String value,
    bool isReply,
    SatelliteComment comment,
  }) async {
    await addComment(
      context: context,
      value: value,
      isReplyDetail: false,
      isReply: isReply,
      comment: comment,
      ssid: _satellite.id,
      ssidType: 1,
      title: _satellite.title,
      opreateId: isReply ? comment.useridentifier : 0,
      starId: _satellite.starid,
    );
  }

  // 切换显示的评论列表的类型
  Future<void> _switchCommentType(WhyFarther result) async {
    try {
      int _page = page;
      showLoading(context);
      setState(() {
        _commentType = result;
      });
      _hasMore = true;
      page = 1;
      var user = Provider.of<UserInfoModel>(context, listen: false).user;
      var userType = user.type;
      var openid = user.openid;
      var authorization = user.authData.authcode;

      var fatherCommentList = await getCommentListInfo(
        type: _commentType == WhyFarther.hot ? 'hot' : 'new',
        userType: userType,
        openid: openid,
        authorization: authorization,
        ssid: widget.satelliteId,
        ssidtype: 1,
        page: page,
      );

      var scrollTop = _scrollController.position.pixels;
      if (_page > 1 && scrollTop > _maxFirstScrollTop) {
        _scrollController.jumpTo(1.0);
      }
      setState(() {
        if (fatherCommentList.length == 0) {
          _hasMore = false;
        }
        _fatherCommentList = fatherCommentList;
        _maxFirstScrollTop = null;
      });
      hideLoading(context);
    } catch (e) {
      hideLoading(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return WillPopScope(
      onWillPop: () async {
        if (_inputKey != null && _inputKey.currentState.showCustomKeyBoard) {
          _inputKey.currentState.hideEmoji();
          return false;
        }
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
                    : Column(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _inputKey.currentState.blurKeyBoard();
                              },
                              child: CustomScrollView(
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
                                    delegate:
                                        CommonSliverPersistentHeaderDelegate(
                                      height: ScreenUtil().setWidth(80),
                                      child: CommentTypeHeader(
                                        count: _satelliteCommentCount,
                                        commentType: _commentType,
                                        onSelected: _switchCommentType,
                                      ),
                                    ),
                                  ),
                                  CommentSliverList(
                                    isReplyDetail: false,
                                    fatherCommentList: _fatherCommentList,
                                    hasMore: _hasMore,
                                    inputKey: _inputKey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CommentTextInput(
                            key: _inputKey,
                            submit: _submitComment,
                            keyboardHeight: keyboardHeight,
                          ),
                        ],
                      ),
              ),
      ),
    );
  }
}
