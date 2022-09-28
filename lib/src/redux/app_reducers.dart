import 'package:multi_camera_photography_fe/src/redux/actions/user_info.actions.dart';
import 'package:multi_camera_photography_fe/src/redux/app_state.dart';
import 'package:multi_camera_photography_fe/src/redux/reducers/user_info.reducers.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState.updatedState(
      userInfo: userInfoReducer(state.userInfo, action));
}
