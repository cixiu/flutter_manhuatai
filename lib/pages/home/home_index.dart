import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import './home_rank.dart';
import './home_recommend.dart';

import 'package:flutter_manhuatai/routes/application.dart';

// import 'package:flutter_manhuatai/api/api.dart';

class HomeIndex extends StatefulWidget {
  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController tabController;
  bool hasLoadRecomment = false;

  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, initialIndex: 1, length: 2);
    tabController.addListener(_tabControllerListener);
  }

  // 监听tabBar的切换
  _tabControllerListener() {
    print('当前tabIndex ${tabController.index}');
    if (tabController.index != tabController.previousIndex) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    this.tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          title: Container(
            width: MediaQuery.of(context).size.width,
            height: 30.0,
            color: Colors.grey,
            child: Text('搜索框，进入搜索页'),
          ),
          // flexibleSpace: Container(
          //   color: Colors.greenAccent,
          // ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: Container(
              color: Colors.blue,
              height: 30.0,
              child: TabBar(
                controller: tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 12.5),
                labelStyle: TextStyle(fontSize: 16.0),
                // indicatorSize: TabBarIndicatorSize.label,
                // isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    child: Text('排行'),
                  ),
                  Tab(
                    child: Text('推荐'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[HomeRank(), HomeRecommend()],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Test'),
        onPressed: () {
          Application.router.navigateTo(context, '/test',
              transition: TransitionType.inFromRight);
        },
      ),
    );
  }
}
