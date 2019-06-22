import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/components/match_text/match_text.dart';
import 'package:flutter_manhuatai/models/get_channels_res.dart'
    as GetChannelsRes;
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

class RelatedChannels extends StatelessWidget {
  final String keyword;
  final List<GetChannelsRes.Data> relatedChannelList;

  RelatedChannels({
    this.keyword,
    this.relatedChannelList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(
        ScreenUtil().setWidth(20),
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
              padding: EdgeInsets.only(
                bottom: ScreenUtil().setWidth(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '相关频道(${relatedChannelList.length})',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(32),
                    ),
                  ),
                  relatedChannelList.length > 2
                      ? Container(
                          height: ScreenUtil().setWidth(32),
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: ScreenUtil().setWidth(1),
                            ),
                            borderRadius: BorderRadius.circular(
                              ScreenUtil().setWidth(14),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '全部',
                            strutStyle: StrutStyle(
                              forceStrutHeight: true,
                              fontSize: ScreenUtil().setSp(20),
                            ),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenUtil().setSp(20),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: relatedChannelList.take(2).map((item) {
                return Container(
                  height: ScreenUtil().setWidth(140),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                  ),
                  margin: EdgeInsets.only(
                    bottom: ScreenUtil().setWidth(50),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(50),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: ScreenUtil().setWidth(1),
                          ),
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setWidth(60),
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                            '${AppConst.commentImgHost}/${item.image}',
                          ),
                          radius: ScreenUtil().setWidth(60),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                MatchText(
                                  item.name,
                                  matchText: keyword,
                                  matchedStyle: TextStyle(
                                    color: Colors.blue,
                                    fontSize: ScreenUtil().setSp(32),
                                  ),
                                ),
                                Text(
                                  item.intro,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: ScreenUtil().setSp(24),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(20),
                                      ),
                                      child: Text(
                                        '${Utils.formatNumber(item.focusNum.toInt().toString())}人入驻',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: ScreenUtil().setSp(20),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '帖子: ${Utils.formatNumber(item.satelliteNum.toInt().toString())}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: ScreenUtil().setSp(20),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(120),
                                  height: ScreenUtil().setWidth(40),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(20),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: ScreenUtil().setWidth(24),
                                      ),
                                      Text(
                                        '入驻',
                                        strutStyle: StrutStyle(
                                          forceStrutHeight: true,
                                          fontSize: ScreenUtil().setWidth(24),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setWidth(24),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
