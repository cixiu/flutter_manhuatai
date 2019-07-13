import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/components/load_more_widget/load_more_widget.dart';

import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;

import 'satellite_content.dart';
import 'satellite_header.dart';

class RecommendSatelliteSliverList extends StatelessWidget {
  final List<Satellite> recommendSatelliteList;
  final List<UserRoleInfo.Data> userRoleInfoList;
  final bool hasMore;

  RecommendSatelliteSliverList({
    this.recommendSatelliteList,
    this.userRoleInfoList,
    this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == recommendSatelliteList.length) {
            return LoadMoreWidget(
              hasMore: hasMore,
            );
          }

          var item = recommendSatelliteList[index];
          UserRoleInfo.Data roleInfo;
          roleInfo = userRoleInfoList.firstWhere(
            (userRole) {
              return item.useridentifier == userRole.userId;
            },
            orElse: () => null,
          );

          return Column(
            children: <Widget>[
              SatelliteHeader(
                item: item,
                roleInfo: roleInfo,
              ),
              SatelliteContent(
                item: item,
              ),
            ],
          );
        },
        childCount: recommendSatelliteList.length + 1,
      ),
    );
  }
}
