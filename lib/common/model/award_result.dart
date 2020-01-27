import 'package:json_annotation/json_annotation.dart';

part 'award_result.g.dart';

@JsonSerializable()
class AwardResult extends Object {
  @JsonKey(name: 'achievetime')
  int achievetime;

  @JsonKey(name: 'awardresult')
  List<Awardresult> awardresult;

  AwardResult(
    this.achievetime,
    this.awardresult,
  );

  factory AwardResult.fromJson(Map<String, dynamic> srcJson) =>
      _$AwardResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AwardResultToJson(this);
}

@JsonSerializable()
class Awardresult extends Object {
  @JsonKey(name: 'task_award_id')
  int taskAwardId;

  @JsonKey(name: 'target_type')
  int targetType;

  @JsonKey(name: 'ismultiple')
  int ismultiple;

  @JsonKey(name: 'times')
  int times;

  @JsonKey(name: 'number')
  int number;

  @JsonKey(name: 'extranumber')
  int extranumber;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'order_num')
  int orderNum;

  @JsonKey(name: 'target_unit')
  int targetUnit;

  Awardresult(
    this.taskAwardId,
    this.targetType,
    this.ismultiple,
    this.times,
    this.number,
    this.extranumber,
    this.name,
    this.icon,
    this.description,
    this.orderNum,
    this.targetUnit,
  );

  factory Awardresult.fromJson(Map<String, dynamic> srcJson) =>
      _$AwardresultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AwardresultToJson(this);
}
