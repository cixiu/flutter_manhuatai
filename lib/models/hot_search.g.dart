// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotSearch _$HotSearchFromJson(Map<String, dynamic> json) {
  return HotSearch(json['comic_id'] as int, json['comic_name'] as String,
      json['last_chapter_name'] as String, json['comic_newid'] as String);
}

Map<String, dynamic> _$HotSearchToJson(HotSearch instance) => <String, dynamic>{
      'comic_id': instance.comicId,
      'comic_name': instance.comicName,
      'last_chapter_name': instance.lastChapterName,
      'comic_newid': instance.comicNewid
    };
