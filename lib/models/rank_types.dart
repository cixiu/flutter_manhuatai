import 'package:json_annotation/json_annotation.dart';

part 'rank_types.g.dart';

@JsonSerializable()
class RankTypes extends Object {
  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  Data data;

  RankTypes(
    this.status,
    this.msg,
    this.data,
  );

  factory RankTypes.fromJson(Map<String, dynamic> srcJson) =>
      _$RankTypesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RankTypesToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'rank_type_list')
  List<Rank_type_list> rankTypeList;

  @JsonKey(name: 'sort_type_list')
  List<Sort_type_list> sortTypeList;

  @JsonKey(name: 'product_id_list')
  List<Product_id_list> productIdList;

  @JsonKey(name: 'time_type_list')
  List<Time_type_list> timeTypeList;

  @JsonKey(name: 'yearlist')
  List<int> yearlist;

  @JsonKey(name: 'servertime')
  int servertime;

  @JsonKey(name: 'weeklist')
  List<dynamic> weeklist;

  Data(
    this.rankTypeList,
    this.sortTypeList,
    this.productIdList,
    this.timeTypeList,
    this.yearlist,
    this.servertime,
    this.weeklist,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Rank_type_list extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'value')
  String value;

  Rank_type_list(
    this.name,
    this.value,
  );

  factory Rank_type_list.fromJson(Map<String, dynamic> srcJson) =>
      _$Rank_type_listFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Rank_type_listToJson(this);
}

@JsonSerializable()
class Sort_type_list extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'value')
  String value;

  Sort_type_list(
    this.name,
    this.value,
  );

  factory Sort_type_list.fromJson(Map<String, dynamic> srcJson) =>
      _$Sort_type_listFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Sort_type_listToJson(this);
}

@JsonSerializable()
class Product_id_list extends Object {
  @JsonKey(name: 'name')
  int name;

  @JsonKey(name: 'value')
  String value;

  Product_id_list(
    this.name,
    this.value,
  );

  factory Product_id_list.fromJson(Map<String, dynamic> srcJson) =>
      _$Product_id_listFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Product_id_listToJson(this);
}

@JsonSerializable()
class Time_type_list extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'value')
  String value;

  Time_type_list(
    this.name,
    this.value,
  );

  factory Time_type_list.fromJson(Map<String, dynamic> srcJson) =>
      _$Time_type_listFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Time_type_listToJson(this);
}
