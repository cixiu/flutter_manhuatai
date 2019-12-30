import 'package:json_annotation/json_annotation.dart';

part 'task_process.g.dart';

@JsonSerializable()
class TaskProcess extends Object {
  @JsonKey(name: 'data')
  List<Data> data;

  TaskProcess(
    this.data,
  );

  factory TaskProcess.fromJson(Map<String, dynamic> srcJson) =>
      _$TaskProcessFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TaskProcessToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'task_id')
  int taskId;

  @JsonKey(name: 'trigger_type')
  int triggerType;

  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'current_value')
  int currentValue;

  @JsonKey(name: 'can_award')
  int canAward;

  @JsonKey(name: 'target_limit')
  String targetLimit;

  @JsonKey(name: 'limit_type')
  int limitType;

  Data(
    this.taskId,
    this.triggerType,
    this.userId,
    this.currentValue,
    this.canAward,
    this.targetLimit,
    this.limitType,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
