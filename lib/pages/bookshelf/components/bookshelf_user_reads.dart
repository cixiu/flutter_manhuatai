import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/components/cancel_dialog/cancel_dialog.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/components/pull_load_wrapper/pull_load_wrapper.dart';
import 'package:flutter_manhuatai/components/request_loading/request_loading.dart';
import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/store/index.dart';
import 'package:flutter_manhuatai/store/user_collects.dart';
import 'package:flutter_manhuatai/store/user_reads.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redux/redux.dart';

class BookshelfUserReads extends StatefulWidget {
  @override
  _BookshelfUserReadsState createState() => _BookshelfUserReadsState();
}

class _BookshelfUserReadsState extends State<BookshelfUserReads>
    with
        AutomaticKeepAliveClientMixin,
        RefreshCommonState,
        WidgetsBindingObserver {
  bool _isLoading = true;
  final _control = PullLoadWrapperControl();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // 需要头部
    _control.needHeader = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  Future<void> _handleRefresh() async {
    Store<AppState> store = StoreProvider.of(context);
    if (store.state.userReads != null && _isLoading == true) {
      _control.dataListLength = store.state.userReads.length;
      setState(() {
        _isLoading = false;
      });
      return;
    }

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
    getUserRecordRes.userCollect.sort((collectA, collectB) {
      return collectB.updateTime - collectA.updateTime;
    });

    _control.dataListLength = getUserRecordRes.userRead.length;

    store.dispatch(UpdateUserCollectsAction(getUserRecordRes.userCollect));
    store.dispatch(UpdateUserReadsAction(getUserRecordRes.userRead));

    if (!this.mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> deleteOneRead({
    User_read item,
    Store<AppState> store,
  }) async {
    try {
      showLoading(context);
      var userInfo = store.state.userInfo;
      var guestInfo = store.state.guestInfo;
      var user = userInfo.uid != null ? userInfo : guestInfo;
      int _comicId = item.comicId;

      String deviceid = '';
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceid = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceid = iosInfo.identifierForVendor;
      }

      var status = await Api.delUserRead(
        type: user.type,
        openid: user.openid,
        deviceid: deviceid,
        myUid: user.uid,
        comicId: _comicId,
      );

      if (status) {
        showToast('已取消对${item.comicName}的订阅');
        store.state.userReads.removeWhere((comicRead) {
          return comicRead.comicId == item.comicId;
        });
        store.dispatch(
          UpdateUserReadsAction(store.state.userReads),
        );
        hideLoading(context);
      } else {
        hideLoading(context);
        showToast('操作失败');
      }
    } catch (e) {
      hideLoading(context);
      showToast('操作失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StoreBuilder<AppState>(
      builder: (context, store) {
        var userReads = store.state.userReads;
        _control.dataListLength = userReads.length;

        return PullLoadWrapper(
          refreshKey: refreshIndicatorKey,
          control: _control,
          isFirstLoading: _isLoading,
          onRefresh: _handleRefresh,
          itemBuilder: (context, index) {
            var item = userReads[index];

            return _buildReadComicItem(
              context: context,
              item: item,
              store: store,
            );
          },
        );
      },
    );
  }

  Widget _buildReadComicItem({
    BuildContext context,
    User_read item,
    Store<AppState> store,
  }) {
    return GestureDetector(
      onTap: () async {
        await Application.router
            .navigateTo(context, '/comic/detail/${item.comicId}');
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return CancelDialog(
              title: '是否要删除《${item.comicName}》',
              confirm: () async {
                await deleteOneRead(
                  item: item,
                  store: store,
                );
              },
            );
          },
        );
      },
      child: Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            bottom: ScreenUtil().setWidth(20),
                          ),
                          child: Text(
                            '${Utils.fromNow(item.readTime)}',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: ScreenUtil().setSp(24),
                            ),
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                              text: '阅读至  ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil().setSp(28),
                              ),
                              children: [
                                TextSpan(
                                  text: '${item.chapterName}',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: ScreenUtil().setSp(28),
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
            ),
          ],
        ),
      ),
    );
  }
}
