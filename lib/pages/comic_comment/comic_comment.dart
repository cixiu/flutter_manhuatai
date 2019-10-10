import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/common/dao/comment.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/common/model/common_satellite_comment.dart';
import 'package:flutter_manhuatai/components/comment_sliver_list/comment_sliver_list.dart';
import 'package:flutter_manhuatai/components/comment_type_header/comment_type_header.dart';
import 'package:flutter_manhuatai/components/common_sliver_persistent_header_delegate.dart/common_sliver_persistent_header_delegate.dart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComicCommentPage extends StatefulWidget {
  final String comicId;

  ComicCommentPage({
    this.comicId,
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
      // loadMore();
    }
  }

  Future<void> _handleRefresh() async {
    try {
      page = 1;
      _hasMore = true;
      _maxFirstScrollTop = null;
      var user = User(context);
      var userType = user.info.type;
      var openid = user.info.openid;
      var authorization = user.info.authData.authcode;
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
      );

      if (!this.mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _commentCount = commentCount;
        _fatherCommentList = fatherCommentList;
        // _inputKey = GlobalKey<CommentTextInputState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('漫画名称'),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: _isLoading
            ? Container()
            : Column(
                children: <Widget>[
                  Expanded(
                    child: CustomScrollView(
                      physics: ClampingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      controller: _scrollController,
                      slivers: <Widget>[
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: CommonSliverPersistentHeaderDelegate(
                            height: ScreenUtil().setWidth(80),
                            child: CommentTypeHeader(
                              count: _commentCount,
                              commentType: _commentType,
                              // onSelected: _switchCommentType,
                            ),
                          ),
                        ),
                        CommentSliverList(
                          isReplyDetail: false,
                          fatherCommentList: _fatherCommentList,
                          hasMore: _hasMore,
                          // inputKey: _inputKey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
