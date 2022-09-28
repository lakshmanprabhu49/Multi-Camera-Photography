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

class StartCollabScreen extends StatefulWidget {
  const StartCollabScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  // ignore: library_private_types_in_public_api
  _StartCollabScreenState createState() => _StartCollabScreenState();
}

class _StartCollabScreenState extends State<StartCollabScreen> with RouteAware {
  bool workingMaster = false;
  double maxDuration = 0;
  Directory selectedDirectory = Directory(FolderPicker.rootPath);
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
              Container(
                  transform: Matrix4.translationValues(0, 35, 0),
                  padding:
                      EdgeInsets.fromLTRB(screenSize.width * 0.01, 0, 0, 0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent),
                          elevation: MaterialStatePropertyAll(0)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_outlined,
                        size: 40,
                        color: Colors.white,
                      ))),
              Container(
                  transform:
                      Matrix4.translationValues(0, screenSize.height * 0.15, 0),
                  margin: EdgeInsets.fromLTRB(
                      screenSize.width * 0.1, 0, screenSize.width * 0.1, 0),
                  height: screenSize.height * 0.65,
                  width: screenSize.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: screenSize.width * 0.75,
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            alignment: Alignment.center,
                            child: Text(
                              'Collab Details',
                              style: GoogleFonts.yesevaOne(
                                  fontSize: 30,
                                  color: PaletteColors.pink3,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            width: screenSize.width * 0.75,
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            alignment: Alignment.centerLeft,
                            child: Text('Collab Name',
                                style: GoogleFonts.yesevaOne(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                    color: PaletteColors.purple2)),
                          ),
                          Container(
                            width: screenSize.width * 0.75,
                            height: 50,
                            margin: EdgeInsets.fromLTRB(15, 10, 10, 5),
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            decoration: BoxDecoration(
                                color: NeutralColors.white1,
                                border: Border.all(color: NeutralColors.white2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            alignment: Alignment.centerLeft,
                            child: TextFormField(
                              maxLength: 10,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  fillColor: NeutralColors.white1,
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none)),
                              style: GoogleFonts.abel(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                  color: PaletteColors.purple3,
                                  backgroundColor: NeutralColors.white1),
                            ),
                          ),
                          // TODO: add working master
                          Container(
                            width: screenSize.width * 0.75,
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Working Master',
                                      style: GoogleFonts.yesevaOne(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20,
                                          color: PaletteColors.pink2)),
                                  Transform.scale(
                                      scale: 1.3,
                                      child: Switch(
                                          value: workingMaster,
                                          activeColor: PaletteColors.pink3,
                                          activeTrackColor: PaletteColors.pink1,
                                          onChanged: (newValue) {
                                            setState(() {
                                              workingMaster = newValue;
                                            });
                                          }))
                                ]),
                          ),
                          Container(
                            width: screenSize.width * 0.75,
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            alignment: Alignment.centerLeft,
                            child: Text('Master Name',
                                style: GoogleFonts.yesevaOne(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                    color: PaletteColors.purple2)),
                          ),
                          Container(
                            width: screenSize.width * 0.75,
                            height: 50,
                            margin: EdgeInsets.fromLTRB(15, 10, 10, 5),
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            decoration: BoxDecoration(
                                color: NeutralColors.white1,
                                border: Border.all(color: NeutralColors.white2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            alignment: Alignment.centerLeft,
                            child: TextFormField(
                              maxLength: 10,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  fillColor: NeutralColors.white1,
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none)),
                              style: GoogleFonts.abel(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                  color: PaletteColors.purple3,
                                  backgroundColor: NeutralColors.white1),
                            ),
                          ),
                          Container(
                            width: screenSize.width * 0.75,
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            alignment: Alignment.centerLeft,
                            child: Text('Max Duration (mins)',
                                style: GoogleFonts.yesevaOne(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                    color: PaletteColors.pink2)),
                          ),
                          Slider.adaptive(
                              value: maxDuration,
                              min: 0,
                              max: 60,
                              divisions: 4,
                              label: '$maxDuration mins',
                              activeColor: PaletteColors.pink1,
                              thumbColor: PaletteColors.pink3,
                              onChanged: (newValue) {
                                setState(() {
                                  maxDuration = newValue;
                                });
                              }),
                          Container(
                            width: screenSize.width * 0.75,
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('File Storage Location',
                                      style: GoogleFonts.yesevaOne(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20,
                                          color: PaletteColors.purple2)),
                                  Container(
                                      width: 35,
                                      height: 35,
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              padding: MaterialStatePropertyAll(
                                                  EdgeInsets.zero),
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      PaletteColors.purple4),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      NeutralColors.white1)),
                                          onPressed: () {
                                            _pickDirectory(context);
                                          },
                                          child: Icon(
                                            Icons.folder_open_outlined,
                                            size: 30,
                                            color: PaletteColors.purple1,
                                          ))),
                                ]),
                          ),
                          Container(
                            width: screenSize.width * 0.75,
                            height: 50,
                            margin: EdgeInsets.fromLTRB(15, 10, 10, 5),
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            decoration: BoxDecoration(
                                color: NeutralColors.white1,
                                border: Border.all(color: NeutralColors.white2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    '${selectedDirectory.path}',
                                    style: GoogleFonts.abel(
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal,
                                        color: PaletteColors.purple3,
                                        backgroundColor: NeutralColors.white1),
                                  )),
                            ),
                          ),
                        ]),
                  )),
              Container(
                  width: screenSize.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        transform: Matrix4.translationValues(
                            0, screenSize.height * 0.825, 0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: PaletteColors.purple2),
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              minimumSize: MaterialStateProperty.all(
                                  Size(screenSize.width, 75)),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: () {},
                          child: Icon(
                            Icons.arrow_forward,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
