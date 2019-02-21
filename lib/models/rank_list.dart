import 'package:json_annotation/json_annotation.dart';

part 'rank_list.g.dart';

@JsonSerializable()
class RankList extends Object {
  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  List<Data> data;

  RankList(
    this.status,
    this.msg,
    this.data,
  );

  factory RankList.fromJson(Map<String, dynamic> srcJson) =>
      _$RankListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RankListToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'list')
  List<ListSub> list;

  Data(
    this.type,
    this.name,
    this.list,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class ListSub extends Object {
  @JsonKey(name: 'count_day')
  int countDay;

  @JsonKey(name: 'comic_id')
  int comicId;

  @JsonKey(name: 'comic_name')
  String comicName;

  @JsonKey(name: 'comic_urlid')
  String comicUrlid;

  @JsonKey(name: 'author_name')
  String authorName;

  @JsonKey(name: 'sort_typelist')
  String sortTypelist;

  @JsonKey(name: 'lastchapter_id')
  String lastchapterId;

  @JsonKey(name: 'lastchapter_urlid')
  String lastchapterUrlid;

  @JsonKey(name: 'lastchapter_title')
  String lastchapterTitle;

  @JsonKey(name: 'last_chapter_id')
  String lastChapterId;

  @JsonKey(name: 'last_chapter_newid')
  String lastChapterNewid;

  @JsonKey(name: 'last_chapter_name')
  String lastChapterName;

  @JsonKey(name: 'comic_feature')
  String comicFeature;

  @JsonKey(name: 'comic_score')
  double comicScore;

  @JsonKey(name: 'count_num')
  String countNum;

  @JsonKey(name: 'rise_rank')
  int riseRank;

  ListSub(
    this.countDay,
    this.comicId,
    this.comicName,
    this.comicUrlid,
    this.authorName,
    this.sortTypelist,
    this.lastchapterId,
    this.lastchapterUrlid,
    this.lastchapterTitle,
    this.lastChapterId,
    this.lastChapterNewid,
    this.lastChapterName,
    this.comicFeature,
    this.comicScore,
    this.countNum,
    this.riseRank,
  );

  factory ListSub.fromJson(Map<String, dynamic> srcJson) =>
      _$ListSubFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ListSubToJson(this);
}
