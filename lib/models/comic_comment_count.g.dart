// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_comment_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComicCommentCount _$ComicCommentCountFromJson(Map<String, dynamic> json) {
  return ComicCommentCount(
    json['data'] as int,
    json['status'] as int,
    json['msg'] as String,
  );
}

Map<String, dynamic> _$ComicCommentCountToJson(ComicCommentCount instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'msg': instance.msg,
    };
