class AppPermissionsState {
  bool bluetooth = false;
  bool location = false;
  bool wifi = false;
  bool storage = false;
  bool camera = false;
  AppPermissionsState.initialState() {
    bluetooth = false;
    location = false;
    wifi = false;
    storage = false;
    camera = false;
  }

  AppPermissionsState.updatedState(
      {bool? bluetooth,
      bool? location,
      bool? wifi,
      bool? storage,
      bool? camera}) {
    if (bluetooth != null) {
      this.bluetooth = bluetooth;
    }
    if (location != null) {
      this.location = location;
    }
    if (wifi != null) {
      this.wifi = wifi;
    }
    if (storage != null) {
      this.storage = storage;
    }
    if (camera != null) {
      this.camera = camera;
    }
  }
}
