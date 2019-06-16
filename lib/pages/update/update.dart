import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/pages/update/components/update_list_view.dart';

class HomeUpdate extends StatefulWidget {
  @override
  _HomeUpdateState createState() => _HomeUpdateState();
}

class _HomeUpdateState extends State<HomeUpdate>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      initialIndex: 6,
      length: 7,
    );
    tabController.addListener(_tabControllerListener);
  }

  // 监听tabBar的切换
  void _tabControllerListener() {
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
    var len = 7;
    List<String> dateList = List(len);
    var weekday = DateTime.now().weekday;

    dateList[0] = AppConst.weekdayString[(weekday + 1) % len];
    dateList[1] = AppConst.weekdayString[(weekday + 2) % len];
    dateList[2] = AppConst.weekdayString[(weekday + 3) % len];
    dateList[3] = AppConst.weekdayString[(weekday + 4) % len];
    dateList[4] = AppConst.weekdayString[(weekday + 5) % len];
    dateList[5] = '昨日';
    dateList[6] = '今日';

    var statusBarHeight = MediaQuery.of(context).padding.top;
    var tabBarHeight = ScreenUtil().setWidth(40);
    var toolBarHeight = statusBarHeight + tabBarHeight;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(toolBarHeight),
        child: Column(
          children: <Widget>[
            Container(
              height: statusBarHeight,
            ),
            Expanded(
              child: TabBar(
                controller: tabController,
                indicatorColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.blue,
                labelPadding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setWidth(20),
                  horizontal: 0.0,
                ),
                unselectedLabelColor: Colors.grey[800],
                labelStyle: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: ScreenUtil().setWidth(24),
                ),
                tabs: _buildTabs(dateList),
              ),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: _buildTabBarViews(dateList),
      ),
    );
  }

  List<Widget> _buildTabs(List<String> dateList) {
    return dateList.map((item) {
      return Text(item);
    }).toList();
  }

  List<Widget> _buildTabBarViews(List<String> dateList) {
    List<Widget> _children = [];
    for (int i = 0; i < dateList.length; i++) {
      _children.add(UpdateListView(
        index: i,
      ));
    }
    return _children;
  }
}
