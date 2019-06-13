import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:flutter_manhuatai/models/book_list.dart' as RecommendList;
import 'package:flutter_manhuatai/common/const/app_const.dart';

class Utils {
  // 计算图片的显示规格，通过 16:9 形式的字符串，计算成一个数字比例
  static double computedRatio(String horizonRatio) {
    List<String> ratioList = horizonRatio.split(':');
    int widthRatio = int.parse(ratioList[0]);
    int heightRatio = int.parse(ratioList[1]);

    return widthRatio / heightRatio;
  }

  // 拼接图片的url
  static formatBookImgUrl(
      {RecommendList.Comic_info comicInfo,
      RecommendList.Config config,
      String customHorizonratio,
      bool useDefalut = false}) {
    // double ratio =computedRatio(book.config.horizonratio);
    String horizonratio =
        customHorizonratio != null ? customHorizonratio : config.horizonratio;
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

  // 将数字转化为相应的单位
  /// 100000以下不转换，100000以上转为以“万”为单位，超过1亿的转为以“亿”为单位
  static String formatNumber(String numberString) {
    String resultNumber;
    int number = num.parse(numberString);
    const WAN = 10000;
    const TEN_WAN = WAN * 10;
    const YI = 100000000;

    // 如果数字小于100000 直接返回
    if (number < TEN_WAN) {
      resultNumber = numberString;
    }

    // 如果数字 100000 < number < 100000000  返回 以“万”为单位
    if (number > TEN_WAN && number < YI) {
      double ratioWan = number / WAN;
      if (ratioWan >= 100) {
        resultNumber = '${ratioWan.floor()}万';
      } else {
        resultNumber = '${ratioWan.toStringAsFixed(1)}万';
      }
    }

    // 如果 number > 100000000  返回 以“亿”为单位
    if (number > YI) {
      double ratioYi = number / YI;
      if (ratioYi >= 100) {
        resultNumber = '${ratioYi.floor()}亿';
      } else {
        resultNumber = '${ratioYi.toStringAsFixed(1)}亿';
      }
    }

    return resultNumber;
  }

  /// 同过id 比如漫画的id, 粉丝的id等拼凑图片的url
  ///
  /// 使用示例
  /// ```
  /// generateImgUrlFromId(id: 123, aspectRatio:'1:1', type: 'head') // https://image.mhxk.com/file/kanmanhua_images/head/000/123/456.jgp-100x100.jpg.webp
  /// ```
  static String generateImgUrlFromId({
    @required int id,
    @required String aspectRatio,
    String type,
  }) {
    String imgHost = AppConst.img_host;

    List<String> ratioList = aspectRatio.split(':');
    int widthRatio = int.parse(ratioList[0]);
    int heightRatio = int.parse(ratioList[1]);

    String size = 'm${widthRatio}x$heightRatio';
    String suffix = AppConst.imageSizeSuffixMap[size];

    String imgUrl;

    if (type == 'head') {
      imgHost = '$imgHost/file/kanmanhua_images/head';
      const int Len = 9;

      // 将id补0至9位数  123456 => 000123456
      String idStr = id.toString().padLeft(Len, '0');
      // 将补0后的字符串数字切成千分位 截取成 000,123,456
      String idFirst = idStr.substring(0, 3);
      String idSecond = idStr.substring(3, 6);
      String idThrid = idStr.substring(6, 9);

      imgUrl = '$imgHost/$idFirst/$idSecond/$idThrid.jpg$suffix';
    } else {
      if (size == 'm2x1') {
        imgUrl = '$imgHost/mh/${id}_2_1.jpg$suffix';
      } else {
        imgUrl = '$imgHost/mh/$id.jpg$suffix';
      }
    }

    return imgUrl;
  }

  // 格式化时间
  static String formatDate(int timestamp, [pattern = 'yyyy.MM.dd']) {
    // 将小于 13 位的时间戳补 0 为 13 位数字的时间戳
    var timestampString = timestamp.toString().padRight(13, '0');
    var dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestampString));

    return DateFormat(pattern).format(dateTime);
  }

  /// 获取当前时间在这一年是第几周 -- ISO 8601 标准
  ///
  /// 第一个日历星期有以下四种等效说法：
  ///
  ///  1，本年度第一个星期四所在的星期；
  ///
  ///  2，1月4日所在的星期；
  ///
  ///  3，本年度第一个至少有4天在同一星期内的星期；
  ///
  ///  4，星期一在去年12月29日至今年1月4日以内的星期；
  static String getWeek([DateTime date]) {
    // 获取当前date的时间
    date = date ?? DateTime.now();

    // 设置当前时间本周星期四的日期
    var targetThursday =
        DateTime(date.year, date.month, date.day - (date.weekday + 6) % 7 + 3);

    // 获取本年度的1月4日的时间
    var firstThursday = DateTime(targetThursday.year, 1, 4);

    // 设置本年度的1月4日所在周的星期四的日期 作为本年度的第一周开始日期
    firstThursday = DateTime(firstThursday.year, firstThursday.month,
        firstThursday.day - (firstThursday.weekday + 6) % 7 + 3);

    // 检查当前时间星期四所在周的时区 与 本年度1月4日所在周的星期四的时区差
    var ds = targetThursday.timeZoneOffset.inHours -
        firstThursday.timeZoneOffset.inHours;

    targetThursday = DateTime(targetThursday.year, targetThursday.month,
        targetThursday.day, targetThursday.hour - ds);

    // 当前时间星期四所在周的时间与本年度1月4日所在周的星期四的时间差
    var weekDiff = (targetThursday.difference(firstThursday).inDays) / 7;
    var week = 1 + weekDiff.floor();

    return '${date.year}年第${week}周';
  }
}
