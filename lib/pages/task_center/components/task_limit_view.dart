import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/api/task.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_manhuatai/common/model/task_info.dart';

class TaskLimitView extends StatefulWidget {
  final List<Task> limitTask;

  TaskLimitView({
    this.limitTask,
  });

  @override
  _TaskLimitViewState createState() => _TaskLimitViewState();
}

class _TaskLimitViewState extends State<TaskLimitView> {
  // 打开当前任务的任务列表
  void _openCurrentTaskList() {
    print('打开当前任务的任务列表');
  }

  // TODO: 一键完成
  Future<void> _finishTask({List<Action_awards> taskListAward}) async {
    var user = User(context);
    for (int i = 0; i < taskListAward.length; i++) {
      var taskAward = taskListAward[i];
      var response = await TaskApi.validateTask(
        taskAward: taskAward,
        type: user.info.type,
        openid: user.info.openid,
        authorization: user.info.taskData.authcode,
      );
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    double positionedLeft = ScreenUtil().setWidth(60);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.limitTask.map((task) {
        return Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
              ),
              child: Image.asset(
                'lib/images/task/icon_task_xianshi_bg.png',
                height: ScreenUtil().setWidth(245),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: ScreenUtil().setWidth(30),
              left: positionedLeft,
              child: Text(
                task.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(34),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              top: ScreenUtil().setWidth(80),
              left: positionedLeft,
              child: Text(
                task.actionAwards.first.display,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            ),
            Positioned(
              bottom: ScreenUtil().setWidth(30),
              left: positionedLeft,
              child: Row(
                children: task.actionAwards.first.awardList.map((award) {
                  return Stack(
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
                  );
                }).toList(),
              ),
            ),
            Positioned(
              top: ScreenUtil().setWidth(40),
              right: ScreenUtil().setWidth(60),
              child: Text(
                '${Utils.formatDate(task.startTime, 'MM.dd')}-${Utils.formatDate(task.endTime, 'MM.dd')}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            // 是否显示已完成标志
            // 如果 last_finish_time 在任务的 start_time 和 end_time 之间，则显示已完成
            task.actionAwards.last.lastFinishTime > task.startTime &&
                    task.actionAwards.last.lastFinishTime < task.endTime
                ? Positioned(
                    bottom: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(40),
                    child: Image.asset(
                      'lib/images/task/icon_task_done_xianshi.png',
                      width: ScreenUtil().setWidth(180),
                      height: ScreenUtil().setWidth(135),
                    ))
                : Positioned(
                    bottom: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(60),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _openCurrentTaskList();
                      },
                      child: Container(
                        width: ScreenUtil().setWidth(220),
                        height: ScreenUtil().setWidth(80),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setWidth(45),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '去完成',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(32),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        );
      }).toList(),
    );
  }
}
