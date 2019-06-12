// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankTypes _$RankTypesFromJson(Map<String, dynamic> json) {
  return RankTypes(
      json['status'] as int,
      json['msg'] as String,
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$RankTypesToJson(RankTypes instance) => <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'data': instance.data
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      (json['rank_type_list'] as List)
          ?.map((e) => e == null
              ? null
              : Rank_type_list.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['sort_type_list'] as List)
          ?.map((e) => e == null
              ? null
              : Sort_type_list.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['product_id_list'] as List)
          ?.map((e) => e == null
              ? null
              : Product_id_list.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['time_type_list'] as List)
          ?.map((e) => e == null
              ? null
              : Time_type_list.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['yearlist'] as List)?.map((e) => e as int)?.toList(),
      json['servertime'] as int,
      json['weeklist'] as List);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'rank_type_list': instance.rankTypeList,
      'sort_type_list': instance.sortTypeList,
      'product_id_list': instance.productIdList,
      'time_type_list': instance.timeTypeList,
      'yearlist': instance.yearlist,
      'servertime': instance.servertime,
      'weeklist': instance.weeklist
    };

Rank_type_list _$Rank_type_listFromJson(Map<String, dynamic> json) {
  return Rank_type_list(json['name'] as String, json['value'] as String);
}

Map<String, dynamic> _$Rank_type_listToJson(Rank_type_list instance) =>
    <String, dynamic>{'name': instance.name, 'value': instance.value};

Sort_type_list _$Sort_type_listFromJson(Map<String, dynamic> json) {
  return Sort_type_list(json['name'] as String, json['value'] as String);
}

Map<String, dynamic> _$Sort_type_listToJson(Sort_type_list instance) =>
    <String, dynamic>{'name': instance.name, 'value': instance.value};

Product_id_list _$Product_id_listFromJson(Map<String, dynamic> json) {
  return Product_id_list(json['name'] as int, json['value'] as String);
}

Map<String, dynamic> _$Product_id_listToJson(Product_id_list instance) =>
    <String, dynamic>{'name': instance.name, 'value': instance.value};

Time_type_list _$Time_type_listFromJson(Map<String, dynamic> json) {
  return Time_type_list(json['name'] as String, json['value'] as String);
}

Map<String, dynamic> _$Time_type_listToJson(Time_type_list instance) =>
    <String, dynamic>{'name': instance.name, 'value': instance.value};
