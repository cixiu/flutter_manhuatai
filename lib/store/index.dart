// import 'dart:async';
// import 'package:flutter_manhuatai/models/user_record.dart';
// import 'package:flutter_manhuatai/utils/sp.dart';

// import 'package:flutter_manhuatai/models/user_info.dart';

// import 'user_info.dart';
// import 'user_collects.dart';
// import 'user_reads.dart';

// /// 全局Redux store 的对象，保存State数据
// class AppState {
//   // /// 用户信息
//   // UserInfo userInfo;

//   // /// 游客信息
//   // UserInfo guestInfo;

//   /// 用户的收藏
//   List<User_collect> userCollects;

//   /// 用户阅读历史记录
//   List<User_read> userReads;

//   AppState({
//     // this.userInfo,
//     // this.guestInfo,
//     this.userCollects,
//     this.userReads,
//   });
// }

// /// 通过 Reducer 创建 store 保存的 AppState
// AppState rootReducer(AppState state, action) {
//   return AppState(
//     // userInfo: userInfoReducer(state.userInfo, action),
//     // guestInfo: guestInfoReducer(state.guestInfo, action),
//     userCollects: userCollectsReducer(state.userCollects, action),
//     userReads: userReadsReducer(state.userReads, action),
//   );
// }

// Future<AppState> initState() async {
//   print('初始化 redux 数据');
//   // var userAndGuest = await Future.wait([
//   //   SpUtils.loadUserInfo(),
//   //   SpUtils.loadGuestInfo(),
//   // ]);
//   return AppState(
//     // userInfo: userAndGuest[0],
//     // guestInfo: userAndGuest[1],
//     userCollects: null,
//     userReads: null,
//   );
// }
