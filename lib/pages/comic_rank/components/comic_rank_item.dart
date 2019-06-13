import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/models/rank_data_detials.dart'
    as RankDataDetials;
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

    return Container(
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
                        Text(comicItem.comicName),
                        // 漫画出品公司
                        Text(comicItem.authorName),
                      ],
                    ),
                    Text('${index + 1}'),
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
                      ),
                    ),
                    // 当周人气
                    Text('${Utils.formatNumber(comicItem.countNum)} 当周人气'),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
