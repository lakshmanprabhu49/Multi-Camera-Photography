import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_camera_photography_fe/src/common/common.dart';
import 'package:multi_camera_photography_fe/src/models/colors.dart';

class JoinCollabInputDetailsInputParams {
  String? workerName;
  String? masterName;
  JoinCollabInputDetailsInputParams({
    this.workerName,
    this.masterName,
  });
}

class JoinCollabInputDetails extends StatelessWidget {
  String workerName;
  String masterName;
  GlobalKey<FormState> formKey;
  ValueChangedCallback valueChangedCallback;
  JoinCollabInputDetails(
      {Key? key,
      required this.formKey,
      required this.masterName,
      required this.workerName,
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
              child: Text('Worker Name',
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
                initialValue: workerName,
                validator: (value) {
                  return value!.length < 3
                      ? 'Please enter atleast 3 characters'
                      : null;
                },
                maxLength: 10,
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
                onChanged: ((newValue) {
                  valueChangedCallback(
                      JoinCollabInputDetailsInputParams(workerName: newValue));
                }),
              ),
            ),
            Container(
              width: screenSize.width * 0.75,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              alignment: Alignment.centerLeft,
              child: Text('Master Name',
                  style: GoogleFonts.yesevaOne(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: PaletteColors.pink2)),
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
                validator: (value) {
                  return value!.length < 3
                      ? 'Please enter atleast 3 characters'
                      : null;
                },
                initialValue: masterName,
                maxLength: 10,
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
                onChanged: ((newValue) {
                  valueChangedCallback(
                      JoinCollabInputDetailsInputParams(masterName: newValue));
                }),
              ),
            ),
          ]),
        ));
  }
}
