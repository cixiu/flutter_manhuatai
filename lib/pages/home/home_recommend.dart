import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/pull_load_wrapper/pull_load_wrapper.dart';
import 'package:flutter_manhuatai/components/banner_swipper/banner_swipper.dart';
import 'package:flutter_manhuatai/components/book_item/book_item.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/recommend_list.dart' as RecommendList;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('HomeRecommend didChangeDependencies');
  }

  @override
  void didUpdateWidget(HomeRecommend oldWidget) {
    super.didUpdateWidget(oldWidget);
    // print('更新推荐页面数据');
  }

  Future<void> handleRefrsh() async {
    Map<String, dynamic> data = await Api.getRecommentList();
    RecommendList.RecommendList recommendList =
        RecommendList.RecommendList.fromJson(data);
    // bookId == 7414 代表bannerList
    List<RecommendList.Comic_info> bannerList =
        recommendList.data.book[0].title.contains('安卓')
            ? recommendList.data.book[0].comicInfo.take(6).toList()
            : [];

    recommendList.data.book.removeWhere((item) {
      // 将漫画台漫画头条, 精品小说, 游戏专区, 独家策划的book_id过滤掉
      return item.bookId == 5035 ||
          item.bookId == 4938 ||
          item.bookId == 6669 ||
          item.bookId == 5072 ||
          item.bookId == 3743 ||
          item.bookId == 9669 ||
          item.bookId == 8833;
    });

    int start = bannerList.length != 0 ? 1 : 0;
    int length = recommendList.data.book.length;
    var bookList = recommendList.data.book.getRange(start, length).where((book) {
      return book.config.displayType != 20;
    }).toList();

    setState(() {
      _bannerList = bannerList;
      _bookList = bookList;
      recommendPageControl.dataListLength = bookList.length;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PullLoadWrapper(
      refreshKey: refreshIndicatorKey,
      control: recommendPageControl,
      isFirstLoading: isLoading,
      onRefresh: handleRefrsh,
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
