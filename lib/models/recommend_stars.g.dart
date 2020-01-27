// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_stars.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendStars _$RecommendStarsFromJson(Map<String, dynamic> json) {
  return RecommendStars(
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['status'] as int,
    json['msg'] as String,
  );
}

Map<String, dynamic> _$RecommendStarsToJson(RecommendStars instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'msg': instance.msg,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['target_id'] as int,
    json['target_name'] as String,
    json['isfollow'] as int,
    json['target_desc'] as String,
    json['image'] as String,
    json['focusnum'] as int,
    json['satellitenum'] as int,
    json['is_compel'] as int,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'target_id': instance.targetId,
      'target_name': instance.targetName,
      'isfollow': instance.isfollow,
      'target_desc': instance.targetDesc,
      'image': instance.image,
      'focusnum': instance.focusnum,
      'satellitenum': instance.satellitenum,
      'is_compel': instance.isCompel,
    };
