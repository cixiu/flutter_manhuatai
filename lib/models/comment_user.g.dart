// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentUser _$CommentUserFromJson(Map<String, dynamic> json) {
  return CommentUser(
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['status'] as int,
      json['msg'] as String);
}

Map<String, dynamic> _$CommentUserToJson(CommentUser instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'msg': instance.msg
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['Uid'] as int,
      json['Ulevel'] as int,
      json['Uname'] as String,
      json['IsVip'] as int,
      json['IdUrl'] as String,
      json['IdName'] as String,
      json['RoleId'] as int,
      json['ApplyInfo'] as String,
      json['view_keywords'] as int);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Uid': instance.uid,
      'Ulevel': instance.ulevel,
      'Uname': instance.uname,
      'IsVip': instance.isVip,
      'IdUrl': instance.idUrl,
      'IdName': instance.idName,
      'RoleId': instance.roleId,
      'ApplyInfo': instance.applyInfo,
      'view_keywords': instance.viewKeywords
    };
