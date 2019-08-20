import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redux/redux.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/components/cancel_dialog/cancel_dialog.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/components/load_more_widget/load_more_widget.dart';
import 'package:flutter_manhuatai/components/pull_load_wrapper/pull_load_wrapper.dart';
import 'package:flutter_manhuatai/components/request_loading/request_loading.dart';
import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/store/index.dart';
import 'package:flutter_manhuatai/store/user_collects.dart';
import 'package:flutter_manhuatai/store/user_reads.dart';
import 'package:flutter_manhuatai/utils/utils.dart';

class BookshelfUserCollects extends StatefulWidget {
  @override
  _BookshelfUserCollectsState createState() => _BookshelfUserCollectsState();
}

class _BookshelfUserCollectsState extends State<BookshelfUserCollects>
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
    await getUserRecordAsyncAction(store);
    if (!this.mounted) {
      return;
    }

    _control.dataListLength = store.state.userCollects.length;
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> deleteOneCollect({
    User_collect item,
    Store<AppState> store,
  }) async {
    try {
      showLoading(context);
      var userInfo = store.state.userInfo;
      var guestInfo = store.state.guestInfo;
      var user = userInfo.uid != null ? userInfo : guestInfo;
      String action = 'dels';
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

      var status = await Api.setUserCollect(
        type: user.type,
        openid: user.openid,
        deviceid: deviceid,
        myUid: user.uid,
        action: action,
        comicId: _comicId,
        comicIdList: [_comicId],
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

      store.dispatch(
        UpdateUserCollectsAction(getUserRecordRes.userCollect),
      );

      hideLoading(context);

      if (status) {
        showToast('已取消对${item.comicName}的订阅');
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
    super.build(context);

    return StoreBuilder<AppState>(
      builder: (context, store) {
        var userCollects = store.state.userCollects;
        _control.dataListLength = userCollects?.length;

        return PullLoadWrapper(
          refreshKey: refreshIndicatorKey,
          control: _control,
          isFirstLoading: _isLoading,
          onRefresh: _handleRefresh,
          customBottomWidget: _buildNomoreWrapper(_control.dataListLength),
          itemBuilder: (context, index) {
            var item = userCollects[index];

            return _buildCollectComicItem(
              context: context,
              item: item,
              store: store,
            );
          },
        );
      },
    );
  }

  Widget _buildNomoreWrapper(int count) {
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
                  '共$count部漫画~',
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

  Widget _buildCollectComicItem({
    BuildContext context,
    User_collect item,
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
              title: '是否取消对《${item.comicName}》的订阅？',
              confirm: () async {
                await deleteOneCollect(
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
                                fontSize: ScreenUtil().setSp(28),
                              ),
                              children: [
                                TextSpan(
                                  text: '${item.lastChapterName}',
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
            // GestureDetector(
            //   behavior: HitTestBehavior.opaque,
            //   onTap: () {
            //     showDialog(
            //       context: context,
            //       builder: (context) {
            //         return CancelDialog(
            //           title: '是否取消对《${item.comicName}》的订阅？',
            //           confirm: () async {
            //             await deleteOneCollect(
            //               item: item,
            //               store: store,
            //             );
            //           },
            //         );
            //       },
            //     );
            //   },
            //   child: Container(
            //     padding: EdgeInsets.only(
            //       top: ScreenUtil().setWidth(30),
            //       bottom: ScreenUtil().setWidth(30),
            //       left: ScreenUtil().setWidth(30),
            //     ),
            //     child: Icon(
            //       Icons.delete,
            //       color: Colors.grey,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
