// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_hot_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicHotList _$TopicHotListFromJson(Map<String, dynamic> json) {
  return TopicHotList(
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    json['status'] as int,
    json['msg'] as String,
  );
}

Map<String, dynamic> _$TopicHotListToJson(TopicHotList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'msg': instance.msg,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : List_List.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'list': instance.list,
    };

List_List _$List_ListFromJson(Map<String, dynamic> json) {
  return List_List(
    json['id'] as int,
    json['name'] as String,
    json['status'] as int,
    json['created_time'] as int,
    json['updated_time'] as int,
    json['productline_ids'] as String,
    json['order_num'] as int,
    json['cover'] as String,
    json['type'] as int,
    json['desc'] as String,
    json['follow_count'] as int,
    json['satellite_num'] as int,
    json['view_count'] as int,
  );
}

Map<String, dynamic> _$List_ListToJson(List_List instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'created_time': instance.createdTime,
      'updated_time': instance.updatedTime,
      'productline_ids': instance.productlineIds,
      'order_num': instance.orderNum,
      'cover': instance.cover,
      'type': instance.type,
      'desc': instance.desc,
      'follow_count': instance.followCount,
      'satellite_num': instance.satelliteNum,
      'view_count': instance.viewCount,
    };
