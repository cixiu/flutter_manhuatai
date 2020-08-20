// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateList _$UpdateListFromJson(Map<String, dynamic> json) {
  return UpdateList(
    json['tab_title'] as String,
    (json['update'] as List)
        ?.map((e) =>
            e == null ? null : Update.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['today'] as List)
        ?.map(
            (e) => e == null ? null : Today.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['servicetime'] as int,
  );
}

Map<String, dynamic> _$UpdateListToJson(UpdateList instance) =>
    <String, dynamic>{
      'tab_title': instance.tabTitle,
      'update': instance.update,
      'today': instance.today,
      'servicetime': instance.servicetime,
    };

Update _$UpdateFromJson(Map<String, dynamic> json) {
  return Update(
    json['comicUpdateDate'] as String,
    json['comicUpdateDate_new'] as String,
    (json['info'] as List)
        ?.map(
            (e) => e == null ? null : Info.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UpdateToJson(Update instance) => <String, dynamic>{
      'comicUpdateDate': instance.comicUpdateDate,
      'comicUpdateDate_new': instance.comicUpdateDateNew,
      'info': instance.info,
    };

Info _$InfoFromJson(Map<String, dynamic> json) {
  return Info(
    json['comic_id'] as int,
    json['comic_name'] as String,
    json['comic_chapter_name'] as String,
    json['update_time'] as String,
    json['author_name'] as String,
    (json['comic_type'] as List)?.map((e) => e as String)?.toList(),
    json['renqi'] as int,
    json['comic_feature'] as String,
    json['chapter_feature'] as String,
    json['feature_location'] as int,
    json['outter_color'] as String,
    json['inner_color'] as String,
    json['font_size'] as int,
    json['brush_size'] as int,
    json['feature_img'] as String,
    json['copyright_type'] as int,
    (json['score'] as num)?.toDouble(),
    json['comic_newid'] as String,
  );
}

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'comic_id': instance.comicId,
      'comic_name': instance.comicName,
      'comic_chapter_name': instance.comicChapterName,
      'update_time': instance.updateTime,
      'author_name': instance.authorName,
      'comic_type': instance.comicType,
      'renqi': instance.renqi,
      'comic_feature': instance.comicFeature,
      'chapter_feature': instance.chapterFeature,
      'feature_location': instance.featureLocation,
      'outter_color': instance.outterColor,
      'inner_color': instance.innerColor,
      'font_size': instance.fontSize,
      'brush_size': instance.brushSize,
      'feature_img': instance.featureImg,
      'copyright_type': instance.copyrightType,
      'score': instance.score,
      'comic_newid': instance.comicNewid,
    };

Today _$TodayFromJson(Map<String, dynamic> json) {
  return Today(
    json['comic_id'] as int,
    json['comic_name'] as String,
    json['comic_chapter_name'] as String,
    json['update_time'] as String,
    json['author_name'] as String,
    (json['comic_type'] as List)?.map((e) => e as String)?.toList(),
    json['yesterday_view_num'] as int,
    json['renqi'] as int,
    json['comic_feature'] as String,
    json['chapter_feature'] as String,
    json['feature_location'] as int,
    json['outter_color'] as String,
    json['inner_color'] as String,
    json['font_size'] as int,
    json['brush_size'] as int,
    json['feature_img'] as String,
    json['copyright_type'] as int,
    (json['score'] as num)?.toDouble(),
    json['comic_newid'] as String,
  );
}

Map<String, dynamic> _$TodayToJson(Today instance) => <String, dynamic>{
      'comic_id': instance.comicId,
      'comic_name': instance.comicName,
      'comic_chapter_name': instance.comicChapterName,
      'update_time': instance.updateTime,
      'author_name': instance.authorName,
      'comic_type': instance.comicType,
      'yesterday_view_num': instance.yesterdayViewNum,
      'renqi': instance.renqi,
      'comic_feature': instance.comicFeature,
      'chapter_feature': instance.chapterFeature,
      'feature_location': instance.featureLocation,
      'outter_color': instance.outterColor,
      'inner_color': instance.innerColor,
      'font_size': instance.fontSize,
      'brush_size': instance.brushSize,
      'feature_img': instance.featureImg,
      'copyright_type': instance.copyrightType,
      'score': instance.score,
      'comic_newid': instance.comicNewid,
    };
