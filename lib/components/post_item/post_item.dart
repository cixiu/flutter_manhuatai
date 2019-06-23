import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:extended_text/extended_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';

import 'package:flutter_manhuatai/models/get_satellite_res.dart'
    as GetSatelliteRes;
import 'package:flutter_manhuatai/models/comment_user.dart' as CommentUser;
import 'package:flutter_manhuatai/utils/utils.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/components/match_text/match_text.dart';

import 'post_special_text_span_builder.dart';

class PostItem extends StatelessWidget {
  final String keyword;
  final GetSatelliteRes.Data postItem;
  final CommentUser.Data postAuthor;

  PostItem({
    this.keyword = '',
    this.postItem,
    this.postAuthor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildPostAuthor(),
              _buildPostTitle(),
              _buildPostContent(),
              _buildPostImages(),
              _buildPostStarName(),
            ],
          ),
        ),
        _buildPostBottomAction(),
        Container(
          height: ScreenUtil().setWidth(14),
          color: Colors.grey[200],
        ),
      ],
    );
  }

  Widget _buildPostAuthor() {
    var authorImgUrl = Utils.generateImgUrlFromId(
      id: postAuthor.uid,
      aspectRatio: '1:1',
      type: 'head',
    );
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(30),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              right: ScreenUtil().setWidth(20),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: ScreenUtil().setWidth(1),
              ),
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(40),
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(authorImgUrl),
              radius: ScreenUtil().setWidth(40),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: ScreenUtil().setWidth(10),
                  ),
                  child: Text(
                    postAuthor.uname,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(28),
                    ),
                  ),
                ),
                Text(
                  Utils.formatDate(postItem.createTime),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil().setSp(20),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPostTitle() {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(20),
      ),
      child: MatchText(
        postItem.title,
        matchText: keyword,
        overflow: TextOverflow.visible,
        matchedStyle: TextStyle(
          color: Colors.blue,
          fontSize: ScreenUtil().setWidth(28),
        ),
      ),
    );
  }

  Widget _buildPostContent() {
    var unescape = HtmlUnescape();
    // 将 html 标签去掉
    var htmlReg = RegExp('<[^>]+>');
    var content = postItem.content
        .replaceAll(htmlReg, '')
        .replaceAll(' ', '')
        .replaceAll('\n', '');
    content = unescape.convert(content);

    return content.isEmpty
        ? Container()
        : Container(
            margin: EdgeInsets.only(
              bottom: ScreenUtil().setWidth(20),
            ),
            child: ExtendedText(
              content,
              overflow: ExtendedTextOverflow.ellipsis,
              specialTextSpanBuilder: PostSpecialTextSpanBuilder(),
              maxLines: 3,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: ScreenUtil().setSp(22),
              ),
            ),
          );
  }

  Widget _buildPostImages() {
    List<dynamic> images = json.decode(postItem.images);
    if (images.length == 0) {
      return Container();
    }

    List<ImageInfo> imageViewList = [];
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
      imageViewList.add(ImageInfo(
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
          _buildPostViewImages(
            imageViewList: imageViewList,
          ),
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

  Widget _buildPostStarName() {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(20),
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: ScreenUtil().setWidth(40),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(10),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(8),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              postItem.starName,
              strutStyle: StrutStyle(
                forceStrutHeight: true,
                fontSize: ScreenUtil().setWidth(22),
              ),
              style: TextStyle(
                color: Colors.grey,
                fontSize: ScreenUtil().setWidth(22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostBottomAction() {
    TextStyle style = TextStyle(
      color: Colors.grey[400],
      fontSize: ScreenUtil().setSp(24),
    );

    return Container(
      height: ScreenUtil().setWidth(86),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[350],
            width: ScreenUtil().setWidth(1),
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          _buildPostBottomActionItem(
            text: '更多',
            icon: Icon(
              Icons.more_horiz,
              color: Colors.grey[400],
              size: ScreenUtil().setWidth(28),
            ),
          ),
          _buildPostBottomActionItem(
            text: '${postItem.replyNum}',
            icon: Image.asset(
              'lib/images/icon_newsc_comment.png',
              width: ScreenUtil().setWidth(28),
              height: ScreenUtil().setWidth(28),
            ),
          ),
          _buildPostBottomActionItem(
            text: '${postItem.supportNum.toInt()}',
            icon: Icon(
              Icons.thumb_up,
              color: Colors.grey[400],
              size: ScreenUtil().setWidth(28),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostViewImages({List<ImageInfo> imageViewList}) {
    int length = imageViewList.length;
    double maxWidth = ScreenUtil().setWidth(710);
    double marginWidth = ScreenUtil().setWidth(20);

    if (length == 1) {
      var item = imageViewList.first;
      var width = maxWidth;
      var height = width / 2;
      return ImageWrapper(
        url: item.url,
        width: width,
        height: height,
      );
    }
    if (length == 2) {
      var width = (maxWidth - marginWidth) / 2;
      var height = width;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: imageViewList.map((item) {
          return ImageWrapper(
            url: item.url,
            width: width,
            height: height,
          );
        }).toList(),
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
        ImageWrapper(
          url: item1.url,
          width: firthWidth,
          height: firthHeight,
        ),
        Container(
          height: firthHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ImageWrapper(
                url: item2.url,
                width: secondWidth,
                height: secondHeight,
              ),
              ImageWrapper(
                url: item3.url,
                width: secondWidth,
                height: secondHeight,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPostBottomActionItem({
    String text,
    Widget icon,
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
                child: icon,
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

class ImageInfo {
  final String url;
  final int width;
  final int height;

  ImageInfo({
    this.url,
    this.width,
    this.height,
  });
}
