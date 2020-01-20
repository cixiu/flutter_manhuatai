// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelInfo _$LevelInfoFromJson(Map<String, dynamic> json) {
  return LevelInfo(
    json['id'] as int,
    json['start_level'] as int,
    json['end_level'] as int,
    json['limit_comment'] as int,
    json['limit_satellite'] as int,
    json['limit_friends'] as int,
    json['is_comment_picture'] as int,
    json['is_comment_check'] as int,
    json['is_apply_audit_officer'] as int,
    json['is_sensitive_keywords'] as int,
    json['is_sensitive_view'] as int,
    json['give_recommend_ticket'] as int,
    json['give_month_ticket'] as int,
    json['give_coin'] as int,
    json['status'] as int,
    json['created_time'] as int,
    json['updated_time'] as int,
  );
}

Map<String, dynamic> _$LevelInfoToJson(LevelInfo instance) => <String, dynamic>{
      'id': instance.id,
      'start_level': instance.startLevel,
      'end_level': instance.endLevel,
      'limit_comment': instance.limitComment,
      'limit_satellite': instance.limitSatellite,
      'limit_friends': instance.limitFriends,
      'is_comment_picture': instance.isCommentPicture,
      'is_comment_check': instance.isCommentCheck,
      'is_apply_audit_officer': instance.isApplyAuditOfficer,
      'is_sensitive_keywords': instance.isSensitiveKeywords,
      'is_sensitive_view': instance.isSensitiveView,
      'give_recommend_ticket': instance.giveRecommendTicket,
      'give_month_ticket': instance.giveMonthTicket,
      'give_coin': instance.giveCoin,
      'status': instance.status,
      'created_time': instance.createdTime,
      'updated_time': instance.updatedTime,
    };
