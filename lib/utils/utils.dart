import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter_manhuatai/common/model/task_info.dart';
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
  static formatBookImgUrl({
    RecommendList.Comic_info comicInfo,
    RecommendList.Config config,
    String customHorizonratio,
    bool useDefalut = false,
  }) {
    // double ratio =computedRatio(book.config.horizonratio);
    String horizonratio =
        customHorizonratio != null ? customHorizonratio : config.horizonratio;
    List<String> ratioList = horizonratio.split(':');
    int widthRatio = int.parse(ratioList[0]);
    int heightRatio = int.parse(ratioList[1]);

    // 判断是否是动态漫
    // if (comicInfo.anim_cover_image)

    if (comicInfo.imgUrl != null && comicInfo.imgUrl != '') {
      return '${AppConst.cmsHost}/${comicInfo.imgUrl}${AppConst.imageSizeSuffix.defaultSuffix}';
    } else {
      // 强制使用defaultSuffix
      if (useDefalut) {
        return '${AppConst.imgNewHost}/mh/${comicInfo.comicId}.jpg${AppConst.imageSizeSuffix.defaultSuffix}';
      }

      if (widthRatio / heightRatio == 2.0) {
        return '${AppConst.imgNewHost}/mh/${comicInfo.comicId}_2_1.jpg${AppConst.imageSizeSuffix.m2x1}';
      } else {
        String suffixString = 'm${widthRatio}x$heightRatio';
        return '${AppConst.imgNewHost}/mh/${comicInfo.comicId}.jpg${AppConst.imageSizeSuffixMap[suffixString]}';
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
    String imgHost = AppConst.imgNewHost;

    List<String> ratioList = aspectRatio.split(':');
    int widthRatio = int.parse(ratioList[0]);
    int heightRatio = int.parse(ratioList[1]);

    String size = 'm${widthRatio}x$heightRatio';
    String suffix = AppConst.imageSizeSuffixMap[size];

    String imgUrl;

    if (type == 'head') {
      imgHost = AppConst.userHeadImgHost;
      imgHost = '$imgHost/kmh_user_head';
      size = 'head';
      suffix = AppConst.imageSizeSuffixMap[size];

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

    return '${date.year}年第$week周';
  }

  static String fromNow(int timestamp, [pattern = 'yyyy-MM-dd']) {
    if (timestamp == null) return '';
    String timestampString = timestamp.toString().padRight(13, '0');
    timestamp = int.parse(timestampString);
    int diff = DateTime.now().millisecondsSinceEpoch - timestamp;
    double seconds = diff / 1000;
    if (seconds < 60) {
      return '刚刚';
    }

    double minutes = seconds / 60;
    if (minutes < 60) {
      return '${minutes.floor()}分钟前';
    }

    double hours = minutes / 60;
    if (hours >= 1 && hours <= 24) {
      return '${hours.floor()}小时前';
    }

    double days = hours / 24;
    if (days >= 1 && days <= 2) {
      return '昨天';
    }

    if (days > 2 && days <= 7) {
      return '${days.floor()}' + '天前';
    }

    return formatDate(timestamp, pattern);
  }

  /// 获取deviceId
  static Future<String> getDeviceId() async {
    String deviceid = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceid = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceid = iosInfo.identifierForVendor;
    }

    return deviceid;
  }

  /// 获取今天的开始和结束的时间戳
  static List<int> getTodayStartAndEndTimeStamp() {
    List<int> list = List();
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    int day = DateTime.now().day;
    String monthString = month.toString().padLeft(2, '0');
    String dayString = day.toString().padLeft(2, '0');
    String todayStartFormatString = '$year-$monthString-$dayString 00:00:00';
    String todayEndFormatString = '$year-$monthString-$dayString 23:59:59';
    // 今天开始的时间戳
    int todayStartTime =
        DateTime.tryParse(todayStartFormatString).millisecondsSinceEpoch;
    // 今天结束的时间戳
    int todayEndTime =
        DateTime.tryParse(todayEndFormatString).millisecondsSinceEpoch;

    list..add(todayStartTime)..add(todayEndTime);
    return list;
  }

  /// 获取本周的开始时间和结束时间的时间戳
  static List<int> getWeekStartAndEndTimeStamp() {
    List<int> list = List();

    int daysPerWeek = DateTime.daysPerWeek;
    // 今天是周几
    int today = DateTime.now().weekday;
    // 一天的 milliseconds = 24 * 60 * 60 * 1000
    int unitMilliseconds = 86400000;
    // 今天与周一相差的天数
    int diffStart = today - 1;
    // 今天与周日相差的天数
    int diffEnd = daysPerWeek - today;

    var todayTimeStamps = getTodayStartAndEndTimeStamp();

    list
      ..add(
        todayTimeStamps.first - unitMilliseconds * diffStart,
      )
      ..add(
        todayTimeStamps.last + unitMilliseconds * diffEnd,
      );
    return list;
  }

  // 任务是否完成
  static hasFinishedAward({
    Task task,
    Action_awards award,
  }) {
    bool flag = true;
    int lastFinishTime = award.lastFinishTime;

    // 一次行的任务或者限时性任务
    if (task.timeSpanUnit == 'total') {
      if (lastFinishTime == 0) {
        flag = false;
      }
      return flag;
    }
    // 每周更新的任务
    if (task.timeSpanUnit == 'week') {
      var times = Utils.getWeekStartAndEndTimeStamp();
      int startTime = times.first;
      // 如果 lastFinishTime 小于 本周的开始时间
      // 那么这个任务一定还没有完成
      if (lastFinishTime < startTime) {
        flag = false;
      }
      return flag;
    }
    // 每日更新的任务
    if (task.timeSpanUnit == 'day') {
      var times = Utils.getTodayStartAndEndTimeStamp();
      int startTime = times.first;
      // 如果 lastFinishTime 小于 今天的开始时间
      // 那么这个任务一定还没有完成
      if (lastFinishTime < startTime) {
        flag = false;
      }
      return flag;
    }
    // 小时的奖励
    if (task.timeSpanUnit == 'hour') {
      bool flag = true;
      int nowTime = DateTime.now().millisecondsSinceEpoch;
      // 如果 现在时间 - lastFinishTime 大于 1小时
      // 那么这个任务一定还没有完成
      if (nowTime - lastFinishTime > 60 * 60 * 1000) {
        flag = false;
      }
      return flag;
    }
    return false;
  }
}
