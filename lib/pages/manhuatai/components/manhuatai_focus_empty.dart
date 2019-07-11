import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_manhuatai/models/recommend_users.dart'
    as RecommendUsers;

import 'manhuatai_sliver_title.dart';

class ManhuataiFocusEmpty extends StatelessWidget {
  final List<RecommendUsers.Data> recommendUsers;

  ManhuataiFocusEmpty({
    this.recommendUsers,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(50),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'lib/images/icon_redeem_code_empty.png',
                  height: ScreenUtil().setWidth(200),
                ),
                Text(
                  '还没有关注任何人哦~',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil().setSp(24),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(50),
          ),
          child: Column(
            children: [
              ManhuataiSliverTitle(
                title: '有趣的人值得关注',
                onTap: () {
                  print('跳转至推荐的用户列表页面');
                },
              ),
              Container(
                height: ScreenUtil().setWidth(380),
                margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setWidth(20),
                ),
                child: ListView(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(30),
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: recommendUsers.take(10).map((item) {
                    return Container(
                      width: ScreenUtil().setWidth(250),
                      height: ScreenUtil().setWidth(380),
                      margin: EdgeInsets.only(
                        right: ScreenUtil().setWidth(30),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(8),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(110),
                            height: ScreenUtil().setWidth(110),
                            margin: EdgeInsets.only(
                              top: ScreenUtil().setWidth(30),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(53),
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                Utils.generateImgUrlFromId(
                                  id: item.targetId,
                                  aspectRatio: '1:1',
                                  type: 'head',
                                ),
                              ),
                              radius: ScreenUtil().setWidth(55),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                    top: ScreenUtil().setWidth(30),
                                  ),
                                  child: Text(
                                    item.targetName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: ScreenUtil().setSp(28),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(20),
                                  ),
                                  margin: EdgeInsets.only(
                                    top: ScreenUtil().setWidth(10),
                                  ),
                                  child: Text(
                                    item.targetDesc,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: ScreenUtil().setSp(20),
                                      height: 0.8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: ScreenUtil().setWidth(10),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'lib/images/icon_flow_bg.png',
                                  width: ScreenUtil().setWidth(150),
                                ),
                                Text(
                                  '+关注',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(24),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(50),
          ),
          alignment: Alignment.center,
          child: Text(
            '小主没有更多了呢！',
            style: TextStyle(
              color: Colors.grey,
              fontSize: ScreenUtil().setSp(24),
            ),
          ),
        ),
      ]),
    );
  }
}
