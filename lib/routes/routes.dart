import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './route_handlers.dart';

class Routes {
  static String root = '/';
  static String login = '/login';

  static configureRoutes(Router router) {
    router.define(login, handler: loginHandler);
  }
}
