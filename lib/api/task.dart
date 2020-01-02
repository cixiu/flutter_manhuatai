import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_manhuatai/api/http.dart';
import 'package:flutter_manhuatai/common/model/award_result.dart';
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
  static Future<AwardResult> validateTask({
    @required String type,
    @required String openid,
    @required String authorization,
    // 完成单个传入的任务
    Action_awards taskAward,
    // 批量完成整个传入的列表任务
    Task task,
  }) async {
    assert(task != null || taskAward != null);
    if (task != null && taskAward != null) {
      throw Exception('task and taskAward just need one');
    }
    final String url = 'http://task.321mh.com/v1/tasks/validatetask';
    Map<String, dynamic> data = Map();
    data = {
      'localtime': '${DateTime.now().millisecondsSinceEpoch}',
      'productname': 'mht',
      'platformname': 'android',
      'client-type': 'android',
      'client-version': '2.3.1',
      'client-channel': 'meizu',
      'type': type,
      'openid': openid,
    };

    if (taskAward != null) {
      data.addAll({
        'targets': {
          '${taskAward.id}_${taskAward.triggerType}': {
            'id': taskAward.targetLimit,
            'value': taskAward.minValue
          }
        },
        'task_award_ids': [taskAward.id],
        'taskid': taskAward.taskId,
      });
    }

    if (task != null) {
      Map targets = Map();
      List<int> taskAwardIds = List();
      task.actionAwards.forEach((award) {
        targets.addAll({
          '${award.id}_${award.triggerType}': {
            'id': award.targetLimit,
            'value': award.minValue
          }
        });
        taskAwardIds.add(award.id);
      });
      data.addAll({
        'targets': targets,
        'task_award_ids': taskAwardIds,
        'taskid': task.id,
      });
    }

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

    if (response['status'] == 0) {
      return AwardResult.fromJson(response['data']);
    }
    return AwardResult.fromJson({});
  }
}
