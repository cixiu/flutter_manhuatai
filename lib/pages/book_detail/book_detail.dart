import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
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
  SwiperController _swiperController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _swiperController = SwiperController();
    _swiperController.addListener(() {
      print(_swiperController.index);
    });
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
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          Utils.generateImgUrlFromId(
                            id: _bookData.bookList[_currentIndex].comicId,
                            aspectRatio: '3:4',
                          ),
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black,
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
                  Container(
                    child: Swiper(
                      autoplay: false,
                      loop: false,
                      viewportFraction: 0.68,
                      scale: 0.65,
                      onIndexChanged: (int index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemCount: _bookData.bookList.length,
                      itemBuilder: (context, index) {
                        var item = _bookData.bookList[index];
                        String imgUrl = Utils.generateImgUrlFromId(
                          id: item.comicId,
                          aspectRatio: '3:4',
                        );

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.01)
                                ..rotateY(0.04)
                                ..rotateZ(0.06),
                              alignment: FractionalOffset.center,
                              child: Container(
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
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  _buildAppBar(),
                  _buildComicInfo(),
                ],
              ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        height: ScreenUtil().setWidth(88),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  '${_bookData.bookName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.all(
                  ScreenUtil().setWidth(28),
                ),
                child: Image.asset(
                  'lib/images/ico_return_white.png',
                  width: ScreenUtil().setWidth(32),
                  height: ScreenUtil().setWidth(32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComicInfo() {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(80),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            '${_bookData.bookList[_currentIndex].comicName}',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(36),
            ),
          ),
          Text(
            '${_bookData.bookList[_currentIndex].comicFeature}',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
        ],
      ),
    );
  }
}
