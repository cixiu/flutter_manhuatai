import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './route_handlers.dart';

class Routes {
  static String root = '/';
  static String login = '/login';
  static String userCenter = '/user_center';

  static configureRoutes(Router router) {
    router.define(login, handler: loginHandler);
    router.define(userCenter, handler: userCenterHandler);
  }
}
