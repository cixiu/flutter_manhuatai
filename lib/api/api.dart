import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_manhuatai/models/rank_data_detials.dart';
import 'package:flutter_manhuatai/models/rank_types.dart';

import './http.dart';

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

  /// 获取用户的信息
  static Future<Map<String, dynamic>> getUserInfo({
    String token,
    String type,
    String deviceid,
    String openid,
    int myuid,
    String autologo,
  }) async {
    final String url =
        'https://getuserinfo-globalapi.yyhao.com/app_api/v5/getuserinfo/';
    var data = {
      'type': 'mkxq',
      'localtime': DateTime.now().millisecondsSinceEpoch,
      'productname': 'mht',
      'client-type': 'android',
      'platformname': 'android',
    };

    if (token != null) {
      data['token'] = token;
    }

    if (type != null) {
      // 如果是游客模式登录，type="device", token="$androidId"
      data['type'] = type;
    }

    if (deviceid != null) {
      data['deviceid'] = deviceid;
    }

    if (openid != null && myuid != null && autologo != null) {
      data['openid'] = openid;
      data['myuid'] = myuid;
      data['autologo'] = autologo;
    }

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: data,
      options: Options(
        contentType: ContentType.parse('application/x-www-form-urlencoded'),
      ),
    );

    return response;
  }

  /// 获取指定漫画的主体信息
  static Future<Map<String, dynamic>> getComicInfoBody({
    @required String comicId,
  }) async {
    final String url =
        'https://getcomicinfo-globalapi.yyhao.com/app_api/v5/getcomicinfo_body/';

    Map<String, dynamic> response = await HttpRequest.get(url, params: {
      'comic_id': comicId,
      'platformname': 'android',
      'productname': 'mht',
    });

    return response;
  }

  /// 获取指定漫画的人气活跃数据
  static Future<Map<String, dynamic>> getComicInfoInfluence({
    @required String comicId,
  }) async {
    final String url =
        'https://comic.321mh.com/app_api/v5/getcomicinfo_influence/';

    Map<String, dynamic> response = await HttpRequest.get(url, params: {
      'comic_id': comicId,
      'rank_type': 'all',
      'platformname': 'android',
      'productname': 'mht',
    });

    return response;
  }

  /// 获取指定漫画的吐槽总数
  static Future<Map<String, dynamic>> getComicCommentCount({
    @required String comicId,
  }) async {
    final String url = 'https://community-hots.321mh.com/comment/count/';

    Map<String, dynamic> response = await HttpRequest.get(url, params: {
      'appId': 2,
      'commentType': 2,
      'ssid': comicId, // 漫画的id
      'ssidType': 0,
    });

    return response;
  }

  /// 获取指定漫画的推荐相关的列表
  static Future<Map<String, dynamic>> getBookByComicId({
    @required String userauth,
    @required String comicId,
  }) async {
    final String url =
        'https://cms-booklist.321mh.com/api/v1/bookList/getBookByComicidNew';

    Map<String, dynamic> response = await HttpRequest.post(url, data: {
      'userauth': userauth,
      'comic_id': comicId,
      'booktype': 'detail',
      'platform': 8,
      'localtime': DateTime.now().millisecondsSinceEpoch,
      'platformname': 'android',
      'productname': 'mht',
    });
    return response;
  }

  /// 获取漫画的作者和角色信息
  static Future<Map<String, dynamic>> getComicInfoRole({
    @required String comicId,
  }) async {
    final String url =
        'https://kanmanapi-main.321mh.com/app_api/v5/getcomicinfo_role/';

    Map<String, dynamic> response = await HttpRequest.get(url, params: {
      'comic_id': comicId, // 漫画的id
      'platformname': 'android',
      'productname': 'mht',
    });

    return response;
  }

  /// 获取排行榜类型
  static Future<RankTypes> getRankTypes() async {
    final String url =
        'https://rankdata-globalapi.321mh.com/app_api/v1/comic/getRankTypes/';

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'platformname': 'android',
        'productname': 'mht',
      },
    );

    return RankTypes.fromJson(response);
  }

  /// 获取排行榜类型的详细信息
  static Future<RankDataDetials> getRankDataDetials({
    @required String sortType,
    String rankType = 'heat',
    String timeType = 'week',
  }) async {
    final String url =
        'https://rankdata-globalapi.321mh.com/app_api/v1/comic/getRankDataDetials/';

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'sort_type': sortType,
        'rank_type': rankType,
        'time_type': timeType,
        'query_time': Utils.formatDate(
          DateTime.now().millisecondsSinceEpoch,
          'yyyy-MM-dd',
        ),
        'product_id': 2,
        'platformname': 'android',
        'productname': 'mht',
      },
    );

    return RankDataDetials.fromJson(response);
  }
}
