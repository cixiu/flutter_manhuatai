import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/components/score_star/score_star.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_manhuatai/models/comic_info_influence.dart';
import 'package:transparent_image/transparent_image.dart';

class ComicDetailHeader extends StatelessWidget {
  final String comicId;
  final ComicInfoBody comicInfoBody;
  final Call_data influenceData;

  ComicDetailHeader({
    this.comicId,
    this.comicInfoBody,
    this.influenceData,
  });

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
        _buildHeaderTabBar(),
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
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              right: ScreenUtil().setWidth(16),
                            ),
                            child: Text(
                              comicInfoBody.comicName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(40),
                              ),
                            ),
                          ),
                          Text(
                            comicInfoBody.comicAuthor,
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: ScreenUtil().setSp(24),
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
                            width:  ScreenUtil().setWidth(24),
                            height:  ScreenUtil().setWidth(54),
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
  Widget _buildHeaderTabBar() {
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
              Container(
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
                    Text('收藏'),
                  ],
                ),
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
              Container(
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
                    Text('吐槽'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
