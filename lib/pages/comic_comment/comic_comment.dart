import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/common/dao/comment.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/common/model/common_satellite_comment.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/components/comment_sliver_list/comment_sliver_list.dart';
import 'package:flutter_manhuatai/components/comment_text_input/comment_text_input.dart';
import 'package:flutter_manhuatai/components/comment_type_header/comment_type_header.dart';
import 'package:flutter_manhuatai/components/common_sliver_persistent_header_delegate.dart/common_sliver_persistent_header_delegate.dart.dart';
import 'package:flutter_manhuatai/components/request_loading/request_loading.dart';
import 'package:flutter_manhuatai/provider_store/user_info_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ComicCommentPage extends StatefulWidget {
  final String comicId;
  final String comicName;

  ComicCommentPage({
    this.comicId,
    this.comicName,
  });

  @override
  _ComicCommentPageState createState() => _ComicCommentPageState();
}

class _ComicCommentPageState extends State<ComicCommentPage>
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
  GlobalKey<CommentTextInputState> _inputKey;

  int _commentCount = 0;
  List<CommonSatelliteComment> _fatherCommentList;

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
      var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
      var user = userInfoModel.user;
      var userType = user.type;
      var openid = user.openid;
      var authorization = user.authData.authcode;
      var ssid = int.tryParse(widget.comicId);
      // 获取漫画的吐槽总数
      var commentCount = await Api.getCommentCount(
        ssid: ssid,
        ssidType: 0,
      );

      var fatherCommentList = await getCommentListInfo(
        type: _commentType == WhyFarther.hot ? 'hot' : 'new',
        userType: userType,
        openid: openid,
        authorization: authorization,
        ssid: ssid,
        ssidtype: 0,
        isComicComment: true,
      );

      if (!this.mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _commentCount = commentCount;
        _fatherCommentList = fatherCommentList;
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
    var ssid = int.tryParse(widget.comicId);

    var fatherCommentList = await getCommentListInfo(
      type: _commentType == WhyFarther.hot ? 'hot' : 'new',
      userType: userType,
      openid: openid,
      authorization: authorization,
      ssid: ssid,
      ssidtype: 0,
      isComicComment: true,
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
      ssid: int.tryParse(widget.comicId),
      satelliteId: 0,
      ssidType: 0,
      title: widget.comicName,
      opreateId: isReply ? comment.useridentifier : 0,
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
      var ssid = int.tryParse(widget.comicId);

      var fatherCommentList = await getCommentListInfo(
        type: _commentType == WhyFarther.hot ? 'hot' : 'new',
        userType: userType,
        openid: openid,
        authorization: authorization,
        ssid: ssid,
        ssidtype: 0,
        isComicComment: true,
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.comicName),
        centerTitle: false,
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
                                SliverPersistentHeader(
                                  pinned: true,
                                  delegate:
                                      CommonSliverPersistentHeaderDelegate(
                                    height: ScreenUtil().setWidth(80),
                                    child: CommentTypeHeader(
                                      count: _commentCount,
                                      commentType: _commentType,
                                      onSelected: _switchCommentType,
                                    ),
                                  ),
                                ),
                                CommentSliverList(
                                  isReplyDetail: false,
                                  isComicComment: true,
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
    );
  }
}
