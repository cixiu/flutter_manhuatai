import 'dart:async';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/model/chapter_info.dart';

import 'package:flutter_manhuatai/common/model/common_satellite_comment.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/models/comment_user.dart';

Future<List<CommonSatelliteComment>> getCommentListInfo({
  String type,
  String userType,
  String openid,
  String authorization,
  int page = 1,
  int ssid,
  int ssidtype,
  int fatherid = 0,
  int relationId,
  bool isComicComment = false,
}) async {
  var getSatelliteFatherComments = await Api.getFatherComments(
    authorization: authorization,
    page: page,
    ssid: ssid,
    ssidtype: ssidtype,
    fatherid: fatherid,
    type: type, // 用来判断获取哪种类型的评论
    // type: _commentType == WhyFarther.hot ? 'hot' : 'new', // 用来判断获取哪种类型的评论
    iswater: null,
  );

  List<int> userIds = [];
  List<int> commentIds = [];
  List<int> chapterIds = [];
  if (getSatelliteFatherComments.length == 0) {
    return [];
  } else {
    getSatelliteFatherComments.forEach((comment) {
      commentIds.add(comment.id);
      var match = RegExp(r'{reply:“(\d+)”}').firstMatch(comment.content.trim());
      if (match != null) {
        userIds.add(int.tryParse(match.group(1)));
      }
      if (!userIds.contains(comment.useridentifier)) {
        userIds.add(comment.useridentifier);
      }
      if (isComicComment && comment.relateid.isNotEmpty) {
        chapterIds.add(int.tryParse(comment.relateid));
      }
    });
  }

  List<ChapterInfo> chapterInfoList = [];
  if (isComicComment) {
    chapterInfoList = await Api.getChapterInfoByChapterId(
      chapterIds: chapterIds,
    );
  }

  // List<int> commentIds =
  //     getSatelliteFatherComments.map((item) => item.id).toList();
  // 获取帖子的一级评论下需要显示的二级评论
  var getSatelliteChildrenCommentsRes = await Api.getChildrenComments(
    type: userType,
    openid: openid,
    authorization: authorization,
    commentIds: commentIds,
  );

  if (getSatelliteChildrenCommentsRes.length != 0) {
    getSatelliteChildrenCommentsRes.forEach((comment) {
      var match = RegExp(r'{reply:“(\d+)”}').firstMatch(comment.content.trim());
      if (match != null) {
        userIds.add(int.tryParse(match.group(1)));
      }
      if (!userIds.contains(comment.useridentifier)) {
        userIds.add(comment.useridentifier);
      }
    });
  }

  var getCommentUserRes = CommentUser.fromJson({});
  if (userIds.length != 0) {
    getCommentUserRes = await Api.getCommentUser(
      relationId: relationId,
      opreateType: 2,
      userids: userIds,
    );
  }

  Map<int, Data> commentUserMap = Map();
  if (getCommentUserRes.data != null) {
    getCommentUserRes.data.forEach((item) {
      if (commentUserMap[item.uid] == null) {
        commentUserMap[item.uid] = item;
      }
    });
  }

  if (getSatelliteChildrenCommentsRes.length != 0) {
    getSatelliteChildrenCommentsRes =
        getSatelliteChildrenCommentsRes.map((child) {
      if (commentUserMap[child.useridentifier] != null) {
        var commentUser = commentUserMap[child.useridentifier];
        child.uid = commentUser.uid;
        child.uname = commentUser.uname;
      }
      return child;
    }).toList();
  }

  return getSatelliteFatherComments.map((item) {
    List<SatelliteComment> childrenCommentList = [];
    Map<int, Data> replyUserMap = {};
    ChapterInfo relationInfo;

    // 将reply格式所匹配到的用户加入Map中
    var fatherMatch =
        RegExp(r'{reply:“(\d+)”}').firstMatch(item.content.trim());
    if (fatherMatch != null) {
      int replyCommentUserId = int.tryParse(fatherMatch.group(1));
      replyUserMap[replyCommentUserId] = commentUserMap[replyCommentUserId];
    }

    if (getSatelliteChildrenCommentsRes.length != 0) {
      getSatelliteChildrenCommentsRes.forEach((child) {
        if (child.fatherid == item.id) {
          childrenCommentList.add(child);
        }

        var match = RegExp(r'{reply:“(\d+)”}').firstMatch(child.content.trim());
        if (match != null) {
          int replyCommentUserId = int.tryParse(match.group(1));
          replyUserMap[replyCommentUserId] = commentUserMap[replyCommentUserId];
        }
      });
    }

    // 如果是漫画的评论
    if (isComicComment && chapterInfoList.length != 0) {
      chapterInfoList.forEach((chapterInfo) {
        if (int.tryParse(item.relateid) == chapterInfo.chapterTopicId) {
          relationInfo = chapterInfo;
        }
      });
    }

    return CommonSatelliteComment(
      fatherComment: item,
      childrenCommentList: childrenCommentList,
      replyUserMap: replyUserMap,
      relationInfo: relationInfo,
    );
  }).toList();
}
