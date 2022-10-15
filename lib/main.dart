import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multi_camera_photography_fe/src/redux/app_reducers.dart';
import 'package:multi_camera_photography_fe/src/redux/app_state.dart';
import 'package:multi_camera_photography_fe/src/redux/middlewares/user_info.middlewares.dart';
import 'package:multi_camera_photography_fe/src/screens/home_screen.dart';
import 'package:redux/redux.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

final Store<AppState> appStore = Store<AppState>(appReducer,
    initialState: AppState.initialState(),
    middleware: [
      userInfoMiddleWare,
    ]);
void main() {
  runApp(StoreProvider(
      store: appStore,
      child: MaterialApp(
        home: HomeScreen(),
        navigatorObservers: [routeObserver],
      )));
}
