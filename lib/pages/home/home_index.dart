import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import './home_rank.dart';
import './home_recommend.dart';

import 'package:flutter_manhuatai/components/refresh_loading.dart';
import 'package:flutter_manhuatai/routes/application.dart';

import 'package:flutter_manhuatai/api/api.dart';

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
    // _getRecommentList();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   new Future.delayed(const Duration(seconds: 0), () {
  //     print('------------------ showRefreshLoading ------------------');
  //     start_time = DateTime.now().millisecondsSinceEpoch;
  //     refreshKey.currentState.show().then((e) {});
  //     // return true;
  //   });
  //   print('afterrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
  // }

  // 监听tabBar的切换
  _tabControllerListener() {
    print('当前tabIndex ${tabController.index}');
    // print(tabController.previousIndex);
    if (tabController.index != tabController.previousIndex) {
      setState(() {
        // _currentIndex = '排行';
      });
    }
  }

  // Future<void> _getRecommentList() async {

  //   var data = await Api.getRecommentList();
  //   print('RefreshIndicator显示的时间 ${DateTime.now().millisecondsSinceEpoch - start_time}');
  //   print(data);
  //   setState(() {
  //     hasLoadRecomment = true;
  //   });

    // Future.delayed(Duration(milliseconds: 0)).then((res1) async {
      
    // });
  // }

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
            height: 30.0,
            color: Colors.grey,
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
                  // Tab(
                  //   child: Text('日更'),
                  // ),
                  // Tab(
                  //   child: Text('后宫'),
                  // ),
                  // Tab(
                  //   child: Text('萝莉'),
                  // ),
                  // Tab(
                  //   child: Text('玄幻'),
                  // ),
                  // Tab(
                  //   child: Text('漫改'),
                  // ),
                  // Tab(
                  //   child: Text('社会'),
                  // ),
                  // Tab(
                  //   child: Text('生活'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          HomeRank(),
          HomeRecommend()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Test'),
        onPressed: () {
          Application.router.navigateTo(context, '/test', transition: TransitionType.inFromRight);
        },
      ),
    );
  }
}
