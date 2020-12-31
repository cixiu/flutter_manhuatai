import 'package:json_annotation/json_annotation.dart';

part 'comic_info_influence.g.dart';


@JsonSerializable()
  class ComicInfoInfluence extends Object {

  @JsonKey(name: 'data')
  Data data;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'msg')
  String msg;

  ComicInfoInfluence(this.data,this.status,this.msg,);

  factory ComicInfoInfluence.fromJson(Map<String, dynamic> srcJson) => _$ComicInfoInfluenceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ComicInfoInfluenceToJson(this);

}


@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'out_list')
  List<int> outList;

  @JsonKey(name: 'insider_list')
  List<Insider_list> insiderList;

  @JsonKey(name: 'call_data')
  Call_data callData;

  Data(this.outList,this.insiderList,this.callData,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}


@JsonSerializable()
  class Insider_list extends Object {

  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'counts')
  int counts;

  @JsonKey(name: 'Uname')
  String uname;

  @JsonKey(name: 'level')
  int level;

  @JsonKey(name: 'isvip')
  int isvip;

  Insider_list(this.uid,this.counts,this.uname,this.level,this.isvip,);

  factory Insider_list.fromJson(Map<String, dynamic> srcJson) => _$Insider_listFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Insider_listToJson(this);

}


@JsonSerializable()
  class Call_data extends Object {

  @JsonKey(name: 'show_call')
  bool showCall;

  @JsonKey(name: 'copyright_type')
  int copyrightType;

  @JsonKey(name: 'default_price')
  int defaultPrice;

  @JsonKey(name: 'show_bonus')
  bool showBonus;

  @JsonKey(name: 'pv')
  String pv;

  @JsonKey(name: 'uv')
  String uv;

  @JsonKey(name: 'collect')
  String collect;

  @JsonKey(name: 'share')
  String share;

  @JsonKey(name: 'comment')
  String comment;

  @JsonKey(name: 'reward')
  String reward;

  @JsonKey(name: 'gift')
  String gift;

  @JsonKey(name: 'ticket')
  String ticket;

  @JsonKey(name: 'recommend')
  String recommend;

  @JsonKey(name: 'score')
  String score;

  @JsonKey(name: 'currmon_bonus')
  int currmonBonus;

  @JsonKey(name: 'lastmon_bonus')
  int lastmonBonus;

  @JsonKey(name: 'thisweek_heat')
  String thisweekHeat;

  @JsonKey(name: 'thisweek_heat_rank')
  int thisweekHeatRank;

  @JsonKey(name: 'uprise_rank')
  int upriseRank;

  @JsonKey(name: 'thistotal_heat')
  String thistotalHeat;

  @JsonKey(name: 'thistotal_heat_rank')
  int thistotalHeatRank;

  Call_data(this.showCall,this.copyrightType,this.defaultPrice,this.showBonus,this.pv,this.uv,this.collect,this.share,this.comment,this.reward,this.gift,this.ticket,this.recommend,this.score,this.currmonBonus,this.lastmonBonus,this.thisweekHeat,this.thisweekHeatRank,this.upriseRank,this.thistotalHeat,this.thistotalHeatRank,);

  factory Call_data.fromJson(Map<String, dynamic> srcJson) {
    if (srcJson['pv'] == null || srcJson['pv'] == 0) {
      return _$Call_dataFromJson({});
    }
    return _$Call_dataFromJson(srcJson);
  }

  Map<String, dynamic> toJson() => _$Call_dataToJson(this);

}


