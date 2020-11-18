import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';

import 'package:flutter_manhuatai/models/search_author.dart' as SearchAuthor;
import 'package:flutter_manhuatai/models/sort_list.dart' as SortList;
import 'package:flutter_manhuatai/models/get_channels_res.dart'
    as GetChannelsRes;
import 'package:flutter_manhuatai/pages/manhuatai/components/recommend_satellite_sliver_list.dart';
import 'package:flutter_manhuatai/provider_store/user_info_model.dart';
import 'package:flutter_manhuatai/common/model/satellite.dart';
import 'package:flutter_manhuatai/models/recommend_satellite.dart';
import 'package:flutter_manhuatai/models/user_role_info.dart' as UserRoleInfo;

import 'components/related_authors.dart';
import 'components/related_channels.dart';
import 'components/related_comics.dart';

class SearchResultPage extends StatefulWidget {
  final String keyword;

  SearchResultPage({
    Key key,
    this.keyword,
  }) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage>
    with RefreshCommonState, WidgetsBindingObserver {
  bool _isLoading = true;
  List<SortList.Data> _sortListData;
  SearchAuthor.Data _searchAuthorData;
  List<GetChannelsRes.Data> _channelList;

  ScrollController _scrollController = ScrollController();
  int page = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  List<Satellite> _recommendSatelliteList = [];
  int _satelliteCount = 0;
  List<UserRoleInfo.Data> _userRoleInfoList = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_listenenScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  Future<void> handleRefresh() async {
    var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
    var user = userInfoModel.user;
    var type = userInfoModel.hasLogin ? 'mkxq' : 'device';
    var openid = user.openid;
    var authorization = user.authData.authcode;

    List<Future<dynamic>> futures = List()
      ..add(Api.getSortList(
        searchKey: widget.keyword,
      ))
      ..add(Api.searchAuthor(
        searchKey: widget.keyword,
      ))
      ..add(Api.getChannels(
        userIdentifier: user.uid,
        level: user.ulevel,
        keyword: widget.keyword,
      ))
      ..add(Api.getRelatedSatellite(
        openid: openid,
        type: type,
        keyword: widget.keyword,
      ));

    var result = await Future.wait(futures);
    if (!this.mounted) {
      return;
    }
    var getSortListRes = result[0] as SortList.SortList;
    var searchAuthorRes = result[1] as SearchAuthor.SearchAuthor;
    var getChannelsRes = result[2] as GetChannelsRes.GetChannelsRes;
    var getRelatedSatelliteRes = result[3] as RecommendSatellite;
    List<int> userids = [];
    getRelatedSatelliteRes.data.list.forEach((item) {
      userids.add(item.useridentifier);
    });

    var getUserroleInfoByUseridsRes = await Api.getUserroleInfoByUserids(
      userids: userids,
      authorization: authorization,
    );
    var data = getRelatedSatelliteRes.data;

    setState(() {
      _sortListData = getSortListRes.data;
      _searchAuthorData = searchAuthorRes.data;
      _channelList = getChannelsRes.data;
      _satelliteCount = data == null ? 0 : data.pager.count;
      _recommendSatelliteList = data == null ? [] : data.list;
      _userRoleInfoList = getUserroleInfoByUseridsRes.data;
      _isLoading = false;
    });
  }

  void _listenenScroll() {
    bool isBottom = _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
    // 判断当前滑动位置是不是到达底部，触发加载更多回调
    if (isBottom) {
      loadMore();
    }
  }

  // 上拉加载更多
  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) {
      return;
    }
    _isLoadingMore = true;

    page++;
    var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
    var user = userInfoModel.user;
    var type = userInfoModel.hasLogin ? 'mkxq' : 'device';
    var openid = user.openid;

    print('加载更多');
    var getRecommendSatelliteRes = await Api.getRelatedSatellite(
      type: type,
      openid: openid,
      keyword: widget.keyword,
      page: page,
    );
    _isLoadingMore = false;

    var recommendSatelliteList = getRecommendSatelliteRes.data?.list;
    if (recommendSatelliteList == null || recommendSatelliteList.length == 0) {
      setState(() {
        _hasMore = false;
      });
      return;
    }

    setState(() {
      _recommendSatelliteList.addAll(recommendSatelliteList);
    });
  }

  Future<void> _supportSatellite(Satellite item, int index) async {
    // var item = _recommendSatelliteList[index];
    var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
    var user = userInfoModel.user;
    var type = userInfoModel.hasLogin ? 'mkxq' : 'device';
    var openid = user.openid;
    var authorization = user.authData.authcode;

    var success = await Api.supportSatellite(
      type: type,
      openid: openid,
      authorization: authorization,
      satelliteId: item.id,
      status: item.issupport == 1 ? 0 : 1,
    );

    if (success) {
      setState(() {
        if (item.issupport == 1) {
          item.issupport = 0;
          item.supportnum -= 1;
        } else {
          item.issupport = 1;
          item.supportnum += 1;
        }
      });
    }
  }

  void _updateSatellite(Satellite item, int index) {
    var _item = _recommendSatelliteList[index];
    setState(() {
      if (_item.issupport != item.issupport) {
        _item.issupport = item.issupport;
        if (item.issupport == 1) {
          _item.supportnum += 1;
        } else {
          _item.supportnum -= 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.light,
        title: Text('${widget.keyword}'),
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: handleRefresh,
        child: _isLoading
            ? Container()
            : CustomScrollView(
                physics: ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                controller: _scrollController,
                slivers: <Widget>[
                  _sortListData.length == 0
                      ? SliverList(
                          delegate: SliverChildListDelegate([]),
                        )
                      : RelatedComics(
                          keyword: widget.keyword,
                          relatedListData: _sortListData,
                        ),
                  _searchAuthorData.total == 0
                      ? SliverList(
                          delegate: SliverChildListDelegate([]),
                        )
                      : RelatedAuthors(
                          keyword: widget.keyword,
                          relatedAuthorList: _searchAuthorData.data,
                        ),
                  _channelList.length == 0
                      ? SliverList(
                          delegate: SliverChildListDelegate([]),
                        )
                      : RelatedChannels(
                          keyword: widget.keyword,
                          relatedChannelList: _channelList,
                        ),
                  _recommendSatelliteList.length == 0
                      ? SliverList(
                          delegate: SliverChildListDelegate([]),
                        )
                      : RecommendSatelliteSliverList(
                          isRelated: true,
                          satelliteCount: _satelliteCount,
                          recommendSatelliteList: _recommendSatelliteList,
                          userRoleInfoList: _userRoleInfoList,
                          hasMore: _hasMore,
                          supportSatellite: _supportSatellite,
                          updateSatellite: _updateSatellite,
                        ),
                ],
              ),
      ),
    );
  }
}
