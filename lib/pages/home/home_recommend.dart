import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/const/user.dart';

import 'package:flutter_manhuatai/components/pull_load_wrapper/pull_load_wrapper.dart';
import 'package:flutter_manhuatai/components/banner_swipper/banner_swipper.dart';
import 'package:flutter_manhuatai/components/book_item/book_item.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/book_list.dart' as RecommendList;

// TODO: 动态漫画的展示

class HomeRecommend extends StatefulWidget {
  @override
  _HomeRecommendState createState() => _HomeRecommendState();
}

class _HomeRecommendState extends State<HomeRecommend>
    with
        AutomaticKeepAliveClientMixin,
        RefreshCommonState,
        WidgetsBindingObserver {
  final recommendPageControl = PullLoadWrapperControl();
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  // 是否根据用户的喜欢来获取推荐列表
  bool _isStreamingLoad = false;
  bool isLoading = true;
  List<RecommendList.Book> _bookList;
  List<RecommendList.Comic_info> _bannerList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // 需要头部
    recommendPageControl.needHeader = true;
    // 需要加载更多
    recommendPageControl.needLoadMore = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  Future<void> handleRefrsh() async {
    var bookList = await _getRecommendList(page: 1);

    setState(() {
      _currentPage = 1;
      _bookList = bookList;
      recommendPageControl.dataListLength = bookList.length;
      recommendPageControl.needLoadMore = true;
      isLoading = false;
      _hasMore = true;
      _isLoadingMore = false;
      _isStreamingLoad = false;
    });
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) {
      return;
    }
    _isLoadingMore = true;
    _currentPage++;
    List<RecommendList.Book> bookList = [];

    if (!_isStreamingLoad) {
      bookList = await _getRecommendList(page: _currentPage);
      if (bookList.length == 0) {
        _isStreamingLoad = true;
      }
    }

    if (_isStreamingLoad) {
      bookList = await _getRecommendList(page: _currentPage, isStreaming: true);
    }

    setState(() {
      _isLoadingMore = false;
      _bookList.addAll(bookList);
      recommendPageControl.dataListLength += bookList.length;
      // 最多显示 200 条书籍类目
      if (bookList.length == 0 || _bookList.length > 200) {
        recommendPageControl.needLoadMore = false;
        _hasMore = false;
      }
    });
  }

  Future<List<RecommendList.Book>> _getRecommendList({
    int page,
    bool isStreaming = false,
  }) async {
    var user = User(context);
    RecommendList.BookList recommendList;
    if (isStreaming) {
      recommendList = await Api.getRecommendStreamingList(
        userId: user.info.uid,
      );
    } else {
      recommendList = await Api.getRecommenNewList(
        userId: user.info.uid,
        page: page,
      );
    }
    // 漫画台安卓男样式
    List<RecommendList.Comic_info> bannerList = [];
    List<int> bannerBookIdList = [];
    recommendList.data.book.forEach((book) {
      if (page == 1 && book.title.contains('安卓')) {
        print(book.title);
        // bannerList = book.comicInfo.take(6).toList();
        bannerList = book.comicInfo.where((item) => item.url.isEmpty).toList();
        bannerBookIdList.add(book.bookId);
        setState(() {
          _bannerList = bannerList;
        });
      }
    });

    recommendList.data.book.removeWhere((item) {
      // 将漫画台漫画头条, 精品小说, 游戏专区, 独家策划的book_id过滤掉
      // TODO:暂时先过滤点动态漫modularType = 2
      return bannerBookIdList.contains(item.bookId) ||
          item.modularType == 2 ||
          item.bookId == 485437 ||
          item.bookId == 485438 ||
          item.bookId == 486467 ||
          item.bookId == 486455 ||
          item.bookId == 5035 ||
          item.bookId == 4938 ||
          item.bookId == 6669 ||
          item.bookId == 5072 ||
          item.bookId == 3743 ||
          item.bookId == 9669 ||
          item.bookId == 8833;
    });

    return recommendList.data.book.where((book) {
      return book.config.displayType != 20;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PullLoadWrapper(
      refreshKey: refreshIndicatorKey,
      control: recommendPageControl,
      isFirstLoading: isLoading,
      onRefresh: handleRefrsh,
      onLoadMore: loadMore,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _bannerList.length != 0
              ? BannerSwipper(
                  bannerList: _bannerList,
                )
              : Container();
        } else {
          return BookItem(book: _bookList[index - 1]);
        }
      },
    );
  }
}
