import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:vector_math/vector_math_64.dart' as v;
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/models/get_book_info_by_id.dart'
    as GetBookInfoById;
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailPage extends StatefulWidget {
  final int bookId;

  BookDetailPage({
    Key key,
    this.bookId,
  }) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage>
    with RefreshCommonState, WidgetsBindingObserver {
  bool _isLoading = true;
  GetBookInfoById.Data _bookData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
    // _scrollController.addListener(_listScroll);
  }

  Future<void> _handleRefresh() async {
    var getBookInfoByIdRes = await Api.getBookInfoById(bookId: widget.bookId);
    setState(() {
      _isLoading = false;
      _bookData = getBookInfoByIdRes.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: _isLoading
            ? Container()
            : Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://image.mhxk.com/mh/91961.jpg-960x1280.jpg.webp',
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black54,
                          BlendMode.overlay,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: ScreenUtil().setWidth(667),
                      child: Swiper(
                        loop: false,
                        viewportFraction: 0.75,
                        scale: 0.8,
                        itemCount: _bookData.bookList.length,
                        itemBuilder: (context, index) {
                          var item = _bookData.bookList[index];
                          String imgUrl = Utils.generateImgUrlFromId(
                              id: item.comicId, aspectRatio: '3:4');
                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.01)
                              ..rotateY(0.04)
                              ..rotateZ(0.06),
                            alignment: FractionalOffset.center,
                            origin: Offset(0.5, 0.5),
                            child: Container(
                              // margin: EdgeInsets.symmetric(
                              //   horizontal: ScreenUtil().setWidth(30),
                              // ),
                              padding: EdgeInsets.all(
                                ScreenUtil().setWidth(6),
                              ),
                              color: Colors.white,
                              width: ScreenUtil().setWidth(500),
                              height: ScreenUtil().setWidth(667),
                              child: ImageWrapper(
                                url: imgUrl,
                                width: ScreenUtil().setWidth(500),
                                height: ScreenUtil().setWidth(667),
                              ),
                            ),
                          );
                        },
                        // itemWidth: MediaQuery.of(context).size.width,
                        itemHeight: ScreenUtil().setWidth(667),
                        // pagination: SwiperPagination(
                        //   margin: EdgeInsets.only(
                        //     bottom: ScreenUtil().setWidth(92),
                        //   ),
                        // ),
                        // controller: SwiperController(),
                        autoplay: false,
                      ),
                    ),
                  ),
                  // Container(
                  //   color: Colors.blue,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  //       Container(
                  //         height: ScreenUtil().setWidth(700),
                  //         child: ListView.builder(
                  //           scrollDirection: Axis.horizontal,
                  //           itemCount: _bookData.bookList.length,
                  //           itemBuilder: (BuildContext ctx, int index) {
                  //             var item = _bookData.bookList[index];
                  //             String imgUrl = Utils.generateImgUrlFromId(
                  //                 id: item.comicId, aspectRatio: '3:4');

                  //             return Transform(
                  //               transform: Matrix4.identity()
                  //                 ..setEntry(3, 2, 0.01)
                  //                 ..rotateY(0.04)
                  //                 ..rotateZ(0.06),
                  //               alignment: FractionalOffset.center,
                  //               origin: Offset(0.5, 0.5),
                  //               child: Container(
                  //                 margin: EdgeInsets.symmetric(
                  //                   horizontal: ScreenUtil().setWidth(30),
                  //                 ),
                  //                 padding: EdgeInsets.all(
                  //                   ScreenUtil().setWidth(6),
                  //                 ),
                  //                 color: Colors.white,
                  //                 width: ScreenUtil().setWidth(500),
                  //                 height: ScreenUtil().setWidth(667),
                  //                 child: ImageWrapper(
                  //                   url: imgUrl,
                  //                   width: ScreenUtil().setWidth(500),
                  //                   height: ScreenUtil().setWidth(667),
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                  // Center(
                  //   child: Transform(
                  //     transform: Matrix4.identity()
                  //       ..setEntry(3, 2, 0.01)
                  //       ..rotateY(0.04)
                  //       ..rotateZ(0.06),
                  //     alignment: FractionalOffset.center,
                  //     origin: Offset(0.5, 0.5),
                  //     child: Container(
                  //       padding: EdgeInsets.all(
                  //         ScreenUtil().setWidth(6),
                  //       ),
                  //       color: Colors.white,
                  //       width: ScreenUtil().setWidth(500),
                  //       height: ScreenUtil().setWidth(667),
                  //       child: ImageWrapper(
                  //         url:
                  //             'https://image.mhxk.com/mh/91961.jpg-960x1280.jpg.webp',
                  //         // width: ScreenUtil().setWidth(500),
                  //         // height: ScreenUtil().setWidth(667),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
      ),
    );
  }
}
