import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/provider_store/user_info_model.dart';

import 'components/mine_entry_list_widget.dart';

class HomeMine extends StatefulWidget {
  @override
  _HomeMineState createState() => _HomeMineState();
}

class _HomeMineState extends State<HomeMine>
    with AutomaticKeepAliveClientMixin, RefreshCommonState {
  @override
  bool get wantKeepAlive => true;

  Future<void> onRefresh() async {
    var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
    userInfoModel.getUseroOrGuestInfo();
  }

  void _goLogin(UserInfo userInfo) {
    if (userInfo.uname == null) {
      Application.router.navigateTo(
        context,
        '/login',
        transition: TransitionType.inFromRight,
      );
    } else {
      Application.router.navigateTo(
        context,
        '/user_center',
        transition: TransitionType.inFromRight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('我的页面build');

    return Scaffold(
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: onRefresh,
        child: Selector<UserInfoModel, UserInfoModel>(
          selector: (context, userInfoModel) => userInfoModel,
          builder: (context, userInfoModel, _) {
            var userInfo = userInfoModel.userInfo;
            var guestInfo = userInfoModel.guestInfo;
            print(userInfo.uname);

            return CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      ClipPath(
                        clipper: BottomClipper(),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            Container(
                              height: ScreenUtil().setWidth(360),
                              color: Colors.white,
                              child: Image.asset(
                                'lib/images/mine/pic_mine_bj.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              width: ScreenUtil().setWidth(680),
                              height: ScreenUtil().setWidth(240),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.6),
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(
                                      ScreenUtil().setWidth(30)),
                                  right: Radius.circular(
                                      ScreenUtil().setWidth(30)),
                                ),
                              ),
                              child: Container(
                                height: ScreenUtil().setWidth(180),
                                margin: EdgeInsets.only(
                                  top: ScreenUtil().setWidth(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(30),
                                ),
                                alignment: Alignment.topCenter,
                                child: GestureDetector(
                                  onTap: () {
                                    _goLogin(userInfo);
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      // 用户头像
                                      _buildAvatar(userInfo),
                                      // 用户名称
                                      _buildUserName(
                                        userInfo: userInfo,
                                        guestInfo: guestInfo,
                                      ),
                                      // 用户等级
                                      _buildUserLevel(
                                        userInfo: userInfo,
                                        guestInfo: guestInfo,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 我的消费品
                      _buildMineGoods(
                        userInfo: userInfo,
                        guestInfo: guestInfo,
                      ),
                      // 我的相关入口列表
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.grey[100],
                        child: MineEntryListWidget(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // 用户头像
  Widget _buildAvatar(UserInfo userInfo) {
    return Container(
      width: ScreenUtil().setWidth(170),
      height: ScreenUtil().setWidth(170),
      padding: EdgeInsets.all(
        ScreenUtil().setWidth(10),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(170),
        ),
      ),
      child: userInfo.uid != null
          ? ClipOval(
              child: ImageWrapper(
                url: Utils.generateImgUrlFromId(
                  id: userInfo.uid,
                  aspectRatio: '1:1',
                  type: 'head',
                ),
                width: ScreenUtil().setWidth(160),
                height: ScreenUtil().setWidth(160),
              ),
            )
          : Image.asset(
              'lib/images/ic_default_avatar.png',
            ),
    );
  }

  // 用户名称
  Widget _buildUserName({
    UserInfo userInfo,
    UserInfo guestInfo,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: ScreenUtil().setWidth(320),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
      ),
      child: Text(
        userInfo?.uname ?? guestInfo.uname,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(32),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // 用户等级
  Widget _buildUserLevel({
    UserInfo userInfo,
    UserInfo guestInfo,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // 导航去等级详情
        Application.router.navigateTo(context, Routes.myLevel);
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            'lib/images/mine/icon_mine_lv.png',
            width: ScreenUtil().setWidth(72),
            height: ScreenUtil().setWidth(42),
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(10),
            ),
            child: Text(
              'LV${userInfo?.ulevel ?? guestInfo.ulevel}',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getGiftItem({String assetIcon, String text}) {
    return Container(
      height: ScreenUtil().setWidth(200),
      child: Column(
        children: <Widget>[
          Image.asset(
            assetIcon,
            width: ScreenUtil().setWidth(96),
            height: ScreenUtil().setWidth(96),
          ),
          Container(
            width: ScreenUtil().setWidth(120),
            height: ScreenUtil().setWidth(50),
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(30),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(25),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              Utils.formatNumber(text),
              strutStyle: StrutStyle(
                forceStrutHeight: true,
              ),
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 我的消费品
  Widget _buildMineGoods({
    UserInfo userInfo,
    UserInfo guestInfo,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _getGiftItem(
          assetIcon: 'lib/images/mine/icon_mine_ciyuan.png',
          text: '${userInfo?.cactive ?? guestInfo?.cactive}',
        ),
        _getGiftItem(
          assetIcon: 'lib/images/mine/icon_mine_guobi.png',
          text: '${userInfo?.cgold ?? guestInfo?.cgold}',
        ),
        _getGiftItem(
          assetIcon: 'lib/images/mine/icon_mine_mengbi.png',
          text: '${userInfo?.coins ?? guestInfo?.coins}',
        ),
        _getGiftItem(
          assetIcon: 'lib/images/mine/icon_mine_luobo.png',
          text: '${userInfo?.recommend ?? guestInfo?.recommend}',
        ),
        _getGiftItem(
          assetIcon: 'lib/images/mine/icon_mine_yuepiao.png',
          text: '${userInfo?.cticket ?? guestInfo?.cticket}',
        ),
      ],
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double bendingHeight = ScreenUtil().setWidth(30);
    path.lineTo(0, 0); //第1个点
    path.lineTo(0, size.height - bendingHeight); //第2个点

    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEdnPoint = Offset(size.width, size.height - bendingHeight);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEdnPoint.dx,
      firstEdnPoint.dy,
    );

    path.lineTo(size.width, size.height - bendingHeight); //第3个点
    path.lineTo(size.width, 0); //第4个点

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
