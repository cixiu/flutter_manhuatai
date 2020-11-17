// import 'package:flutter/widgets.dart';
// import 'package:flutter_manhuatai/store/index.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';

// import 'package:flutter_manhuatai/models/user_info.dart';

// class User {
//   UserInfo info;
//   bool hasLogin;

//   User(BuildContext context) {
//     Store<AppState> store = StoreProvider.of(context);
//     var guestInfo = store.state.guestInfo;
//     var userInfo = store.state.userInfo;

//     this.hasLogin = userInfo.uid != null;
//     this.info = this.hasLogin ? userInfo : guestInfo;
//   }
// }
