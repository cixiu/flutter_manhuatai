import 'package:json_annotation/json_annotation.dart';

part 'follow_list.g.dart';

@JsonSerializable()
class FollowList extends Object {
  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  FollowList(
    this.data,
    this.status,
    this.msg,
  );

  factory FollowList.fromJson(Map<String, dynamic> srcJson) =>
      _$FollowListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FollowListToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'Lid')
  int lid;

  @JsonKey(name: 'LUid')
  int lUid;

  @JsonKey(name: 'Ltarget')
  int ltarget;

  @JsonKey(name: 'Lcontent')
  String lcontent;

  @JsonKey(name: 'Ltime')
  String ltime;

  @JsonKey(name: 'Laction')
  int laction;

  @JsonKey(name: 'Lstatus')
  int lstatus;

  @JsonKey(name: 'Ltid')
  int ltid;

  @JsonKey(name: 'Lnumber')
  int lnumber;

  @JsonKey(name: 'Lnumber2')
  int lnumber2;

  @JsonKey(name: 'Usex')
  int usex;

  @JsonKey(name: 'Uid')
  int uid;

  @JsonKey(name: 'Uname')
  String uname;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'Ulevel')
  int ulevel;

  @JsonKey(name: 'isvip')
  int isvip;

  @JsonKey(name: 'Usign')
  String usign;

  Data(
    this.lid,
    this.lUid,
    this.ltarget,
    this.lcontent,
    this.ltime,
    this.laction,
    this.lstatus,
    this.ltid,
    this.lnumber,
    this.lnumber2,
    this.usex,
    this.uid,
    this.uname,
    this.status,
    this.ulevel,
    this.isvip,
    this.usign,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
