import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_manhuatai/components/image_wrapper.dart';
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
    setState(() {
      recommendList = RecommendList.RecommendList.fromJson(data);
      isLoading = false;
    });
  }

  List<Widget> buildItem(List<RecommendList.Comic_info> bannerList) {
    return bannerList.take(6).map((item) {
      return Column(
        children: <Widget>[
          ImageWrapper(
            width: MediaQuery.of(context).size.width,
            height: 220.0,
            url:
                '${AppConst.img_host}/${item.imgUrl}${AppConst.imageSizeSuffix.defaultSuffix}',
          ),

          // Image.network('https://image.samanlehua.com/${item.imgUrl}', height: 200.0, color: Colors.grey,),
          Text('${item.comicName}'),
        ],
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
                  SizedBox(
                    height: 236.0,
                    child: Swiper(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            ImageWrapper(
                              url:
                                  '${AppConst.img_host}/${this.recommendList.data.book[0].comicInfo[index].imgUrl}${AppConst.imageSizeSuffix.defaultSuffix}',
                              width: MediaQuery.of(context).size.width,
                              height:
                                  236.0 - 36.0,
                              fit: BoxFit.fill,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(this
                                        .recommendList
                                        .data
                                        .book[0]
                                        .comicInfo[index]
                                        .comicName),
                                    Text(this
                                        .recommendList
                                        .data
                                        .book[0]
                                        .comicInfo[index]
                                        .lastComicChapterName,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey[500],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      // itemWidth: MediaQuery.of(context).size.width,
                      itemHeight: 236.0,
                      pagination: SwiperPagination(
                          margin: const EdgeInsets.only(bottom: 46.0)),
                      // controller: SwiperController(),
                      autoplay: true,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        buildItem(this.recommendList.data.book[0].comicInfo),
                  )
                ],
              ));
  }
}
