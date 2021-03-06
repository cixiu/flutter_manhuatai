import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/common/model/common_satellite_comment.dart';
import 'package:flutter_manhuatai/components/comment_content_item/comment_content_item.dart';
import 'package:flutter_manhuatai/components/comment_text_input/comment_text_input.dart';

import 'package:flutter_manhuatai/components/load_more_widget/load_more_widget.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';

typedef void SupportComment(SatelliteComment comment);

class CommentSliverList extends StatelessWidget {
  final bool isReplyDetail;
  final bool isComicComment;
  final List<CommonSatelliteComment> fatherCommentList;
  final bool hasMore;
  final GlobalKey<CommentTextInputState> inputKey;

  CommentSliverList({
    this.isReplyDetail = false,
    this.isComicComment = false,
    this.fatherCommentList,
    this.hasMore,
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
          // return Text(item.fatherComment.uname);
          return CommentContentItem(
            isReplyDetail: isReplyDetail,
            item: item,
            inputKey: inputKey,
            isComicComment: isComicComment,
          );
        },
        childCount: fatherCommentList.length + 1,
      ),
    );
  }
}
