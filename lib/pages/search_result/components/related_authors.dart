import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:flutter_manhuatai/models/search_author.dart' as SearchAuthor;
import 'package:flutter_manhuatai/utils/utils.dart';

import 'package:flutter_manhuatai/components/match_text/match_text.dart';
import 'related_header.dart';

class RelatedAuthors extends StatelessWidget {
  final String keyword;
  final List<SearchAuthor.Data_Data> relatedAuthorList;

  RelatedAuthors({
    this.keyword,
    this.relatedAuthorList,
  });

  @override
  Widget build(BuildContext context) {
    var author = relatedAuthorList.first;

    return SliverPadding(
      padding: EdgeInsets.all(
        ScreenUtil().setWidth(20),
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            RelatedHeader(
              title: '相关用户(${relatedAuthorList.length})',
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: ScreenUtil().setWidth(1),
                    ),
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setWidth(60),
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      Utils.generateImgUrlFromId(
                        id: author.uid,
                        aspectRatio: '1:1',
                        type: 'head',
                      ),
                    ),
                    radius: ScreenUtil().setWidth(60),
                  ),
                ),
                MatchText(
                  author.uname,
                  matchText: keyword,
                  matchedStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: ScreenUtil().setSp(28),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
