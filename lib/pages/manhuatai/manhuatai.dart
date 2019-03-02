import 'package:flutter/material.dart';

class HomeManhuatai extends StatefulWidget {
  @override
  _HomeManhuataiState createState() => _HomeManhuataiState();
}

class _HomeManhuataiState extends State<HomeManhuatai>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('漫画台'),
      ),
      body: new Center(
        child: Text(
          '漫画台',
        ),
      ),
    );
  }
}
