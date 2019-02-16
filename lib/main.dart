import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/pages/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '漫意话',
      home: MyHomePage(),
    );
  }
}
