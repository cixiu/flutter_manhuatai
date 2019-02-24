import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

import 'package:flutter_manhuatai/api/api.dart';

class HomeRank extends StatefulWidget {
  // final int currentIndex;

  // HomeRank(this.currentIndex);

  _HomeRankState createState() => _HomeRankState();
}

class _HomeRankState extends State<HomeRank>
    with AutomaticKeepAliveClientMixin, RefreshCommonState<HomeRank> {
  bool isFirstShow = true;
  bool isLoading = true;
  String title = '排行页';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('初始化排行页面');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('HomeRank didChangeDependencies');
  }

  @override
  void didUpdateWidget(HomeRank oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('更新排行页面数据');
    if (isFirstShow) {
      print('在这里发送http请求');
      setState(() {
        isFirstShow = false;
      });
      // 显示下拉刷新的Indicator, 只需RefrshIndicator的onRefresh函数
      showRefreshLoading();
    }
  }

  Future<void> handleRefrsh() async {
    var response = await Api.getRankList();
    print(response);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build Rank ..................');
    if (isFirstShow) {
      return Container(
        color: Colors.red,
      );
    }

    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: handleRefrsh,
      child: isLoading ? Container() : ListView.builder(
        itemCount: 1000,
        itemBuilder: (context, index) {
          return Text('这是第 $index 个item');
        },
      ),
    );
  }
}
