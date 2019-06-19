import 'package:json_annotation/json_annotation.dart';

part 'sort_list.g.dart';

@JsonSerializable()
class SortList extends Object {
  @JsonKey(name: 'page')
  Page page;

  @JsonKey(name: 'data')
  List<Data> data;

  SortList(
    this.page,
    this.data,
  );

  factory SortList.fromJson(Map<String, dynamic> srcJson) =>
      _$SortListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SortListToJson(this);
}

@JsonSerializable()
class Page extends Object {
  @JsonKey(name: 'current_page')
  int currentPage;

  @JsonKey(name: 'total_page')
  int totalPage;

  @JsonKey(name: 'orderby')
  String orderby;

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'comic_sort')
  String comicSort;

  @JsonKey(name: 'search_key')
  String searchKey;

  @JsonKey(name: 'time')
  int time;

  Page(
    this.currentPage,
    this.totalPage,
    this.orderby,
    this.count,
    this.comicSort,
    this.searchKey,
    this.time,
  );

  factory Page.fromJson(Map<String, dynamic> srcJson) =>
      _$PageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PageToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'comic_id')
  int comicId;

  @JsonKey(name: 'comic_name')
  String comicName;

  @JsonKey(name: 'last_chapter_name')
  String lastChapterName;

  @JsonKey(name: 'comic_type')
  String comicType;

  @JsonKey(name: 'comic_newid')
  String comicNewid;

  Data(
    this.comicId,
    this.comicName,
    this.lastChapterName,
    this.comicType,
    this.comicNewid,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
