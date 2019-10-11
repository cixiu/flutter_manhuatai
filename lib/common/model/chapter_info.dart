import 'package:json_annotation/json_annotation.dart';

part 'chapter_info.g.dart';

@JsonSerializable()
class ChapterInfo extends Object {
  @JsonKey(name: 'chapter_topic_id')
  int chapterTopicId;

  @JsonKey(name: 'comic_id')
  int comicId;

  @JsonKey(name: 'chapter_name')
  String chapterName;

  @JsonKey(name: 'comic_name')
  String comicName;

  @JsonKey(name: 'cartoon_topic_newid')
  String cartoonTopicNewid;

  ChapterInfo(
    this.chapterTopicId,
    this.comicId,
    this.chapterName,
    this.comicName,
    this.cartoonTopicNewid,
  );

  factory ChapterInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$ChapterInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChapterInfoToJson(this);
}
