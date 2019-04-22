import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/pages/login/login.dart';
import 'package:flutter_manhuatai/pages/user_center/user_center.dart';
import 'package:flutter_manhuatai/pages/comic_detail_page/comic_detail_page.dart';

var loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return LoginPage();
  },
);

var userCenterHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return UserCenterPage();
  },
);

var comicDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String comicId = params['comicId']?.first;
    return ComicDetailPage(comicId: comicId);
  },
);
