// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_info_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComicInfoBody _$ComicInfoBodyFromJson(Map<String, dynamic> json) {
  return ComicInfoBody(
      json['servicetime'] as int,
      json['comic_name'] as String,
      json['comic_type'] == null
          ? null
          : Comic_type.fromJson(json['comic_type'] as Map<String, dynamic>),
      (json['comic_type_new'] as List)
          ?.map((e) => e == null
              ? null
              : Comic_type_new.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['update_status_str'] as String,
      json['seo_title'] as String,
      json['seo_keywords'] as String,
      json['seo_description'] as String,
      json['comic_status'] as int,
      json['comic_author'] as String,
      json['comic_desc'] as String,
      json['comic_notice'] as String,
      json['comic_copyright'] as String,
      json['last_chapter_id'] as String,
      json['last_chapter_name'] as String,
      json['copyright_type'] as int,
      json['readtype'] as int,
      json['human_type'] as int,
      json['copyright_type_cn'] as String,
      json['background_color'] as String,
      json['comic_share_url'] as String,
      json['update_time'] as int,
      json['cover_charge_status'] as String,
      json['comic_media'] as String,
      json['site_status'] as String,
      json['shoucang'] as int,
      json['renqi'] as int,
      (json['comic_chapter'] as List)
          ?.map((e) => e == null
              ? null
              : Comic_chapter.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['allprice'] as int,
      json['charge_status'] as String,
      json['charge_paid'] as int,
      json['charge_coin_free'] as int,
      json['charge_share_free'] as int,
      json['charge_advertise_free'] as int,
      json['charge_truetime_free'] as int,
      json['charge_limittime_free'] as int,
      json['charge_limitline_free'] as int,
      json['charge_vip_free'] as int,
      json['charge_spread_free'] as int,
      json['charge_game_free'] as int,
      json['charge_coupons_free'] as int,
      json['charge_lottery_free'] as int,
      json['charge_limittime_paid'] as int,
      json['charge_limitline_paid'] as int,
      json['charge_others_paid'] as int,
      json['charge_credit_paid'] as int,
      json['charge_free_turn'] as int,
      json['isshowdata'] as int,
      (json['cover_list'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$ComicInfoBodyToJson(ComicInfoBody instance) =>
    <String, dynamic>{
      'servicetime': instance.servicetime,
      'comic_name': instance.comicName,
      'comic_type': instance.comicType,
      'comic_type_new': instance.comicTypeNew,
      'update_status_str': instance.updateStatusStr,
      'seo_title': instance.seoTitle,
      'seo_keywords': instance.seoKeywords,
      'seo_description': instance.seoDescription,
      'comic_status': instance.comicStatus,
      'comic_author': instance.comicAuthor,
      'comic_desc': instance.comicDesc,
      'comic_notice': instance.comicNotice,
      'comic_copyright': instance.comicCopyright,
      'last_chapter_id': instance.lastChapterId,
      'last_chapter_name': instance.lastChapterName,
      'copyright_type': instance.copyrightType,
      'readtype': instance.readtype,
      'human_type': instance.humanType,
      'copyright_type_cn': instance.copyrightTypeCn,
      'background_color': instance.backgroundColor,
      'comic_share_url': instance.comicShareUrl,
      'update_time': instance.updateTime,
      'cover_charge_status': instance.coverChargeStatus,
      'comic_media': instance.comicMedia,
      'site_status': instance.siteStatus,
      'shoucang': instance.shoucang,
      'renqi': instance.renqi,
      'comic_chapter': instance.comicChapter,
      'allprice': instance.allprice,
      'charge_status': instance.chargeStatus,
      'charge_paid': instance.chargePaid,
      'charge_coin_free': instance.chargeCoinFree,
      'charge_share_free': instance.chargeShareFree,
      'charge_advertise_free': instance.chargeAdvertiseFree,
      'charge_truetime_free': instance.chargeTruetimeFree,
      'charge_limittime_free': instance.chargeLimittimeFree,
      'charge_limitline_free': instance.chargeLimitlineFree,
      'charge_vip_free': instance.chargeVipFree,
      'charge_spread_free': instance.chargeSpreadFree,
      'charge_game_free': instance.chargeGameFree,
      'charge_coupons_free': instance.chargeCouponsFree,
      'charge_lottery_free': instance.chargeLotteryFree,
      'charge_limittime_paid': instance.chargeLimittimePaid,
      'charge_limitline_paid': instance.chargeLimitlinePaid,
      'charge_others_paid': instance.chargeOthersPaid,
      'charge_credit_paid': instance.chargeCreditPaid,
      'charge_free_turn': instance.chargeFreeTurn,
      'isshowdata': instance.isshowdata,
      'cover_list': instance.coverList
    };

Comic_type _$Comic_typeFromJson(Map<String, dynamic> json) {
  return Comic_type(json['rexue'] as String, json['shenmo'] as String,
      json['jingji'] as String, json['jingpin'] as String);
}

Map<String, dynamic> _$Comic_typeToJson(Comic_type instance) =>
    <String, dynamic>{
      'rexue': instance.rexue,
      'shenmo': instance.shenmo,
      'jingji': instance.jingji,
      'jingpin': instance.jingpin
    };

Comic_type_new _$Comic_type_newFromJson(Map<String, dynamic> json) {
  return Comic_type_new(
      json['id'] as int, json['name'] as String, json['urlid'] as String);
}

Map<String, dynamic> _$Comic_type_newToJson(Comic_type_new instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'urlid': instance.urlid
    };

Comic_chapter _$Comic_chapterFromJson(Map<String, dynamic> json) {
  return Comic_chapter(
      json['chapter_name'] as String,
      json['chapter_id'] as String,
      json['chapter_topic_id'] as int,
      json['create_date'] as int,
      json['islock'] as int,
      json['chapter_share_url'] as String,
      json['download_price'] as int,
      json['price'] as int,
      json['chapter_image'] == null
          ? null
          : Chapter_image.fromJson(
              json['chapter_image'] as Map<String, dynamic>),
      json['isbuy'] as int,
      json['start_num'] as int,
      json['end_num'] as int,
      json['chapter_domain'] as String,
      json['source_url'] as String,
      json['rule'] as String,
      json['webview'] as String,
      json['show_spiltline'] as int);
}

Map<String, dynamic> _$Comic_chapterToJson(Comic_chapter instance) =>
    <String, dynamic>{
      'chapter_name': instance.chapterName,
      'chapter_id': instance.chapterId,
      'chapter_topic_id': instance.chapterTopicId,
      'create_date': instance.createDate,
      'islock': instance.islock,
      'chapter_share_url': instance.chapterShareUrl,
      'download_price': instance.downloadPrice,
      'price': instance.price,
      'chapter_image': instance.chapterImage,
      'isbuy': instance.isbuy,
      'start_num': instance.startNum,
      'end_num': instance.endNum,
      'chapter_domain': instance.chapterDomain,
      'source_url': instance.sourceUrl,
      'rule': instance.rule,
      'webview': instance.webview,
      'show_spiltline': instance.showSpiltline
    };

Chapter_image _$Chapter_imageFromJson(Map<String, dynamic> json) {
  return Chapter_image(
      json['low'] as String, json['middle'] as String, json['high'] as String);
}

Map<String, dynamic> _$Chapter_imageToJson(Chapter_image instance) =>
    <String, dynamic>{
      'low': instance.low,
      'middle': instance.middle,
      'high': instance.high
    };
