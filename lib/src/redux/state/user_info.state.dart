import 'package:multi_camera_photography_fe/src/models/user_info.dart';

class UserInfoState {
  UserInfo? data;
  bool loading = false;
  bool loaded = false;
  bool loadFailed = false;
  UserInfoState.initialState() {
    data = null;
    loaded = false;
    loading = false;
    loadFailed = false;
  }
  UserInfoState.updatedState({
    required this.data,
    required this.loaded,
    required this.loading,
    required this.loadFailed,
  });
}
