import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/manhuatai_focus.dart';
import 'components/manhuatai_recommend.dart';
import 'components/manhuatai_tab_bar.dart';

class HomeManhuatai extends StatefulWidget {
  @override
  _HomeManhuataiState createState() => _HomeManhuataiState();
}

class _HomeManhuataiState extends State<HomeManhuatai>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  onChangeIndex(int index) {
    _controller.animateToPage(
      index,
      duration: Duration(
        milliseconds: 250,
      ),
      curve: Curves.ease,
    );
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ScreenUtil().setWidth(86)),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          brightness: Brightness.light,
          title: ManhuataiTabBar(
            _currentIndex,
            onChangeIndex,
          ),
        ),
      ),
      body: PageView(
        physics: ClampingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: _controller,
        children: <Widget>[
          ManhuataiRecommend(),
          ManhuataiFocus(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
