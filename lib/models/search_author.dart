import 'package:json_annotation/json_annotation.dart';

part 'search_author.g.dart';

@JsonSerializable()
class SearchAuthor extends Object {
  @JsonKey(name: 'data')
  Data data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'message')
  String message;

  SearchAuthor(
    this.data,
    this.status,
    this.message,
  );

  factory SearchAuthor.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchAuthorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchAuthorToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'data')
  List<Data_Data> data;

  Data(
    this.total,
    this.data,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Data_Data extends Object {
  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'platformid')
  int platformid;

  @JsonKey(name: 'utype')
  int utype;

  @JsonKey(name: 'usign')
  String usign;

  @JsonKey(name: 'uname')
  String uname;

  @JsonKey(name: 'score')
  double score;

  @JsonKey(name: 'ustatus')
  int ustatus;

  @JsonKey(name: 'utag_ids')
  String utagIds;

  @JsonKey(name: 'siteid')
  int siteid;

  @JsonKey(name: 'zuopin_num')
  int zuopinNum;

  @JsonKey(name: 'productlineid')
  int productlineid;

  Data_Data(
    this.uid,
    this.platformid,
    this.utype,
    this.usign,
    this.uname,
    this.score,
    this.ustatus,
    this.utagIds,
    this.siteid,
    this.zuopinNum,
    this.productlineid,
  );

  factory Data_Data.fromJson(Map<String, dynamic> srcJson) =>
      _$Data_DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Data_DataToJson(this);
}
