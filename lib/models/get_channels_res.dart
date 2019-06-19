import 'package:json_annotation/json_annotation.dart';

part 'get_channels_res.g.dart';

@JsonSerializable()
class GetChannelsRes extends Object {
  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'servicetime')
  int servicetime;

  GetChannelsRes(
    this.status,
    this.msg,
    this.data,
    this.servicetime,
  );

  factory GetChannelsRes.fromJson(Map<String, dynamic> srcJson) =>
      _$GetChannelsResFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GetChannelsResToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'Id')
  double id;

  @JsonKey(name: 'Name')
  String name;

  @JsonKey(name: 'Intro')
  String intro;

  @JsonKey(name: 'FocusNum')
  double focusNum;

  @JsonKey(name: 'UserType')
  double userType;

  @JsonKey(name: 'SatelliteNum')
  double satelliteNum;

  @JsonKey(name: 'UserIdentifier')
  double userIdentifier;

  @JsonKey(name: 'CreateTime')
  int createTime;

  @JsonKey(name: 'UpdateTime')
  int updateTime;

  @JsonKey(name: 'IsHot')
  double isHot;

  @JsonKey(name: 'IsFocus')
  double isFocus;

  @JsonKey(name: 'Image')
  String image;

  @JsonKey(name: 'RelateId')
  String relateId;

  Data(
    this.id,
    this.name,
    this.intro,
    this.focusNum,
    this.userType,
    this.satelliteNum,
    this.userIdentifier,
    this.createTime,
    this.updateTime,
    this.isHot,
    this.isFocus,
    this.image,
    this.relateId,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
