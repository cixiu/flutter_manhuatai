import 'package:fluro/fluro.dart';

import './route_handlers.dart';

const transitionType = TransitionType.cupertino;

class Routes {
  static String root = '/';
  static String login = '/login'; // 登录
  static String userCenter = '/user_center'; // 用户中心
  static String userTaskList = '/user_task_list'; // 任务中心
  static String comicDetail = '/comic/detail/:comicId'; // 漫画详情
  static String comicComment =
      '/comic/comment'; // 漫画的评论吐槽 eg: /comic/comment?comicId=12345
  static String comicRank = '/comic_rank'; // 漫画排行榜
  static String comicSearch = '/comic_search'; // 搜索
  static String searchResult = '/search_result'; // 搜索结果
  static String satelliteDetail =
      '/satellite_detail'; // 帖子详情 eg: /satellite_detail?satelliteId=123456
  static String bookDetail =
      '/book_detail'; // 漫画书籍详情页 eg: /book_detail?bookId=123456
  static String webView = '/web_view'; // webView
  static String commentReply = '/comment_reply'; // 评论的回复详情页使用CustomRouter进行跳转传参
  static String myLevel = '/my_level'; // 我的等级详情

  static configureRoutes(Router router) {
    router.define(
      login,
      handler: loginHandler,
      transitionType: transitionType,
    );

    router.define(
      userCenter,
      handler: userCenterHandler,
      transitionType: transitionType,
    );

    router.define(
      userTaskList,
      handler: userTaskListHandler,
      transitionType: transitionType,
    );

    router.define(
      comicDetail,
      handler: comicDetailHandler,
      transitionType: transitionType,
    );

    router.define(
      comicComment,
      handler: comicCommentlHandler,
      transitionType: transitionType,
    );

    router.define(
      comicRank,
      handler: comicRankHandler,
      transitionType: transitionType,
    );

    router.define(
      comicSearch,
      handler: comicSearchHandler,
      transitionType: transitionType,
    );

    router.define(
      searchResult,
      handler: searchResultHandler,
      transitionType: transitionType,
    );

    router.define(
      satelliteDetail,
      handler: satelliteDetailHandler,
      transitionType: transitionType,
    );

    router.define(
      bookDetail,
      handler: bookDetailHandler,
      transitionType: transitionType,
    );

    router.define(
      webView,
      handler: webViewHandler,
      transitionType: transitionType,
    );

    router.define(
      myLevel,
      handler: myLevelHandler,
      transitionType: transitionType,
    );
  }
}
