import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:flutter_manhuatai/store/index.dart';
import 'package:flutter_manhuatai/routes/application.dart';

class HomeMine extends StatefulWidget {
  @override
  _HomeMineState createState() => _HomeMineState();
}

class _HomeMineState extends State<HomeMine>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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

  Widget _getGiftItem({String assetIcon, String text}) {
    return Container(
      height: ScreenUtil().setHeight(60),
      child: Row(
        children: <Widget>[
          Image.asset(assetIcon),
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('我的页面build');

    return Scaffold(
      body: StoreBuilder<AppState>(
        builder: (context, store) {
          var userInfo = store.state.userInfo;
          print(userInfo.uname);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.blue,
                          child: Image.asset(
                            'lib/images/star_home_bg.png',
                            width: ScreenUtil.screenWidth,
                            height: ScreenUtil().setHeight(300),
                          ),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(100),
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(80)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '粉丝 ${userInfo?.uname != null ? userInfo.cfans : 0}',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(24),
                                ),
                              ),
                              Text(
                                '关注 ${userInfo?.uname != null ? userInfo.cfocus : 0}',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(24),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        _goLogin(userInfo);
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setHeight(200),
                            height: ScreenUtil().setHeight(200),
                            padding: EdgeInsets.all(
                              ScreenUtil().setHeight(20),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setHeight(200),
                              ),
                            ),
                          ),
                          Container(
                            width: ScreenUtil().setHeight(160),
                            height: ScreenUtil().setHeight(160),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setHeight(160),
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
                                      width: ScreenUtil().setHeight(160),
                                      height: ScreenUtil().setHeight(160),
                                    ),
                                  )
                                : Image.asset(
                                    'lib/images/ic_default_avatar.png',
                                  ),
                          ),
                          Positioned(
                            right: -ScreenUtil().setHeight(20),
                            bottom: ScreenUtil().setHeight(20),
                            child: Container(
                              width: ScreenUtil().setHeight(40),
                              height: ScreenUtil().setHeight(40),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'lib/images/icon_userhome_boy4.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(40),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(20),
                      ),
                      child: Text(
                        userInfo?.uname ?? '游客',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(32),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      userInfo?.usign != null
                          ? userInfo?.usign
                          : '这个家伙很懒，什么都没留下',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(24),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(48),
                ),
                margin: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _getGiftItem(
                      assetIcon: 'lib/images/icon_mine_wow1.png',
                      text: userInfo?.uname != null
                          ? userInfo.cgold.toString()
                          : '5000',
                    ),
                    _getGiftItem(
                      assetIcon: 'lib/images/icon_mine_wow2.png',
                      text: userInfo?.uname != null
                          ? userInfo.coins.toString()
                          : '0',
                    ),
                    _getGiftItem(
                      assetIcon: 'lib/images/icon_mine_wow3.png',
                      text: userInfo?.uname != null
                          ? userInfo.recommend.toString()
                          : '0',
                    ),
                    _getGiftItem(
                      assetIcon: 'lib/images/icon_mine_wow4.png',
                      text: userInfo?.uname != null
                          ? userInfo.cticket.toString()
                          : '0',
                    ),
                  ],
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(20),
                color: Colors.grey[200],
              ),
            ],
          );
        },
      ),
    );
  }
}
