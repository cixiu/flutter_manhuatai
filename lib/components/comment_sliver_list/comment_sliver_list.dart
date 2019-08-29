import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/common/model/common_satellite_comment.dart';
import 'package:flutter_manhuatai/components/comment_content_item/comment_content_item.dart';
import 'package:flutter_manhuatai/components/comment_text_input/comment_text_input.dart';

import 'package:flutter_manhuatai/components/load_more_widget/load_more_widget.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';

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

  @override
  Widget build(BuildContext context) {
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
        },
        childCount: fatherCommentList.length + 1,
      ),
    );
  }
}
