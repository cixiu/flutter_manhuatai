import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
    if (userInfo == null) {
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

    return Scaffold(
      body: StoreBuilder<AppState>(
        builder: (context, store) {
          var userInfo = store.state.userInfo;

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
                          ),
                        ),
                        Container(
                          height: 50.0,
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '粉丝 ${userInfo?.uname.isNotEmpty ? userInfo.cfans : 0}',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                '关注 ${userInfo?.uname.isNotEmpty ? userInfo.cfocus : 0}',
                                style: TextStyle(
                                  fontSize: 12.0,
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
                            width: 100.0,
                            height: 100.0,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            child: userInfo.uid != null
                                ? ClipOval(
                                    child: ImageWrapper(
                                      url: Utils.generateImgUrlFromId(
                                        id: userInfo.uid,
                                        aspectRatio: '1:1',
                                        type: 'head',
                                      ),
                                      width: 80.0,
                                      height: 80.0,
                                    ),
                                  )
                                : Image.asset(
                                    'lib/images/ic_default_avatar.png',
                                  ),
                          ),
                          Positioned(
                            right: -10.0,
                            bottom: 10.0,
                            child: Container(
                              width: 20.0,
                              height: 20.0,
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
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        userInfo?.uname ?? '游客',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      userInfo?.usign?.isNotEmpty
                          ? userInfo?.usign
                          : '这个家伙很懒，什么都没留下',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                margin: EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 30.0,
                      child: Row(
                        children: <Widget>[
                          Image.asset('lib/images/icon_mine_wow1.png'),
                          Container(
                            margin: EdgeInsets.only(left: 8.0),
                            child: Text(
                              userInfo?.uname?.isNotEmpty
                                  ? userInfo.cgold.toString()
                                  : '5000',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 30.0,
                      child: Row(
                        children: <Widget>[
                          Image.asset('lib/images/icon_mine_wow2.png'),
                          Container(
                            margin: EdgeInsets.only(left: 8.0),
                            child: Text(
                              userInfo?.uname?.isNotEmpty
                                  ? userInfo.coins.toString()
                                  : '0',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 30.0,
                      child: Row(
                        children: <Widget>[
                          Image.asset('lib/images/icon_mine_wow3.png'),
                          Container(
                            margin: EdgeInsets.only(left: 8.0),
                            child: Text(
                              userInfo?.uname?.isNotEmpty
                                  ? userInfo.recommend.toString()
                                  : '0',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 30.0,
                      child: Row(
                        children: <Widget>[
                          Image.asset('lib/images/icon_mine_wow4.png'),
                          Container(
                            margin: EdgeInsets.only(left: 8.0),
                            child: Text(
                              userInfo?.uname?.isNotEmpty
                                  ? userInfo.cticket.toString()
                                  : '0',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 10.0,
                color: Colors.grey[200],
              ),
            ],
          );
        },
      ),
    );
  }
}
