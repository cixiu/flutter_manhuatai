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

    Map<String, dynamic> response = await HttpRequest.get(url,
        params: {'platformname': 'android', 'productname': 'mht'});
    return response;
  }
}
