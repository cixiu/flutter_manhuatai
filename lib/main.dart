import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:oktoast/oktoast.dart';

import 'package:flutter_manhuatai/store/index.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/pages/launch/launch_page.dart';

main() async {
  var initialState = await initState();
  final store = Store<AppState>(rootReducer, initialState: initialState);

  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store}) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      child: StoreProvider(
        store: store,
        child: MaterialApp(
          title: '漫意话',
          theme: ThemeData(
            backgroundColor: Colors.white,
            canvasColor: Colors.white,
          ),
          home: LaunchPage(),
          onGenerateRoute: Application.router.generator,
        ),
      ),
    );
  }
}
