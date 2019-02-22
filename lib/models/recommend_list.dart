import 'package:json_annotation/json_annotation.dart';

part 'recommend_list.g.dart';

@JsonSerializable()
class RecommendList extends Object {
  @JsonKey(name: 'data')
  Data data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'message')
  String message;

  RecommendList(
    this.data,
    this.status,
    this.message,
  );

  factory RecommendList.fromJson(Map<String, dynamic> srcJson) =>
      _$RecommendListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendListToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'book')
  List<Book> book;

  @JsonKey(name: 'name')
  String name;

  Data(
    this.book,
    this.name,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Book extends Object {
  @JsonKey(name: 'book_id')
  int bookId;

  @JsonKey(name: 'siteid')
  int siteid;

  @JsonKey(name: 'union_type')
  int unionType;

  @JsonKey(name: 'union_id')
  int unionId;

  @JsonKey(name: 'istop')
  int istop;

  @JsonKey(name: 'top_num')
  int topNum;

  @JsonKey(name: 'ordernum')
  int ordernum;

  @JsonKey(name: 'version_filter')
  int versionFilter;

  @JsonKey(name: 'version_num')
  String versionNum;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'config')
  Config config;

  @JsonKey(name: 'bookcomic_order')
  int bookcomicOrder;

  @JsonKey(name: 'bookcomic_imgstyle')
  int bookcomicImgstyle;

  @JsonKey(name: 'advertise_location')
  String advertiseLocation;

  @JsonKey(name: 'advertise_sdktype')
  String advertiseSdktype;

  @JsonKey(name: 'book_datasource')
  String bookDatasource;

  @JsonKey(name: 'book_intellrecommend')
  String bookIntellrecommend;

  @JsonKey(name: 'comic_info')
  List<Comic_info> comicInfo;

  Book(
    this.bookId,
    this.siteid,
    this.unionType,
    this.unionId,
    this.istop,
    this.topNum,
    this.ordernum,
    this.versionFilter,
    this.versionNum,
    this.title,
    this.config,
    this.bookcomicOrder,
    this.bookcomicImgstyle,
    this.advertiseLocation,
    this.advertiseSdktype,
    this.bookDatasource,
    this.bookIntellrecommend,
    this.comicInfo,
  );

  factory Book.fromJson(Map<String, dynamic> srcJson) =>
      _$BookFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

@JsonSerializable()
class Config extends Object {
  @JsonKey(name: 'display_type')
  int displayType;

  @JsonKey(name: 'isautoslide')
  int isautoslide;

  @JsonKey(name: 'isshowtitle')
  int isshowtitle;

  @JsonKey(name: 'horizonratio')
  String horizonratio;

  @JsonKey(name: 'interwidth')
  int interwidth;

  @JsonKey(name: 'outerwidth')
  int outerwidth;

  @JsonKey(name: 'order_type')
  int orderType;

  @JsonKey(name: 'isshowchange')
  int isshowchange;

  @JsonKey(name: 'isshowdetail')
  int isshowdetail;

  @JsonKey(name: 'isshowmore')
  int isshowmore;

  Config(
    this.displayType,
    this.isautoslide,
    this.isshowtitle,
    this.horizonratio,
    this.interwidth,
    this.outerwidth,
    this.orderType,
    this.isshowchange,
    this.isshowdetail,
    this.isshowmore,
  );

  factory Config.fromJson(Map<String, dynamic> srcJson) =>
      _$ConfigFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}

@JsonSerializable()
class Comic_info extends Object {
  @JsonKey(name: 'comic_id')
  int comicId;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'comic_name')
  String comicName;

  @JsonKey(name: 'total_view_num')
  dynamic totalViewNum; // total_view_num 可能是int 或者 String

  @JsonKey(name: 'update_time')
  String updateTime;

  @JsonKey(name: 'score')
  dynamic score; // score 可能是int 或者 String

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'img_url')
  String imgUrl;

  @JsonKey(name: 'last_comic_chapter_name')
  String lastComicChapterName;

  @JsonKey(name: 'ordernum')
  int ordernum;

  @JsonKey(name: 'comic_type')
  List<String> comicType;

  Comic_info(
    this.comicId,
    this.content,
    this.comicName,
    this.totalViewNum,
    this.updateTime,
    this.score,
    this.url,
    this.imgUrl,
    this.lastComicChapterName,
    this.ordernum,
    this.comicType,
  );

  factory Comic_info.fromJson(Map<String, dynamic> srcJson) =>
      _$Comic_infoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Comic_infoToJson(this);
}
