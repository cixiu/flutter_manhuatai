// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortList _$SortListFromJson(Map<String, dynamic> json) {
  return SortList(
    json['page'] == null
        ? null
        : Page.fromJson(json['page'] as Map<String, dynamic>),
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SortListToJson(SortList instance) => <String, dynamic>{
      'page': instance.page,
      'data': instance.data,
    };

Page _$PageFromJson(Map<String, dynamic> json) {
  return Page(
    json['current_page'] as int,
    json['total_page'] as int,
    json['orderby'] as String,
    json['count'] as int,
    json['comic_sort'] as String,
    json['search_key'] as String,
    json['time'] as int,
  );
}

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'total_page': instance.totalPage,
      'orderby': instance.orderby,
      'count': instance.count,
      'comic_sort': instance.comicSort,
      'search_key': instance.searchKey,
      'time': instance.time,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['comic_id'] as int,
    json['comic_name'] as String,
    json['last_chapter_name'] as String,
    json['comic_type'] as String,
    json['comic_newid'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'comic_id': instance.comicId,
      'comic_name': instance.comicName,
      'last_chapter_name': instance.lastChapterName,
      'comic_type': instance.comicType,
      'comic_newid': instance.comicNewid,
    };
