import 'package:json_annotation/json_annotation.dart';

part 'hot_search.g.dart';

List<HotSearch> getHotSearchList(List<dynamic> list) {
  List<HotSearch> result = [];
  list.forEach((item) {
    result.add(HotSearch.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class HotSearch extends Object {
  @JsonKey(name: 'comic_id')
  int comicId;

  @JsonKey(name: 'comic_name')
  String comicName;

  @JsonKey(name: 'last_chapter_name')
  String lastChapterName;

  @JsonKey(name: 'comic_newid')
  String comicNewid;

  HotSearch(
    this.comicId,
    this.comicName,
    this.lastChapterName,
    this.comicNewid,
  );

  factory HotSearch.fromJson(Map<String, dynamic> srcJson) =>
      _$HotSearchFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotSearchToJson(this);
}
