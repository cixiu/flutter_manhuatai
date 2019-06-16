import 'package:flutter/material.dart';

class ComicSearchPage extends StatefulWidget {
  @override
  _ComicSearchPageState createState() => _ComicSearchPageState();
}

class _ComicSearchPageState extends State<ComicSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
      ),
    );
  }
}
