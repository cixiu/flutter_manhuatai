import 'package:flutter/material.dart';

class HomeBookshelf extends StatefulWidget {
  @override
  _HomeBookshelfState createState() => _HomeBookshelfState();
}

class _HomeBookshelfState extends State<HomeBookshelf>
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
        title: Text('书架'),
      ),
      body: new Center(
        child: Text(
          '书架',
        ),
      ),
    );
  }
}
