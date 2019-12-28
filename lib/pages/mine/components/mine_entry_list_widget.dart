import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MineEntryListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(
            ScreenUtil().setWidth(30),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(ScreenUtil().setWidth(20)),
              right: Radius.circular(ScreenUtil().setWidth(20)),
            ),
          ),
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              top: ScreenUtil().setWidth(20),
            ),
            shrinkWrap: true,
            crossAxisCount: 4,
            childAspectRatio: 1,
            children: <Widget>[
              _buildEntryWidget(
                icon: 'lib/images/mine/icon_mine_mission.png',
                text: '任务中心',
              ),
              _buildEntryWidget(
                icon: 'lib/images/mine/icon_mine_sign.png',
                text: '签到',
              ),
              _buildEntryWidget(
                icon: 'lib/images/mine/icon_mine_money.png',
                text: '商店',
              ),
              _buildEntryWidget(
                icon: 'lib/images/mine/icon_mine_bag.png',
                text: '背包',
              ),
              _buildEntryWidget(
                icon: 'lib/images/mine/icon_mine_us.png',
                text: '消息',
              ),
              _buildEntryWidget(
                icon: 'lib/images/mine/icon_mine_share.png',
                text: '联系我们',
              ),
              _buildEntryWidget(
                icon: 'lib/images/mine/icon_mine_set.png',
                text: '设置',
              ),
              _buildEntryWidget(
                icon: 'lib/images/mine/icon_mine_dhm.png',
                text: '兑换码',
              ),
              _buildEntryWidget(
                icon: 'lib/images/mine/mht_mine_welfare.png',
                text: '福利中心',
              ),
              _buildEntryWidget(
                icon: 'lib/images/mine/mht_mine_activity.png',
                text: '精彩活动',
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildEntryWidget({String icon, String text}) {
    return Column(
      children: <Widget>[
        Image.asset(
          icon,
          width: ScreenUtil().setWidth(80),
          height: ScreenUtil().setWidth(80),
        ),
        Container(
          margin: EdgeInsets.only(
            top: ScreenUtil().setWidth(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
        ),
      ],
    );
  }
}
