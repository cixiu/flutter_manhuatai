// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotSearch _$HotSearchFromJson(Map<String, dynamic> json) {
  return HotSearch(
      json['status'] as int,
      json['msg'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['servicetime'] as int);
}

Map<String, dynamic> _$HotSearchToJson(HotSearch instance) => <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'data': instance.data,
      'servicetime': instance.servicetime
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data((json['Id'] as num)?.toDouble(), json['Name'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) =>
    <String, dynamic>{'Id': instance.id, 'Name': instance.name};
