import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/models/book_list.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

class BookItemContent extends StatelessWidget {
  final double width;
  final double horizonratio;
  // 自定义显示比例，用于显示不同于 config.horizonratio 的图片 eg: '2:1'
  final String customHorizonratio;
  final Comic_info item;
  final Config config;

  BookItemContent({
    this.width,
    this.horizonratio,
    this.customHorizonratio,
    this.item,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ImageWrapper(
            url: Utils.formatBookImgUrl(
              comicInfo: item,
              config: config,
              customHorizonratio: customHorizonratio,
            ),
            width: width,
            height: width / horizonratio,
            // fit: BoxFit.fill,
          ),
          Container(
            margin: EdgeInsets.only(
              right: ScreenUtil().setWidth(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildComicName(),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setWidth(10),
                  ),
                  child: Text(
                    item.content,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(20),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildComicName() {
    TextStyle style = TextStyle(
      color: Colors.black,
      fontSize: ScreenUtil().setSp(28),
    );

    if (config.displayType == 9) {
      return _buildDisplay9ConfigName(style);
    }

    // displayType == 11 时，在漫画名字前面增加漫画的类型
    if (config.displayType == 11 && item.comicType.first.isNotEmpty) {
      return Container(
        padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(16),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setWidth(10),
                horizontal: ScreenUtil().setWidth(12),
              ),
              margin: EdgeInsets.only(
                right: ScreenUtil().setWidth(18),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[400],
                  width: ScreenUtil().setWidth(1),
                ),
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(25),
                ),
              ),
              child: Text(
                item.comicType.first,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: ScreenUtil().setSp(20),
                  height: 1.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                item.comicName,
                overflow: TextOverflow.ellipsis,
                style: style,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().setWidth(16),
      ),
      child: Text(
        item.comicName,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }

  Widget _buildDisplay9ConfigName(TextStyle style) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().setWidth(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            item.comicName,
            overflow: TextOverflow.ellipsis,
            style: style,
          ),
          Row(
            children: <Widget>[
              Image.asset(
                'lib/images/ic_recommend_hot_gray.png',
                width: ScreenUtil().setWidth(24),
              ),
              Text(
                Utils.formatNumber(item.totalViewNum),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenUtil().setWidth(20),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
