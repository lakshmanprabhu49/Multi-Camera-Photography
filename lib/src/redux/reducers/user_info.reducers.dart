import 'package:multi_camera_photography_fe/src/redux/actions/user_info.actions.dart';
import 'package:multi_camera_photography_fe/src/redux/state/user_info.state.dart';

UserInfoState userInfoReducer(UserInfoState state, dynamic action) {
  if (action is GetUserInfoAction) {
    return UserInfoState.updatedState(
        data: state.data, loading: true, loaded: false, loadFailed: false);
  }
  return state;
}
