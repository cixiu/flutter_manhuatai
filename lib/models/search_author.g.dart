// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchAuthor _$SearchAuthorFromJson(Map<String, dynamic> json) {
  return SearchAuthor(
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      json['status'] as int,
      json['message'] as String);
}

Map<String, dynamic> _$SearchAuthorToJson(SearchAuthor instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['total'] as int,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data_Data.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DataToJson(Data instance) =>
    <String, dynamic>{'total': instance.total, 'data': instance.data};

Data_Data _$Data_DataFromJson(Map<String, dynamic> json) {
  return Data_Data(
      json['uid'] as int,
      json['platformid'] as int,
      json['utype'] as int,
      json['usign'] as String,
      json['uname'] as String,
      (json['score'] as num)?.toDouble(),
      json['ustatus'] as int,
      json['utag_ids'] as String,
      json['siteid'] as int,
      json['zuopin_num'] as int,
      json['productlineid'] as int);
}

Map<String, dynamic> _$Data_DataToJson(Data_Data instance) => <String, dynamic>{
      'uid': instance.uid,
      'platformid': instance.platformid,
      'utype': instance.utype,
      'usign': instance.usign,
      'uname': instance.uname,
      'score': instance.score,
      'ustatus': instance.ustatus,
      'utag_ids': instance.utagIds,
      'siteid': instance.siteid,
      'zuopin_num': instance.zuopinNum,
      'productlineid': instance.productlineid
    };
