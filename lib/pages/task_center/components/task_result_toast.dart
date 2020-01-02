import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_manhuatai/common/model/award_result.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskResultToast extends StatefulWidget {
  final AwardResult awardResult;

  TaskResultToast({
    this.awardResult,
  });

  @override
  _TaskResultToastState createState() => _TaskResultToastState();
}

class _TaskResultToastState extends State<TaskResultToast>
    with TickerProviderStateMixin {
  AnimationController _rotationController;
  int _imageIndex = 1;
  Timer _timer;
  // 加倍卡字典
  Map<String, String> _times = {
    '2': '二',
    '3': '三',
    '4': '四',
  };

  @override
  void initState() {
    super.initState();
    _rotationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _rotationController.forward();
    _rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotationController.reset();
        _rotationController.forward();
      }
    });
    // 更新图片，产生动画视图
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer _) {
      setState(() {
        _imageIndex++;
      });
      if (_imageIndex == 10) {
        _.cancel();
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(12),
        ),
        child: Container(
          width: ScreenUtil().setWidth(500),
          constraints: BoxConstraints(
            minHeight: ScreenUtil().setWidth(360),
            maxHeight: ScreenUtil().setWidth(600),
          ),
          // color: Colors.yellow,
          child: Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(500),
                height: widget.awardResult.awardresult.first.extranumber != 0
                    ? ScreenUtil().setWidth(600)
                    : ScreenUtil().setWidth(360),
              ),
              Positioned(
                top: -ScreenUtil().setWidth(168),
                child: Image.asset(
                  'lib/images/task/icon_task_gift.png',
                  width: ScreenUtil().setWidth(350),
                  height: ScreenUtil().setWidth(168),
                ),
              ),
              Positioned(
                top: -ScreenUtil().setWidth(280),
                child: RotationTransition(
                  turns: _rotationController,
                  child: Image.asset(
                    'lib/images/task/icon_task_light.png',
                    width: ScreenUtil().setWidth(450),
                    height: ScreenUtil().setWidth(450),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(116),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setWidth(12),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      // 基础奖励
                      _buildAwardNumber(false),
                      // 额外的奖励
                      widget.awardResult.awardresult.first.extranumber != 0
                          ? Column(
                              children: <Widget>[
                                _buildExtarDes(),
                                _buildAwardNumber(true),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -ScreenUtil().setWidth(116),
                child: Image.asset(
                  'lib/images/task/icon_movie$_imageIndex.png',
                  width: ScreenUtil().setWidth(438),
                  height: ScreenUtil().setWidth(172),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAwardNumber(bool hasExtra) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.awardResult.awardresult.map((award) {
        if (hasExtra && award.extranumber == 0) {
          return Container();
        }

        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.network(
                    '${AppConst.img_host}${award.icon}',
                    width: ScreenUtil().setWidth(80),
                    height: ScreenUtil().setWidth(80),
                  ),
                  Positioned(
                    bottom: ScreenUtil().setWidth(4),
                    right: ScreenUtil().setWidth(4),
                    child: Text(
                      hasExtra ? '${award.extranumber}' : '${award.number}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(28),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setWidth(10),
                ),
                child: Text(
                  '${award.name}',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: ScreenUtil().setSp(28),
                  ),
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExtarDes() {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setWidth(40),
        bottom: ScreenUtil().setWidth(30),
      ),
      child: RichText(
        text: TextSpan(
          text: '${_times['${widget.awardResult.awardresult.first.times}']}倍卡',
          style: TextStyle(
            color: Colors.red[300],
            fontSize: ScreenUtil().setSp(32),
          ),
          children: [
            TextSpan(
              text: '额外获得：',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
