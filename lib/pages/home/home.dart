import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'package:flutter_manhuatai/pages/home/home_index.dart';
import 'package:flutter_manhuatai/pages/update/update.dart';
import 'package:flutter_manhuatai/pages/manhuatai/manhuatai.dart';
import 'package:flutter_manhuatai/pages/bookshelf/bookshelf.dart';
import 'package:flutter_manhuatai/pages/mine/mine.dart';

import 'package:flutter_manhuatai/components/bottom_navigation/bottom_navigation.dart';

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);
  List<Widget> pages = List();

  DateTime _lastPopTime; // 记录上次点击退出的时间

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    pages
      ..add(HomeIndex())
      ..add(HomeUpdate())
      ..add(HomeManhuatai())
      ..add(HomeBookshelf())
      ..add(HomeMine());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  onChangeIndex(int index) {
    _controller.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WillPopScope(
      onWillPop: () {
        if (_currentIndex != 0) {
          onChangeIndex(0);
          return Future.value(false);
        }

        if (_lastPopTime == null ||
            DateTime.now().difference(_lastPopTime) >
                Duration(milliseconds: 1500)) {
          showToast('再按一次退出');
          _lastPopTime = DateTime.now();
          return Future.value(false);
        }

        return Future.value(true);
      },
      child: Scaffold(
        body: PageView(
          controller: _controller,
          children: pages,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigation(
          currentIndex: _currentIndex,
          onChangeIndex: onChangeIndex,
        ),
      ),
    );
  }
}
