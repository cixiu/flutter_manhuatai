import 'package:json_annotation/json_annotation.dart';
import './book_list.dart';
export './book_list.dart';

// part 'book_list_by_comic_id.g.dart';

@JsonSerializable()
class BookListByComicId extends Object {
  @JsonKey(name: 'data')
  List<Book> data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'message')
  String message;

  BookListByComicId(
    this.data,
    this.status,
    this.message,
  );

  // factory BookListByComicId.fromJson(Map<String, dynamic> srcJson) =>
  //     _$BookListByComicIdFromJson(srcJson);
  factory BookListByComicId.fromJson(Map<String, dynamic> srcJson) =>
      BookListByComicId(
          (srcJson['data'] as List)
              ?.map((e) =>
                  e == null ? null : Book.fromJson(e as Map<String, dynamic>))
              ?.toList(),
          srcJson['status'] as int,
          srcJson['message'] as String);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': this.data,
        'status': this.status,
        'message': this.message
      };
}

// @JsonSerializable()
// class Data extends Object {
//   @JsonKey(name: 'book_id')
//   int bookId;

//   @JsonKey(name: 'siteid')
//   int siteid;

//   @JsonKey(name: 'union_type')
//   int unionType;

//   @JsonKey(name: 'union_id')
//   int unionId;

//   @JsonKey(name: 'istop')
//   int istop;

//   @JsonKey(name: 'top_num')
//   int topNum;

//   @JsonKey(name: 'ordernum')
//   int ordernum;

//   @JsonKey(name: 'version_filter')
//   int versionFilter;

//   @JsonKey(name: 'version_num')
//   String versionNum;

//   @JsonKey(name: 'title')
//   String title;

//   @JsonKey(name: 'config')
//   Config config;

//   @JsonKey(name: 'bookcomic_order')
//   int bookcomicOrder;

//   @JsonKey(name: 'bookcomic_imgstyle')
//   int bookcomicImgstyle;

//   @JsonKey(name: 'advertise_location')
//   String advertiseLocation;

//   @JsonKey(name: 'advertise_sdktype')
//   String advertiseSdktype;

//   @JsonKey(name: 'book_datasource')
//   String bookDatasource;

//   @JsonKey(name: 'book_intellrecommend')
//   String bookIntellrecommend;

//   @JsonKey(name: 'comic_info')
//   List<Comic_info> comicInfo;

//   Data(
//     this.bookId,
//     this.siteid,
//     this.unionType,
//     this.unionId,
//     this.istop,
//     this.topNum,
//     this.ordernum,
//     this.versionFilter,
//     this.versionNum,
//     this.title,
//     this.config,
//     this.bookcomicOrder,
//     this.bookcomicImgstyle,
//     this.advertiseLocation,
//     this.advertiseSdktype,
//     this.bookDatasource,
//     this.bookIntellrecommend,
//     this.comicInfo,
//   );

//   factory Data.fromJson(Map<String, dynamic> srcJson) =>
//       _$DataFromJson(srcJson);

//   Map<String, dynamic> toJson() => _$DataToJson(this);
// }

// @JsonSerializable()
// class Config extends Object {
//   @JsonKey(name: 'display_type')
//   int displayType;

//   @JsonKey(name: 'isautoslide')
//   int isautoslide;

//   @JsonKey(name: 'isshowtitle')
//   int isshowtitle;

//   @JsonKey(name: 'horizonratio')
//   String horizonratio;

//   @JsonKey(name: 'interwidth')
//   int interwidth;

//   @JsonKey(name: 'outerwidth')
//   int outerwidth;

//   @JsonKey(name: 'order_type')
//   int orderType;

//   @JsonKey(name: 'isshowchange')
//   int isshowchange;

//   @JsonKey(name: 'isshowdetail')
//   int isshowdetail;

//   @JsonKey(name: 'isshowmore')
//   int isshowmore;

//   @JsonKey(name: 'show_more_url')
//   String showMoreUrl;

//   Config(
//     this.displayType,
//     this.isautoslide,
//     this.isshowtitle,
//     this.horizonratio,
//     this.interwidth,
//     this.outerwidth,
//     this.orderType,
//     this.isshowchange,
//     this.isshowdetail,
//     this.isshowmore,
//     this.showMoreUrl,
//   );

//   factory Config.fromJson(Map<String, dynamic> srcJson) =>
//       _$ConfigFromJson(srcJson);

//   Map<String, dynamic> toJson() => _$ConfigToJson(this);
// }

// @JsonSerializable()
// class Comic_info extends Object {
//   @JsonKey(name: 'comic_id')
//   int comicId;

//   @JsonKey(name: 'comic_newid')
//   String comicNewid;

//   @JsonKey(name: 'content')
//   String content;

//   @JsonKey(name: 'comic_name')
//   String comicName;

//   @JsonKey(name: 'total_view_num')
//   dynamic totalViewNum;

//   @JsonKey(name: 'update_time')
//   String updateTime;

//   @JsonKey(name: 'score')
//   dynamic score;

//   @JsonKey(name: 'url')
//   String url;

//   @JsonKey(name: 'img_url')
//   String imgUrl;

//   @JsonKey(name: 'last_comic_chapter_name')
//   String lastComicChapterName;

//   @JsonKey(name: 'ordernum')
//   int ordernum;

//   @JsonKey(name: 'comic_type')
//   List<dynamic> comicType;

//   @JsonKey(name: 'cartoon_author_list_name')
//   String cartoonAuthorListName;

//   Comic_info(
//     this.comicId,
//     this.comicNewid,
//     this.content,
//     this.comicName,
//     this.totalViewNum,
//     this.updateTime,
//     this.score,
//     this.url,
//     this.imgUrl,
//     this.lastComicChapterName,
//     this.ordernum,
//     this.comicType,
//     this.cartoonAuthorListName,
//   );

//   factory Comic_info.fromJson(Map<String, dynamic> srcJson) =>
//       _$Comic_infoFromJson(srcJson);

//   Map<String, dynamic> toJson() => _$Comic_infoToJson(this);
// }
