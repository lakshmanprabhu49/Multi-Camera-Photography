import 'dart:io';

import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_camera_photography_fe/src/common/common.dart';
import 'package:multi_camera_photography_fe/src/models/colors.dart';
import 'package:multi_camera_photography_fe/src/models/device.dart';
import 'package:multi_camera_photography_fe/src/static/directory_handler_static_class.dart';
import 'package:nearby_connections/nearby_connections.dart';

class ListOfAvailableWorkersInputParams {
  bool? startScanning;
  String? masterName;
  ListOfAvailableWorkersInputParams({
    this.startScanning,
    this.masterName,
  });
}

class ListOfAvailableWorkers extends StatefulWidget {
  bool startScanning;
  String masterName;
  ValueChangedCallback valueChangedCallback;
  ListOfAvailableWorkers(
      {Key? key,
      required this.startScanning,
      required this.masterName,
      required this.valueChangedCallback})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ListOfAvailableWorkersState createState() => _ListOfAvailableWorkersState(
        startScanning: startScanning,
        masterName: masterName,
        valueChangedCallback: valueChangedCallback,
      );
}

class _ListOfAvailableWorkersState extends State<ListOfAvailableWorkers> {
  bool startedScanning = false;
  bool refresh = false;
  bool startScanning;
  String masterName;
  // List<Device> devices = List.empty(growable: true);
  List<Device> devices = [
    // Device(
    //     id: "1",
    //     name: "Worker1",
    //     endpointId: "",
    //     isConnected: true,
    //     isAvailable: true),
    // Device(
    //     id: "2",
    //     name: "Worker2",
    //     endpointId: "",
    //     isConnected: false,
    //     isAvailable: true)
  ];
  Nearby nearby = Nearby();
  ValueChangedCallback valueChangedCallback;
  _ListOfAvailableWorkersState(
      {Key? key,
      required this.startScanning,
      required this.masterName,
      required this.valueChangedCallback});

  void startDiscoveringPeers() async {
    try {
      bool a = await nearby.startDiscovery(
        masterName,
        Strategy.P2P_CLUSTER,
        onEndpointFound: (String id, String userName, String endpointId) {
          // called when an advertiser is found
          devices.add(Device(
              id: id,
              name: userName,
              endpointId: endpointId,
              isConnected: false,
              isAvailable: true));
          setState(() {
            refresh = !refresh;
          });
        },
        onEndpointLost: (String? id) {
          if (id != null) {
            devices.removeWhere((device) => device.id == id);
            nearby.disconnectFromEndpoint(id);
          }
          //called when an advertiser is lost (only if we weren't connected to it )
        },
        serviceId: "com.yourdomain.appname", // uniquely identifies your app
      );
    } catch (exception) {
      // platform exceptions like unable to start bluetooth or insufficient permissions
      print(exception);
    }
  }

  void connectToPeer(Device device, String masterName) async {
    // to be called by discover whenever an endpoint is found
// callbacks are similar to those in startAdvertising method
    try {
      Nearby().requestConnection(
        masterName,
        device.id,
        onConnectionInitiated: (id, info) {},
        onConnectionResult: (id, status) {
          if (status == Status.CONNECTED) {
            Device currentDevice =
                devices.firstWhere((device) => device.id == id);
            devices = devices.map((device) {
              if (device.id == id) {
                return Device(
                    id: id,
                    name: device.name,
                    endpointId: device.id,
                    isConnected: true,
                    isAvailable: true);
              } else {
                return device;
              }
            }).toList();
            setState(() {
              devices = devices;
            });
          }
        },
        onDisconnected: (id) {
          Device currentDevice =
              devices.firstWhere((device) => device.id == id);
          devices = devices.map((device) {
            if (device.id == id) {
              return Device(
                  id: id,
                  name: device.name,
                  endpointId: device.id,
                  isConnected: false,
                  isAvailable: true);
            } else {
              return device;
            }
          }).toList();
        },
      );
    } catch (exception) {
      // called if request was invalid
    }
  }

  void disconnectFromPeer(Device device) async {
    // to be called by discover whenever an endpoint is found
// callbacks are similar to those in startAdvertising method
    try {
      Nearby().disconnectFromEndpoint(
        device.id,
      );
    } catch (exception) {
      // called if request was invalid
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (widget.startScanning && !startedScanning) {
      setState(() {
        startedScanning = true;
      });
      Nearby().stopDiscovery().then((value) {
        startDiscoveringPeers();
      });
    } else if (startedScanning && !widget.startScanning) {
      setState(() {
        startedScanning = false;
      });
      Nearby().stopDiscovery().then((value) {});
    }
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: screenSize.width,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'List of available workers',
                    style: GoogleFonts.yesevaOne(
                        fontWeight: FontWeight.w500,
                        color: PaletteColors.purple4,
                        fontSize: screenSize.width > 700
                            ? screenSize.width * 30 / 700
                            : 20),
                  ),
                )
              ]),
        ),
        Container(
          child: ListView.builder(
            itemCount: devices.length,
            itemBuilder: ((context, index) {
              return Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(
                      color: NeutralColors.white1,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: NeutralColors.white2,
                            offset: Offset(0, -6),
                            blurRadius: 4),
                        BoxShadow(
                            color: NeutralColors.white2,
                            offset: Offset(0, 6),
                            blurRadius: 4)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                '${devices[index].name}',
                                style: GoogleFonts.yesevaOne(
                                  fontSize: 25,
                                  color: PaletteColors.purple2,
                                ),
                              )),
                          Text(
                            devices[index].isConnected
                                ? 'Connected'
                                : (devices[index].isAvailable
                                    ? 'Available'
                                    : 'Not Available'),
                            style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 15,
                                color: devices[index].isConnected
                                    ? SemanticColors.green1
                                    : (devices[index].isAvailable
                                        ? SemanticColors.blue1
                                        : SemanticColors.red1)),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    !devices[index].isConnected
                                        ? SemanticColors.green1
                                        : SemanticColors.red1)),
                            child: Text(
                              devices[index].isConnected
                                  ? 'Disconnect'
                                  : 'Connect',
                              style: GoogleFonts.crimsonPro(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            onPressed: (() {
                              if (devices[index].isConnected) {
                                // Need to disconnect
                                disconnectFromPeer(devices[index]);
                              } else {
                                // Need to connect
                                connectToPeer(
                                    devices[index], widget.masterName);
                              }
                            })),
                      )
                    ],
                  ));
            }),
            shrinkWrap: true,
          ),
        ),
        Container(child: Text('Hi'))
      ],
    ));
  }
}
