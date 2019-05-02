import 'dart:async';
import 'package:flutter_manhuatai/utils/sp.dart';

import 'package:flutter_manhuatai/models/user_info.dart';
import './user_info.dart';

/// 全局Redux store 的对象，保存State数据
class AppState {
  /// 用户信息
  UserInfo userInfo;
  /// 游客信息
  UserInfo guestInfo;

  AppState({
    this.userInfo,
    this.guestInfo,
  });
}

/// 通过 Reducer 创建 store 保存的 AppState
AppState rootReducer(AppState state, action) {
  return AppState(
    userInfo: userInfoReducer(state.userInfo, action),
    guestInfo: guestInfoReducer(state.guestInfo, action),
  );
}

Future<AppState> initState() async {
  print('初始化 redux 数据');
  var userAndGuest = await Future.wait([
    SpUtils.loadUserInfo(),
    SpUtils.loadGuestInfo(),
  ]);
  return AppState(
    userInfo: userAndGuest[0],
    guestInfo: userAndGuest[1],
  );
}
