import 'package:json_annotation/json_annotation.dart';

part 'level_info.g.dart';

List<LevelInfo> getLevelInfoList(List<dynamic> list) {
  List<LevelInfo> result = [];
  list.forEach((item) {
    result.add(LevelInfo.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class LevelInfo extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'start_level')
  int startLevel;

  @JsonKey(name: 'end_level')
  int endLevel;

  @JsonKey(name: 'limit_comment')
  int limitComment;

  @JsonKey(name: 'limit_satellite')
  int limitSatellite;

  @JsonKey(name: 'limit_friends')
  int limitFriends;

  @JsonKey(name: 'is_comment_picture')
  int isCommentPicture;

  @JsonKey(name: 'is_comment_check')
  int isCommentCheck;

  @JsonKey(name: 'is_apply_audit_officer')
  int isApplyAuditOfficer;

  @JsonKey(name: 'is_sensitive_keywords')
  int isSensitiveKeywords;

  @JsonKey(name: 'is_sensitive_view')
  int isSensitiveView;

  @JsonKey(name: 'give_recommend_ticket')
  int giveRecommendTicket;

  @JsonKey(name: 'give_month_ticket')
  int giveMonthTicket;

  @JsonKey(name: 'give_coin')
  int giveCoin;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'created_time')
  int createdTime;

  @JsonKey(name: 'updated_time')
  int updatedTime;

  LevelInfo(
    this.id,
    this.startLevel,
    this.endLevel,
    this.limitComment,
    this.limitSatellite,
    this.limitFriends,
    this.isCommentPicture,
    this.isCommentCheck,
    this.isApplyAuditOfficer,
    this.isSensitiveKeywords,
    this.isSensitiveView,
    this.giveRecommendTicket,
    this.giveMonthTicket,
    this.giveCoin,
    this.status,
    this.createdTime,
    this.updatedTime,
  );

  factory LevelInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$LevelInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LevelInfoToJson(this);
}
