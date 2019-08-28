import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/pages/book_detail/book_detail.dart';
import 'package:flutter_manhuatai/pages/comic_rank/comic_rank.dart';
import 'package:flutter_manhuatai/pages/comic_search/comic_search.dart';
import 'package:flutter_manhuatai/pages/comment_reply/comment_reply.dart';

import 'package:flutter_manhuatai/pages/login/login.dart';
import 'package:flutter_manhuatai/pages/satellite_detail/satellite_detail.dart';
import 'package:flutter_manhuatai/pages/search_result/search_result.dart';
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

// 漫画详情
var comicDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String comicId = params['comicId']?.first;
    return ComicDetailPage(comicId: comicId);
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

// 评论的回复详情页
var commentReplyHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String commentId = params['commentId']?.first;
    String ssid = params['ssid']?.first;
    String relationId = params['relationId']?.first;
    String floorNum = params['floorNum']?.first;
    String commentUserid = params['commentUserid']?.first;
    String commentUsername = params['commentUsername']?.first;
    String commentUserlevel = params['commentUserlevel']?.first;
    String commentUserdeviceTail = params['commentUserdeviceTail']?.first;

    return CommentReplyPage(
      commentId: int.tryParse(commentId),
      ssid: int.tryParse(ssid),
      relationId: int.tryParse(relationId),
      floorNum: int.tryParse(floorNum),
      commentUserid: int.tryParse(commentUserid),
      commentUsername: commentUsername,
      commentUserlevel: int.tryParse(commentUserlevel),
      commentUserdeviceTail: commentUserdeviceTail,
    );
  },
);
