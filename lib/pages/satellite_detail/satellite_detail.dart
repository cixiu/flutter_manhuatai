import 'dart:async';
import 'dart:math';

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_manhuatai/components/post_item/emoji_text.dart';
import 'package:flutter_manhuatai/components/post_item/post_special_text_span_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/store/index.dart';

import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;
import 'package:flutter_manhuatai/models/comment_user.dart' as CommentUser;
import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';

import 'package:flutter_manhuatai/components/common_sliver_persistent_header_delegate.dart/common_sliver_persistent_header_delegate.dart.dart';
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
  // List<SatelliteComment> _childrenCommentList;
  UserRoleInfo.Data _roleInfo;

  String _value = '';
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode(); // 底部输入框的焦点
  double _keyboardHeight = 267.0;
  bool activeEmojiGird = false;
  bool get showCustomKeyBoard => activeEmojiGird;

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
    Store<AppState> store = StoreProvider.of(context);
    var guestInfo = store.state.guestInfo;
    var userInfo = store.state.userInfo;
    var type = userInfo.uid != null ? 'mkxq' : 'device';
    var openid = userInfo.uid != null ? userInfo.openid : guestInfo.openid;
    var authorization = userInfo.uid != null
        ? userInfo.authData.authcode
        : guestInfo.authData.authcode;

    var fatherCommentList = await _getCommentListInfo(
      type: type,
      openid: openid,
      authorization: authorization,
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

    var getCommentUserRes = await Api.getCommentUser(
      relationId: starId,
      opreateType: 2,
      userids: userIds,
    );

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

  // 点赞或者取消点赞
  Future<void> _supportComment(SatelliteComment comment) async {
    Store<AppState> store = StoreProvider.of(context);
    var guestInfo = store.state.guestInfo;
    var userInfo = store.state.userInfo;
    if (userInfo.uid == null) {
      showToast('点赞失败，请先登录');
      return;
    }
    var type = userInfo.uid != null ? 'mkxq' : 'device';
    var openid = userInfo.uid != null ? userInfo.openid : guestInfo.openid;
    var userIdentifier = userInfo.uid != null ? userInfo.uid : guestInfo.uid;
    var userLevel = userInfo.uid != null ? userInfo.ulevel : guestInfo.ulevel;
    var authorization = userInfo.uid != null
        ? userInfo.authData.authcode
        : guestInfo.authData.authcode;

    var success = await Api.supportComment(
      type: type,
      openid: openid,
      authorization: authorization,
      userIdentifier: userIdentifier,
      userLevel: userLevel,
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
    }
  }

  void _insertText(String text) {
    bool isBack = text == '[/返回]';
    if (isBack) {
      if (_value == '') {
        return;
      }
      var backReg = RegExp(r'(\[\/[\u2E80-\u9FFF]+\])$');
      int index = _value.lastIndexOf(backReg);
      if (index > -1) {
        setState(() {
          _value = _value.replaceFirst(backReg, '');
        });
      } else {
        print(_value.substring(0, _value.length - 1));
        setState(() {
          _value = _value.substring(0, _value.length - 1);
        });
      }
    } else {
      setState(() {
        _value += text;
      });
    }

    _textEditingController.value = TextEditingValue(
      text: _value ?? '',
      selection: TextSelection.fromPosition(
        TextPosition(
          affinity: TextAffinity.downstream,
          offset: _value.length,
        ),
      ),
    );
  }

  // 发表评论
  Future<void> _submitComment() async {
    if (_value.trim().isEmpty) {
      showToast('还是写点什么吧');
      return;
    }
    Store<AppState> store = StoreProvider.of(context);
    var guestInfo = store.state.guestInfo;
    var userInfo = store.state.userInfo;
    var type = userInfo.uid != null ? 'mkxq' : 'device';
    var openid = userInfo.uid != null ? userInfo.openid : guestInfo.openid;
    var userIdentifier = userInfo.uid != null ? userInfo.uid : guestInfo.uid;
    var userName = userInfo.uid != null ? userInfo.uname : guestInfo.uname;
    var userLevel = userInfo.uid != null ? userInfo.ulevel : guestInfo.ulevel;
    var authorization = userInfo.uid != null
        ? userInfo.authData.authcode
        : guestInfo.authData.authcode;

    var response = await Api.addComment(
      type: type,
      openid: openid,
      authorization: authorization,
      userLevel: userLevel,
      userIdentifier: userIdentifier,
      userName: userName,
      ssid: _satellite.id,
      fatherId: 0,
      satelliteUserId: _satellite.ulevel,
      starId: _satellite.starid,
      content: _value,
      title: _satellite.title,
      images: [],
    );
    if (response['status'] == 1) {
      showToast('正在快马加鞭审核中');
    } else {
      showToast('${response['msg']}');
    }
    setState(() {
      _value = '';
      _textEditingController.value = TextEditingValue(
        text: _value,
      );
      activeEmojiGird = false;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    if (keyboardHeight > 0) {
      activeEmojiGird = false;
    }

    _keyboardHeight = max(_keyboardHeight, keyboardHeight);

    return WillPopScope(
      onWillPop: () async {
        if (showCustomKeyBoard) {
          setState(() {
            activeEmojiGird = false;
          });
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
                                FocusScope.of(context).unfocus();
                                if (activeEmojiGird) {
                                  setState(() {
                                    activeEmojiGird = false;
                                  });
                                }
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
                          Container(
                            constraints: BoxConstraints(
                              minHeight: ScreenUtil().setWidth(100),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(30),
                              vertical: ScreenUtil().setWidth(20),
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey[350],
                                  width: ScreenUtil().setWidth(1),
                                ),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      minHeight: ScreenUtil().setWidth(60),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[350],
                                        width: ScreenUtil().setWidth(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        ScreenUtil().setWidth(8),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: TextField(
                                      // specialTextSpanBuilder:
                                      //     PostSpecialTextSpanBuilder(
                                      //   showAtBackground: true,
                                      //   type: BuilderType.extendedTextField,
                                      // ),

                                      onChanged: (val) {
                                        setState(() {
                                          _value = val;
                                        });
                                      },
                                      controller: _textEditingController,
                                      minLines: 1,
                                      maxLines: 6,
                                      focusNode: _focusNode,
                                      strutStyle: StrutStyle(
                                        forceStrutHeight: true,
                                        fontSize: ScreenUtil().setSp(28),
                                      ),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: ScreenUtil().setSp(28),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: '神评机会近在眼前~',
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontSize: ScreenUtil().setSp(28),
                                          color: Colors.grey[350],
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: ScreenUtil().setWidth(10),
                                          vertical: ScreenUtil().setWidth(10),
                                        ),
                                      ),
                                      //textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    update(() {
                                      setState(() {
                                        activeEmojiGird = true;
                                      });
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(20),
                                    ),
                                    child: Image.asset(
                                      'lib/images/ico_expression.png',
                                      width: ScreenUtil().setWidth(44),
                                      height: ScreenUtil().setWidth(44),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _submitComment,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(20),
                                    ),
                                    child: Text(
                                      '发表',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: ScreenUtil().setSp(32),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: showCustomKeyBoard ? _keyboardHeight : 0.0,
                            child: buildCustomKeyBoard(),
                          )
                        ],
                      ),
              ),
      ),
    );
  }

  Widget buildCustomKeyBoard() {
    if (!showCustomKeyBoard) return Container();
    if (activeEmojiGird) return buildEmojiGird();
    return Container();
  }

  Widget buildEmojiGird() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[300],
            width: ScreenUtil().setWidth(1),
          ),
        ),
      ),
      child: GridView.builder(
        padding: EdgeInsets.all(0.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: ScreenUtil().setWidth(10),
          mainAxisSpacing: 0.0,
        ),
        itemBuilder: (context, index) {
          var key = EmojiUitl.instance.emojiList[index];
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _insertText('$key');
            },
            child: Container(
              child: Center(
                child: Image.asset(
                  EmojiUitl.instance.emojiMap['$key'],
                  width: ScreenUtil().setWidth(60),
                  height: ScreenUtil().setWidth(60),
                ),
              ),
            ),
          );
        },
        itemCount: EmojiUitl.instance.emojiMap.length,
      ),
    );
  }

  void update(Function change) {
    if (showCustomKeyBoard) {
      change();
    } else {
      SystemChannels.textInput.invokeMethod('TextInput.hide').whenComplete(() {
        Future.delayed(Duration(milliseconds: 200)).whenComplete(() {
          change();
        });
      });
    }
  }
}
