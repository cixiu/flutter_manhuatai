// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_role_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRoleInfo _$UserRoleInfoFromJson(Map<String, dynamic> json) {
  return UserRoleInfo(
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['status'] as int,
    json['message'] as String,
  );
}

Map<String, dynamic> _$UserRoleInfoToJson(UserRoleInfo instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['user_id'] as int,
    json['role_id'] as int,
    json['role_name'] as String,
    json['role_img_url'] as String,
    json['role_desc'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user_id': instance.userId,
      'role_id': instance.roleId,
      'role_name': instance.roleName,
      'role_img_url': instance.roleImgUrl,
      'role_desc': instance.roleDesc,
    };
