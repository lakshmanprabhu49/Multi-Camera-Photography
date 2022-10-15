import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multi_camera_photography_fe/main.dart';
import 'package:multi_camera_photography_fe/src/redux/actions/app_permissions.actions.dart';
import 'package:multi_camera_photography_fe/src/redux/app_state.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerStaticClass {
  static void getPermissions(BuildContext context) async {
    var storagePermission = await Permission.manageExternalStorage.status;
    if (storagePermission.isDenied) {
      storagePermission = await Permission.manageExternalStorage.request();
      if (storagePermission.isGranted) {
        StoreProvider.of<AppState>(context).dispatch(SetAppPermissionsAction(
          storage: true,
        ));
      } else if (storagePermission.isDenied) {
        StoreProvider.of<AppState>(context).dispatch(SetAppPermissionsAction(
          storage: false,
        ));
      }
    }
    var locationPermission = await Permission.location.status;
    if (locationPermission.isDenied) {
      locationPermission = await Permission.location.request();
      if (locationPermission.isGranted) {
        StoreProvider.of<AppState>(context).dispatch(SetAppPermissionsAction(
          location: true,
        ));
      } else if (locationPermission.isDenied) {
        StoreProvider.of<AppState>(context).dispatch(SetAppPermissionsAction(
          location: false,
        ));
      }
    }
    var bluetoothPermission = await Permission.bluetooth.status;
    if (bluetoothPermission.isDenied) {
      bluetoothPermission = await Permission.bluetooth.request();
      if (bluetoothPermission.isGranted) {
        StoreProvider.of<AppState>(context).dispatch(SetAppPermissionsAction(
          bluetooth: true,
        ));
      } else if (bluetoothPermission.isDenied) {
        StoreProvider.of<AppState>(context).dispatch(SetAppPermissionsAction(
          bluetooth: false,
        ));
      }
    }
    var cameraPermission = await Permission.camera.status;
    if (cameraPermission.isDenied) {
      cameraPermission = await Permission.camera.request();
      if (cameraPermission.isGranted) {
        StoreProvider.of<AppState>(context).dispatch(SetAppPermissionsAction(
          camera: true,
        ));
      } else if (cameraPermission.isDenied) {
        StoreProvider.of<AppState>(context).dispatch(SetAppPermissionsAction(
          camera: false,
        ));
      }
    }
    StoreProvider.of<AppState>(context).dispatch(SetAppPermissionsAction(
        bluetooth: bluetoothPermission.isGranted,
        camera: cameraPermission.isGranted,
        storage: storagePermission.isGranted,
        location: locationPermission.isGranted));
  }

  static void enableConnectivityServices(BuildContext context) async {
    getPermissions(context);
    if (appStore.state.appPermissions.location) {
      await Nearby().enableLocationServices();
    }
    if (appStore.state.appPermissions.bluetooth) {
      if (!(await FlutterBlue.instance.isOn) && Platform.isAndroid) {
        try {
          AndroidIntent intent = AndroidIntent(
              action: 'android.bluetooth.adapter.action.REQUEST_ENABLE');
          await intent.launch();
        } catch (error) {
          openAppSettings();
        }
      }
    }
  }
}
