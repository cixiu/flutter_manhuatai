import 'package:json_annotation/json_annotation.dart';

part 'topic_hot_list.g.dart';

@JsonSerializable()
class TopicHotList extends Object {
  @JsonKey(name: 'data')
  Data data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  TopicHotList(
    this.data,
    this.status,
    this.msg,
  );

  factory TopicHotList.fromJson(Map<String, dynamic> srcJson) =>
      _$TopicHotListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopicHotListToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'list')
  List<List_List> list;

  Data(
    this.list,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class List_List extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'created_time')
  int createdTime;

  @JsonKey(name: 'updated_time')
  int updatedTime;

  @JsonKey(name: 'productline_ids')
  String productlineIds;

  @JsonKey(name: 'order_num')
  int orderNum;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'follow_count')
  int followCount;

  @JsonKey(name: 'satellite_num')
  int satelliteNum;

  @JsonKey(name: 'view_count')
  int viewCount;

  List_List(
    this.id,
    this.name,
    this.status,
    this.createdTime,
    this.updatedTime,
    this.productlineIds,
    this.orderNum,
    this.cover,
    this.type,
    this.desc,
    this.followCount,
    this.satelliteNum,
    this.viewCount,
  );

  factory List_List.fromJson(Map<String, dynamic> srcJson) =>
      _$List_ListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$List_ListToJson(this);
}
