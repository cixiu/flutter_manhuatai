import 'package:flutter_manhuatai/models/recommend_list.dart' as RecommendList;
import 'package:flutter_manhuatai/common/const/app_const.dart';

class Utils {
  // 计算图片的显示规格，通过 16:9 形式的字符串，计算成一个数字比例
  static double computedRatio(String horizonRatio) {
    List<String> ratioList = horizonRatio.split(':');
    int widthRatio = int.parse(ratioList[0]);
    int heightRatio = int.parse(ratioList[1]);

    return widthRatio / heightRatio;
  }

  // 将 3:4 格式的 horizonratio 转成 3x4 格式

  // 拼接图片的url
  static formatBookImgUrl(
      {RecommendList.Comic_info comicInfo, RecommendList.Config config, String customHorizonratio, bool useDefalut = false}) {
    // double ratio =computedRatio(book.config.horizonratio);
    String horizonratio = customHorizonratio != null ? customHorizonratio : config.horizonratio;
    List<String> ratioList = horizonratio.split(':');
    int widthRatio = int.parse(ratioList[0]);
    int heightRatio = int.parse(ratioList[1]);

    if (comicInfo.imgUrl != '') {
      return '${AppConst.img_host}/${comicInfo.imgUrl}${AppConst.imageSizeSuffix.defaultSuffix}';
    } else {
      // 强制使用defaultSuffix
      if (useDefalut) {
        return '${AppConst.img_host}/mh/${comicInfo.comicId}.jpg${AppConst.imageSizeSuffix.defaultSuffix}';
      }

      if (widthRatio / heightRatio == 2.0) {
        return '${AppConst.img_host}/mh/${comicInfo.comicId}_2_1.jpg${AppConst.imageSizeSuffix.m2x1}';
      } else {
        String suffixString = 'm${widthRatio}x$heightRatio';
        return '${AppConst.img_host}/mh/${comicInfo.comicId}.jpg${AppConst.imageSizeSuffixMap[suffixString]}';
      }
    }
  }
}
