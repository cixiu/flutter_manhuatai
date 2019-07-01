import 'package:json_annotation/json_annotation.dart';

part 'user_role_info.g.dart';

@JsonSerializable()
class UserRoleInfo extends Object {
  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'message')
  String message;

  UserRoleInfo(
    this.data,
    this.status,
    this.message,
  );

  factory UserRoleInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$UserRoleInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserRoleInfoToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'role_id')
  int roleId;

  @JsonKey(name: 'role_name')
  String roleName;

  @JsonKey(name: 'role_img_url')
  String roleImgUrl;

  @JsonKey(name: 'role_desc')
  String roleDesc;

  Data(
    this.userId,
    this.roleId,
    this.roleName,
    this.roleImgUrl,
    this.roleDesc,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
