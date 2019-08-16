import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:redux/redux.dart';

// 用户收藏和阅读历史记录
final userReadsReducer = combineReducers<List<User_read>>([
  TypedReducer(_updateUserReads),
  TypedReducer(_addUserRead),
  TypedReducer(_changeUserRead),
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

// 修改一条阅读历史
List<User_read> _changeUserRead(
  List<User_read> userReads,
  ChangeUserReadAction action,
) {
  return userReads.map((item) {
    if (item.comicId == action.userRead.comicId) {
      return action.userRead;
    }
    return item;
  }).toList();
}

class ChangeUserReadAction {
  final User_read userRead;

  ChangeUserReadAction(this.userRead);
}
