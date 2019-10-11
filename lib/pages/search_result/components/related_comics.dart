import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/models/sort_list.dart' as SortList;
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/components/match_text/match_text.dart';
import 'related_header.dart';

class RelatedComics extends StatelessWidget {
  final String keyword;
  final List<SortList.Data> relatedListData;

  RelatedComics({
    this.keyword,
    this.relatedListData,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            RelatedHeader(
              title: '相关漫画',
              showAll: relatedListData.length > 6,
              onTap: () {
                print('TODO: 跳转查看全部的相关漫画');
              },
            ),
            Wrap(
              runSpacing: ScreenUtil().setWidth(20),
              alignment: WrapAlignment.spaceBetween,
              children: relatedListData.take(6).map((item) {
                return GestureDetector(
                  onTap: () {
                    Application.router.navigateTo(
                      context,
                      '/comic/detail/${item.comicId}',
                    );
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(224),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ImageWrapper(
                          url: Utils.generateImgUrlFromId(
                            id: item.comicId,
                            aspectRatio: '3:4',
                          ),
                          width: ScreenUtil().setWidth(224),
                          height: ScreenUtil().setWidth(296),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(10),
                          ),
                          child: MatchText(
                            '${item.comicName}',
                            matchText: keyword,
                            matchedStyle: TextStyle(
                              color: Colors.blue,
                              fontSize: ScreenUtil().setSp(28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
