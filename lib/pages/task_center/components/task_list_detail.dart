import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/api/task.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/common/model/award_result.dart';
import 'package:flutter_manhuatai/components/request_loading/request_loading.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/common/model/task_info.dart' hide Icon;

class TaskListDetail extends StatefulWidget {
  final Task task;
  final bool Function(Task task) hasAllFinished;

  TaskListDetail({
    this.task,
    this.hasAllFinished,
  });

  @override
  _TaskListDetailState createState() => _TaskListDetailState();
}

class _TaskListDetailState extends State<TaskListDetail> {
  Task task;

  @override
  void initState() {
    super.initState();
    sortTaskList();
  }

  // 对任务列表进行排序，已完成的任务排在后面
  void sortTaskList() {
    task = widget.task;
    List<Action_awards> hasFinishedList = [];
    List<Action_awards> notFinishedList = [];
    widget.task.actionAwards.forEach((award) {
      if (_hasFinished(award)) {
        hasFinishedList.add(award);
      } else {
        notFinishedList.add(award);
      }
    });
    setState(() {
      task.actionAwards = List()
        ..addAll(notFinishedList)
        ..addAll(hasFinishedList);
    });
  }

  bool _hasFinished(Action_awards award) {
    bool flag = true;
    int lastFinishTime = award.lastFinishTime;

    // 一次行的任务或者限时性任务
    if (task.timeSpanUnit == 'total') {
      if (lastFinishTime == 0) {
        flag = false;
      }
      return flag;
    }
    // 每周更新的任务
    if (task.timeSpanUnit == 'week') {
      var times = Utils.getWeekStartAndEndTimeStamp();
      int startTime = times.first;
      // 如果 lastFinishTime 小于 本周的开始时间
      // 那么这个任务一定还没有完成
      if (lastFinishTime < startTime) {
        flag = false;
      }
      return flag;
    }
    // 每日更新的任务
    if (task.timeSpanUnit == 'day') {
      var times = Utils.getTodayStartAndEndTimeStamp();
      int startTime = times.first;
      // 如果 lastFinishTime 小于 今天的开始时间
      // 那么这个任务一定还没有完成
      if (lastFinishTime < startTime) {
        flag = false;
      }
      return flag;
    }
    // 小时的奖励
    if (task.timeSpanUnit == 'hour') {
      bool flag = true;
      int nowTime = DateTime.now().millisecondsSinceEpoch;
      // 如果 现在时间 - lastFinishTime 大于 1小时
      // 那么这个任务一定还没有完成
      if (nowTime - lastFinishTime > 60 * 60 * 1000) {
        flag = false;
      }
      return flag;
    }
    return false;
  }

  // 一键完成
  Future<void> _finishTask({Action_awards award}) async {
    if (widget.hasAllFinished(task)) {
      return;
    }

    try {
      var user = User(context);
      var type = user.info.type;
      var openid = user.info.openid;
      var authorization = user.info.authData.authcode;
      AwardResult awardResult;

      showLoading(context);
      if (award != null) {
        awardResult = await TaskApi.validateTask(
          type: type,
          openid: openid,
          authorization: authorization,
          taskAward: award,
        );
      } else {
        awardResult = await TaskApi.validateTask(
          type: type,
          openid: openid,
          authorization: authorization,
          task: task,
        );
      }
      print(awardResult);
      hideLoading(context);
    } catch (e) {
      hideLoading(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                _buildHeader(),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      ListView(
                        padding: EdgeInsets.only(
                          bottom: ScreenUtil().setWidth(200),
                        ),
                        controller: scrollController,
                        physics: ClampingScrollPhysics(),
                        children: _buildTaskListView(),
                      ),
                      Positioned(
                        right: ScreenUtil().setWidth(30),
                        bottom: ScreenUtil().setWidth(60),
                        child: GestureDetector(
                          onTap: _finishTask,
                          child: Image.asset(
                            widget.hasAllFinished(task)
                                ? 'lib/images/task/icon_task_receive_b.png'
                                : 'lib/images/task/icon_task_receive_a.png',
                            width: ScreenUtil().setWidth(160),
                            height: ScreenUtil().setWidth(160),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      height: ScreenUtil().setWidth(100),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.blue[50]),
        ),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                task.name,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: ScreenUtil().setSp(34),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              child: Icon(
                Icons.close,
                color: Colors.grey[400],
                size: ScreenUtil().setSp(48),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTaskListView() {
    List<Widget> children = List();
    if (task.desc.isNotEmpty) {
      children.add(
        Container(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setWidth(20),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(30),
          ),
          child: RichText(
            text: TextSpan(
              text: '任务详情：',
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(28),
              ),
              children: [
                TextSpan(
                  text: task.desc,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil().setSp(28),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    double positionedLeft = ScreenUtil().setWidth(60);

    task.actionAwards.forEach((award) {
      children.add(Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(10),
            ),
            child: Image.asset(
              'lib/images/task/icon_task_putong_bg.png',
              height: ScreenUtil().setWidth(245),
              fit: BoxFit.cover,
            ),
          ),
          // 任务名字
          Positioned(
            top: ScreenUtil().setWidth(60),
            left: positionedLeft,
            child: Text(
              award.display,
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(34),
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ),
          // 任务奖励
          Positioned(
            bottom: ScreenUtil().setWidth(30),
            left: positionedLeft,
            child: Row(
              children: award.awardList.map((_award) {
                return Stack(
                  children: <Widget>[
                    Image.network(
                      '${AppConst.img_host}${_award.icon}',
                      width: ScreenUtil().setWidth(80),
                      height: ScreenUtil().setWidth(80),
                    ),
                    Positioned(
                      bottom: ScreenUtil().setWidth(4),
                      right: ScreenUtil().setWidth(4),
                      child: Text(
                        '${_award.amount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(28),
                        ),
                      ),
                    )
                  ],
                );
              }).toList(),
            ),
          ),
          task.finishAwards.length != 0 && award.progressAdd != 0
              ? Positioned(
                  top: ScreenUtil().setWidth(50),
                  right: ScreenUtil().setWidth(60),
                  child: Text(
                    '完成度+${award.progressAdd}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(28),
                    ),
                  ),
                )
              : Container(),
          // 是否显示已完成标志
          _hasFinished(award)
              ? Positioned(
                  bottom: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(60),
                  child: Image.asset(
                    'lib/images/task/icon_task_done_putong.png',
                    width: ScreenUtil().setWidth(180),
                    height: ScreenUtil().setWidth(135),
                  ),
                )
              : Positioned(
                  bottom: ScreenUtil().setWidth(40),
                  right: ScreenUtil().setWidth(60),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // _openCurrentTaskList();
                      _finishTask(award: award);
                    },
                    child: Container(
                      width: ScreenUtil().setWidth(220),
                      height: ScreenUtil().setWidth(80),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(45),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '去完成',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: ScreenUtil().setSp(32),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ));
    });
    return children;
  }
}
