// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendUsers _$RecommendUsersFromJson(Map<String, dynamic> json) {
  return RecommendUsers(
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['status'] as int,
      json['msg'] as String);
}

Map<String, dynamic> _$RecommendUsersToJson(RecommendUsers instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'msg': instance.msg
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['target_id'] as int,
      json['target_name'] as String,
      json['isfollow'] as int,
      json['target_desc'] as String,
      json['ulevel'] as int);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'target_id': instance.targetId,
      'target_name': instance.targetName,
      'isfollow': instance.isfollow,
      'target_desc': instance.targetDesc,
      'ulevel': instance.ulevel
    };
