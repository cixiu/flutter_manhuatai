import 'dart:async';

import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/common/model/common_satellite_comment.dart';
import 'package:flutter_manhuatai/components/comment_text_input/comment_text_input.dart';
import 'package:flutter_manhuatai/components/custom_router/custom_router.dart';
import 'package:flutter_manhuatai/pages/comment_reply/comment_reply.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/components/comment_user_header/comment_user_header.dart';
import 'package:flutter_manhuatai/components/post_item/post_special_text_span_builder.dart';

import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/models/comment_user.dart' as CommentUser;
import 'package:oktoast/oktoast.dart';

// typedef void SupportComment(SatelliteComment comment);

class CommentContentItem extends StatefulWidget {
  final bool isReplyDetail; // 是否是回复的详情页
  final bool needReplyed; // 是否需要带上{reply:'xxx'}的内容，也就是是否是直接回复，还是评论
  final bool isComicComment;
  final CommonSatelliteComment item;
  final GlobalKey<CommentTextInputState> inputKey;

  CommentContentItem({
    this.isReplyDetail = false,
    this.needReplyed = true,
    this.isComicComment = false,
    this.item,
    this.inputKey,
  });

  @override
  _CommentContentItemState createState() => _CommentContentItemState();
}

class _CommentContentItemState extends State<CommentContentItem> {
  String _formatSupportCount(int count) {
    if (count > 10000) {
      return '${(count / 10000).toStringAsFixed(1)}万';
    }
    return count.toString();
  }

  void _setReplyComment(CommonSatelliteComment item) {
    widget.inputKey.currentState
        .focus(hintText: '回复：${item.fatherComment.uname}');
    widget.inputKey.currentState.replyComment(
      isReply: widget.needReplyed,
      comment: item.fatherComment,
    );
  }

  Future<void> _supportComment({
    BuildContext context,
    SatelliteComment comment,
  }) async {
    var user = User(context);
    if (!user.hasLogin) {
      showToast('点赞失败，请先登录');
      return;
    }

    var success = await Api.supportComment(
      type: user.info.type,
      openid: user.info.openid,
      authorization: user.info.authData.authcode,
      userIdentifier: user.info.uid,
      userLevel: user.info.ulevel,
      status: comment.status == 1 ? 0 : 1,
      ssid: comment.ssid,
      commentId: comment.id,
    );

    if (success) {
      setState(() {
        if (comment.status == 1) {
          comment.status = 0;
          comment.supportcount += 1;
        } else {
          comment.status = 1;
          comment.supportcount -= 1;
        }
      });
    } else {
      // showToast('点赞失败，请稍后再试。');
      setState(() {
        if (comment.status == 1) {
          comment.status = 0;
        } else {
          comment.status = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry margin = EdgeInsets.only(
      left: ScreenUtil().setWidth(130),
      right: ScreenUtil().setWidth(30),
      bottom: ScreenUtil().setWidth(20),
    );

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
            item: CommentUserHeaderType(
              uid: widget.item.fatherComment.uid,
              uname: widget.item.fatherComment.uname,
              ulevel: widget.item.fatherComment.ulevel,
              floorDesc: widget.item.fatherComment.floorDesc,
              createtime: widget.item.fatherComment.createtime,
              deviceTail: widget.item.fatherComment.deviceTail,
            ),
          ),
        ),
        _buildFatherCommentContent(
          context: context,
          margin: margin,
          item: widget.item,
        ),
        !widget.isReplyDetail && widget.item.childrenCommentList.length != 0
            ? _buildChildrenComments(
                context: context,
                margin: margin,
                item: widget.item,
              )
            : Container(),
        _buildBottomActionIcons(
          context: context,
          margin: margin,
          item: widget.item,
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
  }

  Widget _buildFatherCommentContent({
    BuildContext context,
    EdgeInsetsGeometry margin,
    CommonSatelliteComment item,
  }) {
    String content = item.fatherComment.content;
    var replyReg = RegExp(r'{reply:“(\d+)”}');
    var match = replyReg.firstMatch(content.trim());
    int replyCommentUserId;
    CommentUser.Data replyCommentUser;
    // 如果这条评论是回复的另一条评论，则拼凑出回复评论的格式
    if (match != null) {
      replyCommentUserId = int.tryParse(match.group(1));
      replyCommentUser = item.replyUserMap[replyCommentUserId];
      content = content.replaceAllMapped(
        replyReg,
        (matches) {
          return replyCommentUser != null
              ? '{reply:${replyCommentUser.uname}：}'
              : '';
        },
      );
      content = replyCommentUser != null ? '回复$content' : content;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!widget.isReplyDetail) {
          _setReplyComment(item);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: margin,
        child: ExtendedText(
          content,
          specialTextSpanBuilder: PostSpecialTextSpanBuilder(
            replyTap: () {
              print('${replyCommentUser.uname}: ${replyCommentUser.uid}');
            },
          ),
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: ScreenUtil().setSp(!widget.isReplyDetail ? 26 : 28),
          ),
        ),
      ),
    );
  }

  Widget _buildChildrenComments({
    BuildContext context,
    EdgeInsetsGeometry margin,
    CommonSatelliteComment item,
  }) {
    var fatherComment = item.fatherComment;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CustomRouter(
            CommentReplyPage(
              fatherComment: item.fatherComment,
              title: item.fatherComment.relateid.isEmpty
                  ? '${item.fatherComment.floorDesc}的回复'
                  : '吐槽详情',
              isComicComment: widget.isComicComment,
            ),
          ),
        );
      },
      child: Container(
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
                        return replyCommentUser != null
                            ? '{reply:${replyCommentUser.uname}：}'
                            : '';
                      },
                    );
                    content = replyCommentUser != null
                        ? '@${comment.uname}： 回复 $content'
                        : '@${comment.uname}：：$content';
                  } else {
                    content = '@${comment.uname}：：${comment.content}';
                  }
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: ScreenUtil().setWidth(10),
                    ),
                    child: ExtendedText(
                      '$content',
                      maxLines: 3,
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
                '共${fatherComment.revertcount}条回复>',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: ScreenUtil().setWidth(22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionIcons({
    BuildContext context,
    EdgeInsetsGeometry margin,
    CommonSatelliteComment item,
  }) {
    int supportcount = item.fatherComment.supportcount;

    return Container(
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // TODO:与relationId相关的信息，比如漫画评论的relationId是comicChapterId，这里需要显示漫画的章节信息
          //
          //
          item.relationInfo != null
              ? Expanded(
                  child: Text(
                    item.relationInfo.chapterName,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(24),
                    ),
                  ),
                )
              : Container(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _setReplyComment(item);
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
              ),
              child: Image.asset(
                'lib/images/icon_pinglun_pinglun_m.png',
                width: ScreenUtil().setWidth(40),
                height: ScreenUtil().setWidth(40),
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _supportComment(
                comment: item.fatherComment,
                context: context,
              );
              // if (supportComment != null) {
              //   supportComment(item.fatherComment);
              // }
            },
            child: Container(
              width: ScreenUtil().setWidth(100),
              margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
              ),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    item.fatherComment.status == 1
                        ? 'lib/images/icon_pinglun_weidianzan_m.png'
                        : 'lib/images/icon_pinglun_yidianzan_m.png',
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setWidth(40),
                  ),
                  Text(
                    '${supportcount == 0 ? ' ' : _formatSupportCount(supportcount)}',
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
