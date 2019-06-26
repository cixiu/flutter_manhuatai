import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/utils/sp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/hot_search.dart';
import 'package:flutter_manhuatai/models/search_comic.dart' as SearchComic;
import 'components/search_app_bar.dart';
import 'components/search_history.dart';
import 'components/search_suggest_list.dart';

class ComicSearchPage extends StatefulWidget {
  @override
  _ComicSearchPageState createState() => _ComicSearchPageState();
}

class _ComicSearchPageState extends State<ComicSearchPage>
    with RefreshCommonState, WidgetsBindingObserver {
  bool _isLoading = true;
  TextEditingController _searchController;
  List<HotSearch> _hotSearchList;
  List<String> _searchHistoryList = [];
  String _searchKey = '';
  Timer _timer;
  List<SearchComic.Data> _suggestList = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController?.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSearchHistoryList();
  }

  Future<void> handleRefresh() async {
    await _getHotSearch();
  }

  Future<void> _getHotSearch() async {
    var _getHotSearch = await Api.getHotSearch();
    var searchHistoryList = await SpUtils.loadSearchHistory();
    if (!this.mounted) {
      return;
    }

    setState(() {
      _hotSearchList = _getHotSearch;
      _searchHistoryList = searchHistoryList;
      _isLoading = false;
    });
  }

  // 输入时触发搜索
  Future<void> _inputChange(String val) async {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: 300), () async {
      // setState(() {});
      var _searchComic = await Api.searchComic(val);
      setState(() {
        _searchKey = val;
        _suggestList = _searchComic.data;
      });
    });
  }

  void _navigateToSearchResultPage(BuildContext context, String query) {
    String keyword = Uri.encodeComponent(query);
    Application.router
        .navigateTo(context, '${Routes.searchResult}?keyword=$keyword');
    SpUtils.saveSearchHistory(query);
  }

  // 更新搜索历史
  void _updateSearchHistoryList() async {
    var searchHistoryList = await SpUtils.loadSearchHistory();
    setState(() {
      _searchHistoryList = searchHistoryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = ScreenUtil().setWidth(80);

    TextStyle commonStyle = TextStyle(
      color: Colors.black,
      fontSize: ScreenUtil().setSp(28),
      fontWeight: FontWeight.normal,
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          appBarHeight,
        ),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          brightness: Brightness.light,
          title: SearchAppBar(
            controller: _searchController,
            searchKey: _searchKey,
            onChange: (val) {
              _inputChange(val);
            },
            close: () {
              setState(() {
                _searchController.value = TextEditingValue(text: '');
                _searchKey = '';
              });
            },
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // 使键盘失焦
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: handleRefresh,
          child: _isLoading
              ? Container()
              : _searchKey.isNotEmpty
                  ? _suggestList.length == 0
                      ? Center(
                          child: Text(
                            '没有搜索到任何内容哦~~',
                            style: commonStyle,
                          ),
                        )
                      : SearchSuggestList(
                          searchKey: _searchKey,
                          suggestList: _suggestList,
                        )
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
                                spacing: ScreenUtil().setWidth(36),
                                runSpacing: ScreenUtil().setWidth(25),
                                children: _buildHotSearchList(),
                              ),
                            ),
                          ],
                        ),
                        _searchHistoryList.length == 0
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(
                                  top: ScreenUtil().setWidth(20),
                                ),
                                child: SearchHistory(
                                  historyList: _searchHistoryList,
                                  update: _updateSearchHistoryList,
                                ),
                              ),
                      ],
                    ),
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
        GestureDetector(
          onTap: () {
            _navigateToSearchResultPage(context, item.comicName);
          },
          child: Container(
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
              item.comicName,
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
        ),
      );
    }

    return _children;
  }
}
