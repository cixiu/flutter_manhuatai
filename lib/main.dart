import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:oktoast/oktoast.dart';

import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/pages/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: '漫意话',
        home: MyHomePage(),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
