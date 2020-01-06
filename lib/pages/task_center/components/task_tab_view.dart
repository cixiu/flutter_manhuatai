import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_manhuatai/common/model/task_info.dart' as TaskInfo;
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_manhuatai/components/bottom_sheet/bottom_sheet.dart'
    as customButtonSheet;

import 'task_list_detail.dart';

class TaskTabView extends StatefulWidget {
  final String positionKey;
  final String name;
  final List<TaskInfo.Task> taskList;

  TaskTabView({
    this.positionKey,
    this.name,
    this.taskList,
  });

  @override
  _TaskTabViewState createState() => _TaskTabViewState();
}

class _TaskTabViewState extends State<TaskTabView>
    with AutomaticKeepAliveClientMixin {
  List<TaskInfo.Task> taskList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    sortTaskList();
  }

  // 对任务列表进行排序，已完成的任务排在后面
  void sortTaskList() {
    List<TaskInfo.Task> hasFinishedList = [];
    List<TaskInfo.Task> notFinishedList = [];
    widget.taskList.forEach((task) {
      sortTaskAward(task);
      if (_hasAllFinished(task)) {
        hasFinishedList.add(task);
      } else {
        notFinishedList.add(task);
      }
    });

    setState(() {
      taskList = List()..addAll(notFinishedList)..addAll(hasFinishedList);
    });
  }

  // 对单个任务的列表任务进行排序，完成的排后面
  void sortTaskAward(TaskInfo.Task task) {
    List<TaskInfo.Action_awards> hasFinishedAwardList = [];
    List<TaskInfo.Action_awards> notFinishedAwardList = [];
    task.actionAwards.forEach((award) {
      if (Utils.hasFinishedAward(task: task, award: award)) {
        hasFinishedAwardList.add(award);
      } else {
        notFinishedAwardList.add(award);
      }
    });
    task.actionAwards = List()
      ..addAll(notFinishedAwardList)
      ..addAll(hasFinishedAwardList);
  }

  bool _hasAllFinished(TaskInfo.Task task) {
    // 一次行的任务或者限时性任务
    if (task.timeSpanUnit == 'total') {
      bool flag = true;
      task.actionAwards.forEach((award) {
        if (award.lastFinishTime == 0) {
          flag = false;
        }
      });
      return flag;
    }
    // 每周更新的任务
    if (task.timeSpanUnit == 'week') {
      var times = Utils.getWeekStartAndEndTimeStamp();
      int startTime = times.first;
      bool flag = true;
      task.actionAwards.forEach((award) {
        int lastFinishTime = award.lastFinishTime;
        // 如果存在一个 lastFinishTime 小于 本周的开始时间
        // 那么这个任务一定还没有完成
        if (lastFinishTime < startTime) {
          flag = false;
        }
      });
      return flag;
    }
    // 每日更新的任务
    if (task.timeSpanUnit == 'day') {
      var times = Utils.getTodayStartAndEndTimeStamp();
      int startTime = times.first;
      bool flag = true;
      task.actionAwards.forEach((award) {
        int lastFinishTime = award.lastFinishTime;
        // 如果存在一个 lastFinishTime 小于 今天的开始时间
        // 那么这个任务一定还没有完成
        if (lastFinishTime < startTime) {
          flag = false;
        }
      });
      return flag;
    }
    // 小时的奖励
    if (task.timeSpanUnit == 'hour') {
      bool flag = true;
      int nowTime = DateTime.now().millisecondsSinceEpoch;
      task.actionAwards.forEach((award) {
        int lastFinishTime = award.lastFinishTime;
        // 如果存在一个 现在时间 - lastFinishTime 大于 1小时
        // 那么这个任务一定还没有完成
        if (nowTime - lastFinishTime > 60 * 60 * 1000) {
          flag = false;
        }
      });
      return flag;
    }
    return false;
  }

  // 获取下一次可以完成任务的开始提示
  String _getNextStartTips(TaskInfo.Task task) {
    String text = '';
    if (task.timeSpanUnit == 'hour') {
      text = '每小时刷新';
    }
    if (task.timeSpanUnit == 'day') {
      text = '每天刷新';
    }
    if (task.timeSpanUnit == 'week') {
      text = '每周刷新';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
      Key('${widget.positionKey}'),
      ListView(
        padding: EdgeInsets.only(
          bottom: ScreenUtil().setWidth(60),
        ),
        children: taskList.map((task) {
          if (task.isHidden == 1) {
            return Container();
          }
          return GestureDetector(
            onTap: () async {
              await customButtonSheet.showModalBottomSheet(
                // isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext ctx) {
                  return TaskListDetail(
                    task: task,
                    hasAllFinished: _hasAllFinished,
                  );
                },
              );
              // 重排任务列表 更新视图
              sortTaskList();
            },
            child: _buildTaskItem(task),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTaskItem(TaskInfo.Task task) {
    double positionedLeft = ScreenUtil().setWidth(60);

    return Stack(
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
          top: ScreenUtil().setWidth(30),
          left: positionedLeft,
          child: Row(
            children: <Widget>[
              Text(
                task.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(34),
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: ScreenUtil().setSp(34),
                color: Colors.grey[400],
              )
            ],
          ),
        ),
        // 任务说明
        Positioned(
          top: ScreenUtil().setWidth(80),
          left: positionedLeft,
          child: Text(
            task.actionAwards.first.display,
            style: TextStyle(
              color: Colors.grey,
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
        ),
        // 任务奖励
        Positioned(
          bottom: ScreenUtil().setWidth(30),
          left: positionedLeft,
          child: Row(
            children: task.actionAwards.first.awardList.map((award) {
              return Container(
                margin: EdgeInsets.only(
                  right: ScreenUtil().setWidth(20),
                ),
                child: Stack(
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
                        '${award.amount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(28),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        _hasAllFinished(task)
            ? Positioned(
                top: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(60),
                child: Text(
                  _getNextStartTips(task),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil().setSp(28),
                  ),
                ),
              )
            : Container(),
        // 是否显示已完成标志
        _hasAllFinished(task)
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
      ],
    );
  }
}
