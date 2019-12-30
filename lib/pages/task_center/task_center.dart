import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

import 'package:flutter_manhuatai/api/task.dart';
import 'package:flutter_manhuatai/common/const/user.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/common/model/task_info.dart';
import 'package:flutter_manhuatai/common/model/task_process.dart';

import 'package:flutter_manhuatai/components/common_sliver_persistent_header_delegate.dart/common_sliver_persistent_header_delegate.dart.dart';

import 'components/task_limit_view.dart';
import 'components/task_tab_view.dart';

class TaskCenter extends StatefulWidget {
  @override
  _TaskCenterState createState() => _TaskCenterState();
}

class _TaskCenterState extends State<TaskCenter>
    with
        WidgetsBindingObserver,
        RefreshCommonState,
        SingleTickerProviderStateMixin {
  TabController primaryTabController;
  TaskInfo taskInfo;
  List<Data> taskProcess;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    primaryTabController =
        TabController(vsync: this, initialIndex: 0, length: 3);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  Future<void> _onRefresh() async {
    var user = User(context);
    var _taskInfo = await TaskApi.getUserTaskList(
      openid: user.info.openid,
      authorization: user.info.authData.authcode,
    );
    var _taskProcess = await TaskApi.getUserTaskProcess(
      openid: user.info.openid,
      authorization: user.info.authData.authcode,
    );

    var taskProcessMap = Map();
    _taskProcess.data.forEach((task) {
      if (taskProcessMap[task.taskId] != null) {
        taskProcessMap[task.taskId].add(task);
      } else {
        taskProcessMap[task.taskId] = List()..add(task);
      }
    });

    print(taskProcessMap[23]);

    setState(() {
      taskInfo = _taskInfo;
      taskProcess = _taskProcess.data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('任务中心'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: _onRefresh,
        child: _isLoading
            ? Container()
            : extended.NestedScrollView(
                physics: ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                pinnedHeaderSliverHeightBuilder: () {
                  return ScreenUtil().setWidth(84);
                },
                innerScrollPositionKeyBuilder: () {
                  return Key('Tab${primaryTabController.index.toString()}');
                },
                headerSliverBuilder:
                    (BuildContext ctx, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverPadding(
                      padding: EdgeInsets.all(0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          TaskLimitView(
                            limitTask: taskInfo.limitTasks,
                          )
                        ]),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      floating: false,
                      delegate: CommonSliverPersistentHeaderDelegate(
                        child: Container(
                          child: TabBar(
                            controller: primaryTabController,
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 12.5),
                            labelStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                            ),
                            labelColor: Colors.blue,
                            unselectedLabelColor: Colors.black,
                            indicatorColor: Colors.blue,
                            indicatorSize: TabBarIndicatorSize.label,
                            isScrollable: true,
                            tabs: <Widget>[
                              Tab(
                                child: Text('日常'),
                              ),
                              Tab(
                                child: Text('萌新'),
                              ),
                              Tab(
                                child: Text('成绩'),
                              ),
                            ],
                          ),
                          //color: Colors.white,
                        ),
                        height: ScreenUtil().setWidth(84),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: primaryTabController,
                  children: <Widget>[
                    TaskTabView(
                      positionKey: 'Tab0',
                      name: '日常',
                    ),
                    TaskTabView(
                      positionKey: 'Tab1',
                      name: '萌新',
                    ),
                    TaskTabView(
                      positionKey: 'Tab2',
                      name: '成就',
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
