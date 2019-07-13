import 'dart:convert';
import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/components/crop_image/crop_image.dart';
import 'package:flutter_manhuatai/components/pic_swiper/pic_swiper.dart';
import 'package:flutter_manhuatai/components/post_item/post_special_text_span_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/models/recommend_satellite.dart'
    as RecommendSatellite;
import 'package:html_unescape/html_unescape.dart';
// import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;

typedef void CurrentTap(int index);

class SatelliteContent extends StatelessWidget {
  final Satellite item;
  // final UserRoleInfo.Data roleInfo;

  SatelliteContent({
    this.item,
  });

  void previewImage({
    BuildContext context,
    int index,
    List<ImageItem> imageList,
  }) {
    var page = PicSwiper(
      index,
      imageList.map<PicSwiperItem>((item) {
        return PicSwiperItem(
          item.url,
        );
      }).toList(),
    );

    Navigator.push(
      context,
      Platform.isAndroid
          ? TransparentMaterialPageRoute(
              builder: (_) {
                return page;
              },
            )
          : TransparentCupertinoPageRoute(
              builder: (_) {
                return page;
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildContentTitle(),
              _buildContentContent(),
              _buildContentImages(context),
              _buildContentStarName(),
            ],
          ),
        ),
        _buildContentBottomAction(),
      ],
    );
  }

  Widget _buildContentTitle() {
    return item.showTitle == 1 || item.iselite == 1 || item.istop == 1
        ? Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setWidth(20),
            ),
            child: Row(
              children: <Widget>[
                item.istop == 1
                    ? Container(
                        margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(10),
                        ),
                        child: Image.asset(
                          'lib/images/icon_task_zhiding_words_bg.png',
                          width: ScreenUtil().setWidth(70),
                          height: ScreenUtil().setWidth(36),
                        ),
                      )
                    : Container(),
                item.iselite == 1
                    ? Container(
                        margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(10),
                        ),
                        child: Image.asset(
                          'lib/images/icon_task_jiajing_words_bg.png',
                          width: ScreenUtil().setWidth(70),
                          height: ScreenUtil().setWidth(36),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: Text(
                    item.title.replaceAll('\n', ' '),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: item.titleColor.isEmpty
                          ? Colors.black
                          : Color(int.parse('0xFF${item.titleColor}')),
                      fontSize: ScreenUtil().setSp(32),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();
  }

  Widget _buildContentContent() {
    var unescape = HtmlUnescape();
    // 将 html 标签去掉
    var htmlReg = RegExp('<[^>]+>');
    var content = item.content.replaceAll(htmlReg, '').replaceAll(' ', '');
    content = unescape.convert(content);

    return content.isEmpty
        ? Container()
        : Container(
            margin: EdgeInsets.only(
              bottom: ScreenUtil().setWidth(20),
              top: ScreenUtil().setWidth(10),
            ),
            child: ExtendedText(
              content,
              overflow: ExtendedTextOverflow.ellipsis,
              specialTextSpanBuilder: PostSpecialTextSpanBuilder(),
              maxLines: 3,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: ScreenUtil().setSp(24),
                height: 1.2,
              ),
            ),
          );
  }

  Widget _buildContentImages(BuildContext context) {
    List<dynamic> images = json.decode(item.images);
    if (images.length == 0) {
      return Container();
    }

    List<ImageItem> imageViewList = [];
    var reg = RegExp(r'@#de<!--IMG#\d+-->@#de(\d+:\d+)');

    images.forEach((item) {
      String url = '';
      int width = 0;
      int height = 0;
      String imgUrl = (item as String).replaceAllMapped(
        reg,
        (matches) {
          List<String> imgWidthAndHeight = matches[1].split(':');
          width = int.parse(imgWidthAndHeight[0]);
          height = int.parse(imgWidthAndHeight[1]);
          return '';
        },
      );

      url = 'https://comment.yyhao.com/${imgUrl}';
      imageViewList.add(ImageItem(
        url: url,
        width: width,
        height: height,
      ));

      return url;
    });

    return Container(
      width: ScreenUtil().setWidth(710),
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(20),
      ),
      child: Stack(
        children: <Widget>[
          _buildContentViewImages(
              imageViewList: imageViewList,
              onTap: (int index) {
                previewImage(
                  context: context,
                  index: index,
                  imageList: imageViewList,
                );
              }),
          imageViewList.length > 3
              ? Positioned(
                  bottom: ScreenUtil().setWidth(20),
                  right: -ScreenUtil().setWidth(20),
                  child: Container(
                    width: ScreenUtil().setWidth(100),
                    height: ScreenUtil().setWidth(40),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(20),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.image,
                          color: Colors.white,
                          size: ScreenUtil().setSp(24),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(10),
                          ),
                          child: Text(
                            '${imageViewList.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildContentViewImages({
    List<ImageItem> imageViewList,
    CurrentTap onTap,
  }) {
    int length = imageViewList.length;
    double maxWidth = ScreenUtil().setWidth(690);
    double marginWidth = ScreenUtil().setWidth(20);

    if (length == 1) {
      var item = imageViewList.first;
      var width = maxWidth;
      var height = width / 2;
      return ClipRRect(
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(12),
        ),
        child: CropImage(
          item: item,
          imageList: imageViewList,
          index: 0,
          thumbWidth: width,
          thumbHeight: height,
          fit: BoxFit.cover,
          autoSetSize: false,
          knowImageSize: false,
        ),
      );
    }

    if (length == 2) {
      var width = (maxWidth - marginWidth) / 2;
      var height = width;
      List<Widget> _children = [];

      for (int i = 0; i < length; i++) {
        var item = imageViewList[i];
        _children.add(ClipRRect(
          borderRadius: BorderRadius.circular(
            ScreenUtil().setWidth(12),
          ),
          child: CropImage(
            item: item,
            index: i,
            thumbWidth: width,
            thumbHeight: height,
            fit: BoxFit.cover,
            autoSetSize: false,
            knowImageSize: false,
            imageList: imageViewList,
          ),
        ));
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _children,
      );
    }

    var item1 = imageViewList[0];
    var item2 = imageViewList[1];
    var item3 = imageViewList[2];
    double itemWidth = (maxWidth - marginWidth) / 3;
    double firthWidth = itemWidth * 2;
    double firthHeight = firthWidth;
    double secondWidth = itemWidth;
    double secondHeight = (firthHeight - marginWidth) / 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(
            ScreenUtil().setWidth(12),
          ),
          child: CropImage(
            item: item1,
            index: 0,
            thumbWidth: firthWidth,
            thumbHeight: firthHeight,
            fit: BoxFit.cover,
            autoSetSize: false,
            knowImageSize: false,
            imageList: imageViewList,
          ),
        ),
        Container(
          height: firthHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(12),
                ),
                child: CropImage(
                  item: item2,
                  index: 1,
                  thumbWidth: secondWidth,
                  thumbHeight: secondHeight,
                  fit: BoxFit.cover,
                  autoSetSize: false,
                  knowImageSize: false,
                  imageList: imageViewList,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(12),
                ),
                child: CropImage(
                  item: item3,
                  index: 2,
                  thumbWidth: secondWidth,
                  thumbHeight: secondHeight,
                  fit: BoxFit.cover,
                  autoSetSize: false,
                  knowImageSize: false,
                  imageList: imageViewList,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildContentStarName() {
    if (item.stars.length == 0) {
      return Container();
    }

    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(20),
      ),
      child: Row(
        children: item.stars.map((star) {
          return Container(
            height: ScreenUtil().setWidth(40),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(10),
            ),
            margin: EdgeInsets.only(
              right: ScreenUtil().setWidth(20),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(12),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              star.name,
              strutStyle: StrutStyle(
                forceStrutHeight: true,
                fontSize: ScreenUtil().setWidth(22),
              ),
              style: TextStyle(
                color: Colors.grey,
                fontSize: ScreenUtil().setWidth(22),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContentBottomAction() {
    return Container(
      height: ScreenUtil().setWidth(86),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[350],
            width: ScreenUtil().setWidth(1),
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          _buildContentBottomActionItem(
            text: '更多',
            icon: 'lib/images/icon_newsc_more.png',
          ),
          _buildContentBottomActionItem(
            text: '${item.replynum}',
            icon: 'lib/images/icon_newsc_comment.png',
          ),
          _buildContentBottomActionItem(
            text: '${item.supportnum.toInt()}',
            icon: 'lib/images/icon_weidianzan_cat.png',
          ),
        ],
      ),
    );
  }

  Widget _buildContentBottomActionItem({
    String text,
    String icon,
  }) {
    return Expanded(
      child: InkResponse(
        onTap: () {},
        containedInkWell: true,
        highlightShape: BoxShape.rectangle,
        child: Container(
          height: ScreenUtil().setWidth(86),
          constraints: BoxConstraints(
            maxWidth: ScreenUtil().setWidth(120),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  right: ScreenUtil().setWidth(10),
                ),
                child: Image.asset(
                  '$icon',
                  width: ScreenUtil().setWidth(28),
                  height: ScreenUtil().setWidth(28),
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                '$text',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: ScreenUtil().setSp(24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
