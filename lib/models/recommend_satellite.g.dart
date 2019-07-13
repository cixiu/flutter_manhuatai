// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_satellite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendSatellite _$RecommendSatelliteFromJson(Map<String, dynamic> json) {
  return RecommendSatellite(
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      json['status'] as int,
      json['msg'] as String);
}

Map<String, dynamic> _$RecommendSatelliteToJson(RecommendSatellite instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'msg': instance.msg
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['pager'] == null
          ? null
          : Pager.fromJson(json['pager'] as Map<String, dynamic>),
      (json['list'] as List)
          ?.map((e) =>
              e == null ? null : Satellite.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DataToJson(Data instance) =>
    <String, dynamic>{'pager': instance.pager, 'list': instance.list};

Pager _$PagerFromJson(Map<String, dynamic> json) {
  return Pager(json['page'] as int, json['count'] as int);
}

Map<String, dynamic> _$PagerToJson(Pager instance) =>
    <String, dynamic>{'page': instance.page, 'count': instance.count};
