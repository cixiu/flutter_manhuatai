import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/provider_store/user_info_model.dart';
import 'package:flutter_manhuatai/provider_store/user_record_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/components/cancel_dialog/cancel_dialog.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';
import 'package:flutter_manhuatai/components/pull_load_wrapper/pull_load_wrapper.dart';
import 'package:flutter_manhuatai/components/request_loading/request_loading.dart';
import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:provider/provider.dart';

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
    var userRecordModel = Provider.of<UserRecordModel>(context, listen: false);
    var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);

    if (userRecordModel.userReads != null && _isLoading == true) {
      _control.dataListLength = userRecordModel.userReads.length;
      setState(() {
        _isLoading = false;
      });
      return;
    }

    await userRecordModel.getUserRecordAsyncAction(
        userInfoModel.user, !_isLoading);

    if (!this.mounted) {
      return;
    }

    _control.dataListLength = userRecordModel.userReads.length;
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> deleteOneRead({
    User_read item,
  }) async {
    try {
      showLoading(context);
      var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
      var user = userInfoModel.user;

      int _comicId = item.comicId;
      var deviceid = await Utils.getDeviceId();

      var status = await Api.delUserRead(
        type: user.type,
        openid: user.openid,
        deviceid: deviceid,
        myUid: user.uid,
        comicId: _comicId,
      );

      if (status) {
        showToast('已取消对${item.comicName}的订阅');
        var userRecordModel =
            Provider.of<UserRecordModel>(context, listen: false);

        userRecordModel.deleteOneUserRead(item);
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

    return Selector<UserRecordModel, List<User_read>>(
      selector: (context, userRecordModel) => userRecordModel.userReads,
      builder: (context, userReads, _) {
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
            );
          },
        );
      },
    );
  }

  Widget _buildReadComicItem({
    BuildContext context,
    User_read item,
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
