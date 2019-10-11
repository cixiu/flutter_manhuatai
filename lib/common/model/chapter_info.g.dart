// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterInfo _$ChapterInfoFromJson(Map<String, dynamic> json) {
  return ChapterInfo(
      json['chapter_topic_id'] as int,
      json['comic_id'] as int,
      json['chapter_name'] as String,
      json['comic_name'] as String,
      json['cartoon_topic_newid'] as String);
}

Map<String, dynamic> _$ChapterInfoToJson(ChapterInfo instance) =>
    <String, dynamic>{
      'chapter_topic_id': instance.chapterTopicId,
      'comic_id': instance.comicId,
      'chapter_name': instance.chapterName,
      'comic_name': instance.comicName,
      'cartoon_topic_newid': instance.cartoonTopicNewid
    };
