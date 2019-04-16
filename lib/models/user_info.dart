import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo extends Object {
  @JsonKey(name: 'Uid')
  int uid;

  @JsonKey(name: 'Uname')
  String uname;

  @JsonKey(name: 'Usex')
  int usex;

  @JsonKey(name: 'Utype')
  int utype;

  @JsonKey(name: 'Ulevel')
  int ulevel;

  @JsonKey(name: 'Uregip')
  String uregip;

  @JsonKey(name: 'Uregtime')
  int uregtime;

  @JsonKey(name: 'Umail')
  String umail;

  @JsonKey(name: 'Usign')
  String usign;

  @JsonKey(name: 'Utag_ids')
  String utagIds;

  @JsonKey(name: 'Uareacode')
  String uareacode;

  @JsonKey(name: 'Ubirthday')
  int ubirthday;

  @JsonKey(name: 'Ubind_mkxq')
  String ubindMkxq;

  @JsonKey(name: 'Uviptime')
  int uviptime;

  @JsonKey(name: 'ismkxq')
  int ismkxq;

  @JsonKey(name: 'isvip')
  int isvip;

  @JsonKey(name: 'vipoverday')
  int vipoverday;

  @JsonKey(name: 'openid')
  String openid;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'newactimg')
  String newactimg;

  @JsonKey(name: 'CUid')
  int cUid;

  @JsonKey(name: 'Cexp')
  int cexp;

  @JsonKey(name: 'Cgold')
  int cgold;

  @JsonKey(name: 'Cticket')
  int cticket;

  @JsonKey(name: 'Cfocus')
  int cfocus;

  @JsonKey(name: 'Cfans')
  int cfans;

  @JsonKey(name: 'Cactive')
  int cactive;

  @JsonKey(name: 'Cnewmsg')
  int cnewmsg;

  @JsonKey(name: 'Cdiamonds')
  int cdiamonds;

  @JsonKey(name: 'ecy_coin_nouse')
  int ecyCoinNouse;

  @JsonKey(name: 'ecy_coin_ios_nouse')
  int ecyCoinIosNouse;

  @JsonKey(name: 'card_adblock')
  int cardAdblock;

  @JsonKey(name: 'discount_total')
  int discountTotal;

  @JsonKey(name: 'ecy_coin')
  int ecyCoin;

  @JsonKey(name: 'ecy_coin_ios')
  int ecyCoinIos;

  @JsonKey(name: 'card_gold_free')
  int cardGoldFree;

  @JsonKey(name: 'card_platinum_free')
  int cardPlatinumFree;

  @JsonKey(name: 'card_black_free')
  int cardBlackFree;

  @JsonKey(name: 'card_supreme_free')
  int cardSupremeFree;

  @JsonKey(name: 'card_double_up')
  int cardDoubleUp;

  @JsonKey(name: 'card_triple_up')
  int cardTripleUp;

  @JsonKey(name: 'card_quadruple_up')
  int cardQuadrupleUp;

  @JsonKey(name: 'card_vip')
  int cardVip;

  @JsonKey(name: 'Cremaincoin')
  int cremaincoin;

  @JsonKey(name: 'isVip')
  int isVip;

  @JsonKey(name: 'serverTime')
  int serverTime;

  @JsonKey(name: 'is_adblock')
  int isAdblock;

  @JsonKey(name: 'is_card_vip')
  int isCardVip;

  @JsonKey(name: 'is_card_gold_free')
  int isCardGoldFree;

  @JsonKey(name: 'is_card_platinum_free')
  int isCardPlatinumFree;

  @JsonKey(name: 'is_card_black_free')
  int isCardBlackFree;

  @JsonKey(name: 'is_card_supreme_free')
  int isCardSupremeFree;

  @JsonKey(name: 'is_card_double_up')
  int isCardDoubleUp;

  @JsonKey(name: 'is_card_triple_up')
  int isCardTripleUp;

  @JsonKey(name: 'is_card_quadruple_up')
  int isCardQuadrupleUp;

  @JsonKey(name: 'card_adblock_days')
  int cardAdblockDays;

  @JsonKey(name: 'is_card_adblock')
  int isCardAdblock;

  @JsonKey(name: 'card_black_free_days')
  int cardBlackFreeDays;

  @JsonKey(name: 'card_double_up_days')
  int cardDoubleUpDays;

  @JsonKey(name: 'card_gold_free_days')
  int cardGoldFreeDays;

  @JsonKey(name: 'card_platinum_free_days')
  int cardPlatinumFreeDays;

  @JsonKey(name: 'card_quadruple_up_days')
  int cardQuadrupleUpDays;

  @JsonKey(name: 'card_supreme_free_days')
  int cardSupremeFreeDays;

  @JsonKey(name: 'card_triple_up_days')
  int cardTripleUpDays;

  @JsonKey(name: 'card_vip_days')
  int cardVipDays;

  @JsonKey(name: 'book_num')
  int bookNum;

  @JsonKey(name: 'coins')
  int coins;

  @JsonKey(name: 'diamonds')
  int diamonds;

  @JsonKey(name: 'limit_comment')
  int limitComment;

  @JsonKey(name: 'limit_satellite')
  int limitSatellite;

  @JsonKey(name: 'limit_friends')
  int limitFriends;

  @JsonKey(name: 'is_comment_picture')
  int isCommentPicture;

  @JsonKey(name: 'is_comment_check')
  int isCommentCheck;

  @JsonKey(name: 'is_apply_audit_officer')
  int isApplyAuditOfficer;

  @JsonKey(name: 'is_sensitive_keywords')
  int isSensitiveKeywords;

  @JsonKey(name: 'is_sensitive_view')
  int isSensitiveView;

  @JsonKey(name: 'limitfocus')
  int limitfocus;

  @JsonKey(name: 'nextlevelexp')
  int nextlevelexp;

  @JsonKey(name: 'limitbook')
  int limitbook;

  @JsonKey(name: 'limitcollect')
  int limitcollect;

  @JsonKey(name: 'isnewuser')
  int isnewuser;

  @JsonKey(name: 'recommend')
  int recommend;

  @JsonKey(name: 'limit')
  Limit limit;

  @JsonKey(name: 'commerceauth')
  Commerceauth commerceauth;

  @JsonKey(name: 'auth_data')
  Auth_data authData;

  @JsonKey(name: 'task_data')
  Task_data taskData;

  @JsonKey(name: 'mkxqaes')
  String mkxqaes;

  @JsonKey(name: 'community_data')
  Community_data communityData;

  @JsonKey(name: 'roleinfo')
  List<dynamic> roleinfo;

  @JsonKey(name: 'view_keywords')
  int viewKeywords;

  UserInfo(
    this.uid,
    this.uname,
    this.usex,
    this.utype,
    this.ulevel,
    this.uregip,
    this.uregtime,
    this.umail,
    this.usign,
    this.utagIds,
    this.uareacode,
    this.ubirthday,
    this.ubindMkxq,
    this.uviptime,
    this.ismkxq,
    this.isvip,
    this.vipoverday,
    this.openid,
    this.type,
    this.newactimg,
    this.cUid,
    this.cexp,
    this.cgold,
    this.cticket,
    this.cfocus,
    this.cfans,
    this.cactive,
    this.cnewmsg,
    this.cdiamonds,
    this.ecyCoinNouse,
    this.ecyCoinIosNouse,
    this.cardAdblock,
    this.discountTotal,
    this.ecyCoin,
    this.ecyCoinIos,
    this.cardGoldFree,
    this.cardPlatinumFree,
    this.cardBlackFree,
    this.cardSupremeFree,
    this.cardDoubleUp,
    this.cardTripleUp,
    this.cardQuadrupleUp,
    this.cardVip,
    this.cremaincoin,
    this.isVip,
    this.serverTime,
    this.isAdblock,
    this.isCardVip,
    this.isCardGoldFree,
    this.isCardPlatinumFree,
    this.isCardBlackFree,
    this.isCardSupremeFree,
    this.isCardDoubleUp,
    this.isCardTripleUp,
    this.isCardQuadrupleUp,
    this.cardAdblockDays,
    this.isCardAdblock,
    this.cardBlackFreeDays,
    this.cardDoubleUpDays,
    this.cardGoldFreeDays,
    this.cardPlatinumFreeDays,
    this.cardQuadrupleUpDays,
    this.cardSupremeFreeDays,
    this.cardTripleUpDays,
    this.cardVipDays,
    this.bookNum,
    this.coins,
    this.diamonds,
    this.limitComment,
    this.limitSatellite,
    this.limitFriends,
    this.isCommentPicture,
    this.isCommentCheck,
    this.isApplyAuditOfficer,
    this.isSensitiveKeywords,
    this.isSensitiveView,
    this.limitfocus,
    this.nextlevelexp,
    this.limitbook,
    this.limitcollect,
    this.isnewuser,
    this.recommend,
    this.limit,
    this.commerceauth,
    this.authData,
    this.taskData,
    this.mkxqaes,
    this.communityData,
    this.roleinfo,
    this.viewKeywords,
  );

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class Limit extends Object {
  @JsonKey(name: 'book')
  int book;

  @JsonKey(name: 'book_comic')
  int bookComic;

  Limit(
    this.book,
    this.bookComic,
  );

  factory Limit.fromJson(Map<String, dynamic> srcJson) =>
      _$LimitFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LimitToJson(this);
}

@JsonSerializable()
class Commerceauth extends Object {
  @JsonKey(name: 'expiry')
  int expiry;

  @JsonKey(name: 'appid')
  String appid;

  @JsonKey(name: 'authcode')
  String authcode;

  @JsonKey(name: 'imagedomain')
  String imagedomain;

  @JsonKey(name: 'imagelimit')
  String imagelimit;

  Commerceauth(
    this.expiry,
    this.appid,
    this.authcode,
    this.imagedomain,
    this.imagelimit,
  );

  factory Commerceauth.fromJson(Map<String, dynamic> srcJson) =>
      _$CommerceauthFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommerceauthToJson(this);
}

@JsonSerializable()
class Auth_data extends Object {
  @JsonKey(name: 'expiry')
  int expiry;

  @JsonKey(name: 'appid')
  String appid;

  @JsonKey(name: 'authcode')
  String authcode;

  @JsonKey(name: 'imagedomain')
  String imagedomain;

  @JsonKey(name: 'imagelimit')
  String imagelimit;

  Auth_data(
    this.expiry,
    this.appid,
    this.authcode,
    this.imagedomain,
    this.imagelimit,
  );

  factory Auth_data.fromJson(Map<String, dynamic> srcJson) =>
      _$Auth_dataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Auth_dataToJson(this);
}

@JsonSerializable()
class Task_data extends Object {
  @JsonKey(name: 'expires')
  int expires;

  @JsonKey(name: 'appid')
  String appid;

  @JsonKey(name: 'authcode')
  String authcode;

  Task_data(
    this.expires,
    this.appid,
    this.authcode,
  );

  factory Task_data.fromJson(Map<String, dynamic> srcJson) =>
      _$Task_dataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Task_dataToJson(this);
}

@JsonSerializable()
class Community_data extends Object {
  @JsonKey(name: 'expiry')
  int expiry;

  @JsonKey(name: 'appid')
  String appid;

  @JsonKey(name: 'authcode')
  String authcode;

  @JsonKey(name: 'imagedomain')
  String imagedomain;

  @JsonKey(name: 'imagelimit')
  String imagelimit;

  Community_data(
    this.expiry,
    this.appid,
    this.authcode,
    this.imagedomain,
    this.imagelimit,
  );

  factory Community_data.fromJson(Map<String, dynamic> srcJson) =>
      _$Community_dataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Community_dataToJson(this);
}
