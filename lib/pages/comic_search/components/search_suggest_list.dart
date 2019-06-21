import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/components/match_text/match_text.dart';
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
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemCount: suggestList.length,
      itemBuilder: (BuildContext context, int index) {
        var item = suggestList[index];

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
            child: MatchText(
              '${item.comicName}',
              matchText: '$searchKey',
            ),
          ),
        );
      },
    );
  }
}
