// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'satellite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Satellite _$SatelliteFromJson(Map<String, dynamic> json) {
  return Satellite(
    json['id'] as int,
    json['appid'] as int,
    json['starid'] as int,
    json['title'] as String,
    json['content'] as String,
    json['usertype'] as int,
    json['noticetype'] as int,
    json['useridentifier'] as int,
    json['username'] as String,
    json['supportnum'] as int,
    json['istop'] as int,
    json['iselite'] as int,
    json['images'] as String,
    json['replynum'] as int,
    json['createtime'] as int,
    json['updatetime'] as int,
    json['status'] as int,
    json['ishot'] as int,
    json['contentlength'] as int,
    json['iswater'] as int,
    (json['starid_list'] as List)?.map((e) => e as int)?.toList(),
    json['productlineid_list'] as String,
    json['topic_list'],
    json['is_recommend'] as int,
    json['location'] as String,
    json['lng_lat'] as String,
    json['show_title'] as int,
    json['title_color'] as String,
    json['device_tail'] as String,
    json['view_count'] as int,
    (json['stars'] as List)
        ?.map(
            (e) => e == null ? null : Stars.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['topics'] as List,
    json['isfollow'] as int,
    json['share_url'] as String,
    json['ulevel'] as int,
    json['view_keywords'] as int,
    json['issupport'] as int,
  );
}

Map<String, dynamic> _$SatelliteToJson(Satellite instance) => <String, dynamic>{
      'id': instance.id,
      'appid': instance.appid,
      'starid': instance.starid,
      'title': instance.title,
      'content': instance.content,
      'usertype': instance.usertype,
      'noticetype': instance.noticetype,
      'useridentifier': instance.useridentifier,
      'username': instance.username,
      'supportnum': instance.supportnum,
      'istop': instance.istop,
      'iselite': instance.iselite,
      'images': instance.images,
      'replynum': instance.replynum,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime,
      'status': instance.status,
      'ishot': instance.ishot,
      'contentlength': instance.contentlength,
      'iswater': instance.iswater,
      'starid_list': instance.staridList,
      'productlineid_list': instance.productlineidList,
      'topic_list': instance.topicList,
      'is_recommend': instance.isRecommend,
      'location': instance.location,
      'lng_lat': instance.lngLat,
      'show_title': instance.showTitle,
      'title_color': instance.titleColor,
      'device_tail': instance.deviceTail,
      'view_count': instance.viewCount,
      'stars': instance.stars,
      'topics': instance.topics,
      'isfollow': instance.isfollow,
      'share_url': instance.shareUrl,
      'ulevel': instance.ulevel,
      'view_keywords': instance.viewKeywords,
      'issupport': instance.issupport,
    };

Stars _$StarsFromJson(Map<String, dynamic> json) {
  return Stars(
    json['id'] as int,
    json['name'] as String,
    json['image'] as String,
  );
}

Map<String, dynamic> _$StarsToJson(Stars instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };
