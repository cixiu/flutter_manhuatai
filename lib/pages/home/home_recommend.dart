import 'package:flutter/material.dart';

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
    var recommendList =  RecommendList.RecommendList.fromJson(data);
    print(data['data']['book'][0]['comic_info'][0]['total_view_num'].runtimeType);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build Recomment .....................');
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: handleRefrsh,
      child: isLoading
          ? Container()
          : ListView.builder(
              itemCount: 1000,
              itemBuilder: (context, index) {
                return Text('这是第 $index 个item');
              },
            ),
    );
  }
}
