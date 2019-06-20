import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  final String keyword;

  SearchResultPage({
    Key key,
    this.keyword,
  }) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.keyword}'),
      ),
    );
  }
}
