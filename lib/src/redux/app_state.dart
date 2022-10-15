import 'package:multi_camera_photography_fe/src/redux/state/app_permissions.state.dart';
import 'package:multi_camera_photography_fe/src/redux/state/user_info.state.dart';

class AppState {
  UserInfoState userInfo = UserInfoState.initialState();
  AppPermissionsState appPermissions = AppPermissionsState.initialState();
  AppState.initialState() {
    userInfo = UserInfoState.initialState();
    appPermissions = AppPermissionsState.initialState();
  }
  AppState.updatedState(
      {UserInfoState? userInfo, AppPermissionsState? appPermissions}) {
    if (userInfo != null) {
      this.userInfo = userInfo;
    }
    if (appPermissions != null) {
      this.appPermissions = appPermissions;
    }
  }
}
