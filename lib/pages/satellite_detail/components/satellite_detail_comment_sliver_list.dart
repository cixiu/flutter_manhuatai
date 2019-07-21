import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/components/comment_user_header/comment_user_header.dart';
import 'package:flutter_manhuatai/components/load_more_widget/load_more_widget.dart';
import 'package:flutter_manhuatai/components/post_item/post_special_text_span_builder.dart';

import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/models/comment_user.dart' as CommentUser;

typedef void SupportComment(SatelliteComment comment);

class SatelliteDetailCommentSliverList extends StatelessWidget {
  final List<CommonSatelliteComment> fatherCommentList;
  final bool hasMore;
  final SupportComment supportComment;

  SatelliteDetailCommentSliverList({
    this.fatherCommentList,
    this.hasMore,
    this.supportComment,
  });

  String _formatSupportCount(int count) {
    if (count > 10000) {
      return '${(count / 10000).toStringAsFixed(1)}万';
    }
    return count.toString();
  }

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
                  item: item.fatherComment,
                ),
              ),
              _buildFatherCommentContent(
                context: context,
                margin: margin,
                content: item.fatherComment.content,
              ),
              item.childrenCommentList.length != 0
                  ? _buildChildrenComments(
                      context: context,
                      margin: margin,
                      item: item,
                    )
                  : Container(),
              _buildBottomActionIcons(
                context: context,
                margin: margin,
                comment: item.fatherComment,
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
          fontSize: ScreenUtil().setSp(26),
        ),
      ),
    );
  }

  // 二级评论
  Widget _buildChildrenComments({
    BuildContext context,
    EdgeInsetsGeometry margin,
    CommonSatelliteComment item,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: margin,
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(20),
        horizontal: ScreenUtil().setWidth(15),
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: ScreenUtil().setWidth(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: item.childrenCommentList.take(2).map((comment) {
                String content = '';
                var replyReg = RegExp(r'{reply:“(\d+)”}');
                var match = replyReg.firstMatch(comment.content.trim());
                int replyCommentUserId;
                CommentUser.Data replyCommentUser;
                // 如果这条评论是回复的另一条评论，则拼凑出回复评论的格式
                if (match != null) {
                  replyCommentUserId = int.tryParse(match.group(1));
                  replyCommentUser = item.replyUserMap[replyCommentUserId];
                  content = comment.content.replaceAllMapped(
                    replyReg,
                    (matches) {
                      return '{reply:${replyCommentUser.uname}：}';
                    },
                  );
                  content = '@${comment.uname}： 回复 $content';
                } else {
                  content = '@${comment.uname}：：${comment.content}';
                }

                return Container(
                  margin: EdgeInsets.only(
                    bottom: ScreenUtil().setWidth(10),
                  ),
                  child: ExtendedText(
                    '$content',
                    specialTextSpanBuilder: PostSpecialTextSpanBuilder(
                      selfStyle: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(22),
                        fontWeight: FontWeight.bold,
                      ),
                      selfTap: () {
                        print('${comment.uname}: ${comment.uid}');
                      },
                      replyStyle: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(22),
                        fontWeight: FontWeight.bold,
                      ),
                      replyTap: () {
                        print(
                            '${replyCommentUser.uname}: ${replyCommentUser.uid}');
                      },
                    ),
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: ScreenUtil().setSp(22),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            child: Text(
              '共${item.fatherComment.revertcount}条回复>',
              style: TextStyle(
                color: Colors.blue,
                fontSize: ScreenUtil().setWidth(22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 评论和点赞的操作区
  Widget _buildBottomActionIcons({
    BuildContext context,
    EdgeInsetsGeometry margin,
    SatelliteComment comment,
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
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (supportComment != null) {
                supportComment(comment);
              }
            },
            child: Container(
              width: ScreenUtil().setWidth(100),
              margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
              ),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    comment.status == 1
                        ? 'lib/images/icon_pinglun_weidianzan_m.png'
                        : 'lib/images/icon_pinglun_yidianzan_m.png',
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setWidth(40),
                  ),
                  Text(
                    '${comment.supportcount == 0 ? ' ' : _formatSupportCount(comment.supportcount)}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(24),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommonSatelliteComment {
  final SatelliteComment fatherComment;
  final List<SatelliteComment> childrenCommentList;
  final Map<int, CommentUser.Data> replyUserMap;

  CommonSatelliteComment({
    this.fatherComment,
    this.childrenCommentList,
    this.replyUserMap,
  });
}
