import 'dart:async';
import 'package:flutter_manhuatai/utils/sp.dart';
import 'package:redux/redux.dart';

import 'package:flutter_manhuatai/models/user_info.dart';
import './user_info.dart';

/// 全局Redux store 的对象，保存State数据
class AppState {
  UserInfo userInfo;

  AppState({this.userInfo});
}

/// 通过 Reducer 创建 store 保存的 AppState
AppState rootReducer(AppState state, action) {
  return AppState(
    userInfo: userInfoReducer(state.userInfo, action),
  );
}

Future<AppState> initState() async {
  var userInfo = await SpUtils.loadUserInfo();
  return AppState(
    userInfo: userInfo,
  );
}
