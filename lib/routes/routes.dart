import 'package:fluro/fluro.dart';

import './route_handlers.dart';

class Routes {
  static String root = '/';
  static String login = '/login'; // 登录
  static String userCenter = '/user_center'; // 用户中心
  static String comicDetail = '/comic/detail/:comicId'; // 漫画详情
  static String comicRank = '/comic_rank'; // 漫画排行榜
  static String comicSearch = '/comic_search'; // 搜索
  static String searchResult = '/search_result'; // 搜索结果
  static String satelliteDetail =
      '/satellite_detail'; // 帖子详情 eg: /satellite_detail?satelliteId=123456
  static String bookDetail =
      '/book_detail'; // 漫画书籍详情页 eg: /book_detail?bookId=123456
  static String webView = '/web_view'; // webView
  static String commentReply =
      '/comment_reply'; // 评论的回复详情页 /comment_reply?commentId=xxx

  static configureRoutes(Router router) {
    router.define(
      login,
      handler: loginHandler,
      transitionType: TransitionType.inFromRight,
    );

    router.define(
      userCenter,
      handler: userCenterHandler,
      transitionType: TransitionType.inFromRight,
    );

    router.define(
      comicDetail,
      handler: comicDetailHandler,
      transitionType: TransitionType.inFromRight,
    );

    router.define(
      comicRank,
      handler: comicRankHandler,
      transitionType: TransitionType.inFromRight,
    );

    router.define(
      comicSearch,
      handler: comicSearchHandler,
      transitionType: TransitionType.inFromRight,
    );

    router.define(
      searchResult,
      handler: searchResultHandler,
      transitionType: TransitionType.inFromRight,
    );

    router.define(
      satelliteDetail,
      handler: satelliteDetailHandler,
      transitionType: TransitionType.inFromRight,
    );

    router.define(
      bookDetail,
      handler: bookDetailHandler,
      transitionType: TransitionType.inFromRight,
    );

    router.define(
      webView,
      handler: webViewHandler,
      transitionType: TransitionType.inFromRight,
    );

    router.define(
      commentReply,
      handler: commentReplyHandler,
      transitionType: TransitionType.inFromRight,
    );
  }
}
