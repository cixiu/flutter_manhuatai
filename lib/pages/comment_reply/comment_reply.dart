import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/dao/comment.dart';
import 'package:flutter_manhuatai/components/comment_type_header/comment_type_header.dart';
import 'package:flutter_manhuatai/components/request_loading/request_loading.dart';
import 'package:flutter_manhuatai/provider_store/user_info_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/common/model/common_satellite_comment.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/components/comment_content_item/comment_content_item.dart';
import 'package:flutter_manhuatai/components/comment_sliver_list/comment_sliver_list.dart';
import 'package:flutter_manhuatai/components/comment_text_input/comment_text_input.dart';
import 'package:flutter_manhuatai/components/common_sliver_persistent_header_delegate.dart/common_sliver_persistent_header_delegate.dart.dart';
import 'package:provider/provider.dart';

class CommentReplyPage extends StatefulWidget {
  final SatelliteComment fatherComment;
  final String title;
  final bool isComicComment;

  CommentReplyPage({
    this.fatherComment,
    this.title = '评论回复',
    this.isComicComment = false,
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
      var user = Provider.of<UserInfoModel>(context, listen: false).user;
      var userType = user.type;
      var openid = user.openid;
      var authorization = user.authData.authcode;

      // 获取父级评论的详细内容
      var fatherComment = await Api.getCommentContent(
        commentId: widget.fatherComment.id,
        userIdentifier: user.uid,
        level: user.ulevel,
      );

      var fatherCommentUserRes = await Api.getCommentUser(
        relationId: 0,
        opreateType: 0,
        userids: [widget.fatherComment.useridentifier.toInt()],
      );

      var fatherCommentUser = fatherCommentUserRes.data.first;

      var commentList = await getCommentListInfo(
        type: _commentType == WhyFarther.hot ? 'hot' : 'new',
        userType: userType,
        openid: openid,
        authorization: authorization,
        ssid: widget.fatherComment.ssid,
        ssidtype: widget.isComicComment ? 0 : 1,
        fatherid: widget.fatherComment.id,
        isComicComment: widget.isComicComment,
        page: page,
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
    var user = Provider.of<UserInfoModel>(context, listen: false).user;
    var userType = user.type;
    var openid = user.openid;
    var authorization = user.authData.authcode;

    var commentList = await getCommentListInfo(
      type: _commentType == WhyFarther.hot ? 'hot' : 'new',
      userType: userType,
      openid: openid,
      authorization: authorization,
      ssid: widget.fatherComment.ssid,
      ssidtype: widget.isComicComment ? 0 : 1,
      fatherid: widget.fatherComment.id,
      isComicComment: widget.isComicComment,
      page: page,
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

  // 回复评论
  Future<void> _submitComment({
    String value,
    bool isReply,
    SatelliteComment comment,
  }) async {
    await addComment(
      context: context,
      value: value,
      isReplyDetail: true,
      isReply: isReply,
      comment: comment,
      fatherId: widget.fatherComment.id,
      ssid: widget.fatherComment.ssid,
      ssidType: widget.isComicComment ? 0 : 1,
      title: _fatherComment.title,
      opreateId: isReply ? comment.useridentifier : 0,
      starId: 0,
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
        ssid: widget.fatherComment.ssid,
        ssidtype: widget.isComicComment ? 0 : 1,
        fatherid: widget.fatherComment.id,
        isComicComment: widget.isComicComment,
        page: page,
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
