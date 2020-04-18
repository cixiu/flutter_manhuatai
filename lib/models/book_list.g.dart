// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookList _$BookListFromJson(Map<String, dynamic> json) {
  return BookList(
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    json['status'] as int,
    json['message'] as String,
  );
}

Map<String, dynamic> _$BookListToJson(BookList instance) => <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    (json['book'] as List)
        ?.map(
            (e) => e == null ? null : Book.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['name'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'book': instance.book,
      'name': instance.name,
    };

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
    json['book_id'] as int,
    json['siteid'] as int,
    json['union_type'] as int,
    json['union_id'] as int,
    json['istop'] as int,
    json['top_num'] as int,
    json['ordernum'] as int,
    json['version_filter'] as int,
    json['version_num'] as String,
    json['title'] as String,
    json['config'] == null
        ? null
        : Config.fromJson(json['config'] as Map<String, dynamic>),
    json['bookcomic_order'] as int,
    json['bookcomic_imgstyle'] as int,
    json['advertise_location'] as String,
    json['advertise_sdktype'] as String,
    json['book_datasource'] as String,
    json['book_intellrecommend'] as String,
    (json['comic_info'] as List)
        ?.map((e) =>
            e == null ? null : Comic_info.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'book_id': instance.bookId,
      'siteid': instance.siteid,
      'union_type': instance.unionType,
      'union_id': instance.unionId,
      'istop': instance.istop,
      'top_num': instance.topNum,
      'ordernum': instance.ordernum,
      'version_filter': instance.versionFilter,
      'version_num': instance.versionNum,
      'title': instance.title,
      'config': instance.config,
      'bookcomic_order': instance.bookcomicOrder,
      'bookcomic_imgstyle': instance.bookcomicImgstyle,
      'advertise_location': instance.advertiseLocation,
      'advertise_sdktype': instance.advertiseSdktype,
      'book_datasource': instance.bookDatasource,
      'book_intellrecommend': instance.bookIntellrecommend,
      'comic_info': instance.comicInfo,
    };

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return Config(
    json['display_type'] as int,
    json['isautoslide'] as int,
    json['isshowtitle'] as int,
    json['horizonratio'] as String,
    json['interwidth'] as dynamic,
    json['outerwidth'] as dynamic,
    json['order_type'] as int,
    json['isshowchange'] as int,
    json['isshowdetail'] as dynamic,
    json['isshowmore'] as int,
  );
}

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'display_type': instance.displayType,
      'isautoslide': instance.isautoslide,
      'isshowtitle': instance.isshowtitle,
      'horizonratio': instance.horizonratio,
      'interwidth': instance.interwidth,
      'outerwidth': instance.outerwidth,
      'order_type': instance.orderType,
      'isshowchange': instance.isshowchange,
      'isshowdetail': instance.isshowdetail,
      'isshowmore': instance.isshowmore,
    };

Comic_info _$Comic_infoFromJson(Map<String, dynamic> json) {
  return Comic_info(
    json['comic_id'] as int,
    json['content'] as String,
    json['comic_name'] as String,
    json['total_view_num'],
    json['update_time'],
    json['score'],
    json['url'] as String,
    json['img_url'] as String,
    json['last_comic_chapter_name'] as String,
    json['ordernum'] as int,
    (json['comic_type'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$Comic_infoToJson(Comic_info instance) =>
    <String, dynamic>{
      'comic_id': instance.comicId,
      'content': instance.content,
      'comic_name': instance.comicName,
      'total_view_num': instance.totalViewNum,
      'update_time': instance.updateTime,
      'score': instance.score,
      'url': instance.url,
      'img_url': instance.imgUrl,
      'last_comic_chapter_name': instance.lastComicChapterName,
      'ordernum': instance.ordernum,
      'comic_type': instance.comicType,
    };
