import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './home_rank.dart';
import './home_recommend.dart';

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
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          ScreenUtil().setWidth(140),
        ),
        child: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.blue,
          brightness: Brightness.dark,
          title: GestureDetector(
            onTap: () {
              Application.router.navigateTo(context, '${Routes.comicSearch}');
            },
            child: Container(
              width: ScreenUtil().setWidth(600),
              height: ScreenUtil().setWidth(60),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
              ),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '请输入漫画名或其他关键词',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: ScreenUtil().setSp(24),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    size: ScreenUtil().setWidth(36),
                    color: Colors.white54,
                  ),
                ],
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              ScreenUtil().setWidth(60),
            ),
            child: Container(
              color: Colors.blue,
              height: ScreenUtil().setWidth(60),
              child: TabBar(
                controller: tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 12.5),
                labelStyle: TextStyle(fontSize: 16.0),
                indicatorColor: Colors.white,
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
        children: [
          HomeRank(),
          HomeRecommend(),
        ],
      ),
    );
  }
}
