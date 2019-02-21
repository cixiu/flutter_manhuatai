import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试的路由页面'),
      ),
      body: Container(
        color: Colors.red,
        child: Text('测试的路由页面'),
      ),
    );
  }
}
