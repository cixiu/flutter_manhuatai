import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/models/get_satellite_res.dart'
    as GetSatelliteRes;
import 'package:flutter_manhuatai/models/comment_user.dart' as CommentUser;

import 'related_header.dart';
import 'package:flutter_manhuatai/components/post_item/post_item.dart';

class RelatedPosts extends StatelessWidget {
  final String keyword;
  final List<GetSatelliteRes.Data> postList;
  final Map<int, CommentUser.Data> postListUserMap;

  RelatedPosts({
    this.keyword,
    this.postList,
    this.postListUserMap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
              ),
              child: RelatedHeader(
                title: '相关帖子(${postList.length})',
                showAll: false,
              ),
            );
          }

          if (index == postList.length + 1) {
            return Container(
              height: ScreenUtil().setWidth(80),
              alignment: Alignment.center,
              child: Text(
                '小主没有更多了呢！',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            );
          }
          var item = postList[index - 1];
          return PostItem(
            keyword: keyword,
            postItem: item,
            postAuthor: postListUserMap[item.userIdentifier.toInt()],
          );
        },
        childCount: postList.length + 2,
      ),
    );
  }
}
