import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/components/satellite_header/satellite_header.dart';
import 'package:flutter_manhuatai/components/satellite_content/satellite_content.dart';

import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;

class SatelliteDetailContentSliverList extends StatelessWidget {
  final Satellite satellite;
  final UserRoleInfo.Data roleInfo;
  final VoidCallback supportSatellite;

  SatelliteDetailContentSliverList({
    this.satellite,
    this.roleInfo,
    this.supportSatellite,
  });

  @override
  Widget build(BuildContext context) {
    bool isSupport = satellite.issupport == 1;

    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          margin: EdgeInsets.only(
            bottom: ScreenUtil().setWidth(30),
          ),
          child: SatelliteHeader(
            item: satellite,
            roleInfo: roleInfo,
            showFollowBtn: true,
          ),
        ),
        SatelliteContent(
          item: satellite,
          isDetail: true,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(30),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  bottom: ScreenUtil().setWidth(30),
                ),
                padding: EdgeInsets.all(
                  ScreenUtil().setWidth(20),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSupport ? Colors.blue : Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(100),
                  ),
                ),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (supportSatellite != null) {
                      supportSatellite();
                    }
                  },
                  child: Image.asset(
                    isSupport
                        ? 'lib/images/icon_read_yizan.png'
                        : 'lib/images/icon_dianzan.png',
                    width: ScreenUtil().setWidth(60),
                    height: ScreenUtil().setWidth(60),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: ScreenUtil().setWidth(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(150),
                      height: ScreenUtil().setWidth(1),
                      color: isSupport ? Colors.blue : Colors.grey[300],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                      ),
                      child: Text(
                        '${satellite.supportnum}人点赞',
                        style: TextStyle(
                          color: isSupport ? Colors.blue : Colors.grey,
                          fontSize: ScreenUtil().setSp(24),
                        ),
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(150),
                      height: ScreenUtil().setWidth(1),
                      color: isSupport ? Colors.blue : Colors.grey[300],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: ScreenUtil().setWidth(50),
                ),
                alignment: Alignment.centerRight,
                child: Text(
                  '阅读 ${Utils.formatNumber(satellite.viewCount.toString())}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil().setSp(24),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
