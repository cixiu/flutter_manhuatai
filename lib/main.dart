import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:oktoast/oktoast.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/pages/launch/launch_page.dart';
import 'package:flutter_manhuatai/provider_store/user_info_model.dart';
import 'package:flutter_manhuatai/provider_store/user_record_model.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var userInfoModel = UserInfoModel();
  await userInfoModel.initModel();
  // await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  // await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  var providers = [
    ChangeNotifierProvider(
      create: (_) => userInfoModel,
    ),
    ChangeNotifierProvider(
      create: (_) => UserRecordModel(),
    ),
  ];

  runApp(MyApp(
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  final List<SingleChildWidget> providers;

  MyApp({
    this.providers,
  }) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      child: MultiProvider(
        providers: providers,
        child: MaterialApp(
          title: '漫意话',
          theme: ThemeData(
            backgroundColor: Colors.white,
            canvasColor: Colors.white,
            appBarTheme: AppBarTheme(
              elevation: 0.0,
              color: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.blue,
              ),
              brightness: Brightness.light,
              textTheme: TextTheme(
                headline6: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          home: LaunchPage(),
          onGenerateRoute: Application.router.generator,
        ),
      ),
    );
  }
}
