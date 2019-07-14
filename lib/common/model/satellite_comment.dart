import 'package:json_annotation/json_annotation.dart';

part 'satellite_comment.g.dart';

@JsonSerializable()
class SatelliteComment extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'fatherid')
  int fatherid;

  @JsonKey(name: 'images')
  String images;

  @JsonKey(name: 'ssid')
  int ssid;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'ip')
  String ip;

  @JsonKey(name: 'place')
  String place;

  @JsonKey(name: 'supportcount')
  int supportcount;

  @JsonKey(name: 'iselite')
  int iselite;

  @JsonKey(name: 'istop')
  int istop;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'revertcount')
  int revertcount;

  @JsonKey(name: 'useridentifier')
  int useridentifier;

  @JsonKey(name: 'appid')
  int appid;

  @JsonKey(name: 'createtime')
  int createtime;

  @JsonKey(name: 'updatetime')
  int updatetime;

  @JsonKey(name: 'ssidtype')
  int ssidtype;

  @JsonKey(name: 'relateid')
  String relateid;

  @JsonKey(name: 'contentlength')
  int contentlength;

  @JsonKey(name: 'iswater')
  int iswater;

  @JsonKey(name: 'haveimage')
  int haveimage;

  @JsonKey(name: 'device_tail')
  String deviceTail;

  @JsonKey(name: 'floor_num')
  int floorNum;

  @JsonKey(name: 'floor_desc')
  String floorDesc;

  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'uname')
  String uname;

  @JsonKey(name: 'isvip')
  int isvip;

  @JsonKey(name: 'ulevel')
  int ulevel;

  @JsonKey(name: 'view_keywords')
  int viewKeywords;

  SatelliteComment(
    this.id,
    this.content,
    this.fatherid,
    this.images,
    this.ssid,
    this.title,
    this.url,
    this.ip,
    this.place,
    this.supportcount,
    this.iselite,
    this.istop,
    this.status,
    this.revertcount,
    this.useridentifier,
    this.appid,
    this.createtime,
    this.updatetime,
    this.ssidtype,
    this.relateid,
    this.contentlength,
    this.iswater,
    this.haveimage,
    this.deviceTail,
    this.floorNum,
    this.floorDesc,
    this.uid,
    this.uname,
    this.isvip,
    this.ulevel,
    this.viewKeywords,
  );

  factory SatelliteComment.fromJson(Map<String, dynamic> srcJson) =>
      _$SatelliteCommentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SatelliteCommentToJson(this);
}
