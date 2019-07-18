import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/components/comment_user_header/comment_user_header.dart';
import 'package:flutter_manhuatai/components/load_more_widget/load_more_widget.dart';
import 'package:flutter_manhuatai/components/post_item/post_special_text_span_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SatelliteDetailCommentSliverList extends StatelessWidget {
  final List<SatelliteComment> fatherCommentList;
  final bool hasMore;

  SatelliteDetailCommentSliverList({
    this.fatherCommentList,
    this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry margin = EdgeInsets.only(
      left: ScreenUtil().setWidth(130),
      right: ScreenUtil().setWidth(30),
      bottom: ScreenUtil().setWidth(20),
    );

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == fatherCommentList.length) {
            return LoadMoreWidget(
              hasMore: hasMore,
            );
          }

          var item = fatherCommentList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(30),
                ),
                margin: EdgeInsets.only(
                  top: ScreenUtil().setWidth(20),
                  bottom: ScreenUtil().setWidth(20),
                ),
                child: CommentUserHeader(
                  item: item,
                ),
              ),
              _buildFatherCommentContent(
                context: context,
                margin: margin,
                content: item.content,
              ),
              _buildBottomActionIcons(
                context: context,
                margin: margin,
                supportCount: item.supportcount,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: ScreenUtil().setWidth(1),
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(30),
                ),
                color: Colors.grey[350],
              )
            ],
          );
        },
        childCount: fatherCommentList.length + 1,
      ),
    );
  }

  // 一级评论的内容
  Widget _buildFatherCommentContent({
    BuildContext context,
    EdgeInsetsGeometry margin,
    String content,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: margin,
      child: ExtendedText(
        content,
        specialTextSpanBuilder: PostSpecialTextSpanBuilder(),
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: ScreenUtil().setSp(28),
        ),
      ),
    );
  }

  // 评论和点赞的操作区
  Widget _buildBottomActionIcons({
    BuildContext context,
    EdgeInsetsGeometry margin,
    int supportCount,
  }) {
    return Container(
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(30),
            ),
            child: Image.asset(
              'lib/images/icon_pinglun_pinglun_m.png',
              width: ScreenUtil().setWidth(40),
              height: ScreenUtil().setWidth(40),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(80),
            margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(20),
            ),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'lib/images/icon_pinglun_weidianzan_m.png',
                  width: ScreenUtil().setWidth(40),
                  height: ScreenUtil().setWidth(40),
                ),
                Text(
                  '${supportCount == 0 ? ' ' : supportCount}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil().setSp(24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
