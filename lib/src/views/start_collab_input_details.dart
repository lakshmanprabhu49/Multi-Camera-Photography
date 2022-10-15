import 'dart:io';

import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_camera_photography_fe/src/common/common.dart';
import 'package:multi_camera_photography_fe/src/models/colors.dart';
import 'package:multi_camera_photography_fe/src/static/directory_handler_static_class.dart';

class StartCollabInputDetailsInputParams {
  String? collabName;
  bool? workingMaster;
  String? masterName;
  double? maxDuration;
  Directory? selectedDirectory;
  StartCollabInputDetailsInputParams(
      {this.collabName,
      this.workingMaster,
      this.masterName,
      this.maxDuration,
      this.selectedDirectory});
}

class StartCollabInputDetails extends StatelessWidget {
  String collabName;
  bool workingMaster;
  String masterName;
  double maxDuration;
  Directory selectedDirectory;
  ValueChangedCallback valueChangedCallback;
  GlobalKey<FormState> formKey;
  StartCollabInputDetails(
      {Key? key,
      required GlobalKey<FormState> this.formKey,
      required this.collabName,
      required this.workingMaster,
      required this.masterName,
      required this.maxDuration,
      required this.selectedDirectory,
      required this.valueChangedCallback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              alignment: Alignment.centerLeft,
              child: TextFormField(
                maxLength: 10,
                validator: (value) {
                  return value!.length < 3
                      ? 'Please enter atleast 3 characters'
                      : null;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    fillColor: NeutralColors.white1,
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
                style: GoogleFonts.abel(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: PaletteColors.purple3,
                    backgroundColor: NeutralColors.white1),
                onChanged: (newValue) {
                  valueChangedCallback(
                      StartCollabInputDetailsInputParams(collabName: newValue));
                },
              ),
            ),
            // TODO: add working master
            Container(
              width: screenSize.width * 0.75,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              valueChangedCallback(
                                  StartCollabInputDetailsInputParams(
                                      workingMaster: newValue));
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
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              alignment: Alignment.centerLeft,
              child: TextFormField(
                maxLength: 10,
                validator: (value) {
                  return value!.length < 3
                      ? 'Please enter atleast 3 characters'
                      : null;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    fillColor: NeutralColors.white1,
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
                style: GoogleFonts.abel(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: PaletteColors.purple3,
                    backgroundColor: NeutralColors.white1),
                onChanged: (newValue) {
                  valueChangedCallback(
                      StartCollabInputDetailsInputParams(masterName: newValue));
                },
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
                min: 10,
                max: 60,
                divisions: 4,
                label: '$maxDuration mins',
                activeColor: PaletteColors.pink1,
                thumbColor: PaletteColors.pink3,
                onChanged: (newValue) {
                  valueChangedCallback(StartCollabInputDetailsInputParams(
                      maxDuration: newValue));
                }),
            Container(
              width: screenSize.width * 0.75,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              alignment: Alignment.centerLeft,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('File Storage Location',
                        style: GoogleFonts.yesevaOne(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            color: PaletteColors.purple2)),
                    Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                padding:
                                    MaterialStatePropertyAll(EdgeInsets.zero),
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    PaletteColors.purple4),
                                foregroundColor: MaterialStateProperty.all(
                                    NeutralColors.white1)),
                            onPressed: () {
                              DirectoryHandlerStaticClass.pickDirectory(
                                      context, selectedDirectory)
                                  .then((newValue) {
                                valueChangedCallback(
                                    StartCollabInputDetailsInputParams(
                                        selectedDirectory: newValue));
                              });
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
                  borderRadius: BorderRadius.all(Radius.circular(30))),
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
        ));
  }
}
