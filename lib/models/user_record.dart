import 'package:json_annotation/json_annotation.dart';

part 'user_record.g.dart';

@JsonSerializable()
class UserRecord extends Object {
  @JsonKey(name: 'user_read')
  List<User_read> userRead;

  @JsonKey(name: 'collectnum')
  int collectnum;

  @JsonKey(name: 'user_collect')
  List<User_collect> userCollect;

  @JsonKey(name: 'limit_collect')
  int limitCollect;

  UserRecord(
    this.userRead,
    this.collectnum,
    this.userCollect,
    this.limitCollect,
  );

  factory UserRecord.fromJson(Map<String, dynamic> srcJson) =>
      _$UserRecordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserRecordToJson(this);
}

@JsonSerializable()
class User_read extends Object {
  @JsonKey(name: 'comic_id')
  int comicId;

  @JsonKey(name: 'comic_newid')
  String comicNewid;

  @JsonKey(name: 'comic_name')
  String comicName;

  @JsonKey(name: 'chapter_page')
  int chapterPage;

  @JsonKey(name: 'chapter_name')
  String chapterName;

  @JsonKey(name: 'chapter_newid')
  String chapterNewid;

  @JsonKey(name: 'read_time')
  int readTime;

  @JsonKey(name: 'last_chapter_name')
  String lastChapterName;

  @JsonKey(name: 'update_time')
  int updateTime;

  @JsonKey(name: 'copyright_type')
  int copyrightType;

  @JsonKey(name: 'chapter_id')
  int chapterId;

  @JsonKey(name: 'last_chapter_newid')
  String lastChapterNewid;

  User_read(
    this.comicId,
    this.comicNewid,
    this.comicName,
    this.chapterPage,
    this.chapterName,
    this.chapterNewid,
    this.readTime,
    this.lastChapterName,
    this.updateTime,
    this.copyrightType,
    this.chapterId,
    this.lastChapterNewid,
  );

  factory User_read.fromJson(Map<String, dynamic> srcJson) =>
      _$User_readFromJson(srcJson);

  Map<String, dynamic> toJson() => _$User_readToJson(this);
}

@JsonSerializable()
class User_collect extends Object {
  @JsonKey(name: 'disable')
  bool disable;

  @JsonKey(name: 'comic_id')
  int comicId;

  @JsonKey(name: 'comic_newid')
  String comicNewid;

  @JsonKey(name: 'comic_name')
  String comicName;

  @JsonKey(name: 'read_time')
  int readTime;

  @JsonKey(name: 'update_time')
  int updateTime;

  @JsonKey(name: 'last_chapter_name')
  String lastChapterName;

  @JsonKey(name: 'copyright_type')
  int copyrightType;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'show_type')
  int showType;

  @JsonKey(name: 'last_chapter_newid')
  String lastChapterNewid;

  User_collect(
    this.disable,
    this.comicId,
    this.comicNewid,
    this.comicName,
    this.readTime,
    this.updateTime,
    this.lastChapterName,
    this.copyrightType,
    this.status,
    this.showType,
    this.lastChapterNewid,
  );

  factory User_collect.fromJson(Map<String, dynamic> srcJson) =>
      _$User_collectFromJson(srcJson);

  Map<String, dynamic> toJson() => _$User_collectToJson(this);
}
