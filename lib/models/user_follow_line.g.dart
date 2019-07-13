// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_follow_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFollowLine _$UserFollowLineFromJson(Map<String, dynamic> json) {
  return UserFollowLine(
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['status'] as int,
      json['msg'] as String);
}

Map<String, dynamic> _$UserFollowLineToJson(UserFollowLine instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'msg': instance.msg
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['user_id'] as int,
      json['create_time'] as int,
      json['type'] as int,
      json['target_id'] as int,
      json['source_id'] as int,
      json['status'] as int,
      json['target_user_id'] as int,
      json['satellite'] == null
          ? null
          : Satellite.fromJson(json['satellite'] as Map<String, dynamic>));
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user_id': instance.userId,
      'create_time': instance.createTime,
      'type': instance.type,
      'target_id': instance.targetId,
      'source_id': instance.sourceId,
      'status': instance.status,
      'target_user_id': instance.targetUserId,
      'satellite': instance.satellite
    };
