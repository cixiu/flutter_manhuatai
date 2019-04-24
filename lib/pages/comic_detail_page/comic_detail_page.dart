import 'dart:async';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/comic_info_body.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
      // bool isBottom = _scrollController.position.pixels ==
      //     _scrollController.position.maxScrollExtent;
      // print(isBottom);
    });
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

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var pinnedHeaderHeight =
        //statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            kToolbarHeight;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(comicInfoBody?.comicName ?? ''),
      //   centerTitle: true,
      // ),
      body: NestedScrollViewRefreshIndicator(
        onRefresh: onRefresh,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: ScreenUtil().setHeight(488),
                title: Text(comicInfoBody?.comicName ?? ''),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Image.network(
                    Utils.generateImgUrlFromId(
                      id: int.parse(widget.comicId),
                      aspectRatio: '2:1',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                // bottom: PreferredSize(
                //   preferredSize: Size.fromHeight(30.0),
                //   child: Container(
                //     height: 30.0,
                //     color: Colors.red,
                //   ),
                // ),
              ),
            ];
          },
          pinnedHeaderSliverHeightBuilder: () {
            return pinnedHeaderHeight;
          },
          innerScrollPositionKeyBuilder: () {
            return Key('position');
          },
          body: Column(
            children: <Widget>[
              Container(
                height: 50.0,
                color: Colors.green,
              ),
              Expanded(
                child: NestedScrollViewInnerScrollPositionKeyWidget(
                  Key('position'),
                  ListView.builder(
                    // controller: _scrollController,
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return Text('$index');
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // body: Container(
      //   child: Image.network(
      //     Utils.generateImgUrlFromId(
      //       id: int.parse(widget.comicId),
      //       aspectRatio: '2:1',
      //     ),
      //     height: ScreenUtil().setHeight(488),
      //   ),
      // ),
    );
  }
}
