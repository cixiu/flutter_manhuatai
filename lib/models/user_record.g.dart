// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRecord _$UserRecordFromJson(Map<String, dynamic> json) {
  return UserRecord(
    (json['user_read'] as List)
        ?.map((e) =>
            e == null ? null : User_read.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['collectnum'] as int,
    (json['user_collect'] as List)
        ?.map((e) =>
            e == null ? null : User_collect.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['limit_collect'] as int,
  );
}

Map<String, dynamic> _$UserRecordToJson(UserRecord instance) =>
    <String, dynamic>{
      'user_read': instance.userRead,
      'collectnum': instance.collectnum,
      'user_collect': instance.userCollect,
      'limit_collect': instance.limitCollect,
    };

User_read _$User_readFromJson(Map<String, dynamic> json) {
  return User_read(
    json['comic_id'] as int,
    json['comic_newid'] as String,
    json['comic_name'] as String,
    json['chapter_page'] as int,
    json['chapter_name'] as String,
    json['chapter_newid'] as String,
    json['read_time'] as int,
    json['last_chapter_name'] as String,
    json['update_time'] as int,
    json['copyright_type'] as int,
    json['chapter_id'] as int,
    json['last_chapter_newid'] as String,
  );
}

Map<String, dynamic> _$User_readToJson(User_read instance) => <String, dynamic>{
      'comic_id': instance.comicId,
      'comic_newid': instance.comicNewid,
      'comic_name': instance.comicName,
      'chapter_page': instance.chapterPage,
      'chapter_name': instance.chapterName,
      'chapter_newid': instance.chapterNewid,
      'read_time': instance.readTime,
      'last_chapter_name': instance.lastChapterName,
      'update_time': instance.updateTime,
      'copyright_type': instance.copyrightType,
      'chapter_id': instance.chapterId,
      'last_chapter_newid': instance.lastChapterNewid,
    };

User_collect _$User_collectFromJson(Map<String, dynamic> json) {
  return User_collect(
    json['disable'] as bool,
    json['comic_id'] as int,
    json['comic_newid'] as String,
    json['comic_name'] as String,
    json['read_time'] as int,
    json['update_time'] as int,
    json['last_chapter_name'] as String,
    json['copyright_type'] as int,
    json['status'] as int,
    json['show_type'] as int,
    json['last_chapter_newid'] as String,
  );
}

Map<String, dynamic> _$User_collectToJson(User_collect instance) =>
    <String, dynamic>{
      'disable': instance.disable,
      'comic_id': instance.comicId,
      'comic_newid': instance.comicNewid,
      'comic_name': instance.comicName,
      'read_time': instance.readTime,
      'update_time': instance.updateTime,
      'last_chapter_name': instance.lastChapterName,
      'copyright_type': instance.copyrightType,
      'status': instance.status,
      'show_type': instance.showType,
      'last_chapter_newid': instance.lastChapterNewid,
    };
