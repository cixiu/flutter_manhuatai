import 'package:json_annotation/json_annotation.dart';

part 'comment_content.g.dart';

@JsonSerializable()
class CommentContent extends Object {
  @JsonKey(name: 'id')
  double id;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'fatherid')
  double fatherid;

  @JsonKey(name: 'images')
  String images;

  @JsonKey(name: 'ssid')
  double ssid;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'supportcount')
  double supportcount;

  @JsonKey(name: 'iselite')
  int iselite;

  @JsonKey(name: 'istop')
  int istop;

  @JsonKey(name: 'revertcount')
  double revertcount;

  @JsonKey(name: 'useridentifier')
  double useridentifier;

  @JsonKey(name: 'createtime')
  int createtime;

  @JsonKey(name: 'updatetime')
  int updatetime;

  @JsonKey(name: 'ssidtype')
  int ssidtype;

  @JsonKey(name: 'issupport')
  int issupport;

  @JsonKey(name: 'RelateId')
  String relateId;

  CommentContent(
    this.id,
    this.content,
    this.fatherid,
    this.images,
    this.ssid,
    this.title,
    this.url,
    this.supportcount,
    this.iselite,
    this.istop,
    this.revertcount,
    this.useridentifier,
    this.createtime,
    this.updatetime,
    this.ssidtype,
    this.issupport,
    this.relateId,
  );

  factory CommentContent.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentContentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentContentToJson(this);
}
