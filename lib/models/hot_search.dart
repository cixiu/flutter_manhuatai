import 'package:json_annotation/json_annotation.dart';

part 'hot_search.g.dart';

@JsonSerializable()
class HotSearch extends Object {
  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'servicetime')
  int servicetime;

  HotSearch(
    this.status,
    this.msg,
    this.data,
    this.servicetime,
  );

  factory HotSearch.fromJson(Map<String, dynamic> srcJson) =>
      _$HotSearchFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotSearchToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'Id')
  double id;

  @JsonKey(name: 'Name')
  String name;

  Data(
    this.id,
    this.name,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
