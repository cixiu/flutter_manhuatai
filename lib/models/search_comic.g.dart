// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_comic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchComic _$SearchComicFromJson(Map<String, dynamic> json) {
  return SearchComic(
    json['status'] as int,
    json['msg'] as String,
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchComicToJson(SearchComic instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['total_view_num'] as int,
    json['cartoon_newid'] as String,
    json['comic_id'] as int,
    json['comic_name'] as String,
    json['comic_newid'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'total_view_num': instance.totalViewNum,
      'cartoon_newid': instance.cartoonNewid,
      'comic_id': instance.comicId,
      'comic_name': instance.comicName,
      'comic_newid': instance.comicNewid,
    };
