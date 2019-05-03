// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_info_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComicInfoRole _$ComicInfoRoleFromJson(Map<String, dynamic> json) {
  return ComicInfoRole(
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['status'] as int,
      json['msg'] as String);
}

Map<String, dynamic> _$ComicInfoRoleToJson(ComicInfoRole instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'msg': instance.msg
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['id'] as int,
      json['user_id'] as int,
      json['name'] as String,
      json['type'] as String,
      json['class_urlid'] as String,
      json['createtime'] as String,
      json['mhid'] as int,
      json['mhname'] as String,
      json['sculpture'] as String,
      json['typename'] as String,
      json['role_img_url'] as String,
      json['ordernum'] as int);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'type': instance.type,
      'class_urlid': instance.classUrlid,
      'createtime': instance.createtime,
      'mhid': instance.mhid,
      'mhname': instance.mhname,
      'sculpture': instance.sculpture,
      'typename': instance.typename,
      'role_img_url': instance.roleImgUrl,
      'ordernum': instance.ordernum
    };
