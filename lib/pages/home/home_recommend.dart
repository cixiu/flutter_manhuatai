import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_manhuatai/components/banner_swipper/banner_swipper.dart';
import 'package:flutter_manhuatai/components/book_item/book_item.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/recommend_list.dart' as RecommendList;
import 'package:flutter_manhuatai/common/const/app_const.dart';

class HomeRecommend extends StatefulWidget {
  // final int currentIndex;

  // HomeRecommend(this.currentIndex);

  _HomeRecommendState createState() => _HomeRecommendState();
}

class _HomeRecommendState extends State<HomeRecommend>
    with
        AutomaticKeepAliveClientMixin,
        RefreshCommonState,
        WidgetsBindingObserver {
  bool isLoading = true;
  RecommendList.RecommendList _recommendList;
  List<RecommendList.Comic_info> _bannerList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
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
          item.bookId == 5072 ||
          item.bookId == 3743;
    });
    setState(() {
      _recommendList = recommendList;
      _bannerList = bannerList;
      isLoading = false;
    });
  }

  List<Widget> buildBookItem() {
    int start = _bannerList.length != 0 ? 1 : 0;
    int lenth = _recommendList.data.book.length;
    List<RecommendList.Book> bookList =
        _recommendList.data.book.getRange(start, lenth).toList();

    return bookList.map((item) {
      return BookItem(
        book: item,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: handleRefrsh,
        child: isLoading
            ? Container()
            : ListView(
                children: <Widget>[
                  this._bannerList.length != 0
                      ? BannerSwipper(
                          bannerList: this._bannerList,
                        )
                      : Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: buildBookItem(),
                  )
                ],
              ));
  }
}
