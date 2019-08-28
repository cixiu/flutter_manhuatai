import 'package:flutter_manhuatai/models/comment_user.dart' as CommentUser;

import 'satellite_comment.dart';

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
