import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/bookshelf_user_collects.dart';
import 'components/bookshelf_user_reads.dart';

class HomeBookshelf extends StatefulWidget {
  @override
  _HomeBookshelfState createState() => _HomeBookshelfState();
}

class _HomeBookshelfState extends State<HomeBookshelf>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('我的书架'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: ScreenUtil().setWidth(60),
            child: TabBar(
              controller: _tabController,
              labelPadding: const EdgeInsets.symmetric(horizontal: 12.5),
              labelStyle: TextStyle(
                fontSize: ScreenUtil().setSp(32),
              ),
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  child: Text('订阅'),
                ),
                Tab(
                  child: Text('历史'),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                BookshelfUserCollects(),
                BookshelfUserReads(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
