// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    json['Uid'] as int,
    json['Uname'] as String,
    json['Usex'] as int,
    json['Utype'] as int,
    json['Ulevel'] as int,
    json['Uregip'] as String,
    json['Uregtime'] as int,
    json['Umail'] as String,
    json['Usign'] as String,
    json['Utag_ids'] as String,
    json['Uareacode'] as String,
    json['Ubirthday'] as int,
    json['Ubind_mkxq'] as String,
    json['Uviptime'] as int,
    json['ismkxq'] as int,
    json['isvip'] as int,
    json['vipoverday'] as int,
    json['openid'] as String,
    json['type'] as String,
    json['newactimg'] as String,
    json['CUid'] as int,
    json['Cexp'] as int,
    json['Cgold'] as int,
    json['Cticket'] as int,
    json['Cfocus'] as int,
    json['Cfans'] as int,
    json['Cactive'] as int,
    json['Cnewmsg'] as int,
    json['Cdiamonds'] as int,
    json['ecy_coin_nouse'] as int,
    json['ecy_coin_ios_nouse'] as int,
    json['card_adblock'] as int,
    json['discount_total'] as int,
    json['ecy_coin'] as int,
    json['ecy_coin_ios'] as int,
    json['card_gold_free'] as int,
    json['card_platinum_free'] as int,
    json['card_black_free'] as int,
    json['card_supreme_free'] as int,
    json['card_double_up'] as int,
    json['card_triple_up'] as int,
    json['card_quadruple_up'] as int,
    json['card_vip'] as int,
    json['Cremaincoin'] as int,
    json['isVip'] as int,
    json['serverTime'] as int,
    json['is_adblock'] as int,
    json['is_card_vip'] as int,
    json['is_card_gold_free'] as int,
    json['is_card_platinum_free'] as int,
    json['is_card_black_free'] as int,
    json['is_card_supreme_free'] as int,
    json['is_card_double_up'] as int,
    json['is_card_triple_up'] as int,
    json['is_card_quadruple_up'] as int,
    json['card_adblock_days'] as int,
    json['is_card_adblock'] as int,
    json['card_black_free_days'] as int,
    json['card_double_up_days'] as int,
    json['card_gold_free_days'] as int,
    json['card_platinum_free_days'] as int,
    json['card_quadruple_up_days'] as int,
    json['card_supreme_free_days'] as int,
    json['card_triple_up_days'] as int,
    json['card_vip_days'] as int,
    json['book_num'] as int,
    json['coins'] as int,
    json['diamonds'] as int,
    json['limit_comment'] as int,
    json['limit_satellite'] as int,
    json['limit_friends'] as int,
    json['is_comment_picture'] as int,
    json['is_comment_check'] as int,
    json['is_apply_audit_officer'] as int,
    json['is_sensitive_keywords'] as int,
    json['is_sensitive_view'] as int,
    json['limitfocus'] as int,
    json['nextlevelexp'] as int,
    json['limitbook'] as int,
    json['limitcollect'] as int,
    json['isnewuser'] as int,
    json['recommend'] as int,
    json['limit'] == null
        ? null
        : Limit.fromJson(json['limit'] as Map<String, dynamic>),
    json['commerceauth'] == null
        ? null
        : Commerceauth.fromJson(json['commerceauth'] as Map<String, dynamic>),
    json['auth_data'] == null
        ? null
        : Auth_data.fromJson(json['auth_data'] as Map<String, dynamic>),
    json['task_data'] == null
        ? null
        : Task_data.fromJson(json['task_data'] as Map<String, dynamic>),
    json['mkxqaes'] as String,
    json['community_data'] == null
        ? null
        : Community_data.fromJson(
            json['community_data'] as Map<String, dynamic>),
    json['roleinfo'] as List,
    json['view_keywords'] as int,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'Uid': instance.uid,
      'Uname': instance.uname,
      'Usex': instance.usex,
      'Utype': instance.utype,
      'Ulevel': instance.ulevel,
      'Uregip': instance.uregip,
      'Uregtime': instance.uregtime,
      'Umail': instance.umail,
      'Usign': instance.usign,
      'Utag_ids': instance.utagIds,
      'Uareacode': instance.uareacode,
      'Ubirthday': instance.ubirthday,
      'Ubind_mkxq': instance.ubindMkxq,
      'Uviptime': instance.uviptime,
      'ismkxq': instance.ismkxq,
      'isvip': instance.isvip,
      'vipoverday': instance.vipoverday,
      'openid': instance.openid,
      'type': instance.type,
      'newactimg': instance.newactimg,
      'CUid': instance.cUid,
      'Cexp': instance.cexp,
      'Cgold': instance.cgold,
      'Cticket': instance.cticket,
      'Cfocus': instance.cfocus,
      'Cfans': instance.cfans,
      'Cactive': instance.cactive,
      'Cnewmsg': instance.cnewmsg,
      'Cdiamonds': instance.cdiamonds,
      'ecy_coin_nouse': instance.ecyCoinNouse,
      'ecy_coin_ios_nouse': instance.ecyCoinIosNouse,
      'card_adblock': instance.cardAdblock,
      'discount_total': instance.discountTotal,
      'ecy_coin': instance.ecyCoin,
      'ecy_coin_ios': instance.ecyCoinIos,
      'card_gold_free': instance.cardGoldFree,
      'card_platinum_free': instance.cardPlatinumFree,
      'card_black_free': instance.cardBlackFree,
      'card_supreme_free': instance.cardSupremeFree,
      'card_double_up': instance.cardDoubleUp,
      'card_triple_up': instance.cardTripleUp,
      'card_quadruple_up': instance.cardQuadrupleUp,
      'card_vip': instance.cardVip,
      'Cremaincoin': instance.cremaincoin,
      'isVip': instance.isVip,
      'serverTime': instance.serverTime,
      'is_adblock': instance.isAdblock,
      'is_card_vip': instance.isCardVip,
      'is_card_gold_free': instance.isCardGoldFree,
      'is_card_platinum_free': instance.isCardPlatinumFree,
      'is_card_black_free': instance.isCardBlackFree,
      'is_card_supreme_free': instance.isCardSupremeFree,
      'is_card_double_up': instance.isCardDoubleUp,
      'is_card_triple_up': instance.isCardTripleUp,
      'is_card_quadruple_up': instance.isCardQuadrupleUp,
      'card_adblock_days': instance.cardAdblockDays,
      'is_card_adblock': instance.isCardAdblock,
      'card_black_free_days': instance.cardBlackFreeDays,
      'card_double_up_days': instance.cardDoubleUpDays,
      'card_gold_free_days': instance.cardGoldFreeDays,
      'card_platinum_free_days': instance.cardPlatinumFreeDays,
      'card_quadruple_up_days': instance.cardQuadrupleUpDays,
      'card_supreme_free_days': instance.cardSupremeFreeDays,
      'card_triple_up_days': instance.cardTripleUpDays,
      'card_vip_days': instance.cardVipDays,
      'book_num': instance.bookNum,
      'coins': instance.coins,
      'diamonds': instance.diamonds,
      'limit_comment': instance.limitComment,
      'limit_satellite': instance.limitSatellite,
      'limit_friends': instance.limitFriends,
      'is_comment_picture': instance.isCommentPicture,
      'is_comment_check': instance.isCommentCheck,
      'is_apply_audit_officer': instance.isApplyAuditOfficer,
      'is_sensitive_keywords': instance.isSensitiveKeywords,
      'is_sensitive_view': instance.isSensitiveView,
      'limitfocus': instance.limitfocus,
      'nextlevelexp': instance.nextlevelexp,
      'limitbook': instance.limitbook,
      'limitcollect': instance.limitcollect,
      'isnewuser': instance.isnewuser,
      'recommend': instance.recommend,
      'limit': instance.limit,
      'commerceauth': instance.commerceauth,
      'auth_data': instance.authData,
      'task_data': instance.taskData,
      'mkxqaes': instance.mkxqaes,
      'community_data': instance.communityData,
      'roleinfo': instance.roleinfo,
      'view_keywords': instance.viewKeywords,
    };

Limit _$LimitFromJson(Map<String, dynamic> json) {
  return Limit(
    json['book'] as int,
    json['book_comic'] as int,
  );
}

Map<String, dynamic> _$LimitToJson(Limit instance) => <String, dynamic>{
      'book': instance.book,
      'book_comic': instance.bookComic,
    };

Commerceauth _$CommerceauthFromJson(Map<String, dynamic> json) {
  return Commerceauth(
    json['expiry'] as int,
    json['appid'] as String,
    json['authcode'] as String,
    json['imagedomain'] as String,
    json['imagelimit'] as String,
  );
}

Map<String, dynamic> _$CommerceauthToJson(Commerceauth instance) =>
    <String, dynamic>{
      'expiry': instance.expiry,
      'appid': instance.appid,
      'authcode': instance.authcode,
      'imagedomain': instance.imagedomain,
      'imagelimit': instance.imagelimit,
    };

Auth_data _$Auth_dataFromJson(Map<String, dynamic> json) {
  return Auth_data(
    json['expiry'] as int,
    json['appid'] as String,
    json['authcode'] as String,
    json['imagedomain'] as String,
    json['imagelimit'] as String,
  );
}

Map<String, dynamic> _$Auth_dataToJson(Auth_data instance) => <String, dynamic>{
      'expiry': instance.expiry,
      'appid': instance.appid,
      'authcode': instance.authcode,
      'imagedomain': instance.imagedomain,
      'imagelimit': instance.imagelimit,
    };

Task_data _$Task_dataFromJson(Map<String, dynamic> json) {
  return Task_data(
    json['expires'] as int,
    json['appid'] as String,
    json['authcode'] as String,
  );
}

Map<String, dynamic> _$Task_dataToJson(Task_data instance) => <String, dynamic>{
      'expires': instance.expires,
      'appid': instance.appid,
      'authcode': instance.authcode,
    };

Community_data _$Community_dataFromJson(Map<String, dynamic> json) {
  return Community_data(
    json['expiry'] as int,
    json['appid'] as String,
    json['authcode'] as String,
    json['imagedomain'] as String,
    json['imagelimit'] as String,
  );
}

Map<String, dynamic> _$Community_dataToJson(Community_data instance) =>
    <String, dynamic>{
      'expiry': instance.expiry,
      'appid': instance.appid,
      'authcode': instance.authcode,
      'imagedomain': instance.imagedomain,
      'imagelimit': instance.imagelimit,
    };
