import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/models/rank_data_detials.dart'
    as RankDataDetials;
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComicRankItem extends StatelessWidget {
  final RankDataDetials.Data comicItem;
  final int index;

  ComicRankItem({
    this.comicItem,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    String imgUrl = Utils.generateImgUrlFromId(
      id: comicItem.comicId,
      aspectRatio: '3:4',
    );

    String sortTypelistText = comicItem.sortTypelist
        .replaceAll(RegExp(r'\w+,'), '')
        .replaceAll(RegExp(r'\|'), ' ');

    int riseRank = int.parse(comicItem.riseRank);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Application.router
            .navigateTo(context, '/comic/detail/${comicItem.comicId}');
      },
      child: Container(
        height: ScreenUtil().setWidth(236),
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
        ),
        margin: EdgeInsets.only(
          bottom: ScreenUtil().setWidth(30),
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                right: ScreenUtil().setWidth(20),
              ),
              child: ImageWrapper(
                url: imgUrl,
                width: ScreenUtil().setWidth(178),
                height: ScreenUtil().setWidth(236),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // 漫画名称
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setWidth(20),
                            ),
                            child: Text(
                              comicItem.comicName,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: ScreenUtil().setSp(28),
                              ),
                            ),
                          ),
                          // 漫画出品公司
                          Text(
                            comicItem.authorName,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenUtil().setSp(24),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Stack(
                            alignment: Alignment(0.0, 0.6),
                            children: <Widget>[
                              Image.asset(
                                'lib/images/icon_comicrank_1ph${index < 3 ? index + 1 : 4}.png',
                                width: ScreenUtil().setWidth(52),
                                height: ScreenUtil().setWidth(52),
                                fit: BoxFit.cover,
                              ),
                              Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(20),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 1.0,
                            ),
                            width: ScreenUtil().setWidth(52),
                            height: ScreenUtil().setWidth(24),
                            color: Colors.grey[100],
                            alignment: Alignment.center,
                            child: riseRank == 0
                                ? Container(
                                    width: ScreenUtil().setWidth(32),
                                    height: 2.0,
                                    color: Colors.grey,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        riseRank > 0
                                            ? 'lib/images/icon_comicrank_sjs28.png'
                                            : 'lib/images/icon_comicrank_sjj28.png',
                                        width: ScreenUtil().setWidth(16),
                                        height: ScreenUtil().setWidth(18),
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(1),
                                          top: ScreenUtil().setWidth(1),
                                        ),
                                        child: Text(
                                          '${riseRank.abs()}',
                                          strutStyle: StrutStyle(
                                            forceStrutHeight: true,
                                            fontSize: ScreenUtil().setSp(18),
                                          ),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: ScreenUtil().setSp(18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // 漫画类型
                      Expanded(
                        child: Text(
                          sortTypelistText,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenUtil().setSp(24),
                          ),
                        ),
                      ),
                      // 当周人气
                      Text(
                        '${Utils.formatNumber(comicItem.countNum)} 当周人气',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: ScreenUtil().setSp(20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
