import 'package:flutter/material.dart';

class HomeUpdate extends StatefulWidget {
  @override
  _HomeUpdateState createState() => _HomeUpdateState();
}

class _HomeUpdateState extends State<HomeUpdate>
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
        title: Text('更新'),
      ),
      body: new Center(
        child: Text(
          '更新',
        ),
      ),
    );
  }
}
