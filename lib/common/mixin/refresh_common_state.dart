import 'dart:async';
import 'package:flutter/material.dart';

mixin RefreshCommonState<T extends StatefulWidget> on State<T>, AutomaticKeepAliveClientMixin<T> {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      print('--------------------- showRefreshLoading ---------------------');
      refreshIndicatorKey.currentState.show().then((e) {});
      return true;
    });
  }

  // @override
  // void initState() {
  //   super.initState();

  // }
}
