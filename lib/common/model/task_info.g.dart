// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskInfo _$TaskInfoFromJson(Map<String, dynamic> json) {
  return TaskInfo(
    (json['limit_tasks'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['sort_tasks'] as List)
        ?.map((e) =>
            e == null ? null : Sort_tasks.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['service_time'] as int,
  );
}

Map<String, dynamic> _$TaskInfoToJson(TaskInfo instance) => <String, dynamic>{
      'limit_tasks': instance.limitTasks,
      'sort_tasks': instance.sortTasks,
      'service_time': instance.serviceTime,
    };

Action_awards _$Action_awardsFromJson(Map<String, dynamic> json) {
  return Action_awards(
    json['id'] as int,
    json['type'] as int,
    json['task_id'] as int,
    json['trigger_type'] as int,
    json['target_limit'] as String,
    json['min_value'] as int,
    json['max_value'] as int,
    json['progress_add'] as int,
    json['order_num'] as int,
    (json['award_list'] as List)
        ?.map((e) =>
            e == null ? null : Award_list.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['is_delete'] as int,
    json['target_name'] as String,
    json['url'] as String,
    json['limit_type'] as int,
    json['display'] as String,
    json['is_accumulate'] as int,
    json['action_type'] as int,
    json['last_finish_time'] as int,
  );
}

Map<String, dynamic> _$Action_awardsToJson(Action_awards instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'task_id': instance.taskId,
      'trigger_type': instance.triggerType,
      'target_limit': instance.targetLimit,
      'min_value': instance.minValue,
      'max_value': instance.maxValue,
      'progress_add': instance.progressAdd,
      'order_num': instance.orderNum,
      'award_list': instance.awardList,
      'is_delete': instance.isDelete,
      'target_name': instance.targetName,
      'url': instance.url,
      'limit_type': instance.limitType,
      'display': instance.display,
      'is_accumulate': instance.isAccumulate,
      'action_type': instance.actionType,
      'last_finish_time': instance.lastFinishTime,
    };

Award_list _$Award_listFromJson(Map<String, dynamic> json) {
  return Award_list(
    json['target_type'] as int,
    json['amount'] as int,
    json['target_unit'] as int,
    json['icon'] as String,
    json['description'] as String,
    json['award_name'] as String,
  );
}

Map<String, dynamic> _$Award_listToJson(Award_list instance) =>
    <String, dynamic>{
      'target_type': instance.targetType,
      'amount': instance.amount,
      'target_unit': instance.targetUnit,
      'icon': instance.icon,
      'description': instance.description,
      'award_name': instance.awardName,
    };

Sort_tasks _$Sort_tasksFromJson(Map<String, dynamic> json) {
  return Sort_tasks(
    json['id'] as int,
    json['name'] as String,
    json['status'] as int,
    json['order_num'] as int,
    json['created_time'] as String,
    json['updated_time'] as String,
    json['task_version'] as int,
    (json['task_list'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$Sort_tasksToJson(Sort_tasks instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'order_num': instance.orderNum,
      'created_time': instance.createdTime,
      'updated_time': instance.updatedTime,
      'task_version': instance.taskVersion,
      'task_list': instance.taskList,
    };

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    json['id'] as int,
    json['sort_id'] as int,
    json['name'] as String,
    json['start_time'] as int,
    json['end_time'] as int,
    json['created_time'] as String,
    json['updated_time'] as String,
    json['time_span_value'] as int,
    json['time_span_unit'] as String,
    json['is_hidden'] as int,
    json['is_auto_popup'] as int,
    json['is_show_step'] as int,
    json['desc'] as String,
    json['is_delete'] as int,
    json['task_type'] as int,
    json['order_num'] as int,
    json['time_type'] as int,
    json['show_time'] as String,
    json['complete_type'] as int,
    (json['action_awards'] as List)
        ?.map((e) => e == null
            ? null
            : Action_awards.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['finish_awards'] as List)
        ?.map((e) => e == null
            ? null
            : Finish_awards.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'sort_id': instance.sortId,
      'name': instance.name,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'created_time': instance.createdTime,
      'updated_time': instance.updatedTime,
      'time_span_value': instance.timeSpanValue,
      'time_span_unit': instance.timeSpanUnit,
      'is_hidden': instance.isHidden,
      'is_auto_popup': instance.isAutoPopup,
      'is_show_step': instance.isShowStep,
      'desc': instance.desc,
      'is_delete': instance.isDelete,
      'task_type': instance.taskType,
      'order_num': instance.orderNum,
      'time_type': instance.timeType,
      'show_time': instance.showTime,
      'complete_type': instance.completeType,
      'action_awards': instance.actionAwards,
      'finish_awards': instance.finishAwards,
    };

Finish_awards _$Finish_awardsFromJson(Map<String, dynamic> json) {
  return Finish_awards(
    json['id'] as int,
    json['type'] as int,
    json['task_id'] as int,
    json['trigger_type'] as int,
    json['target_limit'] as String,
    json['min_value'] as int,
    json['max_value'] as int,
    json['progress_add'] as int,
    json['order_num'] as int,
    (json['award_list'] as List)
        ?.map((e) =>
            e == null ? null : Award_list.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['is_delete'] as int,
    json['icon'] == null
        ? null
        : Icon.fromJson(json['icon'] as Map<String, dynamic>),
    json['target_name'] as String,
    json['url'] as String,
    json['limit_type'] as int,
    json['last_finish_time'] as int,
  );
}

Map<String, dynamic> _$Finish_awardsToJson(Finish_awards instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'task_id': instance.taskId,
      'trigger_type': instance.triggerType,
      'target_limit': instance.targetLimit,
      'min_value': instance.minValue,
      'max_value': instance.maxValue,
      'progress_add': instance.progressAdd,
      'order_num': instance.orderNum,
      'award_list': instance.awardList,
      'is_delete': instance.isDelete,
      'icon': instance.icon,
      'target_name': instance.targetName,
      'url': instance.url,
      'limit_type': instance.limitType,
      'last_finish_time': instance.lastFinishTime,
    };

Icon _$IconFromJson(Map<String, dynamic> json) {
  return Icon(
    json['icon_1'] as String,
    json['icon_2'] as String,
    json['icon_3'] as String,
  );
}

Map<String, dynamic> _$IconToJson(Icon instance) => <String, dynamic>{
      'icon_1': instance.icon1,
      'icon_2': instance.icon2,
      'icon_3': instance.icon3,
    };
