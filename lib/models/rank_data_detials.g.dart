// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_data_detials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankDataDetials _$RankDataDetialsFromJson(Map<String, dynamic> json) {
  return RankDataDetials(
      json['status'] as int,
      json['msg'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$RankDataDetialsToJson(RankDataDetials instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'data': instance.data
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['count_day'] as int,
      json['comic_id'] as int,
      json['comic_name'] as String,
      json['comic_urlid'] as String,
      json['author_name'] as String,
      json['sort_typelist'] as String,
      json['lastchapter_id'] as String,
      json['lastchapter_urlid'] as String,
      json['lastchapter_title'] as String,
      json['last_chapter_id'] as String,
      json['last_chapter_newid'] as String,
      json['last_chapter_name'] as String,
      json['comic_feature'] as String,
      json['comic_shortdesc'] as String,
      (json['comic_score'] as num)?.toDouble(),
      json['count_num'] as String,
      json['rise_rank'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'count_day': instance.countDay,
      'comic_id': instance.comicId,
      'comic_name': instance.comicName,
      'comic_urlid': instance.comicUrlid,
      'author_name': instance.authorName,
      'sort_typelist': instance.sortTypelist,
      'lastchapter_id': instance.lastchapterId,
      'lastchapter_urlid': instance.lastchapterUrlid,
      'lastchapter_title': instance.lastchapterTitle,
      'last_chapter_id': instance.lastChapterId,
      'last_chapter_newid': instance.lastChapterNewid,
      'last_chapter_name': instance.lastChapterName,
      'comic_feature': instance.comicFeature,
      'comic_shortdesc': instance.comicShortdesc,
      'comic_score': instance.comicScore,
      'count_num': instance.countNum,
      'rise_rank': instance.riseRank
    };
