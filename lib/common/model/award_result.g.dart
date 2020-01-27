// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'award_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AwardResult _$AwardResultFromJson(Map<String, dynamic> json) {
  return AwardResult(
    json['achievetime'] as int,
    (json['awardresult'] as List)
        ?.map((e) =>
            e == null ? null : Awardresult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AwardResultToJson(AwardResult instance) =>
    <String, dynamic>{
      'achievetime': instance.achievetime,
      'awardresult': instance.awardresult,
    };

Awardresult _$AwardresultFromJson(Map<String, dynamic> json) {
  return Awardresult(
    json['task_award_id'] as int,
    json['target_type'] as int,
    json['ismultiple'] as int,
    json['times'] as int,
    json['number'] as int,
    json['extranumber'] as int,
    json['name'] as String,
    json['icon'] as String,
    json['description'] as String,
    json['order_num'] as int,
    json['target_unit'] as int,
  );
}

Map<String, dynamic> _$AwardresultToJson(Awardresult instance) =>
    <String, dynamic>{
      'task_award_id': instance.taskAwardId,
      'target_type': instance.targetType,
      'ismultiple': instance.ismultiple,
      'times': instance.times,
      'number': instance.number,
      'extranumber': instance.extranumber,
      'name': instance.name,
      'icon': instance.icon,
      'description': instance.description,
      'order_num': instance.orderNum,
      'target_unit': instance.targetUnit,
    };
