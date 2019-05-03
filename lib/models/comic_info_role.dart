import 'package:json_annotation/json_annotation.dart';

part 'comic_info_role.g.dart';

@JsonSerializable()
class ComicInfoRole extends Object {
  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  ComicInfoRole(
    this.data,
    this.status,
    this.msg,
  );

  factory ComicInfoRole.fromJson(Map<String, dynamic> srcJson) =>
      _$ComicInfoRoleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ComicInfoRoleToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'class_urlid')
  String classUrlid;

  @JsonKey(name: 'createtime')
  String createtime;

  @JsonKey(name: 'mhid')
  int mhid;

  @JsonKey(name: 'mhname')
  String mhname;

  @JsonKey(name: 'sculpture')
  String sculpture;

  @JsonKey(name: 'typename')
  String typename;

  @JsonKey(name: 'role_img_url')
  String roleImgUrl;

  @JsonKey(name: 'ordernum')
  int ordernum;

  Data(
    this.id,
    this.userId,
    this.name,
    this.type,
    this.classUrlid,
    this.createtime,
    this.mhid,
    this.mhname,
    this.sculpture,
    this.typename,
    this.roleImgUrl,
    this.ordernum,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
