import 'package:json_annotation/json_annotation.dart';

part 'get_book_info_by_id.g.dart';

@JsonSerializable()
class GetBookInfoById extends Object {
  @JsonKey(name: 'data')
  Data data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'message')
  String message;

  GetBookInfoById(
    this.data,
    this.status,
    this.message,
  );

  factory GetBookInfoById.fromJson(Map<String, dynamic> srcJson) =>
      _$GetBookInfoByIdFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GetBookInfoByIdToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'book_id')
  int bookId;

  @JsonKey(name: 'book_name')
  String bookName;

  @JsonKey(name: 'summary')
  String summary;

  @JsonKey(name: 'shoucang')
  int shoucang;

  @JsonKey(name: 'share')
  int share;

  @JsonKey(name: 'createtime')
  String createtime;

  @JsonKey(name: 'updatetime')
  String updatetime;

  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'img_url')
  String imgUrl;

  @JsonKey(name: 'share_title')
  String shareTitle;

  @JsonKey(name: 'share_summary')
  String shareSummary;

  @JsonKey(name: 'book_list')
  List<Book_list> bookList;

  Data(
    this.bookId,
    this.bookName,
    this.summary,
    this.shoucang,
    this.share,
    this.createtime,
    this.updatetime,
    this.userId,
    this.imgUrl,
    this.shareTitle,
    this.shareSummary,
    this.bookList,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Book_list extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'comic_name')
  String comicName;

  @JsonKey(name: 'product_id')
  int productId;

  @JsonKey(name: 'comic_feature')
  String comicFeature;

  @JsonKey(name: 'load_type')
  int loadType;

  @JsonKey(name: 'img_url')
  String imgUrl;

  @JsonKey(name: 'nofollow')
  int nofollow;

  @JsonKey(name: 'sort_num')
  int sortNum;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'comic_id')
  int comicId;

  @JsonKey(name: 'page_id')
  int pageId;

  @JsonKey(name: 'isdisable')
  int isdisable;

  @JsonKey(name: 'comic_type')
  List<String> comicType;

  @JsonKey(name: 'cartoon_name')
  String cartoonName;

  @JsonKey(name: 'new_cartoon_id')
  String newCartoonId;

  @JsonKey(name: 'new_cartoon_name')
  String newCartoonName;

  @JsonKey(name: 'author_name')
  String authorName;

  @JsonKey(name: 'total_view_num')
  String totalViewNum;

  @JsonKey(name: 'comic_newid')
  String comicNewid;

  @JsonKey(name: 'latest_cartoon_topic_id')
  String latestCartoonTopicId;

  @JsonKey(name: 'cartoon_desc')
  String cartoonDesc;

  @JsonKey(name: 'cartoon_topic_name')
  String cartoonTopicName;

  @JsonKey(name: 'chapter_feature')
  String chapterFeature;

  @JsonKey(name: 'font_color')
  String fontColor;

  @JsonKey(name: 'font_size')
  int fontSize;

  @JsonKey(name: 'border_color')
  String borderColor;

  @JsonKey(name: 'border_size')
  int borderSize;

  @JsonKey(name: 'feature_position')
  int featurePosition;

  @JsonKey(name: 'chapter_image_addr')
  String chapterImageAddr;

  @JsonKey(name: 'cartoon_status')
  int cartoonStatus;

  @JsonKey(name: 'update_time')
  String updateTime;

  Book_list(
    this.id,
    this.comicName,
    this.productId,
    this.comicFeature,
    this.loadType,
    this.imgUrl,
    this.nofollow,
    this.sortNum,
    this.url,
    this.comicId,
    this.pageId,
    this.isdisable,
    this.comicType,
    this.cartoonName,
    this.newCartoonId,
    this.newCartoonName,
    this.authorName,
    this.totalViewNum,
    this.comicNewid,
    this.latestCartoonTopicId,
    this.cartoonDesc,
    this.cartoonTopicName,
    this.chapterFeature,
    this.fontColor,
    this.fontSize,
    this.borderColor,
    this.borderSize,
    this.featurePosition,
    this.chapterImageAddr,
    this.cartoonStatus,
    this.updateTime,
  );

  factory Book_list.fromJson(Map<String, dynamic> srcJson) =>
      _$Book_listFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Book_listToJson(this);
}
