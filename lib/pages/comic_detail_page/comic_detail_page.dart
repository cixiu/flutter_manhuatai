import 'dart:async';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
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

class _ComicDetailPageState extends State<ComicDetailPage>
    with TickerProviderStateMixin {
  ComicInfoBody comicInfoBody = ComicInfoBody.fromJson({});
  ScrollController _scrollController1 = ScrollController();

  @override
  void initState() {
    _scrollController1.addListener(() {
      print('controller1 ${_scrollController1.position.pixels}');
      // bool isBottom = _scrollController1.position.pixels ==
      //     _scrollController1.position.maxScrollExtent;
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
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    print(ScreenUtil.screenWidth);
    print(ScreenUtil.screenHeight);
    print(ScreenUtil.pixelRatio);
    print(ScreenUtil.statusBarHeight);
    print(ScreenUtil.bottomBarHeight);
    print(ScreenUtil.getInstance().setWidth(750));
    print(ScreenUtil.getInstance().setHeight(488));
    print('${ScreenUtil().setHeight(552) - ScreenUtil().setHeight(64)}');
    var pinnedHeaderHeight =
        //statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            kToolbarHeight;
    var isShowAll = true;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(comicInfoBody?.comicName ?? ''),
      //   centerTitle: true,
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: ScreenUtil().setHeight(552),
            title: Text(comicInfoBody?.comicName ?? ''),
            elevation: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: ScreenUtil().setHeight(64),
                    left: 0,
                    child: Image.network(
                      Utils.generateImgUrlFromId(
                        id: int.parse(widget.comicId),
                        aspectRatio: '2:1',
                      ),
                      height: ScreenUtil().setHeight(488),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: Container(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      'lib/images/pic_detail_hx1.png',
                      height: ScreenUtil().setHeight(128),
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return Container(
                    height: 40.0,
                    color: Colors.cyan,
                    child: Stack(
                      overflow: Overflow.visible,
                      // alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          color: Colors.blue,
                          height: 40.0,
                          child: Text('滴滴滴滴滴哒哒多多多多多多多多多多'),
                        ),
                        Positioned(
                          // top: -20.0,
                          child: Container(
                            color: Colors.red,
                            height: 40.0,
                            child: Text('jkddddddddddddddddddddddd'),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Container(
                  color: Colors.red,
                  height: 30.0,
                  child: Text('$index'),
                );
              },
              childCount: 20,
            ),
          ),
          isShowAll
              ? SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(),
                )
              : SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      height: 50.0,
                      color: Colors.grey,
                      child: Text('连载'),
                    )
                  ]),
                ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  height: 30.0,
                  child: Text('$index'),
                );
              },
              childCount: 100,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  color: Colors.green,
                  height: 30.0,
                  child: Text('$index'),
                );
              },
              childCount: 20,
            ),
          )
        ],
      ),
      // body: NestedScrollViewRefreshIndicator(
      //   onRefresh: onRefresh,
      //   child: NestedScrollView(
      //     controller: _scrollController1,
      //     headerSliverBuilder: (context, innerBoxIsScrolled) {
      //       return <Widget>[
      //         SliverAppBar(
      //           pinned: true,
      //           expandedHeight: ScreenUtil().setHeight(488),
      //           title: Text(comicInfoBody?.comicName ?? ''),
      //           flexibleSpace: FlexibleSpaceBar(
      //             collapseMode: CollapseMode.pin,
      //             background: Image.network(
      //               Utils.generateImgUrlFromId(
      //                 id: int.parse(widget.comicId),
      //                 aspectRatio: '2:1',
      //               ),
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //           // bottom: PreferredSize(
      //           //   preferredSize: Size.fromHeight(30.0),
      //           //   child: Container(
      //           //     height: 30.0,
      //           //     color: Colors.red,
      //           //   ),
      //           // ),
      //         ),
      //       ];
      //     },
      //     pinnedHeaderSliverHeightBuilder: () {
      //       return pinnedHeaderHeight;
      //     },
      //     innerScrollPositionKeyBuilder: () {
      //       return Key('position');
      //     },
      //     body: Column(
      //       children: <Widget>[
      //         Container(
      //           height: 50.0,
      //           color: Colors.green,
      //         ),
      //         Expanded(
      //           child: NestedScrollViewInnerScrollPositionKeyWidget(
      //             Key('position'),
      //             ListView.builder(
      //               // controller: _scrollController2,
      //               itemCount: 100,
      //               itemBuilder: (context, index) {
      //                 return Text('$index');
      //               },
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey,
      height: 50.0,
      child: Text('连载'),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
