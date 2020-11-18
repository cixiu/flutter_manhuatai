import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:oktoast/oktoast.dart';
import 'package:device_info/device_info.dart';

import 'package:flutter_manhuatai/components/empty_wrapper/empty_wrapper.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/models/get_book_info_by_id.dart'
    as GetBookInfoById;
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_manhuatai/components/request_loading/request_loading.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:flutter_manhuatai/provider_store/user_info_model.dart';
import 'package:flutter_manhuatai/provider_store/user_record_model.dart';

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
  }

  Future<void> _handleRefresh() async {
    var getBookInfoByIdRes = await Api.getBookInfoById(bookId: widget.bookId);
    // 获取用户的收藏列表
    var userRecordModel = Provider.of<UserRecordModel>(context, listen: false);
    var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
    await userRecordModel.getUserRecordAsyncAction(userInfoModel.user);
    if (!this.mounted) {
      return;
    }
    setState(() {
      _isLoading = false;
      _bookData = getBookInfoByIdRes.data;
    });
  }

  // 收藏或者取消收藏
  Future<void> _setUserCollect({
    int comicId,
    bool hasCollected,
  }) async {
    try {
      showLoading(context);
      var userRecordModel =
          Provider.of<UserRecordModel>(context, listen: false);
      var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
      var user = userInfoModel.user;
      String action = hasCollected ? 'dels' : 'add';

      String deviceid = '';
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceid = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceid = iosInfo.identifierForVendor;
      }

      var status = await Api.setUserCollect(
        type: user.type,
        openid: user.openid,
        deviceid: deviceid,
        myUid: user.uid,
        action: action,
        comicId: comicId,
        comicIdList: [comicId],
      );

      var getUserRecordRes = await Api.getUserRecord(
        type: user.type,
        openid: user.openid,
        deviceid: deviceid,
        myUid: user.uid,
      );

      getUserRecordRes.userCollect.sort((collectA, collectB) {
        return collectB.updateTime - collectA.updateTime;
      });

      userRecordModel.setUserCollects(getUserRecordRes.userCollect);
      hideLoading(context);

      String message = hasCollected ? '已取消收藏' : '收藏成功~~';
      if (status) {
        showToast(message);
      } else {
        showToast('操作失败');
      }
    } catch (e) {
      hideLoading(context);
      showToast('操作失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: _isLoading
            ? Container()
            : _bookData.bookList.length != 0
                ? Stack(
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
                      Selector<UserRecordModel, List<User_collect>>(
                        selector: (context, userRecordModel) =>
                            userRecordModel.userCollects,
                        builder: (ctx, userCollects, _) {
                          return Container(
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
                                String imgUrl = item.imgUrl.isEmpty
                                    ? Utils.generateImgUrlFromId(
                                        id: item.comicId,
                                        aspectRatio: '3:4',
                                      )
                                    : '${AppConst.img_host}/${item.imgUrl}';
                                int collectIndex =
                                    userCollects.indexWhere((collect) {
                                  return collect.comicId == item.comicId;
                                });
                                // 是否已经收藏过漫画了
                                bool hasCollected = collectIndex > -1;

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Application.router.navigateTo(
                                          context,
                                          '/comic/detail/${item.comicId}',
                                        );
                                      },
                                      child: Transform(
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
                                          child: Stack(
                                            children: <Widget>[
                                              ImageWrapper(
                                                url: imgUrl,
                                                width:
                                                    ScreenUtil().setWidth(500),
                                                height:
                                                    ScreenUtil().setWidth(667),
                                              ),
                                              Container(
                                                color: Colors.black12,
                                              ),
                                              Positioned(
                                                top: ScreenUtil().setWidth(20),
                                                right:
                                                    ScreenUtil().setWidth(20),
                                                child: GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () {
                                                    _setUserCollect(
                                                      comicId: item.comicId,
                                                      hasCollected:
                                                          hasCollected,
                                                    );
                                                  },
                                                  child: Image.asset(
                                                    hasCollected
                                                        ? 'lib/images/icon_heart_dianzan.png'
                                                        : 'lib/images/icon_heart_notdianzan.png',
                                                    width: ScreenUtil()
                                                        .setWidth(72),
                                                    height: ScreenUtil()
                                                        .setWidth(72),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom:
                                                    ScreenUtil().setWidth(30),
                                                child: _buildComicTypes(item),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                      _buildAppBar(),
                      _buildComicInfo(),
                    ],
                  )
                : EmptyWrapper(),
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
              behavior: HitTestBehavior.opaque,
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

  Widget _buildComicTypes(GetBookInfoById.Book_list item) {
    return Row(
      children: item.comicType.map((typeName) {
        return Container(
          margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: ScreenUtil().setWidth(2),
            ),
            borderRadius: BorderRadius.circular(
              ScreenUtil().setWidth(50),
            ),
          ),
          child: Text(
            typeName,
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
        );
      }).toList(),
    );
  }
}
