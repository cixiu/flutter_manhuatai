// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_book_info_by_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookInfoById _$GetBookInfoByIdFromJson(Map<String, dynamic> json) {
  return GetBookInfoById(
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    json['status'] as int,
    json['message'] as String,
  );
}

Map<String, dynamic> _$GetBookInfoByIdToJson(GetBookInfoById instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['book_id'] as int,
    json['book_name'] as String,
    json['summary'] as String,
    json['shoucang'] as int,
    json['share'] as int,
    json['createtime'] as String,
    json['updatetime'] as String,
    json['user_id'] as int,
    json['img_url'] as String,
    json['share_title'] as String,
    json['share_summary'] as String,
    (json['book_list'] as List)
        ?.map((e) =>
            e == null ? null : Book_list.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'book_id': instance.bookId,
      'book_name': instance.bookName,
      'summary': instance.summary,
      'shoucang': instance.shoucang,
      'share': instance.share,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime,
      'user_id': instance.userId,
      'img_url': instance.imgUrl,
      'share_title': instance.shareTitle,
      'share_summary': instance.shareSummary,
      'book_list': instance.bookList,
    };

Book_list _$Book_listFromJson(Map<String, dynamic> json) {
  return Book_list(
    json['id'] as int,
    json['comic_name'] as String,
    json['product_id'] as int,
    json['comic_feature'] as String,
    json['load_type'] as int,
    json['img_url'] as String,
    json['nofollow'] as int,
    json['sort_num'] as int,
    json['url'] as String,
    json['comic_id'] as int,
    json['page_id'] as int,
    json['isdisable'] as int,
    (json['comic_type'] as List)?.map((e) => e as String)?.toList(),
    json['cartoon_name'] as String,
    json['new_cartoon_id'] as String,
    json['new_cartoon_name'] as String,
    json['author_name'] as String,
    json['total_view_num'] as String,
    json['comic_newid'] as String,
    json['latest_cartoon_topic_id'] as String,
    json['cartoon_desc'] as String,
    json['cartoon_topic_name'] as String,
    json['chapter_feature'] as String,
    json['font_color'] as String,
    json['font_size'] as int,
    json['border_color'] as String,
    json['border_size'] as int,
    json['feature_position'] as int,
    json['chapter_image_addr'] as String,
    json['cartoon_status'] as int,
    json['update_time'] as String,
  );
}

Map<String, dynamic> _$Book_listToJson(Book_list instance) => <String, dynamic>{
      'id': instance.id,
      'comic_name': instance.comicName,
      'product_id': instance.productId,
      'comic_feature': instance.comicFeature,
      'load_type': instance.loadType,
      'img_url': instance.imgUrl,
      'nofollow': instance.nofollow,
      'sort_num': instance.sortNum,
      'url': instance.url,
      'comic_id': instance.comicId,
      'page_id': instance.pageId,
      'isdisable': instance.isdisable,
      'comic_type': instance.comicType,
      'cartoon_name': instance.cartoonName,
      'new_cartoon_id': instance.newCartoonId,
      'new_cartoon_name': instance.newCartoonName,
      'author_name': instance.authorName,
      'total_view_num': instance.totalViewNum,
      'comic_newid': instance.comicNewid,
      'latest_cartoon_topic_id': instance.latestCartoonTopicId,
      'cartoon_desc': instance.cartoonDesc,
      'cartoon_topic_name': instance.cartoonTopicName,
      'chapter_feature': instance.chapterFeature,
      'font_color': instance.fontColor,
      'font_size': instance.fontSize,
      'border_color': instance.borderColor,
      'border_size': instance.borderSize,
      'feature_position': instance.featurePosition,
      'chapter_image_addr': instance.chapterImageAddr,
      'cartoon_status': instance.cartoonStatus,
      'update_time': instance.updateTime,
    };
