import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/pages/comic_rank/comic_rank.dart';
import 'package:flutter_manhuatai/pages/comic_search/comic_search.dart';

import 'package:flutter_manhuatai/pages/login/login.dart';
import 'package:flutter_manhuatai/pages/satellite_detail/satellite_detail.dart';
import 'package:flutter_manhuatai/pages/search_result/search_result.dart';
import 'package:flutter_manhuatai/pages/user_center/user_center.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/comic_detail_page.dart';

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
