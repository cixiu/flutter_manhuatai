// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'satellite_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SatelliteComment _$SatelliteCommentFromJson(Map<String, dynamic> json) {
  return SatelliteComment(
    json['id'] as int,
    json['content'] as String,
    json['fatherid'] as int,
    json['images'] as String,
    json['ssid'] as int,
    json['title'] as String,
    json['url'] as String,
    json['ip'] as String,
    json['place'] as String,
    json['supportcount'] as int,
    json['iselite'] as int,
    json['istop'] as int,
    json['status'] as int,
    json['revertcount'] as int,
    json['useridentifier'] as int,
    json['appid'] as int,
    json['createtime'] as int,
    json['updatetime'] as int,
    json['ssidtype'] as int,
    json['relateid'] as String,
    json['contentlength'] as int,
    json['iswater'] as int,
    json['haveimage'] as int,
    json['device_tail'] as String,
    json['floor_num'] as int,
    json['floor_desc'] as String,
    json['uid'] as int,
    json['uname'] as String,
    json['isvip'] as int,
    json['ulevel'] as int,
    json['view_keywords'] as int,
  );
}

Map<String, dynamic> _$SatelliteCommentToJson(SatelliteComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'fatherid': instance.fatherid,
      'images': instance.images,
      'ssid': instance.ssid,
      'title': instance.title,
      'url': instance.url,
      'ip': instance.ip,
      'place': instance.place,
      'supportcount': instance.supportcount,
      'iselite': instance.iselite,
      'istop': instance.istop,
      'status': instance.status,
      'revertcount': instance.revertcount,
      'useridentifier': instance.useridentifier,
      'appid': instance.appid,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime,
      'ssidtype': instance.ssidtype,
      'relateid': instance.relateid,
      'contentlength': instance.contentlength,
      'iswater': instance.iswater,
      'haveimage': instance.haveimage,
      'device_tail': instance.deviceTail,
      'floor_num': instance.floorNum,
      'floor_desc': instance.floorDesc,
      'uid': instance.uid,
      'uname': instance.uname,
      'isvip': instance.isvip,
      'ulevel': instance.ulevel,
      'view_keywords': instance.viewKeywords,
    };
