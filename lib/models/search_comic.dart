import 'package:json_annotation/json_annotation.dart';

part 'search_comic.g.dart';

@JsonSerializable()
class SearchComic extends Object {
  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  List<Data> data;

  SearchComic(
    this.status,
    this.msg,
    this.data,
  );

  factory SearchComic.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchComicFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchComicToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'total_view_num')
  int totalViewNum;

  @JsonKey(name: 'cartoon_newid')
  String cartoonNewid;

  @JsonKey(name: 'comic_id')
  int comicId;

  @JsonKey(name: 'comic_name')
  String comicName;

  @JsonKey(name: 'comic_newid')
  String comicNewid;

  Data(
    this.totalViewNum,
    this.cartoonNewid,
    this.comicId,
    this.comicName,
    this.comicNewid,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
