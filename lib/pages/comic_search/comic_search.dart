import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/models/hot_search.dart' as HotSearch;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/search_app_bar.dart';

class ComicSearchPage extends StatefulWidget {
  @override
  _ComicSearchPageState createState() => _ComicSearchPageState();
}

class _ComicSearchPageState extends State<ComicSearchPage>
    with RefreshCommonState, WidgetsBindingObserver {
  bool _isLoading = true;
  List<HotSearch.Data> _hotSearchList;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  Future<void> handleRefresh() async {
    await _getHotSearch();
  }

  Future<void> _getHotSearch() async {
    var _getHotSearch = await Api.getHotSearch();
    print(_getHotSearch);
    setState(() {
      _hotSearchList = _getHotSearch.data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var appBarHeight = ScreenUtil().setWidth(40);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          statusBarHeight + appBarHeight,
        ),
        child: SearchAppBar(),
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: handleRefresh,
        child: _isLoading
            ? Container()
            : ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: ScreenUtil().setWidth(86),
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300],
                              width: ScreenUtil().setWidth(1),
                            ),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '大家都在搜',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: ScreenUtil().setSp(32),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(36),
                          left: ScreenUtil().setWidth(36),
                          right: ScreenUtil().setWidth(36),
                        ),
                        child: Wrap(
                          spacing: ScreenUtil().setWidth(50),
                          runSpacing: ScreenUtil().setWidth(25),
                          children: _buildHotSearchList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  // 构建热门搜索列表
  List<Widget> _buildHotSearchList() {
    Color color1 = Color.fromRGBO(253, 126, 247, 1);
    Color bgColor1 = Color.fromRGBO(253, 126, 247, 0.1);

    Color color2 = Color.fromRGBO(40, 211, 231, 1);
    Color bgColor2 = Color.fromRGBO(40, 211, 231, 0.1);

    Color color3 = Color.fromRGBO(129, 209, 31, 1);
    Color bgColor3 = Color.fromRGBO(129, 209, 31, 0.1);

    Color color4 = Color.fromRGBO(73, 175, 251, 1);
    Color bgColor4 = Color.fromRGBO(73, 175, 251, 0.1);

    Color color5 = Color.fromRGBO(255, 190, 26, 1);
    Color bgColor5 = Color.fromRGBO(255, 190, 26, 0.1);

    Color color6 = Color.fromRGBO(233, 124, 112, 1);
    Color bgColor6 = Color.fromRGBO(233, 124, 112, 0.1);

    List<Widget> _children = [];
    int len = _hotSearchList.length;
    for (int i = 0; i < len; i++) {
      var item = _hotSearchList[i];
      Color color;
      Color bgColor;

      if (i % 6 == 0) {
        color = color1;
        bgColor = bgColor1;
      }
      if (i % 6 == 1) {
        color = color2;
        bgColor = bgColor2;
      }
      if (i % 6 == 2) {
        color = color3;
        bgColor = bgColor3;
      }
      if (i % 6 == 3) {
        color = color4;
        bgColor = bgColor4;
      }
      if (i % 6 == 4) {
        color = color5;
        bgColor = bgColor5;
      }
      if (i % 6 == 5) {
        color = color6;
        bgColor = bgColor6;
      }

      _children.add(
        Container(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setWidth(15),
            horizontal: ScreenUtil().setWidth(20),
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(
              ScreenUtil().setWidth(30),
            ),
          ),
          child: Text(
            item.name,
            strutStyle: StrutStyle(
              forceStrutHeight: true,
              fontSize: ScreenUtil().setWidth(26),
            ),
            style: TextStyle(
              color: color,
              fontSize: ScreenUtil().setWidth(26),
            ),
          ),
        ),
      );
    }

    return _children;
  }
}
