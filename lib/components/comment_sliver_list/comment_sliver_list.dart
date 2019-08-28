import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/model/common_satellite_comment.dart';
import 'package:flutter_manhuatai/components/comment_content_item/comment_content_item.dart';
import 'package:flutter_manhuatai/components/comment_text_input/comment_text_input.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/components/comment_user_header/comment_user_header.dart';
import 'package:flutter_manhuatai/components/load_more_widget/load_more_widget.dart';
import 'package:flutter_manhuatai/components/post_item/post_special_text_span_builder.dart';

import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/models/comment_user.dart' as CommentUser;

typedef void SupportComment(SatelliteComment comment);

class CommentSliverList extends StatelessWidget {
  final bool isReplyDetail;
  final List<CommonSatelliteComment> fatherCommentList;
  final bool hasMore;
  final SupportComment supportComment;
  final int relationId;
  final GlobalKey<CommentTextInputState> inputKey;

  CommentSliverList({
    this.isReplyDetail = false,
    this.fatherCommentList,
    this.hasMore,
    this.supportComment,
    this.relationId,
    this.inputKey,
  });

  String _formatSupportCount(int count) {
    if (count > 10000) {
      return '${(count / 10000).toStringAsFixed(1)}万';
    }
    return count.toString();
  }

  // 设置要回复的评论的一些信息
  void _setReplyComment(CommonSatelliteComment item) {
    inputKey.currentState.focus(hintText: '回复：${item.fatherComment.uname}');
    inputKey.currentState.replyComment(comment: item.fatherComment);
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
          return CommentContentItem(
            isReplyDetail: isReplyDetail,
            item: item,
            relationId: relationId,
            inputKey: inputKey,
            supportComment: supportComment,
          );
          // return Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     Container(
          //       padding: EdgeInsets.symmetric(
          //         horizontal: ScreenUtil().setWidth(30),
          //       ),
          //       margin: EdgeInsets.only(
          //         top: ScreenUtil().setWidth(20),
          //         bottom: ScreenUtil().setWidth(20),
          //       ),
          //       child: CommentUserHeader(
          //         item: CommentUserHeaderType(
          //           uid: item.fatherComment.uid,
          //           uname: item.fatherComment.uname,
          //           ulevel: item.fatherComment.ulevel,
          //           floorDesc: item.fatherComment.floorDesc,
          //           createtime: item.fatherComment.createtime,
          //           deviceTail: item.fatherComment.deviceTail,
          //         ),
          //       ),
          //     ),
          //     _buildFatherCommentContent(
          //       context: context,
          //       margin: margin,
          //       item: item,
          //     ),
          //     !isReplyDetail && item.childrenCommentList.length != 0
          //         ? _buildChildrenComments(
          //             context: context,
          //             margin: margin,
          //             item: item,
          //           )
          //         : Container(),
          //     _buildBottomActionIcons(
          //       context: context,
          //       margin: margin,
          //       item: item,
          //     ),
          //     Container(
          //       width: MediaQuery.of(context).size.width,
          //       height: ScreenUtil().setWidth(1),
          //       margin: EdgeInsets.symmetric(
          //         horizontal: ScreenUtil().setWidth(30),
          //       ),
          //       color: Colors.grey[350],
          //     )
          //   ],
          // );
        },
        childCount: fatherCommentList.length + 1,
      ),
    );
  }

  // // 一级评论的内容
  // Widget _buildFatherCommentContent({
  //   BuildContext context,
  //   EdgeInsetsGeometry margin,
  //   CommonSatelliteComment item,
  // }) {
  //   String content = item.fatherComment.content;
  //   var replyReg = RegExp(r'{reply:“(\d+)”}');
  //   var match = replyReg.firstMatch(content.trim());
  //   int replyCommentUserId;
  //   CommentUser.Data replyCommentUser;
  //   // 如果这条评论是回复的另一条评论，则拼凑出回复评论的格式
  //   if (match != null) {
  //     replyCommentUserId = int.tryParse(match.group(1));
  //     replyCommentUser = item.replyUserMap[replyCommentUserId];
  //     content = content.replaceAllMapped(
  //       replyReg,
  //       (matches) {
  //         return '{reply:${replyCommentUser.uname}：}';
  //       },
  //     );
  //     content = '回复$content';
  //   }

  //   return GestureDetector(
  //     behavior: HitTestBehavior.opaque,
  //     onTap: () {
  //       if (!isReplyDetail) {
  //         _setReplyComment(item);
  //       }
  //     },
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       margin: margin,
  //       child: ExtendedText(
  //         content,
  //         specialTextSpanBuilder: PostSpecialTextSpanBuilder(
  //           replyTap: () {
  //             print('${replyCommentUser.uname}: ${replyCommentUser.uid}');
  //           },
  //         ),
  //         style: TextStyle(
  //           color: Colors.grey[800],
  //           fontSize: ScreenUtil().setSp(!isReplyDetail ? 26 : 28),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // // 二级评论
  // Widget _buildChildrenComments({
  //   BuildContext context,
  //   EdgeInsetsGeometry margin,
  //   CommonSatelliteComment item,
  // }) {
  //   var fatherComment = item.fatherComment;
  //   return GestureDetector(
  //     onTap: () {
  //       Application.router.navigateTo(
  //         context,
  //         '${Routes.commentReply}?commentId=${fatherComment.id}&ssid=${fatherComment.ssid}&relationId=$relationId&floorNum=${fatherComment.floorNum}&commentUserid=${fatherComment.uid}&commentUsername=${Uri.encodeComponent(fatherComment.uname)}&commentUserlevel=${fatherComment.ulevel}&commentUserdeviceTail=${fatherComment.deviceTail}',
  //       );
  //     },
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       margin: margin,
  //       padding: EdgeInsets.symmetric(
  //         vertical: ScreenUtil().setWidth(20),
  //         horizontal: ScreenUtil().setWidth(15),
  //       ),
  //       decoration: BoxDecoration(
  //         color: Colors.grey[200],
  //         borderRadius: BorderRadius.circular(
  //           ScreenUtil().setWidth(8),
  //         ),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Container(
  //             margin: EdgeInsets.only(
  //               bottom: ScreenUtil().setWidth(10),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: item.childrenCommentList.take(2).map((comment) {
  //                 String content = '';
  //                 var replyReg = RegExp(r'{reply:“(\d+)”}');
  //                 var match = replyReg.firstMatch(comment.content.trim());
  //                 int replyCommentUserId;
  //                 CommentUser.Data replyCommentUser;
  //                 // 如果这条评论是回复的另一条评论，则拼凑出回复评论的格式
  //                 if (match != null) {
  //                   replyCommentUserId = int.tryParse(match.group(1));
  //                   replyCommentUser = item.replyUserMap[replyCommentUserId];
  //                   content = comment.content.replaceAllMapped(
  //                     replyReg,
  //                     (matches) {
  //                       return '{reply:${replyCommentUser.uname}：}';
  //                     },
  //                   );
  //                   content = '@${comment.uname}： 回复 $content';
  //                 } else {
  //                   content = '@${comment.uname}：：${comment.content}';
  //                 }

  //                 return Container(
  //                   margin: EdgeInsets.only(
  //                     bottom: ScreenUtil().setWidth(10),
  //                   ),
  //                   child: ExtendedText(
  //                     '$content',
  //                     specialTextSpanBuilder: PostSpecialTextSpanBuilder(
  //                       selfStyle: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: ScreenUtil().setSp(22),
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                       selfTap: () {
  //                         print('${comment.uname}: ${comment.uid}');
  //                       },
  //                       replyStyle: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: ScreenUtil().setSp(22),
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                       replyTap: () {
  //                         print(
  //                             '${replyCommentUser.uname}: ${replyCommentUser.uid}');
  //                       },
  //                     ),
  //                     style: TextStyle(
  //                       color: Colors.grey[800],
  //                       fontSize: ScreenUtil().setSp(22),
  //                     ),
  //                   ),
  //                 );
  //               }).toList(),
  //             ),
  //           ),
  //           Container(
  //             child: Text(
  //               '共${fatherComment.revertcount}条回复>',
  //               style: TextStyle(
  //                 color: Colors.blue,
  //                 fontSize: ScreenUtil().setWidth(22),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // // 评论和点赞的操作区
  // Widget _buildBottomActionIcons({
  //   BuildContext context,
  //   EdgeInsetsGeometry margin,
  //   CommonSatelliteComment item,
  // }) {
  //   int supportcount = item.fatherComment.supportcount;

  //   return Container(
  //     margin: margin,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: <Widget>[
  //         GestureDetector(
  //           behavior: HitTestBehavior.opaque,
  //           onTap: () {
  //             _setReplyComment(item);
  //           },
  //           child: Container(
  //             margin: EdgeInsets.symmetric(
  //               horizontal: ScreenUtil().setWidth(30),
  //             ),
  //             child: Image.asset(
  //               'lib/images/icon_pinglun_pinglun_m.png',
  //               width: ScreenUtil().setWidth(40),
  //               height: ScreenUtil().setWidth(40),
  //             ),
  //           ),
  //         ),
  //         GestureDetector(
  //           behavior: HitTestBehavior.opaque,
  //           onTap: () {
  //             if (supportComment != null) {
  //               supportComment(item.fatherComment);
  //             }
  //           },
  //           child: Container(
  //             width: ScreenUtil().setWidth(100),
  //             margin: EdgeInsets.only(
  //               left: ScreenUtil().setWidth(20),
  //             ),
  //             child: Row(
  //               children: <Widget>[
  //                 Image.asset(
  //                   item.fatherComment.status == 1
  //                       ? 'lib/images/icon_pinglun_weidianzan_m.png'
  //                       : 'lib/images/icon_pinglun_yidianzan_m.png',
  //                   width: ScreenUtil().setWidth(40),
  //                   height: ScreenUtil().setWidth(40),
  //                 ),
  //                 Text(
  //                   '${supportcount == 0 ? ' ' : _formatSupportCount(supportcount)}',
  //                   style: TextStyle(
  //                     color: Colors.grey,
  //                     fontSize: ScreenUtil().setSp(24),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
