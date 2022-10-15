import 'dart:io';

import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:multi_camera_photography_fe/main.dart';
import 'package:multi_camera_photography_fe/src/models/colors.dart';
import 'package:multi_camera_photography_fe/src/models/device.dart';
import 'package:multi_camera_photography_fe/src/redux/app_state.dart';
import 'package:multi_camera_photography_fe/src/screens/home_screen.dart';
import 'package:multi_camera_photography_fe/src/views/join_collab_input_details.dart';
import 'package:nearby_connections/nearby_connections.dart';

class JoinCollabScreen extends StatefulWidget {
  const JoinCollabScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  // ignore: library_private_types_in_public_api
  _JoinCollabScreenState createState() => _JoinCollabScreenState();
}

class _JoinCollabScreenState extends State<JoinCollabScreen> with RouteAware {
  String workerName = '';
  String masterName = '';
  List<Device> availableMasters = [];
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }

  @override
  void didPop() {
    super.didPop();
  }

  @override
  void didPush() {
    super.didPush();
  }

  @override
  void didPushNext() {
    super.didPushNext();
  }

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String?> showAvailableMastersDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Searching for master.......',
          style: GoogleFonts.outfit(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: PaletteColors.purple2,
          ),
        ),
        content: Text(
          'Are you sure you want to logout for this user?',
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: PaletteColors.purple2,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
            ),
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.lusitana(
                    fontSize: 15,
                    color: PaletteColors.pink2,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void startAdvertisingWorker() async {
    try {
      bool a = await Nearby().startAdvertising(
        workerName,
        Strategy.P2P_CLUSTER,
        onConnectionInitiated: (String id, ConnectionInfo info) async {
          if (info.endpointName == masterName) {
            await Nearby().acceptConnection(id,
                onPayLoadRecieved: (String payloadId, Payload payload) {});
          } else {
            // Reject Name
            await Nearby().rejectConnection(id);
          }
          // Called whenever a discoverer requests connection
        },
        onConnectionResult: (String id, Status status) {
          // Called when connection is accepted/rejected
          print(status);
        },
        onDisconnected: (String id) {
          // Callled whenever a discoverer disconnects from advertiser
        },
        serviceId: "com.yourdomain.appname", // uniquely identifies your app
      );
    } catch (exception) {
      // platform exceptions like unable to start bluetooth or insufficient permissions
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, vm) => (Scaffold(
              backgroundColor: NeutralColors.white1,
              body: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Stack(
                    children: [
                      Container(
                        height: screenSize.height * 0.3,
                        padding: EdgeInsets.only(top: 30),
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(150)),
                            gradient: LinearGradient(
                                colors: [
                                  PaletteColors.purple2.withOpacity(0.75),
                                  PaletteColors.pink2.withOpacity(0.75)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Join Collab',
                                style: GoogleFonts.crimsonPro(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 50,
                                    color: Colors.white),
                              )
                            ]),
                      ),
                      Container(
                          transform: Matrix4.translationValues(
                              0, screenSize.height * 0.15, 0),
                          margin: EdgeInsets.fromLTRB(screenSize.width * 0.1, 0,
                              screenSize.width * 0.1, 0),
                          constraints: BoxConstraints(
                              maxHeight: screenSize.height * 0.65),
                          width: screenSize.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: JoinCollabInputDetails(
                            formKey: _formKey,
                            workerName: workerName,
                            masterName: masterName,
                            valueChangedCallback: ((newValue) {
                              if (newValue
                                  is JoinCollabInputDetailsInputParams) {
                                if (newValue.workerName != null) {
                                  setState(() {
                                    workerName = newValue.workerName as String;
                                  });
                                }
                                if (newValue.masterName != null) {
                                  setState(() {
                                    masterName = newValue.masterName as String;
                                  });
                                }
                              }
                            }),
                          )),
                      (Container(
                        transform: Matrix4.translationValues(0, 35, 20),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              maximumSize: MaterialStateProperty.all(
                                  Size(screenSize.width, 40)),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 40,
                          ),
                        ),
                      )),
                      Container(
                          width: screenSize.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: screenSize.width * 0.75,
                                transform: Matrix4.translationValues(
                                    0, screenSize.height * 0.84, 0),
                                decoration: BoxDecoration(
                                    color: PaletteColors.purple4,
                                    borderRadius: BorderRadius.circular(25)),
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      minimumSize: MaterialStateProperty.all(
                                          Size(screenSize.width, 50)),
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent)),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await Nearby().stopAdvertising();
                                      startAdvertisingWorker();
                                      showAvailableMastersDialog();
                                    }
                                  },
                                  child: Text(
                                    'Search for Master',
                                    style: GoogleFonts.yesevaOne(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  )),
            )));
  }
}
