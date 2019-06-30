import 'package:json_annotation/json_annotation.dart';

part 'recommend_stars.g.dart';

@JsonSerializable()
class RecommendStars extends Object {
  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  RecommendStars(
    this.data,
    this.status,
    this.msg,
  );

  factory RecommendStars.fromJson(Map<String, dynamic> srcJson) =>
      _$RecommendStarsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendStarsToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'target_id')
  int targetId;

  @JsonKey(name: 'target_name')
  String targetName;

  @JsonKey(name: 'isfollow')
  int isfollow;

  @JsonKey(name: 'target_desc')
  String targetDesc;

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'focusnum')
  int focusnum;

  @JsonKey(name: 'satellitenum')
  int satellitenum;

  @JsonKey(name: 'is_compel')
  int isCompel;

  Data(
    this.targetId,
    this.targetName,
    this.isfollow,
    this.targetDesc,
    this.image,
    this.focusnum,
    this.satellitenum,
    this.isCompel,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
