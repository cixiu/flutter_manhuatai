import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/models/recommend_satellite.dart'
    as RecommendSatellite;
import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;

class RecommendSatelliteSliverList extends StatelessWidget {
  final List<RecommendSatellite.List_List> recommendSatelliteList;
  final List<UserRoleInfo.Data> userRoleInfoList;

  RecommendSatelliteSliverList({
    this.recommendSatelliteList,
    this.userRoleInfoList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          var item = recommendSatelliteList[index];
          UserRoleInfo.Data roleInfo;
          roleInfo = userRoleInfoList.firstWhere(
            (userRole) {
              return item.useridentifier == userRole.userId;
              // if () {
              //   roleInfo = userRole;
              //   return;
              // }
            },
            orElse: () => null,
          );

          return Column(
            children: <Widget>[
              Container(
                height: ScreenUtil().setWidth(80),
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(30),
                ),
                margin: EdgeInsets.only(
                  top: ScreenUtil().setWidth(30),
                ),
                child: Row(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(80),
                          height: ScreenUtil().setWidth(80),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: ScreenUtil().setWidth(1),
                            ),
                            borderRadius: BorderRadius.circular(
                              ScreenUtil().setWidth(40),
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                              Utils.generateImgUrlFromId(
                                id: item.useridentifier,
                                aspectRatio: '1:1',
                                type: 'head',
                              ),
                            ),
                            radius: ScreenUtil().setWidth(40),
                          ),
                        ),
                        Stack(
                          alignment: Alignment(0.5, 1),
                          children: <Widget>[
                            Image.asset(
                              'lib/images/icon_lv_bg_big.png',
                              width: ScreenUtil().setWidth(66),
                              height: ScreenUtil().setWidth(24),
                            ),
                            Text(
                              '${item.ulevel}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(18),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(10),
                                  ),
                                  child: Text(
                                    item.username,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScreenUtil().setSp(24),
                                    ),
                                  ),
                                ),
                                _buildRoleImage(roleInfo),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('${item.createtime}'),
                                Text('${item.deviceTail}'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Text('关注'),
                    ),
                  ],
                ),
              )
            ],
          );
        },
        childCount: recommendSatelliteList.length,
      ),
    );
  }

  Widget _buildRoleImage(UserRoleInfo.Data roleInfo) {
    if (roleInfo == null) {
      return Container();
    }
    print(roleInfo.roleId);
    String url;
    // 官方
    if (roleInfo.roleId == 18) {
      url = 'lib/images/icon_circle_official.png';
    }
    // 圈子
    if (roleInfo.roleId == 20) {
      url = 'lib/images/icon_circle_master.png';
    }
    // 话事人
    if (roleInfo.roleId == 21) {
      url = 'lib/images/icon_topic_master.png';
    }
    // 纪律委员
    if (roleInfo.roleId == 22) {
      url = 'lib/images/icon_circle_manager.png';
    }
    return Image.asset(
      url,
      width: ScreenUtil().setWidth(60),
      height: ScreenUtil().setWidth(40),
    );
  }
}
