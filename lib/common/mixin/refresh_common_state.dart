import 'dart:async';
import 'package:flutter/material.dart';

mixin RefreshCommonState<T extends StatefulWidget> on State<T> {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  // @override
  // bool get wantKeepAlive => true;

  showRefreshLoading() {
    if (refreshIndicatorKey.currentState == null) {
      return false;
    }

    new Future.delayed(Duration(milliseconds: 250), () {
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
