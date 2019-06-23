import 'package:json_annotation/json_annotation.dart';

part 'comment_user.g.dart';

@JsonSerializable()
class CommentUser extends Object {
  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  CommentUser(
    this.data,
    this.status,
    this.msg,
  );

  factory CommentUser.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentUserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentUserToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'Uid')
  int uid;

  @JsonKey(name: 'Ulevel')
  int ulevel;

  @JsonKey(name: 'Uname')
  String uname;

  @JsonKey(name: 'IsVip')
  int isVip;

  @JsonKey(name: 'IdUrl')
  String idUrl;

  @JsonKey(name: 'IdName')
  String idName;

  @JsonKey(name: 'RoleId')
  int roleId;

  @JsonKey(name: 'ApplyInfo')
  String applyInfo;

  @JsonKey(name: 'view_keywords')
  int viewKeywords;

  Data(
    this.uid,
    this.ulevel,
    this.uname,
    this.isVip,
    this.idUrl,
    this.idName,
    this.roleId,
    this.applyInfo,
    this.viewKeywords,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
