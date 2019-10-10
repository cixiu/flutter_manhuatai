import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/components/request_loading/request_loading.dart';
import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/store/index.dart';
import 'package:flutter_manhuatai/store/user_collects.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redux/redux.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/components/score_star/score_star.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_manhuatai/models/comic_info_influence.dart';

class ComicDetailHeader extends StatelessWidget {
  final String comicId;
  final ComicInfoBody comicInfoBody;
  final Call_data influenceData;
  final int comicCommentCount;

  ComicDetailHeader({
    this.comicId,
    this.comicInfoBody,
    this.influenceData,
    this.comicCommentCount,
  });

  Future<void> _setUserCollect(BuildContext context, bool hasCollected) async {
    try {
      showLoading(context);
      var user = User(context);
      String action = hasCollected ? 'dels' : 'add';
      int _comicId = int.parse(comicId);

      String deviceid = '';
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceid = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceid = iosInfo.identifierForVendor;
      }

      var status = await Api.setUserCollect(
        type: user.info.type,
        openid: user.info.openid,
        deviceid: deviceid,
        myUid: user.info.uid,
        action: action,
        comicId: _comicId,
        comicIdList: [_comicId],
      );

      var getUserRecordRes = await Api.getUserRecord(
        type: user.info.type,
        openid: user.info.openid,
        deviceid: deviceid,
        myUid: user.info.uid,
      );
      getUserRecordRes.userCollect.sort((collectA, collectB) {
        return collectB.updateTime - collectA.updateTime;
      });

      Store<AppState> store = StoreProvider.of(context);
      store.dispatch(UpdateUserCollectsAction(getUserRecordRes.userCollect));
      hideLoading(context);

      String message = hasCollected ? '已取消收藏' : '收藏成功~~';
      if (status) {
        showToast(message);
      } else {
        showToast('操作失败');
      }
    } catch (e) {
      hideLoading(context);
      showToast('操作失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: Utils.generateImgUrlFromId(
            id: int.parse(comicId),
            aspectRatio: '2:1',
          ),
          height: ScreenUtil().setWidth(488),
          fit: BoxFit.cover,
        ),
        _buildHeaderComicBodyInfo(),
        _buildHeaderTabBar(context),
      ],
    );
  }

  // 漫画主体信息区域，评分，背景图
  Widget _buildHeaderComicBodyInfo() {
    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      left: 0,
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.5),
        child: Stack(
          children: <Widget>[
            Container(
              height: ScreenUtil().setWidth(210),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
              ),
              margin: EdgeInsets.only(
                top: ScreenUtil().setWidth(168),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              right: ScreenUtil().setWidth(16),
                            ),
                            constraints: BoxConstraints(
                              maxWidth: ScreenUtil().setWidth(360),
                            ),
                            child: Text(
                              comicInfoBody.comicName,
                              strutStyle: StrutStyle(
                                forceStrutHeight: true,
                                fontSize: ScreenUtil().setSp(40),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(40),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setWidth(8),
                            ),
                            child: Text(
                              comicInfoBody.comicAuthor,
                              strutStyle: StrutStyle(
                                forceStrutHeight: true,
                                fontSize: ScreenUtil().setSp(24),
                              ),
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: ScreenUtil().setSp(24),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ScoreStar(score: influenceData.score),
                              Container(
                                margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(6),
                                ),
                                child: Text(
                                  '${influenceData.score}',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(24),
                                    color: Color(0xfff9ea19),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: ScreenUtil().setWidth(28),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '人气 ${Utils.formatNumber(influenceData.thistotalHeat)}',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(24),
                                    color: Colors.white70,
                                  ),
                                ),
                                Row(
                                  children: comicInfoBody.comicTypeNew
                                      .take(4)
                                      .map((item) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(16),
                                        vertical: ScreenUtil().setWidth(6),
                                      ),
                                      margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(10),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          ScreenUtil().setWidth(20),
                                        ),
                                        color:
                                            Color.fromRGBO(188, 188, 188, 0.5),
                                      ),
                                      child: Text(
                                        item.name,
                                        strutStyle: StrutStyle(
                                          fontSize: ScreenUtil().setSp(20),
                                          forceStrutHeight: true,
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(20),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  // 右侧的漫画封面图
                  Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(158),
                        height: ScreenUtil().setWidth(208),
                        padding: EdgeInsets.all(ScreenUtil().setWidth(4)),
                        color: Colors.white,
                        child: ImageWrapper(
                          url: Utils.generateImgUrlFromId(
                            id: int.parse(comicId),
                            aspectRatio: '3:4',
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Image.asset(
                            'lib/images/icon_detail_front_tag.png',
                            width: ScreenUtil().setWidth(24),
                            height: ScreenUtil().setWidth(54),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(24),
                            child: Text(
                              comicInfoBody.copyrightTypeCn,
                              strutStyle: StrutStyle(
                                fontSize: ScreenUtil().setWidth(16),
                                forceStrutHeight: true,
                              ),
                              style: TextStyle(
                                fontSize: ScreenUtil().setWidth(16),
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                              textAlign: TextAlign.center,
                              // textDirection: TextDirection.ltr,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 收藏，开始阅读，吐槽区域
  Widget _buildHeaderTabBar(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      left: 0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Image.asset(
            'lib/images/pic_detail_hx1.png',
            height: ScreenUtil().setWidth(128),
            fit: BoxFit.fill,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StoreConnector<AppState, List<User_collect>>(
                converter: (store) => store.state.userCollects,
                builder: (context, userCollects) {
                  int collectIndex = userCollects.indexWhere((collect) {
                    return collect.comicId == int.parse(comicId);
                  });
                  // 是否已经收藏过漫画了
                  bool hasCollected = collectIndex > -1;

                  return GestureDetector(
                    onTap: () {
                      _setUserCollect(context, hasCollected);
                    },
                    child: Container(
                      width: ScreenUtil().setWidth(200),
                      height: ScreenUtil().setWidth(64),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Image.asset(
                            'lib/images/icon_detail_collect.png',
                            width: ScreenUtil().setWidth(200),
                            height: ScreenUtil().setWidth(64),
                          ),
                          Positioned(
                            bottom: ScreenUtil().setWidth(6),
                            child: _buildTabText(
                              text: hasCollected ? '已收藏' : '收藏',
                              subText:
                                  '${Utils.formatNumber(influenceData.collect)}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Container(
                width: ScreenUtil().setWidth(248),
                height: ScreenUtil().setWidth(102),
                child: Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Positioned(
                      top: ScreenUtil().setWidth(-10),
                      child: Image.asset(
                        'lib/images/icon_detail_reed.png',
                        width: ScreenUtil().setWidth(248),
                        height: ScreenUtil().setWidth(102),
                      ),
                    ),
                    Positioned(
                      bottom: ScreenUtil().setWidth(20),
                      child: Text('开始阅读'),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Application.router.navigateTo(
                    context,
                    '${Routes.comicComment}?comicId=$comicId',
                  );
                },
                child: Container(
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setWidth(64),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Image.asset(
                        'lib/images/icon_detail_comt.png',
                        width: ScreenUtil().setWidth(200),
                        height: ScreenUtil().setWidth(64),
                      ),
                      Positioned(
                        bottom: ScreenUtil().setWidth(6),
                        child: _buildTabText(
                          text: '吐槽',
                          subText:
                              '${Utils.formatNumber(comicCommentCount.toString())}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // 收藏，开始阅读，吐槽区域的文本Widget
  Widget _buildTabText({
    String text,
    String subText,
  }) {
    return Row(
      children: <Widget>[
        Text(
          text,
          strutStyle: StrutStyle(
            forceStrutHeight: true,
            fontSize: ScreenUtil().setWidth(24),
          ),
          style: TextStyle(
            fontSize: ScreenUtil().setWidth(24),
            color: Color.fromRGBO(0, 0, 0, 0.7),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(10),
          ),
          child: Text(
            subText,
            strutStyle: StrutStyle(
              forceStrutHeight: true,
              fontSize: ScreenUtil().setWidth(20),
            ),
            style: TextStyle(
              fontSize: ScreenUtil().setWidth(20),
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
