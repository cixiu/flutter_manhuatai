import 'package:json_annotation/json_annotation.dart';

part 'recommend_users.g.dart';

@JsonSerializable()
class RecommendUsers extends Object {
  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  RecommendUsers(
    this.data,
    this.status,
    this.msg,
  );

  factory RecommendUsers.fromJson(Map<String, dynamic> srcJson) =>
      _$RecommendUsersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendUsersToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'target_id')
  int targetId;

  @JsonKey(name: 'target_name')
  String targetName;

  @JsonKey(name: 'isfollow')
  int isfollow;

  @JsonKey(name: 'target_desc')
  String targetDesc;

  @JsonKey(name: 'ulevel')
  int ulevel;

  Data(
    this.targetId,
    this.targetName,
    this.isfollow,
    this.targetDesc,
    this.ulevel,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
