import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_manhuatai/api/http.dart';
import 'package:flutter_manhuatai/common/model/task_info.dart';
import 'package:flutter_manhuatai/common/model/task_process.dart';

class TaskApi {
  /// 获取我的任务列表
  static Future<TaskInfo> getUserTaskList({
    String openid,
    String authorization,
  }) async {
    final String url = 'http://task.321mh.com/v1/tasks/getusertasklist';

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'type': 'mkxq',
        'openid': openid,
        'task_version': 1,
        'productname': 'mht',
        'platformname': 'android',
        'client-type': 'android',
        'client-version': '2.3.1',
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $authorization',
        },
      ),
    );
    if (response['status'] == 0) {
      return TaskInfo.fromJson(response['data']);
    }
    return TaskInfo.fromJson({});
  }

  /// 获取我的任务进度
  static Future<TaskProcess> getUserTaskProcess({
    String openid,
    String authorization,
  }) async {
    final String url = 'http://task.321mh.com/v1/tasks/getusertaskprocess';

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'type': 'mkxq',
        'openid': openid,
        'productname': 'mht',
        'platformname': 'android',
        'client-type': 'android',
        'client-version': '2.3.1',
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $authorization',
        },
      ),
    );
    if (response['status'] == 0) {
      return TaskProcess.fromJson(response);
    }
    return TaskProcess.fromJson({});
  }
}
