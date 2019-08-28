import 'dart:async';

import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/common/model/comment_content.dart';
import 'package:flutter_manhuatai/common/model/common_satellite_comment.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/components/comment_content_item/comment_content_item.dart';
import 'package:flutter_manhuatai/components/comment_sliver_list/comment_sliver_list.dart';
import 'package:flutter_manhuatai/components/comment_user_header/comment_user_header.dart';
import 'package:flutter_manhuatai/components/common_sliver_persistent_header_delegate.dart/common_sliver_persistent_header_delegate.dart.dart';
import 'package:flutter_manhuatai/components/post_item/post_special_text_span_builder.dart';
import 'package:flutter_manhuatai/models/comment_user.dart' as CommentUser;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentReplyPage extends StatefulWidget {
  final int commentId;
  final int ssid;
  final int relationId;
  final int floorNum;
  final int commentUserid;
  final String commentUsername;
  final int commentUserlevel;
  final String commentUserdeviceTail;

  CommentReplyPage({
    @required this.commentId,
    @required this.ssid,
    @required this.relationId,
    @required this.floorNum,
    @required this.commentUserid,
    @required this.commentUsername,
    @required this.commentUserlevel,
    this.commentUserdeviceTail,
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

  ScrollController _scrollController = ScrollController();

  CommentContent _fatherComment;
  List<CommonSatelliteComment> _commentList;

  // GlobalKey<CommentTextInputState> _inputKey;

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

      var fatherComment = await Api.getCommentContent(
        commentId: widget.commentId,
        userIdentifier: user.info.uid,
        level: user.info.ulevel,
      );

      var commentList = await _getCommentListInfo(
        type: type,
        openid: openid,
        authorization: authorization,
        relationId: widget.relationId,
      );

      if (!this.mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _fatherComment = fatherComment;
        _commentList = commentList;
        // _inputKey = GlobalKey<CommentTextInputState>();
        if (commentList.length == 0) {
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

    var commentList = await _getCommentListInfo(
      type: user.info.type,
      openid: user.info.openid,
      authorization: user.info.authData.authcode,
      relationId: widget.relationId,
    );
    _isLoadingMore = false;

    if (!this.mounted) {
      return;
    }

    setState(() {
      if (commentList.length == 0) {
        _hasMore = false;
      }
      _commentList.addAll(commentList);
    });

    print('加载更多');
  }

  Future<List<CommonSatelliteComment>> _getCommentListInfo({
    String type,
    String openid,
    String authorization,
    int relationId,
  }) async {
    var getSatelliteFatherComments = await Api.getSatelliteFatherComments(
      authorization: authorization,
      page: page,
      ssid: widget.ssid,
      fatherid: widget.commentId,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              // _inputKey.currentState.blurKeyBoard();
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
                                  title: Text('${widget.floorNum}楼的回复'),
                                  pinned: true,
                                ),
                                // CommentContentItem(
                                //   isReplyDetail: true,
                                //   item: CommonSatelliteComment(
                                //     fatherComment: SatelliteComment()
                                //   ),
                                // ),
                                _buildSliverFatherComment(),
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
                                            '评论 （${_fatherComment.revertcount.toInt()}）',
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
                                CommentSliverList(
                                  isReplyDetail: true,
                                  fatherCommentList: _commentList,
                                  hasMore: _hasMore,
                                  // supportComment: _supportComment,
                                  relationId: widget.relationId,
                                  // inputKey: _inputKey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // CommentTextInput(
                        //   key: _inputKey,
                        //   submit: _submitComment,
                        //   keyboardHeight: keyboardHeight,
                        // ),
                      ],
                    ),
            ),
    );
  }

  Widget _buildSliverFatherComment() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(30),
            ),
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(20),
              bottom: ScreenUtil().setWidth(20),
            ),
            child: CommentUserHeader(
              item: CommentUserHeaderType(
                uid: widget.commentUserid,
                uname: widget.commentUsername,
                ulevel: widget.commentUserlevel,
                floorDesc: '${widget.floorNum}楼',
                createtime: _fatherComment.createtime,
                deviceTail: widget.commentUserdeviceTail,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(130),
              right: ScreenUtil().setWidth(30),
              bottom: ScreenUtil().setWidth(20),
            ),
            child: ExtendedText(
              _fatherComment.content,
              specialTextSpanBuilder: PostSpecialTextSpanBuilder(),
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: ScreenUtil().setSp(28),
              ),
            ),
          ),
          // _buildBottomActionIcons(
          //   context: context,
          //   margin: margin,
          //   item: item,
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: ScreenUtil().setWidth(1),
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(30),
            ),
            color: Colors.grey[350],
          )
        ],
      ),
    );
  }
}
