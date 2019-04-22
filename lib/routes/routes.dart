import 'package:fluro/fluro.dart';

import './route_handlers.dart';

class Routes {
  static String root = '/';
  static String login = '/login'; // 登录
  static String userCenter = '/user_center'; // 用户中心
  static String comicDetail = '/comic/detail/:comicId'; // 漫画详情

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
  }
}
