import 'package:multi_camera_photography_fe/src/redux/state/app_permissions.state.dart';

class SetAppPermissionsAction {
  bool? bluetooth;
  bool? location;
  bool? wifi;
  bool? storage;
  bool? camera;
  SetAppPermissionsAction(
      {this.bluetooth, this.location, this.wifi, this.storage, this.camera});
}
