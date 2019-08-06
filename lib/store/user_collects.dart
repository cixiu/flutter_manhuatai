import 'package:flutter_manhuatai/models/user_record.dart';
import 'package:redux/redux.dart';

// 用户收藏和阅读历史记录
final userCollectsReducer = combineReducers<List<User_collect>>([
  TypedReducer(_updateUserCollects),
]);

List<User_collect> _updateUserCollects(
    List<User_collect> userCollects, UpdateUserCollectsAction action) {
  return action.userCollects;
}

class UpdateUserCollectsAction {
  final List<User_collect> userCollects;

  UpdateUserCollectsAction(this.userCollects);
}
