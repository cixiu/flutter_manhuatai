import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_manhuatai/components/image_wrapper.dart';
import 'package:flutter_manhuatai/common/refresh_common_state.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/recommend_list.dart' as RecommendList;

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
          ClipOval(
            child: ImageWrapper(
              width: 33.0,
              height: 33.0,
              url: 'https://image.samanlehua.com/3/${item.imgUrl}',
            )
          ),

          ImageWrapper(
            width: MediaQuery.of(context).size.width,
            height: 220.0,
            url: 'https://image.samanlehua.com/${item.imgUrl}',
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        buildItem(this.recommendList.data.book[0].comicInfo),
                  ),
                ],
              ));
  }
}
