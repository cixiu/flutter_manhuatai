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
  RecommendList.RecommendList recommendList;

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
    recommendList = RecommendList.RecommendList.fromJson(data);
    recommendList.data.book.removeWhere((item) {
      // 将漫画台漫画头条, 精品小说, 游戏专区, 独家策划的book_id过滤掉
      return item.bookId == 5035 ||
          item.bookId == 4938 ||
          item.bookId == 5072 ||
          item.bookId == 3743;
    });

    setState(() {
      recommendList = recommendList;
      isLoading = false;
    });
    // print(recommendList.data.book[1].title);
  }

  List<Widget> buildItem(List<RecommendList.Book> bookList) {
    return bookList.map((item) {
      return BookItem(book: item,);
    }).toList();
    // return bannerList.take(6).map((item) {
    //   return Column(
    //     children: <Widget>[
    //       Text(),
    //       ImageWrapper(
    //         width: MediaQuery.of(context).size.width,
    //         height: 220.0,
    //         url:
    //             '${AppConst.img_host}/${item.imgUrl}${AppConst.imageSizeSuffix.defaultSuffix}',
    //       ),

    //       // Image.network('https://image.samanlehua.com/${item.imgUrl}', height: 200.0, color: Colors.grey,),
    //       Text('${item.comicName}'),
    //     ],
    //   );
    // }).toList();
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
                  BannerSwipper(
                    bannerList: this
                        .recommendList
                        .data
                        .book[0]
                        .comicInfo
                        .take(6)
                        .toList(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        buildItem(this.recommendList.data.book.getRange(1, this.recommendList.data.book.length).toList()),
                  )
                ],
              ));
  }
}
