import 'package:flutter_manhuatai/models/user_info.dart';
import 'package:redux/redux.dart';

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
