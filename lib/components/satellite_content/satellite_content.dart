import 'dart:convert';
import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/components/crop_image/crop_image.dart';
import 'package:flutter_manhuatai/components/pic_swiper/pic_swiper.dart';
import 'package:flutter_manhuatai/components/post_item/post_special_text_span_builder.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:html_unescape/html_unescape.dart';
// import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;

typedef void CurrentTap(int index);

class SatelliteContent extends StatelessWidget {
  final Satellite item;
  final bool isDetail;
  final VoidCallback supportSatellite;
  // final UserRoleInfo.Data roleInfo;

  SatelliteContent({
    this.item,
    this.isDetail = false,
    this.supportSatellite,
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

  void navigateToSatelliteDetail(BuildContext context) {
    Application.router.navigateTo(
      context,
      '${Routes.satelliteDetail}?satelliteId=${item.id}',
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
              _buildContentContent(context),
              isDetail ? Container() : _buildContentImages(context),
              _buildContentStarName(),
            ],
          ),
        ),
        isDetail ? Container() : _buildContentBottomAction(context),
      ],
    );
  }

  Widget _buildContentTitle() {
    return item.showTitle == 1 || item.iselite == 1 || item.istop == 1
        ? Container(
            margin: EdgeInsets.only(
              bottom: ScreenUtil().setWidth(20),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    child: item.istop == 1
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
                        : Text(''),
                  ),
                  WidgetSpan(
                    child: item.iselite == 1
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
                        : Text(''),
                  ),
                  TextSpan(
                    text: item.title.replaceAll('\n', ' '),
                    style: TextStyle(
                      color: item.titleColor.isEmpty
                          ? Colors.black
                          : Color(int.parse('0xFF${item.titleColor}')),
                      fontSize: ScreenUtil().setSp(32),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _buildContentContent(BuildContext context) {
    var unescape = HtmlUnescape();
    var content = item.content;

    // 将 html 标签去掉
    if (!isDetail) {
      var htmlReg = RegExp('<[^>]+>');
      content = content
          .replaceAll(htmlReg, '')
          .replaceAll(' ', '')
          .replaceAll(RegExp(r'^\n+'), '');
      content = unescape.convert(content);

      return content.isEmpty
          ? Container()
          : Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                bottom: ScreenUtil().setWidth(20),
                // top: ScreenUtil().setWidth(10),
              ),
              child: ExtendedText(
                content,
                overflow: isDetail ? null : TextOverflow.ellipsis,
                specialTextSpanBuilder: PostSpecialTextSpanBuilder(),
                maxLines: isDetail ? null : 3,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: ScreenUtil().setSp(28),
                  height: 1.2,
                ),
              ),
            );
    } else {
      List<dynamic> images =
          item.images.endsWith(']') ? json.decode(item.images) : [];
      content = unescape.convert(content);

      content = content.replaceAllMapped(
        RegExp(r'<!--IMG#(\d+)-->'),
        (matches) {
          String imgFlagString = matches[0];
          int index = int.tryParse(matches[1]);
          if (images.length == 0) {
            return '\n\${insert}\$%!--error--%\n\${insert}\$';
          } else {
            // 将images中对应的图片地址取出
            imgFlagString = images[index];
            return '\n\${insert}\$%!--$imgFlagString--%\n\${insert}\$';
          }
        },
      );
      List<String> contentList = content.split('\${insert}\$');

      List<ImageItem> imageList = [];
      contentList.forEach((item) {
        var match = RegExp(r'^%!--((.?)+)--%$').firstMatch(item.trim());
        if (match != null) {
          item = match.group(1);
          if (item != 'error') {
            var reg = RegExp(r'@#de<!--IMG#(\d+)-->@#de(\d+:\d+)');
            String url = '';
            double originWidth = 0;
            double originHeight = 0;
            String imgUrl = item.replaceAllMapped(
              reg,
              (matches) {
                List<String> imgWidthAndHeight = matches[2].split(':');
                originWidth = double.parse(imgWidthAndHeight[0]);
                originHeight = double.parse(imgWidthAndHeight[1]);
                return '';
              },
            );
            url = '${AppConst.commentImgHost}/$imgUrl';

            imageList.add(ImageItem(
              url: url,
              width: originWidth,
              height: originHeight,
            ));
          }
        }
      });

      return contentList.length == 0
          ? Container()
          : Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                bottom: ScreenUtil().setWidth(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: contentList.map((item) {
                  if (!item.startsWith('%!--') && !item.endsWith('--%')) {
                    return item.trim().isEmpty
                        ? Container()
                        : ExtendedText(
                            item,
                            overflow: isDetail ? null : TextOverflow.ellipsis,
                            specialTextSpanBuilder:
                                PostSpecialTextSpanBuilder(),
                            maxLines: isDetail ? null : 3,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: ScreenUtil().setSp(28),
                              height: 1.2,
                            ),
                          );
                  } else {
                    item = RegExp(r'^%!--((.?)+)--%$')
                        .firstMatch(item.trim())
                        .group(1);
                    if (item == 'error') {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setWidth(15),
                        ),
                        color: Colors.grey[200],
                        width: ScreenUtil().setWidth(690),
                        height: ScreenUtil().setWidth(330),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'lib/images/pic_cache.png',
                          width: ScreenUtil().setWidth(120),
                          height: ScreenUtil().setWidth(120),
                        ),
                      );
                    } else {
                      var reg = RegExp(r'@#de<!--IMG#(\d+)-->@#de(\d+:\d+)');
                      String url = '';
                      int index = 0;
                      double originWidth = 0;
                      double originHeight = 0;
                      double width = ScreenUtil().setWidth(690);
                      double height = 0;
                      String imgUrl = item.replaceAllMapped(
                        reg,
                        (matches) {
                          index = int.tryParse(matches[1]);
                          List<String> imgWidthAndHeight =
                              matches[2].split(':');
                          originWidth = double.parse(imgWidthAndHeight[0]);
                          originHeight = double.parse(imgWidthAndHeight[1]);
                          height = width * originHeight / originWidth;
                          return '';
                        },
                      );
                      url = '${AppConst.commentImgHost}/$imgUrl';

                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setWidth(15),
                        ),
                        child: CropImage(
                          item: ImageItem(
                            url: url,
                            width: originWidth,
                            height: originHeight,
                          ),
                          imageList: imageList,
                          index: index,
                          thumbWidth: width,
                          thumbHeight: height,
                          fit: BoxFit.cover,
                          autoSetSize: false,
                          knowImageSize: false,
                          needHero: false,
                        ),
                      );
                    }
                  }
                }).toList(),
              ),
            );
    }
  }

  Widget _buildContentImages(BuildContext context) {
    List<dynamic> images =
        item.images.endsWith(']') ? json.decode(item.images) : [];
    if (images.length == 0) {
      return Container();
    }

    List<ImageItem> imageViewList = [];
    var reg = RegExp(r'@#de<!--IMG#\d+-->@#de(\d+:\d+)');

    images.forEach((item) {
      String url = '';
      double width = 0;
      double height = 0;
      String imgUrl = (item as String).replaceAllMapped(
        reg,
        (matches) {
          List<String> imgWidthAndHeight = matches[1].split(':');
          width = double.parse(imgWidthAndHeight[0]);
          height = double.parse(imgWidthAndHeight[1]);
          return '';
        },
      );

      url = '${AppConst.commentImgHost}/$imgUrl';
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
        top: isDetail ? ScreenUtil().setWidth(40) : 0.0,
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

  Widget _buildContentBottomAction(BuildContext context) {
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
            icon: 'lib/images/icon_pinglun_gengduo_m.png',
          ),
          _buildContentBottomActionItem(
            text: '${item.replynum}',
            icon: 'lib/images/icon_pinglun_pinglun_m.png',
            // onTap: () {
            //   navigateToSatelliteDetail(context);
            // },
          ),
          _buildContentBottomActionItem(
              text: '${item.supportnum.toInt()}',
              icon: 'lib/images/icon_pinglun_weidianzan_m.png',
              activeIcon: 'lib/images/icon_pinglun_yidianzan_m.png',
              isActive: item.issupport == 1,
              onTap: () {
                if (supportSatellite != null) {
                  supportSatellite();
                }
              }),
        ],
      ),
    );
  }

  Widget _buildContentBottomActionItem({
    String text,
    String icon,
    String activeIcon,
    bool isActive = false,
    VoidCallback onTap,
  }) {
    return Expanded(
      child: InkResponse(
        onTap: onTap,
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
                  isActive ? '$activeIcon' : '$icon',
                  width: ScreenUtil().setWidth(48),
                  height: ScreenUtil().setWidth(48),
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                '$text',
                style: TextStyle(
                  color: isActive ? Colors.blue : Colors.grey[400],
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
