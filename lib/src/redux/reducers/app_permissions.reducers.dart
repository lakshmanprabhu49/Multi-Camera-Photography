import 'package:multi_camera_photography_fe/src/redux/actions/app_permissions.actions.dart';
import 'package:multi_camera_photography_fe/src/redux/state/app_permissions.state.dart';

AppPermissionsState appPermissionsReducer(
    AppPermissionsState state, dynamic action) {
  if (action is SetAppPermissionsAction) {
    return AppPermissionsState.updatedState(
      bluetooth: action.bluetooth,
      location: action.location,
      wifi: action.wifi,
      storage: action.storage,
      camera: action.camera,
    );
    // if (action.bluetooth != null) {
    //   return AppPermissionsState.updatedState(bluetooth: action.bluetooth);
    // }
    // if (action.location != null) {
    //   return AppPermissionsState.updatedState(location: action.location);
    // }
    // if (action.wifi != null) {
    //   return AppPermissionsState.updatedState(wifi: action.wifi);
    // }
    // if (action.storage != null) {
    //   return AppPermissionsState.updatedState(storage: action.storage);
    // }
    // if (action.camera != null) {
    //   return AppPermissionsState.updatedState(camera: action.camera);
    // }
  }
  return state;
}
