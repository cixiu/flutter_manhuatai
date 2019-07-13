import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_manhuatai/common/model/satellite.dart';

part 'user_follow_line.g.dart';

@JsonSerializable()
class UserFollowLine extends Object {
  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  UserFollowLine(
    this.data,
    this.status,
    this.msg,
  );

  factory UserFollowLine.fromJson(Map<String, dynamic> srcJson) =>
      _$UserFollowLineFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserFollowLineToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'create_time')
  int createTime;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'target_id')
  int targetId;

  @JsonKey(name: 'source_id')
  int sourceId;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'target_user_id')
  int targetUserId;

  @JsonKey(name: 'satellite')
  Satellite satellite;

  Data(
    this.userId,
    this.createTime,
    this.type,
    this.targetId,
    this.sourceId,
    this.status,
    this.targetUserId,
    this.satellite,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

// @JsonSerializable()
// class Satellite extends Object {
//   @JsonKey(name: 'id')
//   int id;

//   @JsonKey(name: 'appid')
//   int appid;

//   @JsonKey(name: 'starid')
//   int starid;

//   @JsonKey(name: 'title')
//   String title;

//   @JsonKey(name: 'content')
//   String content;

//   @JsonKey(name: 'usertype')
//   int usertype;

//   @JsonKey(name: 'noticetype')
//   int noticetype;

//   @JsonKey(name: 'useridentifier')
//   int useridentifier;

//   @JsonKey(name: 'username')
//   String username;

//   @JsonKey(name: 'supportnum')
//   int supportnum;

//   @JsonKey(name: 'istop')
//   int istop;

//   @JsonKey(name: 'iselite')
//   int iselite;

//   @JsonKey(name: 'images')
//   String images;

//   @JsonKey(name: 'replynum')
//   int replynum;

//   @JsonKey(name: 'createtime')
//   int createtime;

//   @JsonKey(name: 'updatetime')
//   int updatetime;

//   @JsonKey(name: 'status')
//   int status;

//   @JsonKey(name: 'ishot')
//   int ishot;

//   @JsonKey(name: 'contentlength')
//   int contentlength;

//   @JsonKey(name: 'iswater')
//   int iswater;

//   @JsonKey(name: 'starid_list')
//   List<int> staridList;

//   @JsonKey(name: 'productlineid_list')
//   String productlineidList;

//   @JsonKey(name: 'topic_list')
//   dynamic topicList;

//   @JsonKey(name: 'is_recommend')
//   int isRecommend;

//   @JsonKey(name: 'location')
//   String location;

//   @JsonKey(name: 'lng_lat')
//   String lngLat;

//   @JsonKey(name: 'show_title')
//   int showTitle;

//   @JsonKey(name: 'title_color')
//   String titleColor;

//   @JsonKey(name: 'device_tail')
//   String deviceTail;

//   @JsonKey(name: 'view_count')
//   int viewCount;

//   @JsonKey(name: 'stars')
//   List<Stars> stars;

//   @JsonKey(name: 'topics')
//   List<dynamic> topics;

//   @JsonKey(name: 'isfollow')
//   int isfollow;

//   @JsonKey(name: 'share_url')
//   String shareUrl;

//   @JsonKey(name: 'ulevel')
//   int ulevel;

//   @JsonKey(name: 'view_keywords')
//   int viewKeywords;

//   @JsonKey(name: 'issupport')
//   int issupport;

//   Satellite(
//     this.id,
//     this.appid,
//     this.starid,
//     this.title,
//     this.content,
//     this.usertype,
//     this.noticetype,
//     this.useridentifier,
//     this.username,
//     this.supportnum,
//     this.istop,
//     this.iselite,
//     this.images,
//     this.replynum,
//     this.createtime,
//     this.updatetime,
//     this.status,
//     this.ishot,
//     this.contentlength,
//     this.iswater,
//     this.staridList,
//     this.productlineidList,
//     this.topicList,
//     this.isRecommend,
//     this.location,
//     this.lngLat,
//     this.showTitle,
//     this.titleColor,
//     this.deviceTail,
//     this.viewCount,
//     this.stars,
//     this.topics,
//     this.isfollow,
//     this.shareUrl,
//     this.ulevel,
//     this.viewKeywords,
//     this.issupport,
//   );

//   factory Satellite.fromJson(Map<String, dynamic> srcJson) =>
//       _$SatelliteFromJson(srcJson);

//   Map<String, dynamic> toJson() => _$SatelliteToJson(this);
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
