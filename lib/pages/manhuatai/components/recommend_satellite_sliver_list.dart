import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;

import 'package:flutter_manhuatai/components/load_more_widget/load_more_widget.dart';
import 'package:flutter_manhuatai/components/satellite_header/satellite_header.dart';
import 'package:flutter_manhuatai/components/satellite_content/satellite_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef void IndexCallBack(int index);

class RecommendSatelliteSliverList extends StatelessWidget {
  final List<Satellite> recommendSatelliteList;
  final List<UserRoleInfo.Data> userRoleInfoList;
  final bool hasMore;
  final IndexCallBack supportSatellite;

  RecommendSatelliteSliverList({
    this.recommendSatelliteList,
    this.userRoleInfoList,
    this.hasMore,
    this.supportSatellite,
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
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setWidth(30),
                  bottom: ScreenUtil().setWidth(20),
                ),
                child: SatelliteHeader(
                  item: item,
                  roleInfo: roleInfo,
                ),
              ),
              SatelliteContent(
                item: item,
                supportSatellite: () {
                  supportSatellite(index);
                },
              ),
            ],
          );
        },
        childCount: recommendSatelliteList.length + 1,
      ),
    );
  }
}
