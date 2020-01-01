import 'package:json_annotation/json_annotation.dart';

part 'task_info.g.dart';

@JsonSerializable()
class TaskInfo extends Object {
  @JsonKey(name: 'limit_tasks')
  List<Task> limitTasks;

  @JsonKey(name: 'sort_tasks')
  List<Sort_tasks> sortTasks;

  @JsonKey(name: 'service_time')
  int serviceTime;

  TaskInfo(
    this.limitTasks,
    this.sortTasks,
    this.serviceTime,
  );

  factory TaskInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$TaskInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TaskInfoToJson(this);
}

@JsonSerializable()
class Action_awards extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'task_id')
  int taskId;

  @JsonKey(name: 'trigger_type')
  int triggerType;

  @JsonKey(name: 'target_limit')
  String targetLimit;

  @JsonKey(name: 'min_value')
  int minValue;

  @JsonKey(name: 'max_value')
  int maxValue;

  @JsonKey(name: 'progress_add')
  int progressAdd;

  @JsonKey(name: 'order_num')
  int orderNum;

  @JsonKey(name: 'award_list')
  List<Award_list> awardList;

  @JsonKey(name: 'is_delete')
  int isDelete;

  @JsonKey(name: 'target_name')
  String targetName;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'limit_type')
  int limitType;

  @JsonKey(name: 'display')
  String display;

  @JsonKey(name: 'is_accumulate')
  int isAccumulate;

  @JsonKey(name: 'action_type')
  int actionType;

  @JsonKey(name: 'last_finish_time')
  int lastFinishTime;

  Action_awards(
    this.id,
    this.type,
    this.taskId,
    this.triggerType,
    this.targetLimit,
    this.minValue,
    this.maxValue,
    this.progressAdd,
    this.orderNum,
    this.awardList,
    this.isDelete,
    this.targetName,
    this.url,
    this.limitType,
    this.display,
    this.isAccumulate,
    this.actionType,
    this.lastFinishTime,
  );

  factory Action_awards.fromJson(Map<String, dynamic> srcJson) =>
      _$Action_awardsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Action_awardsToJson(this);
}

@JsonSerializable()
class Award_list extends Object {
  @JsonKey(name: 'target_type')
  int targetType;

  @JsonKey(name: 'amount')
  int amount;

  @JsonKey(name: 'target_unit')
  int targetUnit;

  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'award_name')
  String awardName;

  Award_list(
    this.targetType,
    this.amount,
    this.targetUnit,
    this.icon,
    this.description,
    this.awardName,
  );

  factory Award_list.fromJson(Map<String, dynamic> srcJson) =>
      _$Award_listFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Award_listToJson(this);
}

@JsonSerializable()
class Sort_tasks extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'order_num')
  int orderNum;

  @JsonKey(name: 'created_time')
  String createdTime;

  @JsonKey(name: 'updated_time')
  String updatedTime;

  @JsonKey(name: 'task_version')
  int taskVersion;

  @JsonKey(name: 'task_list')
  List<Task> taskList;

  Sort_tasks(
    this.id,
    this.name,
    this.status,
    this.orderNum,
    this.createdTime,
    this.updatedTime,
    this.taskVersion,
    this.taskList,
  );

  factory Sort_tasks.fromJson(Map<String, dynamic> srcJson) =>
      _$Sort_tasksFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Sort_tasksToJson(this);
}

@JsonSerializable()
class Task extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'sort_id')
  int sortId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'start_time')
  int startTime;

  @JsonKey(name: 'end_time')
  int endTime;

  @JsonKey(name: 'created_time')
  String createdTime;

  @JsonKey(name: 'updated_time')
  String updatedTime;

  @JsonKey(name: 'time_span_value')
  int timeSpanValue;

  @JsonKey(name: 'time_span_unit')
  String timeSpanUnit;

  @JsonKey(name: 'is_hidden')
  int isHidden;

  @JsonKey(name: 'is_auto_popup')
  int isAutoPopup;

  @JsonKey(name: 'is_show_step')
  int isShowStep;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'is_delete')
  int isDelete;

  @JsonKey(name: 'task_type')
  int taskType;

  @JsonKey(name: 'order_num')
  int orderNum;

  @JsonKey(name: 'time_type')
  int timeType;

  @JsonKey(name: 'show_time')
  String showTime;

  @JsonKey(name: 'complete_type')
  int completeType;

  @JsonKey(name: 'action_awards')
  List<Action_awards> actionAwards;

  @JsonKey(name: 'finish_awards')
  List<Finish_awards> finishAwards;

  Task(
    this.id,
    this.sortId,
    this.name,
    this.startTime,
    this.endTime,
    this.createdTime,
    this.updatedTime,
    this.timeSpanValue,
    this.timeSpanUnit,
    this.isHidden,
    this.isAutoPopup,
    this.isShowStep,
    this.desc,
    this.isDelete,
    this.taskType,
    this.orderNum,
    this.timeType,
    this.showTime,
    this.completeType,
    this.actionAwards,
    this.finishAwards,
  );

  factory Task.fromJson(Map<String, dynamic> srcJson) =>
      _$TaskFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

@JsonSerializable()
class Finish_awards extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'task_id')
  int taskId;

  @JsonKey(name: 'trigger_type')
  int triggerType;

  @JsonKey(name: 'target_limit')
  String targetLimit;

  @JsonKey(name: 'min_value')
  int minValue;

  @JsonKey(name: 'max_value')
  int maxValue;

  @JsonKey(name: 'progress_add')
  int progressAdd;

  @JsonKey(name: 'order_num')
  int orderNum;

  @JsonKey(name: 'award_list')
  List<Award_list> awardList;

  @JsonKey(name: 'is_delete')
  int isDelete;

  @JsonKey(name: 'icon')
  Icon icon;

  @JsonKey(name: 'target_name')
  String targetName;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'limit_type')
  int limitType;

  @JsonKey(name: 'last_finish_time')
  int lastFinishTime;

  Finish_awards(
    this.id,
    this.type,
    this.taskId,
    this.triggerType,
    this.targetLimit,
    this.minValue,
    this.maxValue,
    this.progressAdd,
    this.orderNum,
    this.awardList,
    this.isDelete,
    this.icon,
    this.targetName,
    this.url,
    this.limitType,
    this.lastFinishTime,
  );

  factory Finish_awards.fromJson(Map<String, dynamic> srcJson) =>
      _$Finish_awardsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Finish_awardsToJson(this);
}

@JsonSerializable()
class Icon extends Object {
  @JsonKey(name: 'icon_1')
  String icon1;

  @JsonKey(name: 'icon_2')
  String icon2;

  @JsonKey(name: 'icon_3')
  String icon3;

  Icon(
    this.icon1,
    this.icon2,
    this.icon3,
  );

  factory Icon.fromJson(Map<String, dynamic> srcJson) =>
      _$IconFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IconToJson(this);
}
