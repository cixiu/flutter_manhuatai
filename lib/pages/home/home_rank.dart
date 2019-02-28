import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/rank/rank_all.dart';
import 'package:flutter_manhuatai/components/rank/rank_self.dart';
import 'package:flutter_manhuatai/components/rank/rank_new.dart';
import 'package:flutter_manhuatai/components/rank/rank_dark.dart';
import 'package:flutter_manhuatai/components/rank/rank_charge.dart';
import 'package:flutter_manhuatai/components/rank/rank_boy.dart';
import 'package:flutter_manhuatai/components/rank/rank_girl.dart';

import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/rank_list.dart' as RankList;

class HomeRank extends StatefulWidget {
  _HomeRankState createState() => _HomeRankState();
}

class _HomeRankState extends State<HomeRank>
    with AutomaticKeepAliveClientMixin, RefreshCommonState<HomeRank> {
  bool isFirstShow = true;
  bool isLoading = true;
  List<RankList.Data> rankList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
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
    print(rankData.data);
    setState(() {
      isLoading = false;
      rankList = rankData.data;
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
      // TODO:使用switch
      // switch (data.type) {
      //   case '':

      //     break;
      //   default:
      // }
      if (index == 1) {
        return RankSelf(
          data: data,
        );
      } else if (index == 2) {
        return RankNew(data: data);
      } else if (index == 3) {
        return RankDark(data: data);
      } else if (index == 4) {
        return RankCharge(data: data);
      } else if (index == 5) {
        return RankBoy(data: data);
      } else if (index == 6) {
        return RankGirl(data: data);
      } else {
        return RankAll(
          data: data,
        );
      }
    }

    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: handleRefrsh,
      child: isLoading
          ? Container()
          : ListView.builder(
              itemCount: rankList.length,
              itemBuilder: itemBuilder,
            ),
    );
  }
}
