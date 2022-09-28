import 'package:multi_camera_photography_fe/src/redux/state/user_info.state.dart';

class AppState {
  UserInfoState userInfo = UserInfoState.initialState();
  AppState.initialState() {
    userInfo = UserInfoState.initialState();
  }
  AppState.updatedState({UserInfoState? userInfo}) {
    if (userInfo != null) {
      this.userInfo = userInfo;
    }
  }
}
