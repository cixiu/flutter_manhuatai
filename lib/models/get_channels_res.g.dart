// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_channels_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetChannelsRes _$GetChannelsResFromJson(Map<String, dynamic> json) {
  return GetChannelsRes(
    json['status'] as int,
    json['msg'] as String,
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['servicetime'] as int,
  );
}

Map<String, dynamic> _$GetChannelsResToJson(GetChannelsRes instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'data': instance.data,
      'servicetime': instance.servicetime,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    (json['Id'] as num)?.toDouble(),
    json['Name'] as String,
    json['Intro'] as String,
    (json['FocusNum'] as num)?.toDouble(),
    (json['UserType'] as num)?.toDouble(),
    (json['SatelliteNum'] as num)?.toDouble(),
    (json['UserIdentifier'] as num)?.toDouble(),
    json['CreateTime'] as int,
    json['UpdateTime'] as int,
    (json['IsHot'] as num)?.toDouble(),
    (json['IsFocus'] as num)?.toDouble(),
    json['Image'] as String,
    json['RelateId'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Intro': instance.intro,
      'FocusNum': instance.focusNum,
      'UserType': instance.userType,
      'SatelliteNum': instance.satelliteNum,
      'UserIdentifier': instance.userIdentifier,
      'CreateTime': instance.createTime,
      'UpdateTime': instance.updateTime,
      'IsHot': instance.isHot,
      'IsFocus': instance.isFocus,
      'Image': instance.image,
      'RelateId': instance.relateId,
    };
