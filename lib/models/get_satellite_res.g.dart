// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_satellite_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSatelliteRes _$GetSatelliteResFromJson(Map<String, dynamic> json) {
  return GetSatelliteRes(
      json['status'] as int,
      json['msg'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['servicetime'] as int);
}

Map<String, dynamic> _$GetSatelliteResToJson(GetSatelliteRes instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'data': instance.data,
      'servicetime': instance.servicetime
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      (json['Id'] as num)?.toDouble(),
      json['Title'] as String,
      json['Content'] as String,
      json['Images'] as String,
      json['CreateTime'] as int,
      json['UpdateTime'] as int,
      (json['SupportNum'] as num)?.toDouble(),
      (json['UserType'] as num)?.toDouble(),
      (json['IsTop'] as num)?.toDouble(),
      (json['IsElite'] as num)?.toDouble(),
      (json['NoticeType'] as num)?.toDouble(),
      json['StarName'] as String,
      (json['StarId'] as num)?.toDouble(),
      json['ReplyNum'] as int,
      (json['IsFocus'] as num)?.toDouble(),
      (json['UserIdentifier'] as num)?.toDouble(),
      (json['IsHot'] as num)?.toDouble(),
      (json['IsSupport'] as num)?.toDouble(),
      (json['StarUserId'] as num)?.toDouble(),
      json['StarImage'] as String,
      json['UserName'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'Title': instance.title,
      'Content': instance.content,
      'Images': instance.images,
      'CreateTime': instance.createTime,
      'UpdateTime': instance.updateTime,
      'SupportNum': instance.supportNum,
      'UserType': instance.userType,
      'IsTop': instance.isTop,
      'IsElite': instance.isElite,
      'NoticeType': instance.noticeType,
      'StarName': instance.starName,
      'StarId': instance.starId,
      'ReplyNum': instance.replyNum,
      'IsFocus': instance.isFocus,
      'UserIdentifier': instance.userIdentifier,
      'IsHot': instance.isHot,
      'IsSupport': instance.isSupport,
      'StarUserId': instance.starUserId,
      'StarImage': instance.starImage,
      'UserName': instance.userName
    };
