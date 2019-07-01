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
              e == null ? null : List_List.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DataToJson(Data instance) =>
    <String, dynamic>{'pager': instance.pager, 'list': instance.list};

Pager _$PagerFromJson(Map<String, dynamic> json) {
  return Pager(json['page'] as int, json['count'] as int);
}

Map<String, dynamic> _$PagerToJson(Pager instance) =>
    <String, dynamic>{'page': instance.page, 'count': instance.count};

List_List _$List_ListFromJson(Map<String, dynamic> json) {
  return List_List(
      json['iselite'] as int,
      (json['starid_list'] as List)?.map((e) => e as int)?.toList(),
      json['iswater'] as int,
      json['title'] as String,
      json['content'] as String,
      json['device_tail'] as String,
      json['istop'] as int,
      json['id'] as int,
      json['useridentifier'] as int,
      json['ishot'] as int,
      json['starid'] as int,
      json['images'] as String,
      json['createtime'] as int,
      json['title_nod'] as String,
      json['title_color'] as String,
      json['usertype'] as int,
      json['lng_lat'] as String,
      json['topic_list'],
      json['productlineid_list'] as String,
      json['circle_order'] as int,
      json['noticetype'] as int,
      json['show_title'] as int,
      json['appid'] as int,
      json['images_length'] as int,
      json['is_recommend'] as int,
      json['replynum'] as int,
      json['location'] as String,
      json['updatetime'] as int,
      json['title_single'] as String,
      json['view_count'] as int,
      json['username'] as String,
      json['supportnum'] as int,
      json['status'] as int,
      json['contentlength'] as int,
      json['label'] as String,
      (json['stars'] as List)
          ?.map((e) =>
              e == null ? null : Stars.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['topics'] as List,
      json['isfollow'] as int,
      json['isvip'] as int,
      json['view_keywords'] as int,
      json['ulevel'] as int,
      json['issupport'] as int,
      json['satellite_label'] as String,
      json['share_url'] as String);
}

Map<String, dynamic> _$List_ListToJson(List_List instance) => <String, dynamic>{
      'iselite': instance.iselite,
      'starid_list': instance.staridList,
      'iswater': instance.iswater,
      'title': instance.title,
      'content': instance.content,
      'device_tail': instance.deviceTail,
      'istop': instance.istop,
      'id': instance.id,
      'useridentifier': instance.useridentifier,
      'ishot': instance.ishot,
      'starid': instance.starid,
      'images': instance.images,
      'createtime': instance.createtime,
      'title_nod': instance.titleNod,
      'title_color': instance.titleColor,
      'usertype': instance.usertype,
      'lng_lat': instance.lngLat,
      'topic_list': instance.topicList,
      'productlineid_list': instance.productlineidList,
      'circle_order': instance.circleOrder,
      'noticetype': instance.noticetype,
      'show_title': instance.showTitle,
      'appid': instance.appid,
      'images_length': instance.imagesLength,
      'is_recommend': instance.isRecommend,
      'replynum': instance.replynum,
      'location': instance.location,
      'updatetime': instance.updatetime,
      'title_single': instance.titleSingle,
      'view_count': instance.viewCount,
      'username': instance.username,
      'supportnum': instance.supportnum,
      'status': instance.status,
      'contentlength': instance.contentlength,
      'label': instance.label,
      'stars': instance.stars,
      'topics': instance.topics,
      'isfollow': instance.isfollow,
      'isvip': instance.isvip,
      'view_keywords': instance.viewKeywords,
      'ulevel': instance.ulevel,
      'issupport': instance.issupport,
      'satellite_label': instance.satelliteLabel,
      'share_url': instance.shareUrl
    };

Stars _$StarsFromJson(Map<String, dynamic> json) {
  return Stars(
      json['id'] as int, json['name'] as String, json['image'] as String);
}

Map<String, dynamic> _$StarsToJson(Stars instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image
    };
