import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/pages/login/login.dart';

var loginHandler =Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return LoginPage();
  }
);
