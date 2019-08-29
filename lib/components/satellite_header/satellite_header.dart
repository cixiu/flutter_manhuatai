import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;

class SatelliteHeader extends StatelessWidget {
  final Satellite item;
  final UserRoleInfo.Data roleInfo;
  final bool showFollowBtn;

  SatelliteHeader({
    this.item,
    this.roleInfo,
    this.showFollowBtn = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(80),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                            fontSize: ScreenUtil().setSp(28),
                          ),
                        ),
                      ),
                      _buildRoleImage(roleInfo),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(30),
                        ),
                        child: Text(
                          '${Utils.fromNow(item.createtime)}',
                          strutStyle: StrutStyle(
                            forceStrutHeight: true,
                            fontSize: ScreenUtil().setSp(20),
                          ),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenUtil().setSp(20),
                          ),
                        ),
                      ),
                      Text(
                        '${item.deviceTail}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: ScreenUtil().setSp(20),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          // isfollow == 0 表示还未关注用户，所以需要显示关注按钮
          // isfollow == 1 表示已关注
          showFollowBtn && item.isfollow == 0
              ? Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset(
                      'lib/images/icon_follow_small_noshadow.png',
                      width: ScreenUtil().setWidth(90),
                      height: ScreenUtil().setWidth(36),
                    ),
                    Text(
                      '关注',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(24),
                      ),
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildRoleImage(UserRoleInfo.Data roleInfo) {
    if (roleInfo == null) {
      return Container();
    }
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

    if (url == null) {
      url = roleInfo.roleImgUrl;
      return Image.network(
        url,
        width: ScreenUtil().setWidth(60),
        height: ScreenUtil().setWidth(40),
      );
    }

    return Image.asset(
      url,
      width: ScreenUtil().setWidth(60),
      height: ScreenUtil().setWidth(40),
    );
  }
}
