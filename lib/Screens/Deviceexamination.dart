import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:gallery_saver/gallery_saver.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resize/resize.dart';
import '/Screens/gpscamwithlocation.dart';
import '/models/devicequery.dart';

import '../constants.dart';
import '../models/DeviceExamination.dart';
import '../network/api_helper.dart';
import '../stayles.dart';
import '../utils/flutter_toast_util.dart';

String getDuration(DateTime? timeSinceLastTick) {
  print("time diff${DateTime.now()}");

  print('diffff' + ":git" + timeSinceLastTick!.toIso8601String());

  if (timeSinceLastTick == null) return '';

  Duration durationToSubtract = Duration(hours: 5, minutes: 30);
  print('clock ${timeSinceLastTick.add(durationToSubtract)}');
  DateTime timeparce = DateTime.parse(timeSinceLastTick.toIso8601String());
  print("actualdate ${DateTime.now().difference(timeparce).inSeconds}");
  int difference = DateTime.now()
      .difference(timeSinceLastTick.add(durationToSubtract))
      .inSeconds
      .abs();
  print(DateTime.now());
  print('diffff' + difference.toString());
  print('diffff' + (difference < 60).toString());
  if (difference < 0) return "";
  if (difference < 60) return difference.toString() + ' sec';
  if (difference < 3600) {
    return (difference / 60).floor().toString() + ' mins';
  }
  int hourDiff = DateTime.now().difference(timeSinceLastTick).inHours;
  if (hourDiff < 24) return hourDiff.toString() + ' hours';
  return DateTime.now().difference(timeSinceLastTick).inDays.toString() +
      'days';
}

class DeviceExamination extends StatefulWidget {
  const DeviceExamination({Key? key}) : super(key: key);

  @override
  State<DeviceExamination> createState() => DeviceExaminationState();
}

class DeviceExaminationState extends State<DeviceExamination> {
  int val = 1;
  static DeviceExaminationState? instance;
  List<TelematicModel> devicedata = [];
  String _address = '';
  bool loading = false;
  @override
  void initState() {
    instance = this;
    super.initState();
    _initializeCamera();
    _getCurrentLocation();
  }

  TextEditingController deviceid = new TextEditingController();
  TextEditingController wp = new TextEditingController();
  Position? _currentPosition;
  TextEditingController Fc = new TextEditingController();
  Future<void> scanQRpc() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#228B22', 'Cancel', true, ScanMode.QR);
      setState(() {
        deviceid.text = barcodeScanRes;
      });
    } on PlatformException {
      barcodeScanRes = 'Failed to get ';
    }
//barcode scanner flutter ant

    try {
      setState(() {
        deviceid.text = barcodeScanRes;
        print("after updating ${deviceid.text}");
        // _scanBarcode = barcodeScanRes;
      });
    } catch (e) {
      print("error is $e");
    }
  }

  List<String> imagePaths = ['', '', ''];
  List<String> items = [
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4',
    'Level 1,Level 2',
    'Level 1,Level 3',
    'Level 1,Level 4',
    'Level 2,Level 3',
    'Level 2,Level 4',
    'Level 3,Level 1',
    'Level 3,Level 4',
  ];
  String? selectedItem;
  String formatAddress(Map<String, dynamic> data) {
    final address = data['address'];
    // final street = address['village'] ?? '';
    // final area = address['state_district'] ?? '';
    // final city = address['city'] ?? '';
    // final state = address['state'] ?? '';
    // final country = address['country'] ?? '';
    // final postcode = address['postcode'] ?? '';
    //     address.replaceAll('{', '').replaceAll('}', '');
    return '${address}';
  }

  late CameraController _cameraController;
  Future<void>? _initializeCameraControllerFuture;

  Map<Permission, PermissionStatus>? statuses;

  Future requestPermissions() async {
    statuses = await [
      Permission.location,
      Permission.camera,
      // Permission.,
    ].request();

    if (statuses?[Permission.location] == PermissionStatus.denied) {
      requestPermissions(); // Handle denied location permission here
    }

    if (statuses?[Permission.camera] == PermissionStatus.denied) {
      requestPermissions();
      // Handle denied camera permission here
    }

    if (statuses?[Permission.microphone] == PermissionStatus.denied) {
      requestPermissions();
      // Handle denied microphone permission here
    }
  }

  Future<void> _getCurrentLocation() async {
    await requestPermissions();
    if (statuses?[Permission.location] == PermissionStatus.granted) {
      try {
        setState(() {
          loading = true;
        });

        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          _currentPosition = position;
        });
        getAddressFromCoordinates(position);
      } catch (e) {
        print('Error getting current location: $e');
      }
    } else {
      requestPermissions();
    }
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(firstCamera, ResolutionPreset.medium);
    await _cameraController.initialize();
    _initializeCameraControllerFuture = _cameraController.initialize();
    setState(() {});
  }

  Future<void> getAddressFromCoordinates(Position position) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}&zoom=18&addressdetails=1';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          var datarempce = formatAddress(data);
          String modifiedString =
              datarempce.replaceAll('{', '').replaceAll('}', '');
          _address = modifiedString;
          // Get.to(CameraScreen());
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  bool _isButtonEnabled = true;
  void _doTakeScreenshot(index) async {
    try {
      String? path = await FlutterNativeScreenshot.takeScreenshot();
      debugPrint('Screenshot taken, path: $path');
      if (path == null || path.isEmpty) {
        // _showSnackBar('Error taking the screenshot :(');
        return;
      } // if error
      // _showSnackBar('The screenshot has been saved to: $path');
      File imgFile = File(path);
      setState(() {
        imagePaths[index] = path;
      });
      final isSaved = await GallerySaver.saveImage(path);
      // _imgHolder = Image.file(imgFile);
    } catch (e) {
    } finally {
      await Future.delayed(Duration(seconds: 2)).then((value) {
        setState(() {
          _isButtonEnabled = true;
        });
      });
    }
  }

  Future<Widget> _openCamera(int index) async {
    void makefalse(index) async {
      setState(() {
        _isButtonEnabled = false;
      });
      await Future.delayed(Duration(seconds: 2)).then((value) {
        _doTakeScreenshot(index);
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeCameraControllerFuture!,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the camera controller has been initialized, show the camera preview
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CameraPreview(_cameraController),
                );
              } else {
                // Otherwise, show a loading indicator
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: EdgeInsets.only(bottom: 16.0),
          //     child: FloatingActionButton(
          //       child: Icon(Icons.camera),
          //       onPressed: _doTakeScreenshot,
          //     ),
          //   ),
          // ),
          Visibility(
            visible: _isButtonEnabled,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                  child: Icon(Icons.camera),
                  onPressed: () {
                    makefalse(index);
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                margin: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width - 30,
                color: Colors.black,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                          height: 35,
                        ),
                        Text(
                          "Lat:${_currentPosition?.latitude}",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Long:${_currentPosition?.longitude}",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Text(_address,
                        maxLines: 5,
                        softWrap: true,
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        imagePaths[index] = pickedFile.path;
      });
    }
  }

  bool laoding = false;
  int valiisue = 1;

  Future<List<TelematicModel>> getTelematics(String deviceList) async {
    setState(() {
      laoding = true;
    });
    List<TelematicModel> telematicDataMap = [];
    print('device list ${deviceList}');
    Map<String, dynamic> body = {'deviceList': deviceList};
    String path = 'http://20.219.2.201/farmer_mobile/telematic/devices';
    Map<String, dynamic> response =
        await ApiHelper().post(path: path, postData: body);

    if (response.isNotEmpty && (response['success'] ?? false)) {
      print('manoj telemetrics ${response["data"]}');
      if (response["data"] is List<dynamic>) {
        print(response['data'].length);
        for (int i = 0; i < response['data'].length; i++) {
          print(response['data'][i]);
          TelematicModel telematicModel =
              TelematicModel.fromJson(response['data'][i]);
          print(telematicModel.operatingMode.toString());
          print("telemetric model ${telematicModel.deviceID}");
          telematicDataMap.add(telematicModel);
          // telematicDataMap[telematicModel.deviceID!] = telematicModel;
          // print(telematicDataMap[telematicModel.deviceID!]!.deviceID.toString());
        }
        setState(() {
          laoding = false;
        });
        return telematicDataMap;
      }
    } else {
      setState(() {
        laoding = false;
      });
      // FlutterToastUtil.showErrorToast((response['message'] ?? ''));
    }
    setState(() {
      laoding = false;
    });
    return telematicDataMap;
  }

  Future getdata(devicid) async {
    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var path = "";
    if (val == 1) {
      path =
          "http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid/DeviceID";
    } else {
      path =
          "http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid/HardwareSerialNumber";
    }
    // 'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid';
    print(path);
    final dio = Dio();
    Map<String, dynamic> returnData = {};
    try {
      final response = await dio
          .get(path, options: Options(headers: header), queryParameters: {});
      if (response.statusCode == 200) {
        returnData = response.data;
        print(returnData);
      }
    } catch (e) {
      print("error is :$e");
      Fluttertoast.showToast(
          msg: 'Cannot get requested data, please try later: ${e.toString()}');
      print("error ios :" + e.toString());
    }
    return returnData;
  }

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final imageHeight = width * hight * 0.00015;
    final fontSizeheaders = width * hight * 0.00008;
    final fontSize = width * hight * 0.000045;
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    child: Image.asset(
                      'assets/images/cultyvate.png',
                      height: imageHeight,
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height / 20,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Farmer",
                              style: TextStyle(
                                  color: Color.fromRGBO(10, 192, 92, 2),
                                  fontSize: fontSizeheaders,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " Device Testing",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: fontSizeheaders,
                                  fontWeight: FontWeight.bold),
                            ),
                          ])),
                  Row(children: [
                    Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = int.parse(value.toString());
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    Text(
                      "Device ID",
                      style: iostextstyle(fontSize),
                    ),
                    Radio(
                      value: 2,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = int.parse(value.toString());
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    Text(
                      "Serial Number",
                      style: iostextstyle(fontSize),
                    ),
                    SizedBox(width: 5),
                  ]),
                  Row(children: [
                    Container(
                      // height: MediaQuery.of(context).size.height/12,
                      width: MediaQuery.of(context).size.width / 1.26,
                      padding: EdgeInsets.fromLTRB(20, 0, 5, 5),
                      child: TextFormField(
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[0-9a-zA-Z]")),
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
                        controller: deviceid,
                        decoration: InputDecoration(
                          labelText: val == 1 ? 'Device ID' : 'Serial Number',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          suffixIcon: IconButton(
                            iconSize: 50,
                            icon: Icon(MdiIcons.barcode),
                            onPressed: () => scanQRpc(),
                          ),
                          border: OutlineInputBorder(),
                          // counter: Offstage(),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.blueAccent),
                      onPressed: () async {
                        // BlocProvider.of<TimerBloc>(context).add(StartTimer(30));

                        if (deviceid.text.trim().length > 3) {
                          setState(() {
                            devicedata = [];
                            // errormessage = "";
                          });
                          // myBloc.add( FetchDataButtonPressedEvent(shouldCallApi1: val==1 ?true:false, farmerID: deviceid
                          //     .text));
                          // // BlocProvider.of<MyBloc>(context).add(
                          //     FetchDataButtonPressedEvent(shouldCallApi1: val==1 ?true:false, farmerID: deviceid
                          //         .text)
                          // );
                          // DashboardService dashboardService = DashboardService();
                          // setState((){
                          //   dataloading=true;
                          // });
                          // if(val==1) {
                          //   farmer = await dashboardService.getFarmer(deviceid
                          //       .text);
                          // }
                          // else {
                          //   farmer = await dashboardService.Serialnumberdevicetest(deviceid
                          //       .text);
                          // }
                          // setState((){
                          //   dataloading=false;
                          //   showfarmerDetails=true;
                          // });
                          // print(farmer);
                          devicedata =
                              await getTelematics(deviceid.text.trim());
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please Enter Valid Device Id",
                              backgroundColor: Colors.red);
                        }
                      },
                      child: Text(
                        "Search",
                        style: iostextstyle(fontSize),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ]),
                  laoding
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: devicedata.length,
                          itemBuilder: (BuildContext context, int index) {
                            // setState(() {
                            wp.text = devicedata[index].wp.toString();
                            Fc.text = devicedata[index].fc.toString();

                            // });
                            return Column(
                              children: [
                                Container(
                                  // width: MediaQuery.of(context).size.width * 0.45,
                                  margin: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: cultBlack),
                                      color: Colors.grey),
                                  height: 320,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            // margin: EdgeInsets.all(5),
                                            height: 350,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.40,
                                            child: ListView.builder(
                                                itemCount: imagePaths.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 20,
                                                                  right: 20),
                                                          width: 140,
                                                          height: 100,
                                                          color: Colors.grey,
                                                          child:
                                                              imagePaths[index]
                                                                      .isEmpty
                                                                  ? Row(
                                                                      children: [
                                                                        InkWell(
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                100,
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                Icon(
                                                                              Icons.camera_alt,
                                                                              size: 70,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          onTap:
                                                                              () async {
                                                                            print("manoj");
                                                                            final status =
                                                                                await Permission.location.request();
                                                                            final camerastatus =
                                                                                await Permission.camera.request();
                                                                            print(status);
                                                                            if (status.isGranted &&
                                                                                camerastatus.isGranted) {
                                                                              if (_currentPosition != null && _address != '') {
                                                                                Get.to(CameraScreen(
                                                                                  position: _currentPosition,
                                                                                  address: _address,
                                                                                  indexposition: index,
                                                                                ));
                                                                              } else {
                                                                                _getCurrentLocation();
                                                                              }
                                                                              // Permission granted, handle the location access
                                                                            } else if (status.isDenied) {
                                                                              await Permission.location.request();
                                                                              // Permission denied, handle the denial
                                                                            } else if (status.isPermanentlyDenied) {
                                                                              await Permission.location.request();
                                                                              // Permission permanently denied, show an error message or navigate to app settings
                                                                            }
                                                                          },
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              50,
                                                                        )
                                                                      ],
                                                                    )
                                                                  : Row(
                                                                      children: [
                                                                        InkWell(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                Image.file(File(imagePaths[index])),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return Dialog(
                                                                                      child: Container(
                                                                                    height: MediaQuery.of(context).size.height,
                                                                                    child: Image.file(
                                                                                      File(imagePaths[index]),
                                                                                    ),
                                                                                  ));
                                                                                });
                                                                          },
                                                                        ),
                                                                        IconButton(
                                                                          icon: Icon(
                                                                              Icons.delete,
                                                                              color: Colors.red),
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              imagePaths[index] = '';
                                                                              // Remove the image path from the list
                                                                              // imagePaths.removeAt(index);
                                                                            });
                                                                            // Delete button logic
                                                                          },
                                                                        ),
                                                                      ],
                                                                    )),
                                                    ],
                                                  );
                                                })),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(5, 10, 0, 5),
                                          // color:cultGreen,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
                                          // height: 150,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 15
                                                // top: 15,
                                                ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 15,
                                                    ),
                                                    child: Column(children: [
                                                      Container(
                                                          width: 10,
                                                          height: 55,
                                                          decoration: BoxDecoration(
                                                              color: ((devicedata[index].online ?? false) && devicedata[index].l1 != 0)
                                                                  ? (devicedata[index].l1Color == 'G'
                                                                      ? cultGreen
                                                                      : devicedata[index].l1Color == 'R'
                                                                          ? cultRed
                                                                          : cultYellow)
                                                                  : Colors.white,
                                                              border: Border.all(
                                                                width: 0.5,
                                                                color:
                                                                    cultBlack,
                                                              ))),
                                                      SizedBox(height: 2),
                                                      Container(
                                                          width: 10,
                                                          height: 55,
                                                          decoration: BoxDecoration(
                                                              color: ((devicedata[index].online ?? false) && devicedata[index].l2 != 0)
                                                                  ? (devicedata[index].l2Color == 'G'
                                                                      ? cultGreen
                                                                      : devicedata[index].l2Color == 'R'
                                                                          ? cultRed
                                                                          : cultYellow)
                                                                  : Colors.white,
                                                              border: Border.all(
                                                                width: 0.5,
                                                                color:
                                                                    cultBlack,
                                                              ))),
                                                      SizedBox(height: 2),
                                                      Container(
                                                          width: 10,
                                                          height: 55,
                                                          decoration: BoxDecoration(
                                                              color: ((devicedata[index].online ?? false) && devicedata[index].l3 != 0)
                                                                  ? (devicedata[index].l3Color == 'G'
                                                                      ? cultGreen
                                                                      : devicedata[index].l3Color == 'R'
                                                                          ? cultRed
                                                                          : cultYellow)
                                                                  : Colors.white,
                                                              border: Border.all(
                                                                width: 0.5,
                                                                color:
                                                                    cultBlack,
                                                              ))),
                                                      SizedBox(height: 2),
                                                      Container(
                                                          width: 10,
                                                          height: 55,
                                                          decoration: BoxDecoration(
                                                              color: ((devicedata[index].online ?? false) && devicedata[index].l4 != 0)
                                                                  ? (devicedata[index].l4Color == 'G'
                                                                      ? cultGreen
                                                                      : devicedata[index].l4Color == 'R'
                                                                          ? cultRed
                                                                          : cultYellow)
                                                                  : Colors.white,
                                                              border: Border.all(
                                                                width: 0.5,
                                                                color:
                                                                    cultBlack,
                                                              ))),
                                                    ]),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 40),
                                                    child: Column(children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                              (devicedata[index]
                                                                              .l1
                                                                              ?.round() ??
                                                                          0)
                                                                      .toString() +
                                                                  ' %',
                                                              style:
                                                                  iostextstyle(
                                                                      fontSize))
                                                        ],
                                                      ),
                                                      SizedBox(height: 40),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                              (devicedata[index]
                                                                              .l2
                                                                              ?.round() ??
                                                                          0)
                                                                      .toString() +
                                                                  ' %',
                                                              style:
                                                                  iostextstyle(
                                                                      fontSize))
                                                        ],
                                                      ),
                                                      SizedBox(height: 40),
                                                      Row(
                                                        children: [
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                              (devicedata[index]
                                                                              .l3
                                                                              ?.round() ??
                                                                          0)
                                                                      .toString() +
                                                                  ' %',
                                                              style:
                                                                  iostextstyle(
                                                                      fontSize))
                                                        ],
                                                      ),
                                                      SizedBox(height: 40),
                                                      Row(
                                                        children: [
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                              (devicedata[index]
                                                                              .l4
                                                                              ?.round() ??
                                                                          0)
                                                                      .toString() +
                                                                  ' %',
                                                              style:
                                                                  iostextstyle(
                                                                      fontSize))
                                                        ],
                                                      ),
                                                    ]),
                                                  ),
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      width: 80,
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                'Soil Moisture',
                                                                maxLines: 3,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    iostextstylebold(
                                                                        fontSize),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                                (((devicedata[index].l1 ?? 0) + (devicedata[index].l2 ?? 0) + (devicedata[index].l3 ?? 0) + (devicedata[index].l4 ?? 0)) /
                                                                            4)
                                                                        .round()
                                                                        .toString() +
                                                                    '%',
                                                                style: iostextstylebold(
                                                                    fontSize)),
                                                            SizedBox(height: 5),
                                                            Text(
                                                                getDuration(
                                                                    devicedata[
                                                                            index]
                                                                        .sensorDataPacketDateTime),
                                                                style:
                                                                    iostextstylegrey(
                                                                        fontSize))
                                                          ])),
                                                ]),
                                          ),
                                        ),

                                        // Padding(
                                        //   padding: EdgeInsets.symmetric(
                                        //       vertical: 20),
                                        //   child: Column(children: [
                                        //     Row(
                                        //       crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //       mainAxisAlignment:
                                        //       MainAxisAlignment.start,
                                        //       children: [
                                        //         const SizedBox(width: 5),
                                        //         Text(
                                        //           (telematicData[soilMoistureDevice
                                        //               ?.deviceEUIID]
                                        //               ?.l1
                                        //               ?.round() ??
                                        //               0)
                                        //               .toString() +
                                        //               ' %',
                                        //           style: TextStyle(
                                        //               fontSize:
                                        //               footerFont),
                                        //         )
                                        //       ],
                                        //     ),
                                        //     SizedBox(height: 15),
                                        //     Row(
                                        //       mainAxisAlignment:
                                        //       MainAxisAlignment.start,
                                        //       children: [
                                        //         const SizedBox(width: 5),
                                        //         Text(
                                        //           (telematicData[soilMoistureDevice
                                        //               ?.deviceEUIID]
                                        //               ?.l2
                                        //               ?.round() ??
                                        //               0)
                                        //               .toString() +
                                        //               ' %',
                                        //           style: TextStyle(
                                        //               fontSize:
                                        //               footerFont),
                                        //         )
                                        //       ],
                                        //     ),
                                        //     SizedBox(height: 15),
                                        //     Row(
                                        //       children: [
                                        //         const SizedBox(width: 5),
                                        //         Text(
                                        //           (telematicData[soilMoistureDevice
                                        //               ?.deviceEUIID]
                                        //               ?.l3
                                        //               ?.round() ??
                                        //               0)
                                        //               .toString() +
                                        //               ' %',
                                        //           style: TextStyle(
                                        //               fontSize:
                                        //               footerFont),
                                        //         )
                                        //       ],
                                        //     ),
                                        //     SizedBox(height: 15),
                                        //     Row(
                                        //       children: [
                                        //         const SizedBox(width: 5),
                                        //         Text(
                                        //           (telematicData[soilMoistureDevice
                                        //               ?.deviceEUIID]
                                        //               ?.l4
                                        //               ?.round() ??
                                        //               0)
                                        //               .toString() +
                                        //               ' %',
                                        //           style: TextStyle(
                                        //               fontSize:
                                        //               footerFont),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ]),
                                        // ),
                                      ]),
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Ok",
                                              style: iostextstyle(fontSize),
                                            ),
                                            Radio(
                                                value: 1,
                                                groupValue: valiisue,
                                                onChanged: (val) {
                                                  setState(() {
                                                    valiisue = 1;
                                                  });
                                                }),
                                            Text(
                                              "Issue Found",
                                              style: iostextstyle(fontSize),
                                            ),
                                            Radio(
                                                value: 2,
                                                groupValue: valiisue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    valiisue = 2;
                                                  });
                                                })
                                          ],
                                        ),
                                        Visibility(
                                          visible: valiisue == 2,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              hint: Text(
                                                'Select Type',
                                                style: TextStyle(
                                                  fontSize: fontSize,
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                ),
                                              ),
                                              items: items
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                            fontSize: fontSize,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: selectedItem,
                                              onChanged: (value) {
                                                // if(value=='Farmland'){
                                                setState(() {
                                                  // markercolor=Colors.red;
                                                  // color=Colors.red.withOpacity(0.2);
                                                  // polygrm.add([]);
                                                  // if(polygrm.length>1){
                                                  //   i=i+1;
                                                  // }
                                                  selectedItem =
                                                      value.toString();
                                                });

                                                // }
                                                // else if(value=='Block'){
                                                //   setState(() {
                                                //     color= Colors.blue.withOpacity(0.2);
                                                //     markercolor=Colors.blue;
                                                //     polygrm.add([]);
                                                //     if(polygrm.length>1){
                                                //       i=i+1;
                                                //     }
                                                //     selectedItem =  value as String;
                                                //   });
                                                // }
                                                // else if(value=='Plot'){
                                                //   setState(() {
                                                //     markercolor=Colors.brown;
                                                //     color= Colors.brown.withOpacity(0.5);
                                                //     polygrm.add([]);
                                                //     if(polygrm.length>1){
                                                //       i=i+1;
                                                //     }
                                                //     selectedItem =  value as String;
                                                //   });
                                                // }
                                                // else if (value=='Virtual Sensor'){
                                                //   setState(() {
                                                //     markercolor=Colors.green;
                                                //     selectedItem =  value as String;
                                                //   });
                                                // }
                                                // else{
                                                //   setState(() {
                                                //     markercolor=Colors.amberAccent;
                                                //     selectedItem =  value as String;
                                                //   });
                                                // }
                                                //
                                                // setState(() {
                                                //   selectedItem = value as String;
                                                // });
                                              },
                                              buttonStyleData:
                                                  const ButtonStyleData(
                                                height: 40,
                                                width: 140,
                                              ),
                                              menuItemStyleData:
                                                  const MenuItemStyleData(
                                                height: 40,
                                              ),
                                            ),

                                            //   DropdownButton<String>(
                                            //     hint:  Text("Select Type ",style: TextStyle(color: Colors.white),),
                                            //     value: selectedItem,
                                            //     iconEnabledColor: Colors.white,
                                            //     iconDisabledColor: Colors.white,
                                            //     iconSize: 15,
                                            //     dropdownColor: markercolor,
                                            // enableFeedback: true,
                                            //     items: items.map((String value) {
                                            //       return DropdownMenuItem<String>(
                                            //         value: value,
                                            //
                                            //         child: Center(
                                            //           // alignment: Alignment.center, // Align the text to the center
                                            //           child: Text("$value",textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                            //         ),
                                            //       );
                                            //     }).toList(),
                                            //     onChanged: (String? newValue) {
                                            //       if(newValue=='Farm'){
                                            //         setState(() {
                                            //           markercolor=Colors.red;
                                            //           color=Colors.red.withOpacity(0.2);
                                            //           polygrm.add([]);
                                            //           if(polygrm.length>1){
                                            //             i=i+1;
                                            //           }
                                            //           selectedItem = newValue;
                                            //         });
                                            //
                                            //       }
                                            //       else if(newValue=='Block'){
                                            //         setState(() {
                                            //           color= Colors.blue.withOpacity(0.2);
                                            //           markercolor=Colors.blue;
                                            //           polygrm.add([]);
                                            //           if(polygrm.length>1){
                                            //             i=i+1;
                                            //           }
                                            //           selectedItem = newValue;
                                            //         });
                                            //       }
                                            //       else if(newValue=='Plot'){
                                            //         setState(() {
                                            //           markercolor=Colors.brown;
                                            //           color= Colors.brown.withOpacity(0.5);
                                            //           polygrm.add([]);
                                            //           if(polygrm.length>1){
                                            //             i=i+1;
                                            //           }
                                            //           selectedItem = newValue;
                                            //         });
                                            //       }
                                            //       else if (newValue=='V Sensor'){
                                            //         setState(() {
                                            //           markercolor=Colors.green;
                                            //           selectedItem = newValue;
                                            //         });
                                            //       }
                                            //       else{
                                            //         setState(() {
                                            //           markercolor=Colors.amberAccent;
                                            //           selectedItem = newValue;
                                            //         });
                                            //       }
                                            //     },
                                            //
                                            //     underline:SizedBox(),
                                            //   )
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // Text('More'),
                                      Text(
                                        "WP",
                                        style: iostextstyle(fontSize),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        child: TextField(
                                          controller: wp,
                                          decoration: new InputDecoration(
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "FC",
                                        style: iostextstyle(fontSize),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        child: TextField(
                                          controller: Fc,
                                          decoration: new InputDecoration(
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                valiisue == 1
                                    ? Flat3dButton.text(
                                        onPressed: () => print('clicked'),
                                        color: Colors.green,
                                        text: 'Save',
                                      )
                                    : Flat3dButton.text(
                                        onPressed: () => print('clicked'),
                                        color: Colors.red,
                                        text: 'Raise Ticket',
                                      ),
                              ],
                            );
                          })
                ])));
  }
}

String formatAddress(Map<String, dynamic> data) {
  final address = data['address'];
  // final street = address['village'] ?? '';
  // final area = address['state_district'] ?? '';
  // final city = address['city'] ?? '';
  // final state = address['state'] ?? '';
  // final country = address['country'] ?? '';
  // final postcode = address['postcode'] ?? '';
  //     address.replaceAll('{', '').replaceAll('}', '');
  return '${address}';
}
