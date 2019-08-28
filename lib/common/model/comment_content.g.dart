// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentContent _$CommentContentFromJson(Map<String, dynamic> json) {
  return CommentContent(
      (json['id'] as num)?.toDouble(),
      json['content'] as String,
      (json['fatherid'] as num)?.toDouble(),
      json['images'] as String,
      (json['ssid'] as num)?.toDouble(),
      json['title'] as String,
      json['url'] as String,
      (json['supportcount'] as num)?.toDouble(),
      json['iselite'] as int,
      json['istop'] as int,
      (json['revertcount'] as num)?.toDouble(),
      (json['useridentifier'] as num)?.toDouble(),
      json['createtime'] as int,
      json['updatetime'] as int,
      json['ssidtype'] as int,
      json['issupport'] as int,
      json['RelateId'] as String);
}

Map<String, dynamic> _$CommentContentToJson(CommentContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'fatherid': instance.fatherid,
      'images': instance.images,
      'ssid': instance.ssid,
      'title': instance.title,
      'url': instance.url,
      'supportcount': instance.supportcount,
      'iselite': instance.iselite,
      'istop': instance.istop,
      'revertcount': instance.revertcount,
      'useridentifier': instance.useridentifier,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime,
      'ssidtype': instance.ssidtype,
      'issupport': instance.issupport,
      'RelateId': instance.relateId
    };
