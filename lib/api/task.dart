import 'dart:async';
import 'dart:io';

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

  /// 验证任务
  static Future<Map<String, dynamic>> validateTask({
    String type,
    String openid,
    String authorization,
    Action_awards taskAward,
  }) async {
    final String url = 'http://task.321mh.com/v1/tasks/validatetask';

    var data = {
      'targets': {
        '${taskAward.id}_${taskAward.triggerType}': {
          'id': taskAward.targetLimit,
          'value': taskAward.minValue
        }
      },
      'task_award_ids': [taskAward.id],
      'taskid': taskAward.taskId,
      'localtime':
          '${DateTime.now().millisecondsSinceEpoch + 1000 * taskAward.minValue}',
      'productname': 'mht',
      'platformname': 'android',
      'client-type': 'android',
      'client-version': '2.3.1',
      'client-channel': 'meizu',
      'type': type,
      'openid': openid,
    };
    print(data);

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $authorization',
        },
        contentType: ContentType.json,
      ),
    );

    return response;
    // if (response['status'] == 0) {
    //   return TaskProcess.fromJson(response);
    // }
    // return TaskProcess.fromJson({});
  }
}
