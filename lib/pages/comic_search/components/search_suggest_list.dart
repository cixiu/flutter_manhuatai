import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/utils/sp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/models/search_comic.dart' as SearchComic;

class SearchSuggestList extends StatelessWidget {
  final String searchKey;
  final List<SearchComic.Data> suggestList;

  SearchSuggestList({
    this.searchKey,
    this.suggestList,
  });

  void _navigateToSearchResultPage(BuildContext context, String query) {
    String keyword = Uri.encodeComponent(query);
    Application.router
        .navigateTo(context, '${Routes.searchResult}?keyword=$keyword');
    SpUtils.saveSearchHistory(query);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle commonStyle = TextStyle(
      color: Colors.black,
      fontSize: ScreenUtil().setSp(28),
      fontWeight: FontWeight.normal,
    );
    TextStyle selectedStyle = TextStyle(
      color: Colors.blue,
      fontSize: ScreenUtil().setSp(28),
      fontWeight: FontWeight.bold,
    );

    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemCount: suggestList.length,
      itemBuilder: (BuildContext context, int index) {
        var item = suggestList[index];
        // 是否包含搜索的关键词
        bool _hasContainSearchKey = item.comicName.contains(searchKey);
        List<String> comicNameList = [];

        // 将漫画中的关键词提取出来
        if (_hasContainSearchKey) {
          comicNameList = item.comicName.split(searchKey);
        }

        return InkResponse(
          onTap: () {
            _navigateToSearchResultPage(context, item.comicName);
          },
          containedInkWell: true,
          highlightShape: BoxShape.rectangle,
          child: Container(
            height: ScreenUtil().setWidth(96),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(96),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[200],
                  width: ScreenUtil().setWidth(1),
                ),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: !_hasContainSearchKey
                ? Text(
                    '${item.comicName}',
                    overflow: TextOverflow.clip,
                    style: commonStyle,
                  )
                : Text.rich(
                    TextSpan(
                      text: comicNameList[0],
                      style: commonStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: '$searchKey',
                          style: selectedStyle,
                        ),
                        TextSpan(
                          text: comicNameList[1],
                          style: commonStyle,
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
