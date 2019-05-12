import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComicReadPage extends StatefulWidget {
  final String comicId;
  final int chapterTopicId;

  ComicReadPage({
    Key key,
    this.comicId,
    this.chapterTopicId,
  }) : super(key: key);

  @override
  _ComicReadPageState createState() => _ComicReadPageState();
}

class _ComicReadPageState extends State<ComicReadPage> {
  ComicInfoBody comicInfoBody;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays ([]);
    _getComicInfoBody();
  }

  // 获取指定漫画的主体信息
  Future<void> _getComicInfoBody() async {
    var response = await Api.getComicInfoBody(comicId: widget.comicId);
    var _comicInfoBody = ComicInfoBody.fromJson(response);
    setState(() {
      comicInfoBody = _comicInfoBody;
    });
  }

  // 点击中间区域，呼起菜单
  void openMenu(TapUpDetails details) {
    double midPosition = MediaQuery.of(context).size.height / 2;
    double diff = ScreenUtil().setWidth(350);
    double top = midPosition - diff;
    double bottom = midPosition + diff;
    double tapPosition = details.globalPosition.dy;

    if (tapPosition > top && tapPosition < bottom) {
      print('点击了中间区域 $tapPosition');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: comicInfoBody != null
          ? GestureDetector(
              // 点击中间区域，呼起菜单
              onTapUp: openMenu,
              child: ListView.builder(
                itemCount: comicInfoBody.comicChapter.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: ScreenUtil().setWidth(150),
                    alignment: Alignment.center,
                    child: Text(
                      comicInfoBody.comicChapter[index].chapterName,
                    ),
                  );
                },
              ),
            )
          : Container(),
    );
  }
}
