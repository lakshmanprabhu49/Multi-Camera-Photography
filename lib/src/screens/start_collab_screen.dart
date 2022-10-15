import 'dart:io';

import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:multi_camera_photography_fe/main.dart';
import 'package:multi_camera_photography_fe/src/models/colors.dart';
import 'package:multi_camera_photography_fe/src/screens/home_screen.dart';
import 'package:multi_camera_photography_fe/src/views/list_of_available_workers.dart';
import 'package:multi_camera_photography_fe/src/views/start_collab_input_details.dart';
import 'package:nearby_connections/nearby_connections.dart';

class StartCollabScreen extends StatefulWidget {
  const StartCollabScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  // ignore: library_private_types_in_public_api
  _StartCollabScreenState createState() => _StartCollabScreenState();
}

class _StartCollabScreenState extends State<StartCollabScreen> with RouteAware {
  String collabName = '';
  bool workingMaster = false;
  String masterName = '';
  double maxDuration = 15;
  Directory selectedDirectory = Directory(FolderPicker.rootPath);
  bool inCollabDetailsScreen = true;
  bool startScanningForDevices = false;
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

  Future<void> _pickDirectory(BuildContext context) async {
    Directory directory = selectedDirectory;
    if (directory == null) {
      directory = Directory(FolderPicker.rootPath);
    }

    Directory? newDirectory = await FolderPicker.pick(
        allowFolderCreation: true,
        context: context,
        rootDirectory: directory,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))));
    if (newDirectory != null) {
      setState(() {
        selectedDirectory = newDirectory;
        print(selectedDirectory);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (!inCollabDetailsScreen) {
      setState(() {
        startScanningForDevices = true;
      });
    } else {
      setState(() {
        startScanningForDevices = false;
      });
    }
    return Scaffold(
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Start Collab',
                    style: GoogleFonts.crimsonPro(
                        fontWeight: FontWeight.w900,
                        fontSize: 50,
                        color: Colors.white),
                  )
                ]),
              ),
              AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  transform: Matrix4.translationValues(
                      inCollabDetailsScreen ? 0 : -1 * screenSize.width,
                      screenSize.height * 0.175,
                      0),
                  margin: EdgeInsets.fromLTRB(
                      screenSize.width * 0.1, 0, screenSize.width * 0.1, 0),
                  height: screenSize.height * 0.65,
                  width: screenSize.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: StartCollabInputDetails(
                      formKey: _formKey,
                      collabName: collabName,
                      workingMaster: workingMaster,
                      masterName: masterName,
                      maxDuration: maxDuration,
                      selectedDirectory: selectedDirectory,
                      valueChangedCallback: ((newValue) {
                        if (newValue is StartCollabInputDetailsInputParams) {
                          if (newValue.collabName != null) {
                            setState(() {
                              collabName = newValue.collabName as String;
                            });
                          }
                          if (newValue.workingMaster != null) {
                            setState(() {
                              workingMaster = newValue.workingMaster as bool;
                            });
                          }
                          if (newValue.masterName != null) {
                            setState(() {
                              masterName = newValue.masterName as String;
                            });
                          }
                          if (newValue.maxDuration != null) {
                            setState(() {
                              maxDuration = newValue.maxDuration as double;
                            });
                          }
                          if (newValue.selectedDirectory != null) {
                            setState(() {
                              selectedDirectory =
                                  newValue.selectedDirectory as Directory;
                            });
                          }
                        }
                      }))),
              AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  transform: Matrix4.translationValues(
                      inCollabDetailsScreen ? 1 * screenSize.width : 0,
                      screenSize.height * 0.175,
                      0),
                  margin: EdgeInsets.fromLTRB(
                      screenSize.width * 0.1, 0, screenSize.width * 0.1, 0),
                  constraints:
                      BoxConstraints(maxHeight: screenSize.height * 0.65),
                  width: screenSize.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: ListOfAvailableWorkers(
                    startScanning: !inCollabDetailsScreen,
                    masterName: masterName,
                    valueChangedCallback: ((value) {}),
                  )),
              AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  transform: Matrix4.translationValues(
                      inCollabDetailsScreen
                          ? 1 * screenSize.width + screenSize.width * 0.1
                          : screenSize.width * 0.1,
                      screenSize.width > 700
                          ? (screenSize.height * 0.1)
                          : screenSize.height * 0.12,
                      0),
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(
                      5, 5, screenSize.width > 700 ? 30 : 10, 0),
                  width: screenSize.width > 700 ? 50 : 30,
                  height: screenSize.width > 700 ? 50 : 30,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                        fixedSize: MaterialStateProperty.all(
                            Size(screenSize.width, 40)),
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(PaletteColors.purple4)),
                    onPressed: () async {
                      await Nearby().stopDiscovery();
                      setState(() {
                        inCollabDetailsScreen = true;
                      });
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: NeutralColors.white1,
                    ),
                  )),
              if (inCollabDetailsScreen)
                Container(
                    width: screenSize.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          transform: Matrix4.translationValues(
                              0, screenSize.height * 0.84, 0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: PaletteColors.purple2),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                minimumSize: MaterialStateProperty.all(
                                    Size(screenSize.width, 75)),
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  inCollabDetailsScreen = false;
                                });
                              }
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    )),
              if (inCollabDetailsScreen)
                (Container(
                  transform: Matrix4.translationValues(0, 35, 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                        maximumSize: MaterialStateProperty.all(
                            Size(screenSize.width, 40)),
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                  ),
                )),
            ],
          )),
    );
  }
}
