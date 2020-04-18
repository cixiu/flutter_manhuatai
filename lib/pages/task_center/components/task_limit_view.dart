import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/model/award_result.dart';
import 'package:flutter_manhuatai/components/request_loading/request_loading.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';
import 'package:flutter_manhuatai/store/index.dart';
import 'package:flutter_manhuatai/store/user_info.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/api/task.dart';
import 'package:flutter_manhuatai/common/const/app_const.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_manhuatai/common/model/task_info.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redux/redux.dart';

import 'task_result_toast.dart';

class TaskLimitView extends StatefulWidget {
  final List<Task> limitTask;

  TaskLimitView({
    this.limitTask,
  });

  @override
  _TaskLimitViewState createState() => _TaskLimitViewState();
}

class _TaskLimitViewState extends State<TaskLimitView> {
  Future<void> _finishTask({Task task}) async {
    try {
      var user = User(context);
      // 如果未登录，则跳转去登录
      if (!user.hasLogin) {
        Application.router.navigateTo(context, '${Routes.login}');
        return;
      }
      var type = user.info.type;
      var openid = user.info.openid;
      var authorization = user.info.authData.authcode;
      AwardResult awardResult;

      showLoading(context);
      awardResult = await TaskApi.validateTask(
        type: type,
        openid: openid,
        authorization: authorization,
        task: task,
      );
      if (awardResult.awardresult != null) {
        setState(() {
          task.actionAwards.forEach((award) {
            award.lastFinishTime = awardResult.achievetime;
          });
        });
      } else {
        hideLoading(context);
        showToast('任务领取失败');
        return;
      }

      Store<AppState> store = StoreProvider.of(context);
      await getUseroOrGuestInfo(store);
      hideLoading(context);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return TaskResultToast(awardResult: awardResult);
        },
      );
    } catch (e) {
      hideLoading(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double positionedLeft = ScreenUtil().setWidth(60);
    double positionedRight = ScreenUtil().setWidth(40);

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
              right: positionedRight,
              child: Text(
                task.actionAwards.first.display,
                overflow: TextOverflow.ellipsis,
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
                    bottom: ScreenUtil().setWidth(15),
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
                        _finishTask(task: task);
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
                          '一键完成',
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
