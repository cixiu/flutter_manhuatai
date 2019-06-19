import 'package:json_annotation/json_annotation.dart';

part 'get_satellite_res.g.dart';

@JsonSerializable()
class GetSatelliteRes extends Object {
  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'servicetime')
  int servicetime;

  GetSatelliteRes(
    this.status,
    this.msg,
    this.data,
    this.servicetime,
  );

  factory GetSatelliteRes.fromJson(Map<String, dynamic> srcJson) =>
      _$GetSatelliteResFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GetSatelliteResToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'Id')
  double id;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'Content')
  String content;

  @JsonKey(name: 'Images')
  String images;

  @JsonKey(name: 'CreateTime')
  int createTime;

  @JsonKey(name: 'UpdateTime')
  int updateTime;

  @JsonKey(name: 'SupportNum')
  double supportNum;

  @JsonKey(name: 'UserType')
  double userType;

  @JsonKey(name: 'IsTop')
  double isTop;

  @JsonKey(name: 'IsElite')
  double isElite;

  @JsonKey(name: 'NoticeType')
  double noticeType;

  @JsonKey(name: 'StarName')
  String starName;

  @JsonKey(name: 'StarId')
  double starId;

  @JsonKey(name: 'ReplyNum')
  int replyNum;

  @JsonKey(name: 'IsFocus')
  double isFocus;

  @JsonKey(name: 'UserIdentifier')
  double userIdentifier;

  @JsonKey(name: 'IsHot')
  double isHot;

  @JsonKey(name: 'IsSupport')
  double isSupport;

  @JsonKey(name: 'StarUserId')
  double starUserId;

  @JsonKey(name: 'StarImage')
  String starImage;

  @JsonKey(name: 'UserName')
  String userName;

  Data(
    this.id,
    this.title,
    this.content,
    this.images,
    this.createTime,
    this.updateTime,
    this.supportNum,
    this.userType,
    this.isTop,
    this.isElite,
    this.noticeType,
    this.starName,
    this.starId,
    this.replyNum,
    this.isFocus,
    this.userIdentifier,
    this.isHot,
    this.isSupport,
    this.starUserId,
    this.starImage,
    this.userName,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
