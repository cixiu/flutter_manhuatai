import 'package:json_annotation/json_annotation.dart';

part 'comic_comment_count.g.dart';

@JsonSerializable()
class ComicCommentCount extends Object {
  @JsonKey(name: 'data')
  int data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  ComicCommentCount(
    this.data,
    this.status,
    this.msg,
  );

  factory ComicCommentCount.fromJson(Map<String, dynamic> srcJson) =>
      _$ComicCommentCountFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ComicCommentCountToJson(this);
}
