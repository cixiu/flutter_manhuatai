import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/common/model/level_info.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/components/user_level_widget/user_level_widget.dart';
import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:flutter_manhuatai/store/index.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';

import 'components/level_sliver_list.dart';
import 'components/level_way_sliver_list.dart';

class MyLevel extends StatefulWidget {
  @override
  _MyLevelState createState() => _MyLevelState();
}

class _MyLevelState extends State<MyLevel>
    with RefreshCommonState, WidgetsBindingObserver {
  List<LevelInfo> _levelList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  Future<void> onRefresh() async {
    var user = User(context);
    var openid = user.info.openid;

    var result = await Api.getUserLevelInfo(openid: openid);

    if (!mounted) {
      return;
    }

    setState(() {
      _levelList = result;
      _isLoading = false;
    });
  }

  UserInfo getUserInfo(Store<AppState> store) {
    return store.state.userInfo.uid != null
        ? store.state.userInfo
        : store.state.guestInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: onRefresh,
        child: _isLoading
            ? Container()
            : StoreConnector<AppState, Store<AppState>>(
                converter: (store) => store,
                builder: (ctx, store) {
                  var userInfo = getUserInfo(store);
                  return Stack(
                    children: <Widget>[
                      CustomScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate([
                              Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  _buildBackground(),
                                  Positioned(
                                    top: ScreenUtil().setWidth(100),
                                    child: _buildUserInfo(userInfo),
                                  ),
                                  Positioned(
                                    bottom: ScreenUtil().setWidth(100),
                                    child: _buildLevelInfo(userInfo),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                          LevelSliverList(
                            levelList: _levelList,
                            currentLevel: userInfo.ulevel,
                          ),
                          LevelWaySliverList(),
                        ],
                      ),
                      Positioned(
                        top: ScreenUtil().setWidth(70),
                        left: ScreenUtil().setWidth(20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.navigate_before,
                            size: ScreenUtil().setWidth(60),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  // 背景图片
  Widget _buildBackground() {
    return Image.asset(
      'lib/images/level/pic_level_bg.png',
      height: ScreenUtil().setWidth(600),
      fit: BoxFit.cover,
    );
  }

  // 用户信息
  Widget _buildUserInfo(UserInfo userInfo) {
    return Column(
      children: <Widget>[
        _buildAvatar(userInfo),
        _buildUserName(userInfo),
        _buildUserLevelInfo(userInfo),
      ],
    );
  }

  // 用户头像
  Widget _buildAvatar(UserInfo userInfo) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(5),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            'lib/images/level/pic_level_pao.png',
            width: ScreenUtil().setWidth(350),
            fit: BoxFit.cover,
          ),
          Container(
            width: ScreenUtil().setWidth(150),
            height: ScreenUtil().setWidth(150),
            padding: EdgeInsets.all(
              ScreenUtil().setWidth(5),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(150),
              ),
            ),
            child: ClipOval(
              child: ImageWrapper(
                url: Utils.generateImgUrlFromId(
                  id: userInfo.uid,
                  aspectRatio: '1:1',
                  type: 'head',
                ),
                width: ScreenUtil().setWidth(160),
                height: ScreenUtil().setWidth(160),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 用户名称
  Widget _buildUserName(UserInfo userInfo) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(5),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              right: ScreenUtil().setWidth(20),
            ),
            child: Text(
              userInfo.uname,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(36),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          UserLevelWidget(
            userInfo: userInfo,
            size: LevelSize.small,
          ),
        ],
      ),
    );
  }

  // 用户的经验值
  Widget _buildUserLevelInfo(UserInfo userInfo) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            right: ScreenUtil().setWidth(10),
          ),
          child: Text(
            '${userInfo.cexp}',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(54),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          '经验值',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ],
    );
  }

  // 经验值
  Widget _buildLevelInfo(UserInfo userInfo) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          _buildUserLevelDiff(userInfo),
          _buildLevelProgress(userInfo),
        ],
      ),
    );
  }

  Widget _buildUserLevelDiff(UserInfo userInfo) {
    TextStyle style = TextStyle(
      color: Colors.white,
      fontSize: ScreenUtil().setSp(24),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '距下一等级还需要${userInfo.nextlevelexp - userInfo.cexp}经验值',
            style: style,
          ),
          Text(
            '${userInfo.cexp}/${userInfo.nextlevelexp}',
            style: style,
          ),
        ],
      ),
    );
  }

  // 等级进度
  // TODO: 等级超过100级后需要限制
  Widget _buildLevelProgress(UserInfo userInfo) {
    TextStyle style = TextStyle(
      color: Colors.white60,
      fontSize: ScreenUtil().setSp(34),
    );
    TextStyle currentStyle = TextStyle(
      color: Colors.white,
      fontSize: ScreenUtil().setSp(38),
    );

    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setWidth(20),
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: ScreenUtil().setWidth(3),
                  color: Colors.white,
                ),
              ),
              Image.asset(
                'lib/images/level/icon_level_chidouren.png',
                width: ScreenUtil().setWidth(50),
              ),
              Expanded(
                child: Container(
                  height: ScreenUtil().setWidth(3),
                  color: Colors.white60,
                ),
              ),
            ],
          ),
          Positioned(
            left: ScreenUtil().setWidth(80),
            top: ScreenUtil().setWidth(-4),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'lib/images/level/icon_level_exp.png',
                  width: ScreenUtil().setWidth(30),
                ),
                Text(
                  'V${userInfo.ulevel - 1}',
                  style: style,
                ),
              ],
            ),
          ),
          Positioned(
            left: ScreenUtil().setWidth(250),
            top: ScreenUtil().setWidth(-10),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'lib/images/level/icon_level_exp_big.png',
                  width: ScreenUtil().setWidth(40),
                ),
                Text(
                  'V${userInfo.ulevel}',
                  style: currentStyle,
                ),
              ],
            ),
          ),
          Positioned(
            right: ScreenUtil().setWidth(250),
            top: ScreenUtil().setWidth(-4),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'lib/images/level/icon_level_exp_hui.png',
                  width: ScreenUtil().setWidth(30),
                ),
                Text(
                  'V${userInfo.ulevel + 1}',
                  style: style,
                ),
              ],
            ),
          ),
          Positioned(
            right: ScreenUtil().setWidth(80),
            top: ScreenUtil().setWidth(-4),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'lib/images/level/icon_level_exp_hui.png',
                  width: ScreenUtil().setWidth(30),
                ),
                Text(
                  'V${userInfo.ulevel + 2}',
                  style: style,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
