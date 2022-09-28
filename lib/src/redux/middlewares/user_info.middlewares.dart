import 'package:multi_camera_photography_fe/src/redux/actions/user_info.actions.dart';
import 'package:multi_camera_photography_fe/src/redux/app_state.dart';
import 'package:redux/redux.dart';

void userInfoMiddleWare(
    Store<AppState> store, dynamic action, NextDispatcher next) async {
  if (action is GetUserInfoAction) {
    try {
      // Do the needful
      // Dispatch SuccessAction
    } catch (error) {
      // Dispatch Fail Action
    }
  }
}
