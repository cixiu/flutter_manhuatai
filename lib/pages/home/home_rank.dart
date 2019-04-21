import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/pull_load_wrapper/pull_load_wrapper.dart';
import 'package:flutter_manhuatai/components/rank/rank_all.dart';
import 'package:flutter_manhuatai/components/rank/rank_self.dart';
import 'package:flutter_manhuatai/components/rank/rank_new.dart';
import 'package:flutter_manhuatai/components/rank/rank_dark.dart';
import 'package:flutter_manhuatai/components/rank/rank_charge.dart';
import 'package:flutter_manhuatai/components/rank/rank_boy.dart';
import 'package:flutter_manhuatai/components/rank/rank_girl.dart';
import 'package:flutter_manhuatai/components/rank/rank_serialize.dart';
import 'package:flutter_manhuatai/components/rank/rank_finish.dart';
import 'package:flutter_manhuatai/components/rank/rank_free.dart';

import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/rank_list.dart' as RankList;

class HomeRank extends StatefulWidget {
  _HomeRankState createState() => _HomeRankState();
}

class _HomeRankState extends State<HomeRank>
    with AutomaticKeepAliveClientMixin, RefreshCommonState<HomeRank> {
  final rankPageControl = PullLoadWrapperControl();
  bool isFirstShow = true;
  bool isLoading = true;
  List<RankList.Data> rankList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    rankPageControl.needHeader = false;
    super.initState();
    print('初始化排行页面');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('HomeRank didChangeDependencies');
  }

  @override
  void didUpdateWidget(HomeRank oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('更新排行页面数据');
    if (isFirstShow) {
      print('在这里发送http请求');
      setState(() {
        isFirstShow = false;
      });
      // 显示下拉刷新的Indicator, 只需RefrshIndicator的onRefresh函数
      showRefreshLoading();
    }
  }

  Future<void> handleRefrsh() async {
    var response = await Api.getRankList();
    RankList.RankList rankData = RankList.RankList.fromJson(response);
    setState(() {
      isLoading = false;
      rankList = rankData.data;
      rankPageControl.dataListLength = rankData.data.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build Rank ..................');
    if (isFirstShow) {
      return Container();
    }

    Widget itemBuilder(BuildContext context, int index) {
      var data = rankList[index];
      var type = data.type;

      if (type == 'all') {
        return RankAll(data: data);
      } else if (type == 'self') {
        return RankSelf(data: data);
      } else if (type == 'new') {
        return RankNew(data: data);
      } else if (type == 'dark') {
        return RankDark(data: data);
      } else if (type == 'charge') {
        return RankCharge(data: data);
      } else if (type == 'boy') {
        return RankBoy(data: data);
      } else if (type == 'girl') {
        return RankGirl(data: data);
      } else if (type == 'serialize') {
        return RankSerialize(data: data);
      } else if (type == 'finish') {
        return RankFinish(data: data);
      } else if (type == 'free') {
        return RankFree(data: data);
      } else {
        return RankAll(data: data);
      }
    }

    return PullLoadWrapper(
      isFirstLoading: isLoading,
      refreshKey: refreshIndicatorKey,
      onRefresh: handleRefrsh,
      control: rankPageControl,
      itemBuilder: itemBuilder,
    );
  }
}
