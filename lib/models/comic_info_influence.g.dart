// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_info_influence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComicInfoInfluence _$ComicInfoInfluenceFromJson(Map<String, dynamic> json) {
  return ComicInfoInfluence(
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    json['status'] as int,
    json['msg'] as String,
  );
}

Map<String, dynamic> _$ComicInfoInfluenceToJson(ComicInfoInfluence instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'msg': instance.msg,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    (json['out_list'] as List)?.map((e) => e as int)?.toList(),
    (json['insider_list'] as List)
        ?.map((e) =>
            e == null ? null : Insider_list.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['call_data'] == null
        ? null
        : Call_data.fromJson(json['call_data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'out_list': instance.outList,
      'insider_list': instance.insiderList,
      'call_data': instance.callData,
    };

Insider_list _$Insider_listFromJson(Map<String, dynamic> json) {
  return Insider_list(
    json['uid'] as int,
    json['counts'] as int,
    json['Uname'] as String,
    json['level'] as int,
    json['isvip'] as int,
  );
}

Map<String, dynamic> _$Insider_listToJson(Insider_list instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'counts': instance.counts,
      'Uname': instance.uname,
      'level': instance.level,
      'isvip': instance.isvip,
    };

Call_data _$Call_dataFromJson(Map<String, dynamic> json) {
  return Call_data(
    json['show_call'] as bool,
    json['copyright_type'] as int,
    json['default_price'] as int,
    json['show_bonus'] as bool,
    json['pv'] as String,
    json['uv'] as String,
    json['collect'] as String,
    json['share'] as String,
    json['comment'] as String,
    json['reward'] as String,
    json['gift'] as String,
    json['ticket'] as String,
    json['recommend'] as String,
    json['score'] as String,
    json['currmon_bonus'] as int,
    json['lastmon_bonus'] as int,
    json['thisweek_heat'] as String,
    json['thisweek_heat_rank'] as int,
    json['uprise_rank'] as int,
    json['thistotal_heat'] as String,
    json['thistotal_heat_rank'] as int,
  );
}

Map<String, dynamic> _$Call_dataToJson(Call_data instance) => <String, dynamic>{
      'show_call': instance.showCall,
      'copyright_type': instance.copyrightType,
      'default_price': instance.defaultPrice,
      'show_bonus': instance.showBonus,
      'pv': instance.pv,
      'uv': instance.uv,
      'collect': instance.collect,
      'share': instance.share,
      'comment': instance.comment,
      'reward': instance.reward,
      'gift': instance.gift,
      'ticket': instance.ticket,
      'recommend': instance.recommend,
      'score': instance.score,
      'currmon_bonus': instance.currmonBonus,
      'lastmon_bonus': instance.lastmonBonus,
      'thisweek_heat': instance.thisweekHeat,
      'thisweek_heat_rank': instance.thisweekHeatRank,
      'uprise_rank': instance.upriseRank,
      'thistotal_heat': instance.thistotalHeat,
      'thistotal_heat_rank': instance.thistotalHeatRank,
    };
