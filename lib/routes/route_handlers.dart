import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/pages/another_comic_book_list/another_comic_book_list.dart';
import 'package:flutter_manhuatai/pages/another_comic_detail/another_comic_detail.dart';
import 'package:flutter_manhuatai/pages/another_comic_home/another_comic_home.dart';
import 'package:flutter_manhuatai/pages/another_comic_read/another_comic_read.dart';
import 'package:flutter_manhuatai/pages/book_detail/book_detail.dart';
import 'package:flutter_manhuatai/pages/comic_comment/comic_comment.dart';
import 'package:flutter_manhuatai/pages/comic_rank/comic_rank.dart';
import 'package:flutter_manhuatai/pages/comic_search/comic_search.dart';

import 'package:flutter_manhuatai/pages/login/login.dart';
import 'package:flutter_manhuatai/pages/my_level/my_level.dart';
import 'package:flutter_manhuatai/pages/satellite_detail/satellite_detail.dart';
import 'package:flutter_manhuatai/pages/search_result/search_result.dart';
import 'package:flutter_manhuatai/pages/task_center/task_center.dart';
import 'package:flutter_manhuatai/pages/user_center/user_center.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/comic_detail_page.dart';
import 'package:flutter_manhuatai/pages/web_view/web_view.dart';

// 登录
var loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return LoginPage();
  },
);

// 用户中心
var userCenterHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return UserCenterPage();
  },
);

// 任务中心
var userTaskListHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return TaskCenter();
  },
);

// 漫画详情
var comicDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String comicId = params['comicId']?.first;
    return ComicDetailPage(comicId: comicId);
  },
);

// 漫画的吐槽评论
var comicCommentlHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String comicId = params['comicId']?.first;
    String comicName = params['comicName']?.first;
    return ComicCommentPage(
      comicId: comicId,
      comicName: comicName,
    );
  },
);

// 漫画排行榜
var comicRankHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String type = params['type']?.first;
    return ComicRankPage(type: type);
  },
);

// 搜索
var comicSearchHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ComicSearchPage();
  },
);

// 搜索结果
var searchResultHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String keyword = params['keyword']?.first;

    return SearchResultPage(
      keyword: keyword,
    );
  },
);

// 搜索结果
var satelliteDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String satelliteId = params['satelliteId']?.first;

    return SatelliteDetailPage(
      satelliteId: int.tryParse(satelliteId),
    );
  },
);

// 漫画书籍详情页
var bookDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String bookId = params['bookId']?.first;

    return BookDetailPage(
      bookId: int.tryParse(bookId),
    );
  },
);

// webView
var webViewHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String url = params['url']?.first;

    return WebViewPage(
      url: url,
    );
  },
);

// 我的等级详情
var myLevelHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MyLevel();
  },
);

// 另一个漫画的首页
var anotherComicHomeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return AnotherComicHome();
  },
);

// 另一个漫画的数据列表
var anotherComicBookListHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String bookName = params['bookName']?.first;
    String recommendId = params['recommendId']?.first;
    String recommendOperation = params['recommendOperation']?.first;

    return AnotherComicBookList(
      bookName: bookName,
      recommendId: recommendId,
      recommendOperation: recommendOperation,
    );
  },
);

// 另一个漫画的数据列表
var anotherComicDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String bookName = params['bookName']?.first;
    String bookId = params['bookId']?.first;
    String dataType = params['dataType']?.first;

    return AnotherComicDetail(
      bookName: bookName,
      bookId: bookId,
      dataType: dataType,
    );
  },
);

// 另一个漫画的漫画阅读
var anotherComicReadHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String indexNumber = params['indexNumber']?.first;
    String bookName = params['bookName']?.first;
    String bookId = params['bookId']?.first;
    String dataType = params['dataType']?.first;

    return AnotherComicRead(
      indexNumber: indexNumber,
      bookName: bookName,
      bookId: bookId,
      dataType: dataType,
    );
  },
);
