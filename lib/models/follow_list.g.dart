// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowList _$FollowListFromJson(Map<String, dynamic> json) {
  return FollowList(
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['status'] as int,
      json['msg'] as String);
}

Map<String, dynamic> _$FollowListToJson(FollowList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'msg': instance.msg
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['Lid'] as int,
      json['LUid'] as int,
      json['Ltarget'] as int,
      json['Lcontent'] as String,
      json['Ltime'] as String,
      json['Laction'] as int,
      json['Lstatus'] as int,
      json['Ltid'] as int,
      json['Lnumber'] as int,
      json['Lnumber2'] as int,
      json['Usex'] as int,
      json['Uid'] as int,
      json['Uname'] as String,
      json['status'] as int,
      json['Ulevel'] as int,
      json['isvip'] as int,
      json['Usign'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Lid': instance.lid,
      'LUid': instance.lUid,
      'Ltarget': instance.ltarget,
      'Lcontent': instance.lcontent,
      'Ltime': instance.ltime,
      'Laction': instance.laction,
      'Lstatus': instance.lstatus,
      'Ltid': instance.ltid,
      'Lnumber': instance.lnumber,
      'Lnumber2': instance.lnumber2,
      'Usex': instance.usex,
      'Uid': instance.uid,
      'Uname': instance.uname,
      'status': instance.status,
      'Ulevel': instance.ulevel,
      'isvip': instance.isvip,
      'Usign': instance.usign
    };
