import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/models/rank_types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComicRankPage extends StatefulWidget {
  final String type;

  ComicRankPage({
    Key key,
    this.type,
  }) : super(key: key);

  @override
  _ComicRankPageState createState() => _ComicRankPageState();
}

class _ComicRankPageState extends State<ComicRankPage> with RefreshCommonState {
  String _sortType = '';
  bool _isLoading = true;

  List<Sort_type_list> _sortTypeList;

  @override
  void initState() {
    super.initState();
    _sortType = widget.type;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  Future<void> onRefresh() async {
    var _getRankTypesRes = await Api.getRankTypes();
    setState(() {
      _sortTypeList = _getRankTypesRes.data.sortTypeList;
      _isLoading = false;
    });
  }

  Future<void> _selectSortType(Sort_type_list item) async {
    setState(() {
      _sortType = item.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        title: Text(
          '排行榜',
          style: TextStyle(
            color: Colors.black87,
            fontSize: ScreenUtil().setSp(32),
          ),
        ),
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: onRefresh,
        child: _isLoading
            ? Container()
            : CustomScrollView(
                physics: ClampingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      GridView.count(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20),
                        ),
                        shrinkWrap: true,
                        crossAxisCount: _sortTypeList.length ~/ 2,
                        childAspectRatio: 2,
                        children: _buildSortTypeListWidget(),
                      ),
                    ]),
                  ),
                ],
              ),
      ),
    );
  }

  List<Widget> _buildSortTypeListWidget() {
    TextStyle style = TextStyle(
      color: Colors.grey[600],
      fontSize: ScreenUtil().setSp(28),
    );
    TextStyle activeStyle = TextStyle(
      color: Colors.blue,
      fontSize: ScreenUtil().setSp(28),
      fontWeight: FontWeight.w600,
    );

    return _sortTypeList.map((item) {
      return GestureDetector(
        onTap: () {
          _selectSortType(item);
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            item.value,
            style: item.name == _sortType ? activeStyle : style,
          ),
        ),
      );
    }).toList();
  }
}
