import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:redux/redux.dart';

// 用户信息
final userInfoReducer = combineReducers<UserInfo>([
  TypedReducer(_updateUserInfo),
]);

UserInfo _updateUserInfo(UserInfo user, UpdateUserInfoAction action) {
  return action.userInfo;
}

class UpdateUserInfoAction {
  final UserInfo userInfo;

  UpdateUserInfoAction(this.userInfo);
}

// 游客信息
final guestInfoReducer = combineReducers<UserInfo>([
  TypedReducer(_updateGuestInfo),
]);

UserInfo _updateGuestInfo(UserInfo guest, UpdateGuestInfoAction action) {
  return action.guestInfo;
}

class UpdateGuestInfoAction {
  final UserInfo guestInfo;

  UpdateGuestInfoAction(this.guestInfo);
}
