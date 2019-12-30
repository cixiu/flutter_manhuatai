// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_process.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskProcess _$TaskProcessFromJson(Map<String, dynamic> json) {
  return TaskProcess(
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TaskProcessToJson(TaskProcess instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['task_id'] as int,
    json['trigger_type'] as int,
    json['user_id'] as int,
    json['current_value'] as int,
    json['can_award'] as int,
    json['target_limit'] as String,
    json['limit_type'] as int,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'task_id': instance.taskId,
      'trigger_type': instance.triggerType,
      'user_id': instance.userId,
      'current_value': instance.currentValue,
      'can_award': instance.canAward,
      'target_limit': instance.targetLimit,
      'limit_type': instance.limitType,
    };
