import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './route_handlers.dart';

class Routes {
  static String root = '/';
  static String test = '/test';

  static configureRoutes(Router router) {
    router.define(test, handler: testHandler);
  }
}
