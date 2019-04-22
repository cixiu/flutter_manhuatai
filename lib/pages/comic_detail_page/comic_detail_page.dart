import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/comic_info_body.dart';

/// 漫画详情
class ComicDetailPage extends StatefulWidget {
  final String comicId;

  ComicDetailPage({
    @required this.comicId,
  });

  @override
  _ComicDetailPageState createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage> {
  ComicInfoBody comicInfoBody = ComicInfoBody.fromJson({});

  @override
  void initState() {
    _getComicInfoBody();
    super.initState();
  }

  Future<void> _getComicInfoBody() async {
    var response = await Api.getComicInfoBody(comicId: widget.comicId);
    var _comicInfoBody = ComicInfoBody.fromJson(response);
    setState(() {
      comicInfoBody = _comicInfoBody;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comicInfoBody?.comicName ?? ''),
        centerTitle: true,
      ),
      body: Container(
        child: Text('${comicInfoBody.comicName}: ${widget.comicId}'),
      ),
    );
  }
}
