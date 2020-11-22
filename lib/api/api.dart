import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/common/model/chapter_info.dart';
import 'package:flutter_manhuatai/common/model/comment_content.dart';
import 'package:flutter_manhuatai/common/model/level_info.dart';
import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/models/book_list.dart' as RecommendList;
import 'package:flutter_manhuatai/models/book_list.dart';
import 'package:flutter_manhuatai/models/comment_user.dart';
import 'package:flutter_manhuatai/models/follow_list.dart';
import 'package:flutter_manhuatai/models/get_book_info_by_id.dart';
import 'package:flutter_manhuatai/models/get_channels_res.dart';
import 'package:flutter_manhuatai/models/get_satellite_res.dart';
import 'package:flutter_manhuatai/models/hot_search.dart';
import 'package:flutter_manhuatai/models/recommend_satellite.dart';
import 'package:flutter_manhuatai/models/recommend_stars.dart';
import 'package:flutter_manhuatai/models/recommend_users.dart';
import 'package:flutter_manhuatai/models/search_author.dart';
import 'package:flutter_manhuatai/models/search_comic.dart';
import 'package:flutter_manhuatai/models/sort_list.dart';
import 'package:flutter_manhuatai/models/topic_hot_list.dart';
import 'package:flutter_manhuatai/models/update_list.dart';
import 'package:flutter_manhuatai/models/user_follow_line.dart';
import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:flutter_manhuatai/models/user_role_info.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import 'package:flutter_manhuatai/utils/utils.dart';
import 'package:flutter_manhuatai/models/rank_data_detials.dart';
import 'package:flutter_manhuatai/models/rank_types.dart';

import './http.dart';

class Api {
  /// 获取首页的推荐推荐列表数据（老版本）
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

  /// 获取首页的推荐推荐列表数据（新版本）
  static Future<RecommendList.BookList> getRecommenNewList({
    @required int userId,
    @required int page,
  }) async {
    final String url =
        'http://recommend.321mh.com/api/v2/booklist/getbookbytype';

    Map<String, dynamic> response = await HttpRequest.get(url, params: {
      'user_id': userId,
      'page': page,
      'pagesize': 10,
      'pytype': '',
      'booktype': 132,
      'platform': 8,
      'platformname': 'android',
      'productname': 'mht'
    });
    if (response['status'] != 0) {
      return RecommendList.BookList.fromJson({});
    }
    return RecommendList.BookList.fromJson(response);
  }

  /// 获取首页的推荐推荐列表数据根据（用户的喜好进行推荐）
  static Future<RecommendList.BookList> getRecommendStreamingList({
    @required int userId,
  }) async {
    final String url =
        'http://recommend.321mh.com/api/v2/booklist/recommendstreamlist';

    Map<String, dynamic> response = await HttpRequest.get(url, params: {
      'user_id': userId,
      'pytype': '',
      'booktype': 132,
      'platform': 8,
      'platformname': 'android',
      'productname': 'mht'
    });
    if (response['status'] != 0) {
      return RecommendList.BookList.fromJson({});
    }
    return RecommendList.BookList.fromJson(response);
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
        contentType: Headers.formUrlEncodedContentType,
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
        contentType: Headers.formUrlEncodedContentType,
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
        contentType: Headers.formUrlEncodedContentType,
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
        'http://comic.321mh.com/app_api/v5/getcomicinfo_influence/';

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
    final String url = 'http://community-hots.321mh.com/comment/count/';

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
        'http://cms-booklist.321mh.com/api/v1/bookList/getBookByComicidNew';

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
        'http://kanmanapi-main.321mh.com/app_api/v5/getcomicinfo_role/';

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

  /// 获取更新列表
  static Future<UpdateList> getUpdateList() async {
    final String url = 'https://comic.321mh.com/app_api/v5/updatelist/';

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'platformname': 'android',
        'productname': 'mht',
      },
    );

    return UpdateList.fromJson(response);
  }

  /// 获取热门搜索列表
  static Future<List<HotSearch>> getHotSearch() async {
    final String url =
        'https://getconfig-globalapi.yyhao.com/app_api/v5/gettopsearch/';

    List<dynamic> response = await HttpRequest.get(
      url,
      params: {
        'platformname': 'android',
        'productname': 'mht',
      },
    );

    return getHotSearchList(response);
  }

  /// 搜索漫画
  static Future<SearchComic> searchComic(String serachKey,
      [int topNumber]) async {
    final String url =
        'https://getconfig-globalapi.yyhao.com/app_api/v5/serachcomic/';

    Map<String, dynamic> params = {
      'serachKey': serachKey,
      'platformname': 'android',
      'productname': 'mht',
    };

    if (topNumber != null) {
      params.addAll({'topNumber': topNumber});
    }

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: params,
    );

    return SearchComic.fromJson(response);
  }

  /// 获取关键词中的漫画列表
  static Future<SortList> getSortList({
    int page = 1,
    int size = 7,
    String orderby = 'click',
    String searchKey,
  }) async {
    final String url =
        'https://getconfig-globalapi.yyhao.com/app_api/v5/getsortlist/';

    Map<String, dynamic> params = {
      'page': page,
      'size': size,
      'orderby': orderby,
      'search_key': searchKey,
      'platformname': 'android',
      'productname': 'mht',
    };

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: params,
    );

    return SortList.fromJson(response);
  }

  /// 获取关键词相关的漫画作者
  static Future<SearchAuthor> searchAuthor({
    int page = 1,
    int size = 10,
    String openid,
    String type,
    String searchKey,
    String authorization,
  }) async {
    final String url = 'https://community-new.321mh.com/v1/user/searchuser';

    Map<String, dynamic> params = {
      'page': page,
      'size': size,
      'openid': openid,
      'type': type,
      'keyword': searchKey,
      'platformname': 'android',
      'productname': 'mht',
    };

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: params,
      options: Options(
        headers: {
          'Authorization': 'Bearer $authorization',
        },
      ),
    );

    return SearchAuthor.fromJson(response);
  }

  /// 获取关键词相关的频道
  static Future<GetChannelsRes> getChannels({
    int userIdentifier,
    int level,
    String keyword,
  }) async {
    final String url = 'https://community-new.321mh.com/star/gets/';

    Map<String, dynamic> params = {
      'userIdentifier': userIdentifier, // 登录用户的id
      'userloglevel': 1,
      'appId': 2,
      'level': level, // 用户的等级
      'siteId': 8,
      'isHot': 0,
      'universeId': 0,
      'isSelf': 0,
      'starId': 0,
      'userId': 0,
      'keyword': keyword,
    };

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: params,
    );

    return GetChannelsRes.fromJson(response);
  }

  /// 获取关键词相关的帖子
  static Future<GetSatelliteRes> getSatellite({
    int userIdentifier,
    int level,
    String keyword,
    int satelliteId = 0,
    int satelliteType = 0,
    int starId = 0,
    int isJoin = 0,
  }) async {
    final String url = 'https://community.321mh.com/satellite/gets/';

    Map<String, dynamic> params = {
      'userIdentifier': userIdentifier,
      'userloglevel': 1,
      'appId': 2,
      'level': level,
      'isWater': -1,
      'siteId': 8,
      'satelliteId': satelliteId,
      'satelliteType': satelliteType,
      'starId': starId,
      'isJoin': isJoin,
      'keyWord': keyword,
    };

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: params,
    );

    return GetSatelliteRes.fromJson(response);
  }

  /// 获取关键词相关的帖子(new)
  static Future<RecommendSatellite> getRelatedSatellite({
    String openid,
    String type,
    String keyword,
    int page = 1,
    int size = 10,
  }) async {
    final String url =
        'http://community-new.321mh.com/satellite/getsatellitebykeyword/';

    Map<String, dynamic> params = {
      'openid': openid,
      'type': type,
      'keyword': keyword,
      'page': page,
      'size': size,
      'productname': 'mht',
      'platformname': 'android',
    };

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: params,
    );

    var data = response['data'];
    if (data is List && data.length == 0) {
      return RecommendSatellite.fromJson({});
    }

    return RecommendSatellite.fromJson(response);
  }

  /// 根据用户的id列表获取用户的列表信息
  static Future<CommentUser> getCommentUser({
    int relationId,
    int opreateType,
    List<int> userids,
  }) async {
    String url = 'https://community-hots.321mh.com/user/commentuser/?appId=2';
    // 规范中如果请求中的 params 是一个 List, 则会被解析成 'key[]: value' 格式，
    // 但是由于这里的后端的api参数并没有按照规范来做，所以这里需要自己拼接成 'key: value'形式加入到 url 中,
    userids.forEach((item) {
      url += '&userids=$item';
    });

    if (relationId != null && opreateType != null) {
      url += '&relationId=$relationId&opreateType=$opreateType';
    }

    Map<String, dynamic> response = await HttpRequest.get(
      url,
    );

    return CommentUser.fromJson(response);
  }

  /// 获取推荐帖子列表中的 banner 数据
  static Future<BookList> getBookByPosition({
    positionId = 7,
  }) async {
    final String url =
        'https://cms-booklist.321mh.com/api/v1/bookList/getBookByPosition';

    Map<String, dynamic> response = await HttpRequest.get(url, params: {
      'position_id': positionId,
      'page': 1,
      'pagesize': 20,
      'platformname': 'android',
      'productname': 'mht'
    });
    return BookList.fromJson(response);
  }

  /// 获取推荐帖子列表中的圈子
  static Future<RecommendStars> getRecommendStars({
    String type = 'mkxq',
    String openid,
    String authorization,
  }) async {
    final String url =
        'http://community-new.321mh.com/v1/banner/getrecommendstars';

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: {
        'type': type,
        'openid': openid,
        'localtime': DateTime.now().millisecondsSinceEpoch,
        'platformname': 'android',
        'productname': 'mht',
        'client-version': '2.0.2'
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          HttpHeaders.authorizationHeader: '$authorization',
        },
      ),
    );
    return RecommendStars.fromJson(response);
  }

  /// 获取推荐帖子列表中的热门话题数据
  static Future<TopicHotList> getTopicHotList({
    String type = 'device',
    String openid,
    String authorization,
    int page = 1,
    int pageSize = 10,
  }) async {
    final String url = 'http://community-new.321mh.com/v1/topic/hotlist';

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'type': type,
        'openid': openid,
        'page': page,
        'page_size': pageSize,
        'platformname': 'android',
        'productname': 'mht'
      },
      options: Options(
        headers: {
          'auth_token': '$authorization',
        },
      ),
    );
    return TopicHotList.fromJson(response);
  }

  /// 获取推荐帖子列表中的热门帖子数据
  static Future<RecommendSatellite> getRecommendSatellite({
    String type = 'device',
    String openid,
    String authorization,
    int page = 1,
    int pageSize = 10,
  }) async {
    final String url =
        'http://community-new.321mh.com/v1/satellite/getrecommendsatellite';

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'type': type,
        'openid': openid,
        'page': page,
        'page_size': pageSize,
        'platformname': 'android',
        'productname': 'mht'
      },
      options: Options(
        headers: {
          'auth_token': '$authorization',
        },
      ),
    );
    return RecommendSatellite.fromJson(response);
  }

  /// 获取用户的角色信息
  static Future<UserRoleInfo> getUserroleInfoByUserids({
    List<int> userids,
    String authorization,
  }) async {
    final String url =
        'http://kanmanapi-main.321mh.com/v1/user/getuserroleinfobyuserids';

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: {
        'userids': userids.toString(),
        'localtime': DateTime.now().millisecondsSinceEpoch,
        'platformname': 'android',
        'productname': 'mht'
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'auth_token': '$authorization',
        },
      ),
    );
    return UserRoleInfo.fromJson(response);
  }

  /// 获取推荐的用户
  static Future<RecommendUsers> getRecommendUsers({
    String type = 'device',
    String openid,
    String authorization,
  }) async {
    final String url =
        'http://community-new.321mh.com/v1/banner/getrecommendusers';

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: {
        'openid': openid,
        'type': type,
        'localtime': DateTime.now().millisecondsSinceEpoch,
        'platformname': 'android',
        'productname': 'mht'
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'auth_token': '$authorization',
        },
      ),
    );
    return RecommendUsers.fromJson(response);
  }

  /// 获取用户的关注列表
  static Future<FollowList> getUsergFollowList({
    String type = 'device',
    String openid,
    String deviceid = '',
    int myuid,
    int row = 10,
    int page = 1,
  }) async {
    final String url =
        'https://follow-list.321mh.com/app_api/v5/getuserguanzhu/';

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: {
        'openid': openid,
        'type': type,
        'deviceid': deviceid,
        'myuid': myuid,
        'row': row,
        'page': page,
        'localtime': DateTime.now().millisecondsSinceEpoch,
        'platformname': 'android',
        'productname': 'mht'
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return FollowList.fromJson(response);
  }

  /// 获取关注用的帖子列表
  static Future<UserFollowLine> getUserFollowLine({
    String type = 'device',
    String openid,
    String authorization,
    int pageSize = 10,
    int createTime,
    int dataType,
    int targetId,
  }) async {
    final String url =
        'http://community-new.321mh.com/v1/timeline/getuserfollowline';
    Map<String, dynamic> params = {
      'openid': openid,
      'type': type,
      'page_size': pageSize,
      'platformname': 'android',
      'productname': 'mht'
    };

    if (dataType != null) {
      params['data_type'] = dataType;
      params['create_time'] = createTime;
    }

    if (targetId != null) {
      params['target_id'] = targetId;
    }

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: params,
      options: Options(
        headers: {
          'auth_token': '$authorization',
        },
      ),
    );
    if (response['status'] == 500) {
      return UserFollowLine.fromJson({});
    }
    return UserFollowLine.fromJson(response);
  }

  /// 帖子的点赞或者取消点缀
  static Future<bool> supportSatellite({
    String type = 'device',
    String openid,
    String authorization,
    int satelliteId,
    int status, // 1是点缀， 0是取消点缀
  }) async {
    final String url =
        'http://community-new.321mh.com/v1/satellite/supportsatellite';

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: {
        'openid': openid,
        'type': type,
        'satellite_id': satelliteId,
        'status': status,
        'localtime': DateTime.now().millisecondsSinceEpoch,
        'platformname': 'android',
        'productname': 'mht'
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'auth_token': '$authorization',
        },
      ),
    );
    return response['status'] == 0;
  }

  /// 获取帖子的详情
  static Future<Satellite> getSatelliteDetail({
    String type = 'device',
    String openid,
    String authorization,
    int satelliteId,
  }) async {
    final String url =
        'http://community-new.321mh.com/v1/satellite/getsatellitedetail';

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'openid': openid,
        'type': type,
        'satellite_id': satelliteId,
        'platformname': 'android',
        'productname': 'mht'
      },
      options: Options(
        headers: {
          'auth_token': '$authorization',
        },
      ),
    );
    return Satellite.fromJson(response['data']);
  }

  /// 获取帖子的一级评论
  ///
  /// type = 'hot' 表示热门评论
  ///
  /// type = 'new' 表示最新评论
  static Future<List<SatelliteComment>> getFatherComments({
    String authorization,
    int ssid,
    int ssidtype = 1,
    int page = 1,
    int size = 20,
    int contenttype = 3,
    int iswater = 0,
    int fatherid = 0,
    int relateid = 0,
    String type = 'hot',
  }) async {
    final String url = type == 'hot'
        ? 'http://community-new.321mh.com/v1/comment/gethotscomment'
        : 'http://community-new.321mh.com/v1/comment/newgetsv2';

    var params = {
      'appid': 2,
      'ssid': ssid,
      'ssidtype': ssidtype,
      'page': page,
      // 'size': size,
      // 'contenttype': contenttype,
      'fatherid': fatherid,
      'relateid': relateid
    };

    if (type == 'hot') {
      params['size'] = size;
      params['contenttype'] = contenttype;
    } else {
      params['pagesize'] = size;
      if (iswater != null) {
        params['iswater'] = iswater;
      }
    }

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: params,
      options: Options(
        headers: {
          'auth_token': '$authorization',
        },
      ),
    );
    return (response['data'] as List)
        ?.map((item) => item == null
            ? null
            : SatelliteComment.fromJson(item as Map<String, dynamic>))
        ?.toList();
  }

  /// 根据帖子的一级comment的fatherid来获取childrenComments
  static Future<List<SatelliteComment>> getChildrenComments({
    String type = 'device',
    String openid,
    String authorization,
    @required List<int> commentIds,
  }) async {
    final String url =
        'http://community-new.321mh.com/v1/comment/getchildrencomment';
    String commentIdsString = '';
    commentIds.forEach((item) {
      commentIdsString += '$item,';
    });

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'openid': openid,
        'type': type,
        'comment_ids': commentIdsString,
        'platformname': 'android',
        'productname': 'mht'
      },
      options: Options(
        headers: {
          'auth_token': '$authorization',
        },
      ),
    );
    return (response['data'] as List)
        ?.map((item) => item == null
            ? null
            : SatelliteComment.fromJson(item as Map<String, dynamic>))
        ?.toList();
  }

  /// 获取帖子的评论总数
  static Future<int> getCommentCount({
    int ssid,
    int appId = 2,
    int ssidType = 1,
    int commentType = 2,
  }) async {
    final String url = 'http://community-hots.321mh.com/comment/count/';

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'appId': appId,
        'ssid': ssid,
        'ssidType': ssidType,
        'commentType': commentType,
      },
    );
    return (response['data'] as int);
  }

  /// 帖子的评论点赞或者取消点赞
  static Future<bool> supportComment({
    int appId = 2,
    String type = 'device',
    @required String openid,
    @required String authorization,
    @required int commentId,
    @required int userLevel,
    @required int userIdentifier,
    @required int ssid,
    int siteId = 8,
    int ssidType = 1,
    @required status,
  }) async {
    final String url = 'http://community.321mh.com/comment/support/';

    Map<String, dynamic> response = await HttpRequest.put(
      url,
      data: {
        "appId": appId,
        "auth_token": "$authorization",
        "authorization": "Bearer $authorization",
        "commentId": commentId,
        "level": "$userLevel",
        "openid": "$openid",
        "siteId": siteId,
        "ssid": ssid,
        "ssidType": ssidType,
        "status": status,
        "type": "$type",
        "userIdentifier": '$userIdentifier',
        "userloglevel": 1
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $authorization',
        },
      ),
    );
    if (response['data'] != true) {
      return false;
    }
    return (response['data'] as bool);
  }

  /// 帖子的评论点赞或者取消点赞
  static Future<Map<String, dynamic>> addComment({
    int appId = 2,
    String type = 'device',
    @required String openid,
    @required String authorization,
    @required int userLevel,
    @required int userIdentifier,
    @required String userName,
    @required int ssid,
    int satelliteId,
    String replyName,
    int fatherId = 0,
    int siteId = 8,
    @required int satelliteUserId,
    int ssidType = 1,
    int starId,
    @required String content,
    @required String title,
    List<String> images,
    String deviceTail = '',
    String relateId = '',
  }) async {
    final String url = 'http://community-new.321mh.com/v1/comment/add/';

    var data = {
      "appId": "$appId",
      "auth_token": authorization,
      "authorization": "Bearer $authorization",
      "content": content,
      "device_tail": deviceTail,
      "fatherId": fatherId,
      "images": images == null ? images.toString() : "[]",
      "level": "$userLevel",
      "openid": "$openid",
      "opreateId": satelliteUserId,
      "relateId": relateId,
      "satelliteId": satelliteId != null ? satelliteId : ssid,
      "selfName": userName,
      "siteId": siteId,
      "ssid": ssid,
      "ssidType": ssidType,
      "starId": starId,
      "title": title,
      "type": type,
      "url": "",
      "userIdentifier": "$userIdentifier",
      "userloglevel": 1
    };

    // 要回复的用户，在评论的回复页面中需要使用
    if (replyName != null) {
      data['replyName'] = replyName;
    }

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      params: {
        'FatherId': fatherId,
      },
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $authorization',
        },
      ),
    );
    return response;
  }

  /// 获取用户的收藏和阅读历史记录
  static Future<UserRecord> getUserRecord({
    String type = 'device',
    String openid,
    String deviceid,
    int myUid,
    int autologo = 1,
  }) async {
    final String url =
        'https://kanmanapi-main.321mh.com/app_api/v5/getuserrecord/';

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: {
        'openid': openid,
        'type': type,
        'deviceid': deviceid,
        'myuid': myUid,
        'autologo': autologo,
        'localtime': DateTime.now().millisecondsSinceEpoch,
        'platformname': 'android',
        'productname': 'mht'
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return UserRecord.fromJson(response);
  }

  /// 设置用户对漫画的订阅状态
  /// action = 'add' 表示收藏 此时 comicId 必填
  /// action = 'dels' 表示删除 此时 comicIdList 必填
  static Future<bool> setUserCollect({
    String type = 'device',
    String openid,
    String deviceid,
    int myUid,
    int comicId,
    List<int> comicIdList,
    String action,
    int autologo = 1,
  }) async {
    final String url =
        'https://kanmanapi-main.321mh.com/app_api/v5/setusercollect/';

    Map<String, dynamic> data = {
      'openid': openid,
      'type': type,
      'deviceid': deviceid,
      'myuid': myUid,
      'localtime': DateTime.now().millisecondsSinceEpoch,
      'platformname': 'android',
      'productname': 'mht'
    };

    data['action'] = action;
    if (action == 'add') {
      if (comicId == null) {
        throw ErrorDescription('订阅漫画时，comicId不能为空');
      } else {
        data['comic_id'] = comicId;
      }
    }

    if (action == 'dels') {
      if (comicIdList == null) {
        throw ErrorDescription('取消订阅的漫画时，comicIdList不能为空');
      } else {
        String comicIdListString = '';
        comicIdList.forEach((id) {
          comicIdListString += '$id,';
        });
        data['comic_id_list'] = comicIdListString;
      }
    }

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: data,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    return response['status'];
  }

  /// 添加用户对漫画阅读历史记录
  static Future<bool> addUserRead({
    String type = 'device',
    @required String openid,
    @required String deviceid,
    @required int myUid,
    @required String authorization,
    int comicId,
    int chapterId,
    String chapterName,
    int chapterPage,
    int autologo = 1,
  }) async {
    final String url = 'https://adduserread.321mh.com/app_api/v5/adduserread/';

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: {
        'openid': openid,
        'type': type,
        'deviceid': deviceid,
        'myuid': myUid,
        'userauth': authorization,
        'comic_id': comicId,
        'chapter_id': chapterId,
        'chapter_name': chapterName,
        'chapter_page': chapterPage,
        'localtime': DateTime.now().millisecondsSinceEpoch,
        'platformname': 'android',
        'productname': 'mht'
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return response['status'] == 0;
  }

  /// 删除用户对漫画阅读历史记录
  static Future<bool> delUserRead({
    String type = 'device',
    @required String openid,
    @required String deviceid,
    @required int myUid,
    int comicId,
    int autologo = 1,
  }) async {
    final String url =
        'https://kanmanapi-main.321mh.com/app_api/v5/deluserread/';

    Map<String, dynamic> response = await HttpRequest.post(
      url,
      data: {
        'openid': openid,
        'type': type,
        'deviceid': deviceid,
        'myuid': myUid,
        'comic_id': comicId,
        'localtime': DateTime.now().millisecondsSinceEpoch,
        'platformname': 'android',
        'productname': 'mht'
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return response['status'];
  }

  /// 通过bookId获取bookList
  static Future<GetBookInfoById> getBookInfoById({
    @required int bookId,
  }) async {
    final String url =
        'http://cms-booklist.321mh.com/api/v1/bookList/getbookinfo_sys';

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'book_id': bookId,
        'platformname': 'android',
        'productname': 'mht'
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return GetBookInfoById.fromJson(response);
  }

  /// 通过commentId获取评论的信息
  static Future<CommentContent> getCommentContent({
    @required int commentId,
    @required int userIdentifier,
    @required int level,
    int siteId = 8,
  }) async {
    final String url = 'http://community.321mh.com/comment/getcontent/';

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'appId': 2,
        'commentId': commentId,
        'userIdentifier': userIdentifier,
        'level': level,
        'userloglevel': 1,
        'siteId': siteId,
        'opreateTime': DateTime.now().millisecondsSinceEpoch,
      },
    );

    if (response['status'] == 1 && response['data'] is List) {
      var data = response['data'] as List<dynamic>;
      if (data.length != 0) {
        return CommentContent.fromJson(data.first);
      }
    }

    return CommentContent.fromJson({});
  }

  /// 通过chapterId获取漫画的章节信息
  static Future<List<ChapterInfo>> getChapterInfoByChapterId({
    @required List<int> chapterIds,
  }) async {
    String url =
        'http://kanmanapi-main.321mh.com/v1/comic/getchapterinfobychapterid';
    String chapterIdString = '';

    // if (chapterIds.length != 0) {
    chapterIds.forEach((chpaterId) {
      chapterIdString += '&chapterid=$chpaterId';
    });

    url += '?' + chapterIdString.substring(1);
    // }

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {'platformname': 'android', 'productname': 'mht'},
    );

    if (response['status'] == 0 && response['data'] is List) {
      var data = response['data'] as List<dynamic>;
      if (data.length != 0) {
        return data.map((item) {
          return ChapterInfo.fromJson(item);
        }).toList();
      }
    }

    return [];
  }

  /// 通过特权等级列表
  static Future<List<LevelInfo>> getUserLevelInfo({
    @required String openid,
  }) async {
    String url = 'http://kanmanapi-main.321mh.com/v1/user/getuserlevelinfo';

    Map<String, dynamic> response = await HttpRequest.get(
      url,
      params: {
        'openid': openid,
        'type': 'mkxq',
        'platformname': 'android',
        'productname': 'mht',
      },
    );

    if (response['status'] == 0 && response['data'] is List) {
      var data = response['data'] as List<dynamic>;
      return getLevelInfoList(data);
    }

    return [];
  }
}
