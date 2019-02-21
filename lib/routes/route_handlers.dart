import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/pages/test/test_page.dart';

var testHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return TestPage();
  }
);
