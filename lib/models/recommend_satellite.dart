import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_manhuatai/common/model/satellite.dart';

part 'recommend_satellite.g.dart';

@JsonSerializable()
class RecommendSatellite extends Object {
  @JsonKey(name: 'data')
  Data data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  RecommendSatellite(
    this.data,
    this.status,
    this.msg,
  );

  factory RecommendSatellite.fromJson(Map<String, dynamic> srcJson) =>
      _$RecommendSatelliteFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendSatelliteToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'pager')
  Pager pager;

  @JsonKey(name: 'list')
  List<Satellite> list;

  Data(
    this.pager,
    this.list,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Pager extends Object {
  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'count')
  int count;

  Pager(
    this.page,
    this.count,
  );

  factory Pager.fromJson(Map<String, dynamic> srcJson) =>
      _$PagerFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PagerToJson(this);
}

// @JsonSerializable()
// class List_List extends Object {
//   @JsonKey(name: 'iselite')
//   int iselite;

//   @JsonKey(name: 'starid_list')
//   List<int> staridList;

//   @JsonKey(name: 'iswater')
//   int iswater;

//   @JsonKey(name: 'title')
//   String title;

//   @JsonKey(name: 'content')
//   String content;

//   @JsonKey(name: 'device_tail')
//   String deviceTail;

//   @JsonKey(name: 'istop')
//   int istop;

//   @JsonKey(name: 'id')
//   int id;

//   @JsonKey(name: 'useridentifier')
//   int useridentifier;

//   @JsonKey(name: 'ishot')
//   int ishot;

//   @JsonKey(name: 'starid')
//   int starid;

//   @JsonKey(name: 'images')
//   String images;

//   @JsonKey(name: 'createtime')
//   int createtime;

//   @JsonKey(name: 'title_nod')
//   String titleNod;

//   @JsonKey(name: 'title_color')
//   String titleColor;

//   @JsonKey(name: 'usertype')
//   int usertype;

//   @JsonKey(name: 'lng_lat')
//   String lngLat;

//   @JsonKey(name: 'topic_list')
//   dynamic topicList;

//   @JsonKey(name: 'productlineid_list')
//   String productlineidList;

//   @JsonKey(name: 'circle_order')
//   int circleOrder;

//   @JsonKey(name: 'noticetype')
//   int noticetype;

//   @JsonKey(name: 'show_title')
//   int showTitle;

//   @JsonKey(name: 'appid')
//   int appid;

//   @JsonKey(name: 'images_length')
//   int imagesLength;

//   @JsonKey(name: 'is_recommend')
//   int isRecommend;

//   @JsonKey(name: 'replynum')
//   int replynum;

//   @JsonKey(name: 'location')
//   String location;

//   @JsonKey(name: 'updatetime')
//   int updatetime;

//   @JsonKey(name: 'title_single')
//   String titleSingle;

//   @JsonKey(name: 'view_count')
//   int viewCount;

//   @JsonKey(name: 'username')
//   String username;

//   @JsonKey(name: 'supportnum')
//   int supportnum;

//   @JsonKey(name: 'status')
//   int status;

//   @JsonKey(name: 'contentlength')
//   int contentlength;

//   @JsonKey(name: 'label')
//   String label;

//   @JsonKey(name: 'stars')
//   List<Stars> stars;

//   @JsonKey(name: 'topics')
//   List<dynamic> topics;

//   @JsonKey(name: 'isfollow')
//   int isfollow;

//   @JsonKey(name: 'isvip')
//   int isvip;

//   @JsonKey(name: 'view_keywords')
//   int viewKeywords;

//   @JsonKey(name: 'ulevel')
//   int ulevel;

//   @JsonKey(name: 'issupport')
//   int issupport;

//   @JsonKey(name: 'satellite_label')
//   String satelliteLabel;

//   @JsonKey(name: 'share_url')
//   String shareUrl;

//   List_List(
//     this.iselite,
//     this.staridList,
//     this.iswater,
//     this.title,
//     this.content,
//     this.deviceTail,
//     this.istop,
//     this.id,
//     this.useridentifier,
//     this.ishot,
//     this.starid,
//     this.images,
//     this.createtime,
//     this.titleNod,
//     this.titleColor,
//     this.usertype,
//     this.lngLat,
//     this.topicList,
//     this.productlineidList,
//     this.circleOrder,
//     this.noticetype,
//     this.showTitle,
//     this.appid,
//     this.imagesLength,
//     this.isRecommend,
//     this.replynum,
//     this.location,
//     this.updatetime,
//     this.titleSingle,
//     this.viewCount,
//     this.username,
//     this.supportnum,
//     this.status,
//     this.contentlength,
//     this.label,
//     this.stars,
//     this.topics,
//     this.isfollow,
//     this.isvip,
//     this.viewKeywords,
//     this.ulevel,
//     this.issupport,
//     this.satelliteLabel,
//     this.shareUrl,
//   );

//   factory List_List.fromJson(Map<String, dynamic> srcJson) =>
//       _$List_ListFromJson(srcJson);

//   Map<String, dynamic> toJson() => _$List_ListToJson(this);
// }

// @JsonSerializable()
// class Stars extends Object {
//   @JsonKey(name: 'id')
//   int id;

//   @JsonKey(name: 'name')
//   String name;

//   @JsonKey(name: 'image')
//   String image;

//   Stars(
//     this.id,
//     this.name,
//     this.image,
//   );

//   factory Stars.fromJson(Map<String, dynamic> srcJson) =>
//       _$StarsFromJson(srcJson);

//   Map<String, dynamic> toJson() => _$StarsToJson(this);
// }
