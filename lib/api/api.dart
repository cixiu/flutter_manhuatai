import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

import './http.dart';
import 'package:flutter_manhuatai/models/recommend_list.dart' as RecommendList;
import 'package:flutter_manhuatai/models/rank_list.dart' as RankList;

class Api {
  /// 获取首页的推荐推荐列表数据
  static Future<Map<String, dynamic>> getRecommentList() async {
    final String url =
        'https://cms-booklist.321mh.com/api/v1/bookList/getBookByType';

    Map<String, dynamic> response = await HttpRequest.get(url, params: {
      'page': 1,
      'pagesize': 20,
      'pytype': '',
      'booktype': 132,
      'platform': 8,
      'platformname': 'android',
      'productname': 'mht'
    });
    return response;
  }

  /// 获取首页的排行列表
  static Future<Map<String, dynamic>> getRankList() async {
    final String url =
        'https://rankdata-globalapi.321mh.com/app_api/v1/comic/getIndexRankData/';

    Map<String, dynamic> response = await HttpRequest.get(url, params: {
      'platformname': 'android',
      'productname': 'mht',
    });
    return response;
  }

  /// 获取短信验证码
  static Future<Map<String, dynamic>> sendSms({
    String mobile,
    String imgCode,
    String refresh = '1',
  }) async {
    final String url = 'https://sms.321mh.com/user/v1/sendsms';

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: {
        'mobile': mobile ?? '',
        'imgCode': imgCode ?? '',
        'refresh': refresh,
        'localtime': DateTime.now().millisecondsSinceEpoch,
        'countryCode': '',
        'service': 'mht',
        'productname': 'mht',
        'client-type': 'android',
        'platformname': 'android',
      },
      options: Options(
        contentType: ContentType.parse('application/x-www-form-urlencoded'),
      ),
    );

    return response;
  }

  /// 验证手机短信验证码
  static Future<Map<String, dynamic>> mobileBind({
    String mobile,
    String vcode,
  }) async {
    final String url = 'https://mkxq.zymk.cn/user/v1/mobilebind/';

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: {
        'mobile': mobile ?? '',
        'vcode': vcode ?? '',
        'localtime': DateTime.now().millisecondsSinceEpoch,
        'productname': 'mht',
        'client-type': 'android',
        'platformname': 'android',
      },
      options: Options(
        contentType: ContentType.parse('application/x-www-form-urlencoded'),
      ),
    );

    return response;
  }
}
