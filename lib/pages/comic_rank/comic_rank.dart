import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/models/rank_data_detials.dart'
    as RankDataDetials;
import 'package:flutter_manhuatai/models/rank_types.dart';

import 'components/comic_rank_item.dart';

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
  bool _isSelecting = false; // 是否正在切换排行榜类型

  List<Sort_type_list> _sortTypeList;
  List<RankDataDetials.Data> _sortDataList;

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
    await _getRankDataDetials();
    setState(() {
      _sortTypeList = _getRankTypesRes.data.sortTypeList;
      _isLoading = false;
    });
  }

  // 选择排行榜类型
  Future<void> _selectSortType(Sort_type_list item) async {
    setState(() {
      _sortType = item.name;
    });
    await _getRankDataDetials();
  }

  // 获取排行榜类型的详细信息
  Future<void> _getRankDataDetials() async {
    setState(() {
      _isSelecting = true;
    });
    var _getRankDataDetialsRes = await Api.getRankDataDetials(
      sortType: _sortType,
    );
    setState(() {
      _sortDataList = _getRankDataDetialsRes.data;
      _isSelecting = false;
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
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: CommonSliverPersistentHeaderDelegate(
                      height: ScreenUtil().setWidth(74),
                      child: _buildSortTypeDescription(),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(30),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          var item = _sortDataList[index];
                          return ComicRankItem(
                            comicItem: item,
                            index: index,
                          );
                        },
                        childCount: _sortDataList.length,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  // 排行榜类型
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

  // 排行榜的周期和说明
  Widget _buildSortTypeDescription() {
    TextStyle style = TextStyle(
      color: Colors.grey,
      fontSize: ScreenUtil().setSp(20),
    );

    return Container(
      height: ScreenUtil().setWidth(74),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
      ),
      color: Colors.grey[200],
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: _buildDescriptionItem(
              '${Utils.getWeek()}',
              style: style,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '— 每天12点更新 —',
              style: style,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: _buildDescriptionItem(
              '漫画台·人气',
              style: style,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionItem(String text, {TextStyle style}) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(10),
        horizontal: ScreenUtil().setWidth(15),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: ScreenUtil().setWidth(1),
        ),
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(20),
        ),
      ),
      child: Text(
        '$text',
        strutStyle: StrutStyle(
          forceStrutHeight: true,
          fontSize: ScreenUtil().setSp(20),
        ),
        style: style,
      ),
    );
  }
}

class CommonSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  CommonSliverPersistentHeaderDelegate({
    this.height,
    this.child,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(CommonSliverPersistentHeaderDelegate oldDelegate) {
    //print("shouldRebuild---------------");
    return oldDelegate != this;
  }
}
