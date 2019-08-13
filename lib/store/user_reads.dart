import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:redux/redux.dart';

// 用户收藏和阅读历史记录
final userReadsReducer = combineReducers<List<User_read>>([
  TypedReducer(_updateUserReads),
  TypedReducer(_addUserRead),
]);

List<User_read> _updateUserReads(
  List<User_read> userReads,
  UpdateUserReadsAction action,
) {
  return action.userReads;
}

class UpdateUserReadsAction {
  final List<User_read> userReads;

  UpdateUserReadsAction(this.userReads);
}

// 添加一条记录到阅读历史列表中
List<User_read> _addUserRead(
  List<User_read> userReads,
  AddUserReadAction action,
) {
  userReads.insert(0, action.userRead);
  return userReads;
}

class AddUserReadAction {
  final User_read userRead;

  AddUserReadAction(this.userRead);
}
