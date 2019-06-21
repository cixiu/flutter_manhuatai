import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/components/match_text/match_text.dart';
import 'package:flutter_manhuatai/models/sort_list.dart' as SortList;
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            Container(
              padding: EdgeInsets.only(
                bottom: ScreenUtil().setWidth(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '相关漫画',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(32),
                    ),
                  ),
                  relatedListData.length > 6
                      ? Container(
                          height: ScreenUtil().setWidth(32),
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: ScreenUtil().setWidth(1),
                            ),
                            borderRadius: BorderRadius.circular(
                              ScreenUtil().setWidth(14),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '全部',
                            strutStyle: StrutStyle(
                              forceStrutHeight: true,
                              fontSize: ScreenUtil().setSp(20),
                            ),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenUtil().setSp(20),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
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
