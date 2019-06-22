import 'dart:async';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_manhuatai/api/api.dart';
import 'package:flutter_manhuatai/common/mixin/refresh_common_state.dart';
import 'package:flutter_manhuatai/store/index.dart';

import 'package:flutter_manhuatai/models/search_author.dart' as SearchAuthor;
import 'package:flutter_manhuatai/models/sort_list.dart' as SortList;
import 'package:flutter_manhuatai/models/get_channels_res.dart'
    as GetChannelsRes;
import 'package:flutter_manhuatai/models/get_satellite_res.dart'
    as GetSatelliteRes;

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
  List<GetSatelliteRes.Data> _postList;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRefreshLoading();
    });
  }

  Future<void> handleRefresh() async {
    Store<AppState> store = StoreProvider.of(context);
    var userInfo = store.state.userInfo;
    var guestInfo = store.state.guestInfo;

    List<Future<dynamic>> futures = List()
      ..add(Api.getSortList(
        searchKey: widget.keyword,
      ))
      ..add(Api.searchAuthor(
        searchKey: widget.keyword,
      ))
      ..add(Api.getChannels(
        userIdentifier: userInfo.uid ?? guestInfo.uid,
        level: userInfo.uid != null ? userInfo.ulevel : guestInfo.ulevel,
        keyword: widget.keyword,
      ))
      ..add(Api.getSatellite(
        userIdentifier: userInfo.uid ?? guestInfo.uid,
        level: userInfo.uid != null ? userInfo.ulevel : guestInfo.ulevel,
        keyword: widget.keyword,
      ));

    var result = await Future.wait(futures);
    if (!this.mounted) {
      return;
    }
    var getSortListRes = result[0] as SortList.SortList;
    var searchAuthorRes = result[1] as SearchAuthor.SearchAuthor;
    var getChannelsRes = result[2] as GetChannelsRes.GetChannelsRes;
    var getSatelliteRes = result[3] as GetSatelliteRes.GetSatelliteRes;

    setState(() {
      _sortListData = getSortListRes.data;
      _searchAuthorData = searchAuthorRes.data;
      _channelList = getChannelsRes.data;
      _postList = getSatelliteRes.data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                ],
              ),
      ),
    );
  }
}
