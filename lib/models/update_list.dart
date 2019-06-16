import 'package:json_annotation/json_annotation.dart';

part 'update_list.g.dart';

@JsonSerializable()
class UpdateList extends Object {
  @JsonKey(name: 'tab_title')
  String tabTitle;

  @JsonKey(name: 'update')
  List<Update> update;

  @JsonKey(name: 'today')
  List<Today> today;

  @JsonKey(name: 'servicetime')
  int servicetime;

  UpdateList(
    this.tabTitle,
    this.update,
    this.today,
    this.servicetime,
  );

  factory UpdateList.fromJson(Map<String, dynamic> srcJson) =>
      _$UpdateListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UpdateListToJson(this);
}

@JsonSerializable()
class Update extends Object {
  @JsonKey(name: 'comicUpdateDate')
  String comicUpdateDate;

  @JsonKey(name: 'comicUpdateDate_new')
  String comicUpdateDateNew;

  @JsonKey(name: 'info')
  List<Info> info;

  Update(
    this.comicUpdateDate,
    this.comicUpdateDateNew,
    this.info,
  );

  factory Update.fromJson(Map<String, dynamic> srcJson) =>
      _$UpdateFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UpdateToJson(this);
}

@JsonSerializable()
class Info extends Object {
  @JsonKey(name: 'comic_id')
  int comicId;

  @JsonKey(name: 'comic_name')
  String comicName;

  @JsonKey(name: 'comic_chapter_name')
  String comicChapterName;

  @JsonKey(name: 'update_time')
  String updateTime;

  @JsonKey(name: 'author_name')
  String authorName;

  @JsonKey(name: 'comic_type')
  List<String> comicType;

  @JsonKey(name: 'renqi')
  int renqi;

  @JsonKey(name: 'comic_feature')
  String comicFeature;

  @JsonKey(name: 'chapter_feature')
  String chapterFeature;

  @JsonKey(name: 'feature_location')
  int featureLocation;

  @JsonKey(name: 'outter_color')
  String outterColor;

  @JsonKey(name: 'inner_color')
  String innerColor;

  @JsonKey(name: 'font_size')
  int fontSize;

  @JsonKey(name: 'brush_size')
  int brushSize;

  @JsonKey(name: 'feature_img')
  String featureImg;

  @JsonKey(name: 'copyright_type')
  int copyrightType;

  @JsonKey(name: 'score')
  double score;

  @JsonKey(name: 'comic_newid')
  String comicNewid;

  Info(
    this.comicId,
    this.comicName,
    this.comicChapterName,
    this.updateTime,
    this.authorName,
    this.comicType,
    this.renqi,
    this.comicFeature,
    this.chapterFeature,
    this.featureLocation,
    this.outterColor,
    this.innerColor,
    this.fontSize,
    this.brushSize,
    this.featureImg,
    this.copyrightType,
    this.score,
    this.comicNewid,
  );

  factory Info.fromJson(Map<String, dynamic> srcJson) =>
      _$InfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Today extends Object {
  @JsonKey(name: 'comic_id')
  int comicId;

  @JsonKey(name: 'comic_name')
  String comicName;

  @JsonKey(name: 'comic_chapter_name')
  String comicChapterName;

  @JsonKey(name: 'update_time')
  int updateTime;

  @JsonKey(name: 'author_name')
  String authorName;

  @JsonKey(name: 'comic_type')
  List<String> comicType;

  @JsonKey(name: 'yesterday_view_num')
  int yesterdayViewNum;

  @JsonKey(name: 'renqi')
  int renqi;

  @JsonKey(name: 'comic_feature')
  String comicFeature;

  @JsonKey(name: 'chapter_feature')
  String chapterFeature;

  @JsonKey(name: 'feature_location')
  int featureLocation;

  @JsonKey(name: 'outter_color')
  String outterColor;

  @JsonKey(name: 'inner_color')
  String innerColor;

  @JsonKey(name: 'font_size')
  int fontSize;

  @JsonKey(name: 'brush_size')
  int brushSize;

  @JsonKey(name: 'feature_img')
  String featureImg;

  @JsonKey(name: 'copyright_type')
  int copyrightType;

  @JsonKey(name: 'score')
  double score;

  @JsonKey(name: 'comic_newid')
  String comicNewid;

  Today(
    this.comicId,
    this.comicName,
    this.comicChapterName,
    this.updateTime,
    this.authorName,
    this.comicType,
    this.yesterdayViewNum,
    this.renqi,
    this.comicFeature,
    this.chapterFeature,
    this.featureLocation,
    this.outterColor,
    this.innerColor,
    this.fontSize,
    this.brushSize,
    this.featureImg,
    this.copyrightType,
    this.score,
    this.comicNewid,
  );

  factory Today.fromJson(Map<String, dynamic> srcJson) =>
      _$TodayFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TodayToJson(this);
}
