import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/refresh_loading.dart';

class HomeRecommend extends StatefulWidget {
  // final int currentIndex;

  // HomeRecommend(this.currentIndex);

  _HomeRecommendState createState() => _HomeRecommendState();
}

class _HomeRecommendState extends State<HomeRecommend> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('初始化推荐页面');
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // print('build Recomment .....................');
    return Container(
      child: Text('推荐22222222222222222222222222222222222222222222222222222222222222'),
    );
  }
}
