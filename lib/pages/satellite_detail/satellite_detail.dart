import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;
import 'package:flutter_manhuatai/models/comment_user.dart' as CommentUser;
import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';

import 'package:flutter_manhuatai/components/common_sliver_persistent_header_delegate.dart/common_sliver_persistent_header_delegate.dart.dart';
import 'package:flutter_manhuatai/components/comment_text_input/comment_text_input.dart';
import 'components/satellite_detail_comment_sliver_list.dart';
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
    // 判断当前滑动位置是不是到达底部，触发加载更多回调
    if (isBottom) {
      loadMore();
    }
  }

  Future<void> _handleRefresh() async {
    try {
      page = 1;
      var user = User(context);
      var type = user.info.type;
      var openid = user.info.openid;
      var authorization = user.info.authData.authcode;

      List<Future<dynamic>> futures = List()
        ..add(Api.getSatelliteDetail(
          type: type,
          openid: openid,
          authorization: authorization,
          satelliteId: widget.satelliteId,
        ))
        ..add(Api.getSatelliteCommentCount(
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

      var fatherCommentList = await _getCommentListInfo(
        type: type,
        openid: openid,
        authorization: authorization,
        starId: getSatelliteDetail.starid,
      );

      if (!this.mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _satellite = getSatelliteDetail;
        _satelliteCommentCount = getSatelliteCommentCount;
        _fatherCommentList = fatherCommentList;
        _roleInfo = roleInfo;
        _inputKey = GlobalKey<CommentTextInputState>();
        if (fatherCommentList.length == 0) {
          _hasMore = false;
        }
      });
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
    var user = User(context);

    var fatherCommentList = await _getCommentListInfo(
      type: user.info.type,
      openid: user.info.openid,
      authorization: user.info.authData.authcode,
      starId: _satellite.starid,
    );
    _isLoadingMore = false;

    if (!this.mounted) {
      return;
    }

    setState(() {
      if (fatherCommentList.length == 0) {
        _hasMore = false;
      }
      _fatherCommentList.addAll(fatherCommentList);
    });

    print('加载更多');
  }

  Future<List<CommonSatelliteComment>> _getCommentListInfo({
    String type,
    String openid,
    String authorization,
    int starId,
  }) async {
    var getSatelliteFatherComments = await Api.getSatelliteFatherComments(
      authorization: authorization,
      page: page,
      ssid: widget.satelliteId,
    );

    if (getSatelliteFatherComments.length == 0) {
      return [];
    }

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

    List<int> userIds = [];
    getSatelliteChildrenCommentsRes.forEach((comment) {
      var match = RegExp(r'{reply:“(\d+)”}').firstMatch(comment.content.trim());
      if (match != null) {
        userIds.add(int.tryParse(match.group(1)));
      }
      if (!userIds.contains(comment.useridentifier)) {
        userIds.add(comment.useridentifier);
      }
    });

    var getCommentUserRes = CommentUser.CommentUser.fromJson({});
    if (userIds.length != 0) {
      getCommentUserRes = await Api.getCommentUser(
        relationId: starId,
        opreateType: 2,
        userids: userIds,
      );
    }

    Map<int, CommentUser.Data> commentUserMap = Map();
    if (getCommentUserRes.data != null) {
      getCommentUserRes.data.forEach((item) {
        if (commentUserMap[item.uid] == null) {
          commentUserMap[item.uid] = item;
        }
      });
    }

    getSatelliteChildrenCommentsRes =
        getSatelliteChildrenCommentsRes.map((child) {
      if (commentUserMap[child.useridentifier] != null) {
        var commentUser = commentUserMap[child.useridentifier];
        child.uid = commentUser.uid;
        child.uname = commentUser.uname;
      }
      return child;
    }).toList();

    return getSatelliteFatherComments.map((item) {
      List<SatelliteComment> childrenCommentList = [];
      Map<int, CommentUser.Data> replyUserMap = {};

      getSatelliteChildrenCommentsRes.forEach((child) {
        if (child.fatherid == item.id) {
          childrenCommentList.add(child);
        }

        var match = RegExp(r'{reply:“(\d+)”}').firstMatch(child.content.trim());
        if (match != null) {
          int replyCommentUserId = int.tryParse(match.group(1));
          replyUserMap[replyCommentUserId] = commentUserMap[replyCommentUserId];
        }
      });

      return CommonSatelliteComment(
        fatherComment: item,
        childrenCommentList: childrenCommentList,
        replyUserMap: replyUserMap,
      );
    }).toList();
  }

  // 点赞帖子
  Future<void> _supportSatellite() async {
    var user = User(context);

    var success = await Api.supportSatellite(
      type: user.info.type,
      openid: user.info.openid,
      authorization: user.info.authData.authcode,
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

  // 点赞或者取消点赞
  Future<void> _supportComment(SatelliteComment comment) async {
    var user = User(context);
    if (!user.hasLogin) {
      showToast('点赞失败，请先登录');
      return;
    }

    var success = await Api.supportComment(
      type: user.info.type,
      openid: user.info.openid,
      authorization: user.info.authData.authcode,
      userIdentifier: user.info.uid,
      userLevel: user.info.ulevel,
      status: comment.status == 1 ? 0 : 1,
      ssid: _satellite.id,
      commentId: comment.id,
    );

    if (success) {
      setState(() {
        if (comment.status == 1) {
          comment.status = 0;
          comment.supportcount += 1;
        } else {
          comment.status = 1;
          comment.supportcount -= 1;
        }
      });
    } else {
      showToast('点赞失败，请稍后再试。');
    }
  }

  // 发表评论
  Future<void> _submitComment(String value) async {
    if (value.trim().isEmpty) {
      showToast('还是写点什么吧');
      return;
    }
    var user = User(context);
    String deviceTail = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceTail = androidInfo.device;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceTail = iosInfo.name;
    }

    var response = await Api.addComment(
      type: user.info.type,
      openid: user.info.openid,
      authorization: user.info.authData.authcode,
      userLevel: user.info.ulevel,
      userIdentifier: user.info.uid,
      userName: user.info.uname,
      ssid: _satellite.id,
      fatherId: 0,
      satelliteUserId: _satellite.ulevel,
      starId: _satellite.starid,
      content: value,
      title: _satellite.title,
      images: [],
      deviceTail: deviceTail,
    );
    if (response['status'] == 1) {
      showToast('正在快马加鞭审核中');
    } else {
      showToast('${response['msg']}');
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
                                                fontSize:
                                                    ScreenUtil().setWidth(32),
                                              ),
                                            ),
                                            Text(
                                              '最热',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize:
                                                    ScreenUtil().setWidth(24),
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
                                    supportComment: _supportComment,
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
