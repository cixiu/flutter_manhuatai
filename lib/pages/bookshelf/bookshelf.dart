import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/components/load_more_widget/load_more_widget.dart';
import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBookshelf extends StatefulWidget {
  @override
  _HomeBookshelfState createState() => _HomeBookshelfState();
}

class _HomeBookshelfState extends State<HomeBookshelf>
    with
        AutomaticKeepAliveClientMixin,
        RefreshCommonState,
        WidgetsBindingObserver {
  bool _isLoading = true;
  List<User_collect> _userCollect;
  List<User_read> _userRead;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _handleRefresh() async {
    var user = User(context);
    String deviceid = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceid = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceid = iosInfo.identifierForVendor;
    }

    var getUserRecordRes = await Api.getUserRecord(
      type: user.info.type,
      openid: user.info.openid,
      deviceid: deviceid,
      myUid: user.info.uid,
    );

    if (!this.mounted) {
      return;
    }

    setState(() {
      _userCollect = getUserRecordRes.userCollect;
      _userRead = getUserRecordRes.userRead;
      _isLoading = false;
      _userCollect.sort((collectA, collectB) {
        return collectB.updateTime - collectA.updateTime;
      });
    });
    print(getUserRecordRes);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('我的收藏'),
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: _isLoading
            ? Container()
            : _userCollect.length == 0
                ? Center(
                    child: Text('小主暂时还没有收藏任何漫画哦~~'),
                  )
                : ListView.builder(
                    itemCount: _userCollect.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _userCollect.length) {
                        return Container(
                          margin: EdgeInsets.only(
                            top: ScreenUtil().setWidth(30),
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: ScreenUtil().setWidth(1),
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(20),
                                    ),
                                    child: Text(
                                      '共${_userCollect.length}部漫画~',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: ScreenUtil().setSp(24),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: ScreenUtil().setWidth(1),
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ],
                              ),
                              LoadMoreWidget(
                                hasMore: false,
                              ),
                            ],
                          ),
                        );
                      }
                      var item = _userCollect[index];

                      return Container(
                        padding: EdgeInsets.all(
                          ScreenUtil().setWidth(20),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300],
                              width: ScreenUtil().setWidth(1),
                            ),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            ImageWrapper(
                              url: Utils.generateImgUrlFromId(
                                id: item.comicId,
                                aspectRatio: '3:4',
                              ),
                              width: ScreenUtil().setWidth(200),
                              height: ScreenUtil().setWidth(267),
                            ),
                            Expanded(
                              child: Container(
                                height: ScreenUtil().setWidth(267),
                                margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${item.comicName}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: ScreenUtil().setSp(32),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setWidth(20),
                                          ),
                                          child: Text(
                                            '${Utils.fromNow(item.updateTime)}',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: ScreenUtil().setSp(24),
                                            ),
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                              text: '更新至  ',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize:
                                                    ScreenUtil().setSp(28),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${item.lastChapterName}',
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize:
                                                        ScreenUtil().setSp(28),
                                                  ),
                                                ),
                                              ]),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
