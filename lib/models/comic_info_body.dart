import 'package:json_annotation/json_annotation.dart';

part 'comic_info_body.g.dart';

@JsonSerializable()
class ComicInfoBody extends Object {
  @JsonKey(name: 'servicetime')
  int servicetime;

  @JsonKey(name: 'comic_name')
  String comicName;

  @JsonKey(name: 'comic_type')
  Comic_type comicType;

  @JsonKey(name: 'comic_type_new')
  List<Comic_type_new> comicTypeNew;

  @JsonKey(name: 'update_status_str')
  String updateStatusStr;

  @JsonKey(name: 'seo_title')
  String seoTitle;

  @JsonKey(name: 'seo_keywords')
  String seoKeywords;

  @JsonKey(name: 'seo_description')
  String seoDescription;

  @JsonKey(name: 'comic_status')
  int comicStatus;

  @JsonKey(name: 'comic_author')
  String comicAuthor;

  @JsonKey(name: 'comic_desc')
  String comicDesc;

  @JsonKey(name: 'comic_notice')
  String comicNotice;

  @JsonKey(name: 'comic_copyright')
  String comicCopyright;

  @JsonKey(name: 'last_chapter_id')
  String lastChapterId;

  @JsonKey(name: 'last_chapter_name')
  String lastChapterName;

  @JsonKey(name: 'copyright_type')
  int copyrightType;

  @JsonKey(name: 'readtype')
  int readtype;

  @JsonKey(name: 'human_type')
  int humanType;

  @JsonKey(name: 'copyright_type_cn')
  String copyrightTypeCn;

  @JsonKey(name: 'background_color')
  String backgroundColor;

  @JsonKey(name: 'comic_share_url')
  String comicShareUrl;

  @JsonKey(name: 'update_time')
  int updateTime;

  @JsonKey(name: 'cover_charge_status')
  String coverChargeStatus;

  @JsonKey(name: 'comic_media')
  String comicMedia;

  @JsonKey(name: 'site_status')
  String siteStatus;

  @JsonKey(name: 'shoucang')
  int shoucang;

  @JsonKey(name: 'renqi')
  int renqi;

  @JsonKey(name: 'comic_chapter')
  List<Comic_chapter> comicChapter;

  @JsonKey(name: 'allprice')
  int allprice;

  @JsonKey(name: 'charge_status')
  String chargeStatus;

  @JsonKey(name: 'charge_paid')
  int chargePaid;

  @JsonKey(name: 'charge_coin_free')
  int chargeCoinFree;

  @JsonKey(name: 'charge_share_free')
  int chargeShareFree;

  @JsonKey(name: 'charge_advertise_free')
  int chargeAdvertiseFree;

  @JsonKey(name: 'charge_truetime_free')
  int chargeTruetimeFree;

  @JsonKey(name: 'charge_limittime_free')
  int chargeLimittimeFree;

  @JsonKey(name: 'charge_limitline_free')
  int chargeLimitlineFree;

  @JsonKey(name: 'charge_vip_free')
  int chargeVipFree;

  @JsonKey(name: 'charge_spread_free')
  int chargeSpreadFree;

  @JsonKey(name: 'charge_game_free')
  int chargeGameFree;

  @JsonKey(name: 'charge_coupons_free')
  int chargeCouponsFree;

  @JsonKey(name: 'charge_lottery_free')
  int chargeLotteryFree;

  @JsonKey(name: 'charge_limittime_paid')
  int chargeLimittimePaid;

  @JsonKey(name: 'charge_limitline_paid')
  int chargeLimitlinePaid;

  @JsonKey(name: 'charge_others_paid')
  int chargeOthersPaid;

  @JsonKey(name: 'charge_credit_paid')
  int chargeCreditPaid;

  @JsonKey(name: 'charge_free_turn')
  int chargeFreeTurn;

  @JsonKey(name: 'isshowdata')
  int isshowdata;

  @JsonKey(name: 'cover_list')
  List<String> coverList;

  ComicInfoBody(
    this.servicetime,
    this.comicName,
    this.comicType,
    this.comicTypeNew,
    this.updateStatusStr,
    this.seoTitle,
    this.seoKeywords,
    this.seoDescription,
    this.comicStatus,
    this.comicAuthor,
    this.comicDesc,
    this.comicNotice,
    this.comicCopyright,
    this.lastChapterId,
    this.lastChapterName,
    this.copyrightType,
    this.readtype,
    this.humanType,
    this.copyrightTypeCn,
    this.backgroundColor,
    this.comicShareUrl,
    this.updateTime,
    this.coverChargeStatus,
    this.comicMedia,
    this.siteStatus,
    this.shoucang,
    this.renqi,
    this.comicChapter,
    this.allprice,
    this.chargeStatus,
    this.chargePaid,
    this.chargeCoinFree,
    this.chargeShareFree,
    this.chargeAdvertiseFree,
    this.chargeTruetimeFree,
    this.chargeLimittimeFree,
    this.chargeLimitlineFree,
    this.chargeVipFree,
    this.chargeSpreadFree,
    this.chargeGameFree,
    this.chargeCouponsFree,
    this.chargeLotteryFree,
    this.chargeLimittimePaid,
    this.chargeLimitlinePaid,
    this.chargeOthersPaid,
    this.chargeCreditPaid,
    this.chargeFreeTurn,
    this.isshowdata,
    this.coverList,
  );

  factory ComicInfoBody.fromJson(Map<String, dynamic> srcJson) =>
      _$ComicInfoBodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ComicInfoBodyToJson(this);
}

@JsonSerializable()
class Comic_type extends Object {
  @JsonKey(name: 'rexue')
  String rexue;

  @JsonKey(name: 'shenmo')
  String shenmo;

  @JsonKey(name: 'jingji')
  String jingji;

  @JsonKey(name: 'jingpin')
  String jingpin;

  Comic_type(
    this.rexue,
    this.shenmo,
    this.jingji,
    this.jingpin,
  );

  factory Comic_type.fromJson(Map<String, dynamic> srcJson) =>
      _$Comic_typeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Comic_typeToJson(this);
}

@JsonSerializable()
class Comic_type_new extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'urlid')
  String urlid;

  Comic_type_new(
    this.id,
    this.name,
    this.urlid,
  );

  factory Comic_type_new.fromJson(Map<String, dynamic> srcJson) =>
      _$Comic_type_newFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Comic_type_newToJson(this);
}

@JsonSerializable()
class Comic_chapter extends Object {
  @JsonKey(name: 'chapter_name')
  String chapterName;

  @JsonKey(name: 'chapter_id')
  String chapterId;

  @JsonKey(name: 'chapter_topic_id')
  int chapterTopicId;

  @JsonKey(name: 'create_date')
  int createDate;

  @JsonKey(name: 'islock')
  int islock;

  @JsonKey(name: 'chapter_share_url')
  String chapterShareUrl;

  @JsonKey(name: 'download_price')
  int downloadPrice;

  @JsonKey(name: 'price')
  int price;

  @JsonKey(name: 'chapter_image')
  Chapter_image chapterImage;

  @JsonKey(name: 'isbuy')
  int isbuy;

  @JsonKey(name: 'start_num')
  int startNum;

  @JsonKey(name: 'end_num')
  int endNum;

  @JsonKey(name: 'chapter_domain')
  String chapterDomain;

  @JsonKey(name: 'source_url')
  String sourceUrl;

  @JsonKey(name: 'rule')
  String rule;

  @JsonKey(name: 'webview')
  String webview;

  @JsonKey(name: 'show_spiltline')
  int showSpiltline;

  Comic_chapter(
    this.chapterName,
    this.chapterId,
    this.chapterTopicId,
    this.createDate,
    this.islock,
    this.chapterShareUrl,
    this.downloadPrice,
    this.price,
    this.chapterImage,
    this.isbuy,
    this.startNum,
    this.endNum,
    this.chapterDomain,
    this.sourceUrl,
    this.rule,
    this.webview,
    this.showSpiltline,
  );

  factory Comic_chapter.fromJson(Map<String, dynamic> srcJson) =>
      _$Comic_chapterFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Comic_chapterToJson(this);
}

@JsonSerializable()
class Chapter_image extends Object {
  @JsonKey(name: 'low')
  String low;

  @JsonKey(name: 'middle')
  String middle;

  @JsonKey(name: 'high')
  String high;

  Chapter_image(
    this.low,
    this.middle,
    this.high,
  );

  factory Chapter_image.fromJson(Map<String, dynamic> srcJson) =>
      _$Chapter_imageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Chapter_imageToJson(this);
}
