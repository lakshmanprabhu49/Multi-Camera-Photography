import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:multi_camera_photography_fe/main.dart';
import 'package:multi_camera_photography_fe/src/common/page_transition_slide_anim.dart';
import 'package:multi_camera_photography_fe/src/models/colors.dart';
import 'package:multi_camera_photography_fe/src/screens/start_collab_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  bool manageExternalStoragePermissionGranted = false;
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

  void getPermissions() async {
    var status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        setState(() {
          manageExternalStoragePermissionGranted = true;
        });
      } else if (status.isGranted) {
        setState(() {
          manageExternalStoragePermissionGranted = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    getPermissions();
    return Scaffold(
      backgroundColor: NeutralColors.white1,
      body: Container(
        width: screenSize.width * 1,
        height: screenSize.height * 0.5,
        child: Stack(children: [
          Transform.scale(
            scale: screenSize.width > 700 ? 3 : 2,
            child: Container(
              transform: Matrix4.translationValues(-130, -50, 0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PaletteColors.purple2.withOpacity(0.75),
              ),
            ),
          ),
          Transform.scale(
            scale: screenSize.width > 700 ? 1.5 : 1,
            child: Container(
              transform: Matrix4.translationValues(175, 50, 0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PaletteColors.pink2.withOpacity(0.75),
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(25, 30, 0),
            child: Text(
              'Hey there,',
              style: GoogleFonts.crimsonPro(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(100, 100, 0),
            child: Text(
              'what\'s up next ?',
              style: GoogleFonts.crimsonPro(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0, 175, 0),
            width: screenSize.width,
            height: 80,
            margin: EdgeInsets.symmetric(horizontal: 35),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                PageTransitionSlideAnim route =
                    PageTransitionSlideAnim(child: StartCollabScreen());
                Navigator.push(context, route);
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  minimumSize:
                      MaterialStateProperty.all(Size(screenSize.width, 80)),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      MaterialStateProperty.all(NeutralColors.white1)),
              child: Container(
                width: screenSize.width,
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Start a Collab',
                          style: GoogleFonts.crimsonPro(
                              fontSize: 32,
                              color: PaletteColors.purple2,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: PaletteColors.pink2,
                              size: 32,
                            ))
                      ]),
                ),
              ),
            ),
          ),
          Container(
              transform: Matrix4.translationValues(0, 275, 0),
              width: screenSize.width,
              margin: EdgeInsets.symmetric(horizontal: 35),
              height: 80,
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    minimumSize:
                        MaterialStateProperty.all(Size(screenSize.width, 80)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                        MaterialStateProperty.all(NeutralColors.white1)),
                child: Container(
                  width: screenSize.width,
                  child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Join a Collab',
                            style: GoogleFonts.crimsonPro(
                                fontSize: 32,
                                color: PaletteColors.pink2,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Icon(
                                Icons.image_search_outlined,
                                color: PaletteColors.purple2,
                                size: 32,
                              ))
                        ]),
                  ),
                ),
              )),
        ]),
      ),
    );
  }
}
