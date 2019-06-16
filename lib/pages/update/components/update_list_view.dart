import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/components/pull_load_wrapper/pull_load_wrapper.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/models/update_list.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef Future<void> FutureVoidCallBack();

class UpdateListView extends StatefulWidget {
  final int index;

  UpdateListView({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  _UpdateListViewState createState() => _UpdateListViewState();
}

class _UpdateListViewState extends State<UpdateListView>
    with
        AutomaticKeepAliveClientMixin,
        RefreshCommonState,
        WidgetsBindingObserver {
  final updateListViewController = PullLoadWrapperControl();
  bool _isFirstShow = true;
  bool _isLoading = true;
  Update _updateData;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.index == 6) {
        showRefreshLoading();
        _isFirstShow = false;
      }
    });
  }

  @override
  void didUpdateWidget(UpdateListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isFirstShow) {
      _isFirstShow = false;
      showRefreshLoading();
    }
  }

  Future<void> handleRefresh() async {
    if (!this.mounted) {
      return;
    }
    var getUpdateListRes = await Api.getUpdateList();
    setState(() {
      _updateData = getUpdateListRes.update[widget.index];
      updateListViewController.dataListLength = _updateData.info.length;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PullLoadWrapper(
      refreshKey: refreshIndicatorKey,
      control: updateListViewController,
      isFirstLoading: _isLoading,
      onRefresh: handleRefresh,
      itemBuilder: (context, index) {
        var item = _updateData.info[index];
        String imgUrl = item.featureImg.isEmpty
            ? Utils.generateImgUrlFromId(
                id: item.comicId,
                aspectRatio: '2:1',
              )
            : item.featureImg;

        Color shadowColor = Color(int.parse('0xFF${item.outterColor}'));
        double shadowBlurRadius = item.brushSize.toDouble();

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Application.router.navigateTo(
              context,
              '/comic/detail/${item.comicId}',
            );
          },
          child: Column(
            children: <Widget>[
              Stack(
                alignment: item.featureLocation == 0
                    ? Alignment.bottomLeft
                    : item.featureLocation == 1
                        ? Alignment.bottomCenter
                        : Alignment.bottomRight,
                children: <Widget>[
                  ImageWrapper(
                    url: imgUrl,
                    width: double.infinity,
                    height: ScreenUtil().setWidth(390),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: ScreenUtil().setWidth(36),
                    top: ScreenUtil().setWidth(20),
                    child: Container(
                      height: ScreenUtil().setWidth(32),
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(6),
                        horizontal: ScreenUtil().setWidth(10),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'lib/images/icon_comic_human.png',
                            width: ScreenUtil().setWidth(24),
                            height: ScreenUtil().setWidth(24),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(10),
                            ),
                            child: Text(
                              Utils.formatNumber(item.renqi.toString()),
                              strutStyle: StrutStyle(
                                forceStrutHeight: true,
                                fontSize: ScreenUtil().setSp(20),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(36),
                      vertical: ScreenUtil().setWidth(48),
                    ),
                    child: Text(
                      '${item.chapterFeature.isNotEmpty ? item.chapterFeature : item.comicFeature}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(36),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: shadowColor,
                            offset: Offset(2.0, -2.0),
                            blurRadius: shadowBlurRadius,
                          ),
                          Shadow(
                            color: shadowColor,
                            offset: Offset(-2.0, -2.0),
                            blurRadius: shadowBlurRadius,
                          ),
                          Shadow(
                            color: shadowColor,
                            offset: Offset(2.0, 2.0),
                            blurRadius: shadowBlurRadius,
                          ),
                          Shadow(
                            color: shadowColor,
                            offset: Offset(-2.0, 2.0),
                            blurRadius: shadowBlurRadius,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                  vertical: ScreenUtil().setWidth(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setWidth(6),
                            horizontal: ScreenUtil().setWidth(12),
                          ),
                          margin: EdgeInsets.only(
                            right: ScreenUtil().setWidth(15),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: shadowColor,
                              width: ScreenUtil().setWidth(1),
                            ),
                            borderRadius: BorderRadius.circular(
                              ScreenUtil().setWidth(18),
                            ),
                          ),
                          child: Text(
                            '${item.comicType.first ?? ''}',
                            strutStyle: StrutStyle(
                              forceStrutHeight: true,
                              fontSize: ScreenUtil().setSp(20),
                            ),
                            style: TextStyle(
                              color: shadowColor,
                              fontSize: ScreenUtil().setSp(20),
                            ),
                          ),
                        ),
                        Text(
                          item.comicName,
                          strutStyle: StrutStyle(
                            forceStrutHeight: true,
                            fontSize: ScreenUtil().setSp(28),
                          ),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: ScreenUtil().setSp(28),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(10),
                      ),
                      child: Text(
                        item.comicChapterName,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: ScreenUtil().setSp(24),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
