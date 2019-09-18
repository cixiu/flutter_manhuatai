import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_manhuatai/components/comment_type_header/comment_type_header.dart';
import 'package:flutter_manhuatai/components/request_loading/request_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/common/model/common_satellite_comment.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/components/comment_content_item/comment_content_item.dart';
import 'package:flutter_manhuatai/components/comment_sliver_list/comment_sliver_list.dart';
import 'package:flutter_manhuatai/components/comment_text_input/comment_text_input.dart';
import 'package:flutter_manhuatai/components/common_sliver_persistent_header_delegate.dart/common_sliver_persistent_header_delegate.dart.dart';
import 'package:flutter_manhuatai/models/comment_user.dart' as CommentUser;

class CommentReplyPage extends StatefulWidget {
  final SatelliteComment fatherComment;
  final String title;

  CommentReplyPage({
    this.fatherComment,
    this.title = '评论回复',
  });

  @override
  _CommentReplyPageState createState() => _CommentReplyPageState();
}

class _CommentReplyPageState extends State<CommentReplyPage>
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

  SatelliteComment _fatherComment;
  List<CommonSatelliteComment> _commentList;

  GlobalKey<CommentTextInputState> _inputKey;

  // 如果是漫画的章节评论，则relationId为comicChapterId, 否则为空
  int get relationId => widget.fatherComment.relateid.isEmpty
      ? 0
      : int.tryParse(widget.fatherComment.relateid);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_listenenScroll);
    _fatherComment = widget.fatherComment;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  void _listenenScroll() {
    bool isBottom = _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
    // 设置页面需要滚动至初始位置的基准距离
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
      var user = User(context);
      var type = user.info.type;
      var openid = user.info.openid;
      var authorization = user.info.authData.authcode;

      // 获取父级评论的详细内容
      var fatherComment = await Api.getCommentContent(
        commentId: widget.fatherComment.id,
        userIdentifier: user.info.uid,
        level: user.info.ulevel,
      );

      var fatherCommentUserRes = await Api.getCommentUser(
        relationId: 0,
        opreateType: 0,
        userids: [widget.fatherComment.useridentifier.toInt()],
      );

      var fatherCommentUser = fatherCommentUserRes.data.first;

      var commentList = await _getCommentListInfo(
        type: type,
        openid: openid,
        authorization: authorization,
        relationId: relationId,
      );

      if (!this.mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        // 构建回复评论页的原始评论
        if (fatherComment.fatherid == null) {
          _fatherComment = widget.fatherComment;
        } else {
          _fatherComment = SatelliteComment.fromJson({
            "id": widget.fatherComment.id,
            "content": fatherComment.content,
            "fatherid": fatherComment.fatherid.toInt(),
            "images": fatherComment.images,
            "ssid": fatherComment.ssid.toInt(),
            "title": fatherComment.title,
            "url": fatherComment.url,
            "ip": widget.fatherComment.ip,
            "place": widget.fatherComment.place,
            "supportcount": fatherComment.supportcount.toInt(),
            "iselite": fatherComment.iselite,
            "istop": fatherComment.istop,
            "status": fatherComment.issupport,
            "revertcount": fatherComment.revertcount.toInt(),
            "useridentifier": fatherComment.useridentifier.toInt(),
            "appid": widget.fatherComment.appid,
            "createtime": fatherComment.createtime,
            "updatetime": fatherComment.updatetime,
            "ssidtype": fatherComment.ssidtype,
            "relateid": fatherComment.relateId,
            'uid': fatherCommentUser.uid,
            'uname': fatherCommentUser.uname,
            'ulevel': fatherCommentUser.ulevel,
            'floor_num': widget.fatherComment.floorNum,
            'floor_desc': widget.fatherComment.floorDesc,
            'createtime': fatherComment.createtime,
            'device_tail': widget.fatherComment.deviceTail,
          });
        }
        _commentList = commentList;
        _inputKey = GlobalKey<CommentTextInputState>();
        if (commentList.length < pageSize) {
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
    var user = User(context);

    var commentList = await _getCommentListInfo(
      type: user.info.type,
      openid: user.info.openid,
      authorization: user.info.authData.authcode,
      relationId: relationId,
    );
    _isLoadingMore = false;

    if (!this.mounted) {
      return;
    }

    setState(() {
      if (commentList.length < pageSize) {
        _hasMore = false;
      }
      _commentList.addAll(commentList);
    });

    print('加载更多');
  }

  // 获取评论列表的相关信息
  Future<List<CommonSatelliteComment>> _getCommentListInfo({
    String type,
    String openid,
    String authorization,
    int relationId,
  }) async {
    var getSatelliteFatherComments = await Api.getSatelliteFatherComments(
      authorization: authorization,
      page: page,
      ssid: widget.fatherComment.ssid,
      fatherid: widget.fatherComment.id,
      type: _commentType == WhyFarther.hot ? 'hot' : 'new', // 用来判断获取哪种类型的评论
      iswater: null,
    );

    List<int> userIds = [];
    if (getSatelliteFatherComments.length == 0) {
      return [];
    } else {
      getSatelliteFatherComments.forEach((comment) {
        var match =
            RegExp(r'{reply:“(\d+)”}').firstMatch(comment.content.trim());
        if (match != null) {
          userIds.add(int.tryParse(match.group(1)));
        }
        if (!userIds.contains(comment.useridentifier)) {
          userIds.add(comment.useridentifier);
        }
      });
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

    if (getSatelliteChildrenCommentsRes.length != 0) {
      getSatelliteChildrenCommentsRes.forEach((comment) {
        var match =
            RegExp(r'{reply:“(\d+)”}').firstMatch(comment.content.trim());
        if (match != null) {
          userIds.add(int.tryParse(match.group(1)));
        }
        if (!userIds.contains(comment.useridentifier)) {
          userIds.add(comment.useridentifier);
        }
      });
    }

    var getCommentUserRes = CommentUser.CommentUser.fromJson({});
    if (userIds.length != 0) {
      getCommentUserRes = await Api.getCommentUser(
        relationId: relationId,
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

    if (getSatelliteChildrenCommentsRes.length != 0) {
      getSatelliteChildrenCommentsRes =
          getSatelliteChildrenCommentsRes.map((child) {
        if (commentUserMap[child.useridentifier] != null) {
          var commentUser = commentUserMap[child.useridentifier];
          child.uid = commentUser.uid;
          child.uname = commentUser.uname;
        }
        return child;
      }).toList();
    }

    return getSatelliteFatherComments.map((item) {
      List<SatelliteComment> childrenCommentList = [];
      Map<int, CommentUser.Data> replyUserMap = {};

      // 将reply格式所匹配到的用户加入Map中
      var fatherMatch =
          RegExp(r'{reply:“(\d+)”}').firstMatch(item.content.trim());
      if (fatherMatch != null) {
        int replyCommentUserId = int.tryParse(fatherMatch.group(1));
        replyUserMap[replyCommentUserId] = commentUserMap[replyCommentUserId];
      }

      if (getSatelliteChildrenCommentsRes.length != 0) {
        getSatelliteChildrenCommentsRes.forEach((child) {
          if (child.fatherid == item.id) {
            childrenCommentList.add(child);
          }

          var match =
              RegExp(r'{reply:“(\d+)”}').firstMatch(child.content.trim());
          if (match != null) {
            int replyCommentUserId = int.tryParse(match.group(1));
            replyUserMap[replyCommentUserId] =
                commentUserMap[replyCommentUserId];
          }
        });
      }

      return CommonSatelliteComment(
        fatherComment: item,
        childrenCommentList: childrenCommentList,
        replyUserMap: replyUserMap,
      );
    }).toList();
  }

  // 回复评论
  Future<void> _submitComment({
    String value,
    bool isReply,
    SatelliteComment comment,
  }) async {
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

    if (isReply) {
      value = '{reply:“${comment.uid}”}$value';
    }
    print(value);

    var response = await Api.addComment(
      type: user.info.type,
      openid: user.info.openid,
      authorization: user.info.authData.authcode,
      userLevel: user.info.ulevel,
      userIdentifier: user.info.uid,
      userName: user.info.uname,
      replyName: isReply ? comment.uname : null,
      ssid: widget.fatherComment.ssid,
      fatherId: widget.fatherComment.id,
      satelliteUserId: isReply ? comment.uid : 0,
      starId: 0,
      content: value,
      title: _fatherComment.title,
      images: [],
      deviceTail: deviceTail,
    );
    if (response['status'] == 1) {
      showToast('正在快马加鞭审核中');
    } else {
      showToast('${response['msg']}');
    }
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
      var user = User(context);

      var fatherCommentList = await _getCommentListInfo(
        type: user.info.type,
        openid: user.info.openid,
        authorization: user.info.authData.authcode,
        relationId: relationId,
      );

      // 如果已经加装到了下一个page, 则切换评论列表的类型后，需要将页面滚动至初始位置
      var scrollTop = _scrollController.position.pixels;
      if (_page > 1 && scrollTop > _maxFirstScrollTop) {
        _scrollController.jumpTo(1.0);
      }

      setState(() {
        if (fatherCommentList.length == 0) {
          _hasMore = false;
        }
        _commentList = fatherCommentList;
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

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('${widget.title}'),
      ),
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
                                SliverToBoxAdapter(
                                  child: CommentContentItem(
                                    needReplyed: false,
                                    isReplyDetail: true,
                                    item: CommonSatelliteComment(
                                      fatherComment: _fatherComment,
                                      childrenCommentList: [],
                                      replyUserMap: Map(),
                                    ),
                                    inputKey: _inputKey,
                                  ),
                                ),
                                SliverPersistentHeader(
                                  pinned: true,
                                  delegate:
                                      CommonSliverPersistentHeaderDelegate(
                                    height: ScreenUtil().setWidth(80),
                                    child: CommentTypeHeader(
                                      count: _fatherComment.revertcount,
                                      commentType: _commentType,
                                      onSelected: _switchCommentType,
                                    ),
                                  ),
                                ),
                                CommentSliverList(
                                  isReplyDetail: true,
                                  fatherCommentList: _commentList,
                                  hasMore: _hasMore,
                                  inputKey: _inputKey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        CommentTextInput(
                          key: _inputKey,
                          hintText: '回复：${_fatherComment.uname}',
                          submit: _submitComment,
                          keyboardHeight: keyboardHeight,
                        ),
                      ],
                    ),
            ),
    );
  }
}
