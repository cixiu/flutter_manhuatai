import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_manhuatai/common/model/task_info.dart';

class TaskLimitView extends StatefulWidget {
  final List<Limit_tasks> limitTask;

  TaskLimitView({
    this.limitTask,
  });

  @override
  _TaskLimitViewState createState() => _TaskLimitViewState();
}

class _TaskLimitViewState extends State<TaskLimitView> {
  @override
  Widget build(BuildContext context) {
    double positionedLeft = ScreenUtil().setWidth(40);

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
              top: ScreenUtil().setWidth(20),
              left: positionedLeft,
              child: Text(
                task.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(32),
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
          ],
        );
      }).toList(),
    );
  }
}
