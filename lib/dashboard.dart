import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import '../Screens/Devicequery.dart';
import '../Screens/Farmer_Plot_Maping/Screens/farmer_Acusation_mapping.dart';
import '../Screens/farmerAccusation/Farmeraccasation.dart';
import '../Screens/Innternetcheck/internet.dart';
import '../Screens/Permissiondenydiloag.dart';
import '../Screens/farmerAccusation/bloc/acausationblock.dart';
import '../Screens/farmerAccusation/sqllite.dart';
import '../Screens/farmerdevicemap.dart';
import '../Screens/farmerdevices_locations.dart';
import '../Screens/farmermapdatadetails.dart';
import '../Screens/gpscam.dart';
import '../googlemap.dart';
import '../main.dart';
import '../models/loginAppaccess.dart';
import '../scanpage.dart';
import '../servicemodeblock/servicemodescreen.dart';
import '../stayles.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Deviceexamination.dart';
import 'Screens/devicetesting.dart';
import 'Screens/farmerAccusation/model_classes/farmer_model_saving.dart';
import 'Screens/googlemapdraw.dart';
import 'Screens/scannerFarmerDetails.dart';
import 'Screens/service_mode.dart';
import 'constants.dart';
import 'login/sql_lite_localstorage.dart';

class Dashboard extends StatefulWidget {
  final farmerId;
  final visuble;
  final Version;
  final ServiceAPPlogin;
  final heghtofscreen;
  final widthofscreen;
  const Dashboard(
      {required this.heghtofscreen,
      required this.widthofscreen,
      required this.ServiceAPPlogin,
      required this.Version,
      required this.farmerId,
      required this.visuble})
      : super();

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool drawerIsOpen = false;
  final ConnectivityController _controller = ConnectivityController();

  bool desable = true;
  // Location ?location;
  LocationData? mylocation;
  var versionglobaly = "";
  final GlobalKey<DrawerControllerState> _drawerKey =
      GlobalKey<DrawerControllerState>();

  Future<void> checkAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versioncode = packageInfo.version;
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String buildNumber = packageInfo.buildNumber;
    setState(() {
      versionglobaly = versioncode;
    });
  }

  bool getCanViewValue(
      List<ServiceAPPlogins>? appAccessDataList, String optionName) {
    // Use the firstWhere method to find the AppAccessData object with the given optionName
    ServiceAPPlogins? appAccessData = appAccessDataList?.firstWhere(
      (element) => element.optionName == optionName,
    );

    // Check if the AppAccessData object is found and return the canView value
    return appAccessData?.canViewYN ?? false;
  }

  var instalationlength = 0;
  var hight = 0;
  var width = 0;
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late PostsBloc _postsBloc;
  late FarmerDatabaseHelper _dbHelper;

  @override
  void initState() {
    checkAppVersion();
    // Check_sql_lite_records();
    instalationlength = getOptionCountWithCanView(widget.ServiceAPPlogin);
    // TODO: implement initState
    super.initState();
    _connectivity = Connectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnection);
    _postsBloc = PostsBloc();
    _dbHelper = FarmerDatabaseHelper.instance;

    _checkAndUploadRecords();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    // hight=Me

    // Use MediaQuery here, or perform other initializations based on inherited widgets.
  }

  List<Map<String, dynamic>> allwidgets = [];
  List<Map<String, dynamic>> allwidgetsTab2 = [];
  List<Map<String, dynamic>> allwidgetsTab3 = [];

// Check_sql_lite_records()async{
//   await _controller.checkConnectivity();
//   if(_controller.connectivityResult != ConnectivityResult.none) {
//     final PostsBloc postsBloc = PostsBloc();
//     final dbHelper = FarmerDatabaseHelper.instance;
//     await dbHelper.initDatabase();
//     List<FarmerAcusationDart> farmerdata = await dbHelper.getFarmrdata();
//     if (farmerdata.length > 0) {
//      for(int i=0;i<farmerdata.length;i++) {
//        postsBloc.add(PostFarmerData(body: farmerdata[i], locally: true));
//      }
//     }
//   }
// }

  void _updateConnection(ConnectivityResult result) {
    _checkAndUploadRecords();
  }

  Future<void> _checkAndUploadRecords() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      await _uploadRecords();
    }
  }

  Future<void> _uploadRecords() async {
    await _dbHelper.initDatabase();
    List<FarmerAcusationDart> farmerData = await _dbHelper.getFarmrdata();

    if (farmerData.isNotEmpty) {
      for (int i = 0; i < farmerData.length; i++) {
        _postsBloc.add(PostFarmerData(body: farmerData[i], locally: true));
      }
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  List<ServiceAPPlogins> Tab1list = [];
  List<ServiceAPPlogins> Tab2list = [];
  List<ServiceAPPlogins> Tab3list = [];
  int tab1active = 0;
  int tab2active = 0;
  int tab3active = 0;
  var tab = 0;

  int getOptionCountWithCanView(List<ServiceAPPlogins>? appAccessDataList) {
    final imageHeight = widget.widthofscreen * widget.heghtofscreen * 0.00015;
    final fontSize = widget.widthofscreen * widget.heghtofscreen * 0.000045;
    allwidgets = [];
    List<String> optionNames = [
      'ServAppDeviceQuery',
      'ServAppDeviceServiceMode',
      'ServAppDeviceCalibration',
      'ServAppScanFarmerDetails',
      'ServAppFarmerDeviceLocation',
      'ServAppFarmerPlotMapping',
      'ServAppGPSCam'
    ];
    List<String> optionNamesTab2 = [
      'ServAppDeviceMap',
      'ServAppFarmerDeviceTesting'
    ];
    List<String> optionNamesTab3 = [
      'ServAppFarmerAcquisition',
      'ServAppFarmerAcquisitionPlotMapping'
    ];

    Set<String> addedOptionNames = {};
    Set<String> addedOptionNamesTab2 = {};
    Set<String> addedOptionNamesTab3 = {};
    appAccessDataList?.forEach((element) {
      if (optionNames.contains(element.optionName)) {
        if (!addedOptionNames.contains(element.optionName)) {
          if (element.optionName == 'ServAppDeviceQuery') {
            allwidgets.add({
              'optionName': element.optionName,
              'widget': Stack(
                children: [
                  InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: widget.heghtofscreen *
                            0.15, // Adjust the height as needed
                        width: widget.widthofscreen * 0.4,
                        // width: MediaQuery.of(context).size.width/2.5,
                        // height:120,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: element.canViewYN == true
                                ? Colors.white
                                : Colors.grey,
                            border: Border.all(
                                color: element.canViewYN == true
                                    ? Colors.white
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        // height: 60,
                        // width: ScreenUtil.defaultSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(padding: EdgeInsets.only(top: 0)),
                            // Row(
                            //   children: [
                            Center(
                                child: Image.asset(
                              "assets/images/searchicon.png",
                              height: imageHeight,
                            )),
                            //   ],
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Device Query",
                              style: TextStyle(
                                  color: element.canViewYN == true
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: fontSize),
                            ),
                            // FaIcon(FontAwesomeIcons.sprayCan)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      if (element.canViewYN) {
                        Get.to(DeviceQuery());
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => MyAlertDialog(),
                        );
                      }
                      // Get.to(Devicelocations_find());
                    },
                  ),
                  Positioned(
                      top: 9,
                      left: 9,
                      child: Text(
                        "1",
                        style: TextStyle(
                            color: element.canViewYN == true
                                ? Colors.black
                                : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            });
          }

          // if (!addedOptionNames.contains(element.optionName)) {
          else if (element.optionName == 'ServAppDeviceServiceMode') {
            allwidgets.add({
              'optionName': element.optionName,
              'widget': Stack(
                children: [
                  InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        // width: MediaQuery.of(context).size.width/2.5,
                        height: widget.heghtofscreen *
                            0.15, // Adjust the height as needed
                        width: widget.widthofscreen * 0.4,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: element.canViewYN == true
                                ? Colors.white
                                : Colors.grey,
                            border: Border.all(
                                color: element.canViewYN == true
                                    ? Colors.white
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        // height: 60,
                        // width: ScreenUtil.defaultSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(padding: EdgeInsets.only(top: 0)),
                            Center(
                                child: Image.asset(
                              "assets/images/servicemode.png",
                              height: imageHeight,
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Device Servicemode",
                              style: TextStyle(
                                  color: element.canViewYN == true
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: fontSize),
                            ),
                            // FaIcon(FontAwesomeIcons.sprayCan)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // Fluttertoast.showToast(
                      //     msg: "Comping Up shortly",
                      //     backgroundColor: Colors.red
                      // );
                      if (element.canViewYN) {
                        Get.to(ServiceModeScreen());
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => MyAlertDialog(),
                        );
                      }
                      //
                      // Get.to(Faremer_Devices());
                    },
                  ),
                  Positioned(
                      top: 9,
                      left: 9,
                      child: Text(
                        "2",
                        style: TextStyle(
                            color: element.canViewYN == true
                                ? Colors.black
                                : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            });
          } else if (element.optionName == 'ServAppDeviceCalibration') {
            allwidgets.add(
              {
                'optionName': element.optionName,
                'widget': Stack(
                  children: [
                    InkWell(
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 10,
                        child: Container(
                          // width: MediaQuery.of(context).size.width/2.5,
                          height: widget.heghtofscreen *
                              0.15, // Adjust the height as needed
                          width: widget.widthofscreen * 0.4,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: element.canViewYN == true
                                  ? Colors.white
                                  : Colors.grey,
                              border: Border.all(
                                  color: element.canViewYN == true
                                      ? Colors.white
                                      : Colors.grey),
                              borderRadius: BorderRadius.circular(2)),
                          // height: 60,
                          // width: ScreenUtil.defaultSize.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Padding(padding: EdgeInsets.only(top: 0)),
                              Center(
                                  child: Image.asset(
                                "assets/images/time_sensor.png",
                                height: imageHeight,
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Device Calibration",
                                style: TextStyle(
                                    color: element.canViewYN == true
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: fontSize),
                              ),
                              // FaIcon(FontAwesomeIcons.sprayCan)
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        // Fluttertoast.showToast(
                        //     msg: "Comping Up shortly",
                        //     backgroundColor: Colors.red
                        // );
                        if (element.canViewYN) {
                          Get.to(DeviceExamination());
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => MyAlertDialog(),
                          );
                        }
                        //
                        // Get.to(Faremer_Devices());
                      },
                    ),
                    Positioned(
                        top: 9,
                        left: 9,
                        child: Text(
                          "3",
                          style: TextStyle(
                              color: element.canViewYN == true
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              },
            );
          } else if (element.optionName == 'ServAppFarmerDeviceLocation') {
            allwidgets.add({
              'optionName': element.optionName,
              'widget': Stack(
                children: [
                  InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        // width: MediaQuery.of(context).size.width/2.5,
                        height: widget.heghtofscreen *
                            0.15, // Adjust the height as needed
                        width: widget.widthofscreen * 0.4,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: element.canViewYN == true
                                ? Colors.white
                                : Colors.grey,
                            border: Border.all(
                                color: element.canViewYN == true
                                    ? Colors.white
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        // height: 60,
                        // width: ScreenUtil.defaultSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(padding: EdgeInsets.only(top: 0)),
                            Center(
                                child: Image.asset(
                              "assets/images/Google_map.svg.png",
                              height: imageHeight,
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Flexible(
                              child: Text(
                                "Farmer Device Location",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    color: element.canViewYN == true
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: fontSize),
                              ),
                            )
                            // FaIcon(FontAwesomeIcons.sprayCan)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // Fluttertoast.showToast(
                      //     msg: "Comping Up shortly",
                      //     backgroundColor: Colors.red
                      // );
                      if (element.canViewYN) {
                        Get.to(Faremer_Devices());
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => MyAlertDialog(),
                        );
                      }
                      // else{ );

                      // }
                      //
                      // Get.to(Faremer_Devices());
                    },
                  ),
                  Positioned(
                      top: 9,
                      left: 9,
                      child: Text(
                        "5",
                        style: TextStyle(
                            color: element.canViewYN == true
                                ? Colors.black
                                : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            });
          } else if (element.optionName == 'ServAppScanFarmerDetails') {
            allwidgets.add({
              'optionName': element.optionName,
              'widget': Stack(
                children: [
                  InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: widget.heghtofscreen *
                            0.15, // Adjust the height as needed
                        width: widget.widthofscreen * 0.4,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: element.canViewYN == true
                                ? Colors.white
                                : Colors.grey,
                            // color: (widget.visuble != 'CALL' && widget.visuble != 'ALLS'|| widget.visuble == 'FPMO' ) ? Colors.grey : Colors.white,

                            border: Border.all(
                                color: element.canViewYN == true
                                    ? Colors.white
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        // height: 60,
                        // width: ScreenUtil.defaultSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(padding: EdgeInsets.only(top: 0)),
                            Center(
                                child: Icon(
                              Icons.qr_code_scanner_rounded,
                              size: imageHeight,
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Scan Farmer Details",
                              style: TextStyle(
                                  color: element.canViewYN == true
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: fontSize),
                            )
                            // FaIcon(FontAwesomeIcons.sprayCan)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      if (element.canViewYN) {
                        Get.to(ScanfarmerDetails(
                          farmerID: widget.farmerId,
                          incetpermission: element.canCreateYN,
                          updateparmission: element.canUpdateYN,
                        ));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => MyAlertDialog(),
                        );
                      }
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(builder: (BuildContext context) => myapp()));
                    },
                  ),
                  Positioned(
                      top: 9,
                      left: 9,
                      child: Text(
                        "4",
                        style: TextStyle(
                            color: element.canViewYN == true
                                ? Colors.black
                                : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            });
          } else if (element.optionName == 'ServAppFarmerDeviceLocation') {
            allwidgets.add({
              'optionName': element.optionName,
              'widget': Stack(
                children: [
                  InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: widget.heghtofscreen *
                            0.15, // Adjust the height as needed
                        width: widget.widthofscreen * 0.4,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: element.canViewYN == true
                                ? Colors.white
                                : Colors.grey,
                            border: Border.all(
                                color: element.canViewYN == true
                                    ? Colors.white
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        // height: 60,
                        // width: ScreenUtil.defaultSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(padding: EdgeInsets.only(top: 0)),
                            Center(
                                child: Image.asset(
                              "assets/images/Google_map.svg.png",
                              height: imageHeight,
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Flexible(
                              child: Text(
                                "Farmer Device Location",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    color: element.canViewYN == true
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: fontSize),
                              ),
                            )
                            // FaIcon(FontAwesomeIcons.sprayCan)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // Fluttertoast.showToast(
                      //     msg: "Comping Up shortly",
                      //     backgroundColor: Colors.red
                      // );
                      if (element.canViewYN) {
                        Get.to(Faremer_Devices());
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => MyAlertDialog(),
                        );
                      }
                      // else{ );

                      // }
                      //
                      // Get.to(Faremer_Devices());
                    },
                  ),
                  Positioned(
                      top: 9,
                      left: 9,
                      child: Text(
                        "5",
                        style: TextStyle(
                            color: element.canViewYN == true
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            });
          } else if (element.optionName == 'ServAppFarmerPlotMapping') {
            allwidgets.add({
              'optionName': element.optionName,
              'widget': Stack(
                children: [
                  InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: widget.heghtofscreen *
                            0.15, // Adjust the height as needed
                        width: widget.widthofscreen * 0.4,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: element.canViewYN == true
                                ? Colors.white
                                : Colors.grey,
                            border: Border.all(
                                color: element.canViewYN == true
                                    ? Colors.white
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        // height: 60,
                        // width: ScreenUtil.defaultSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(padding: EdgeInsets.only(top: 0)),
                            Center(
                                child: Image.asset(
                              "assets/images/farm.png",
                              height: imageHeight,
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Farmer Plot Mapping",
                              style: TextStyle(
                                  color: element.canViewYN == true
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: fontSize),
                            ),
                            // FaIcon(FontAwesomeIcons.sprayCan)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // Fluttertoast.showToast(
                      //     msg: "Comping Up shortly",
                      //     backgroundColor: Colors.red
                      // );
                      if (element.canViewYN) {
                        Get.to(FarmerGoogleMapDetailss(
                          fareraccuasation: false,
                          incertpermission: element.canCreateYN,
                        ));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => MyAlertDialog(),
                        );
                      }
                      //
                      // Get.to(Faremer_Devices());
                    },
                  ),
                  Positioned(
                      top: 9,
                      left: 9,
                      child: Text(
                        "6",
                        style: TextStyle(
                            color: element.canViewYN == true
                                ? Colors.black
                                : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            });
          } else if (element.optionName == 'ServAppGPSCam') {
            allwidgets.add({
              'optionName': element.optionName,
              'widget': Stack(
                children: [
                  InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: widget.heghtofscreen *
                            0.15, // Adjust the height as needed
                        width: widget.widthofscreen * 0.4,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: element.canViewYN == true
                                ? Colors.white
                                : Colors.grey,
                            border: Border.all(
                                color: element.canViewYN == true
                                    ? Colors.white
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        // height: 60,
                        // width: ScreenUtil.defaultSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(padding: EdgeInsets.only(top: 0)),
                            Center(
                                child: Image.asset(
                              "assets/images/gpscameraicon.png",
                              height: imageHeight,
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Gps Cam",
                              style: TextStyle(
                                  color: element.canViewYN == true
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: fontSize),
                            ),
                            // FaIcon(FontAwesomeIcons.sprayCan)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      if (element.canViewYN) {
                        Get.to(Gps_Cam(
                          incertpermission: element.canCreateYN,
                        ));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => MyAlertDialog(),
                        );
                      }
                      // Get.to(Devicelocations_find());
                    },
                  ),
                  Positioned(
                      top: 9,
                      left: 9,
                      child: Text(
                        "7",
                        style: TextStyle(
                            color: element.canViewYN == true
                                ? Colors.black
                                : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            });
          }
          Tab1list.add(element);
          addedOptionNames.add(element.optionName.toString());
        }
      }
    });
    appAccessDataList?.forEach((element) {
      if (optionNamesTab2.contains(element.optionName)) {
        if (!addedOptionNamesTab2.contains(element.optionName)) {
          if (element.optionName == 'ServAppDeviceMap') {
            allwidgetsTab2.add({
              'optionName': element.optionName,
              'widget': Stack(
                children: [
                  InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        // width: MediaQuery.of(context).size.width/2.5,
                        height: widget.heghtofscreen *
                            0.15, // Adjust the height as needed
                        width: widget.widthofscreen * 0.4,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: element.canViewYN == true
                                ? Colors.white
                                : Colors.grey,
                            border: Border.all(
                                color: element.canViewYN == true
                                    ? Colors.white
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        // height:  imageHeight,
                        // width: ScreenUtil.defaultSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(padding: EdgeInsets.only(top: 0)),
                            Center(
                                child: Image.asset(
                              "assets/images/FarmerDevicemapicon.png",
                              height: imageHeight,
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Device Map",
                              style: TextStyle(
                                  color: element.canViewYN == true
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: fontSize),
                            ),
                            // FaIcon(FontAwesomeIcons.sprayCan)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // Fluttertoast.showToast(
                      //     msg: "Comping Up shortly",
                      //     backgroundColor: Colors.red
                      // );
                      if (element.canViewYN) {
                        Get.to(FarmerDeviceMap());
                        //
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => MyAlertDialog(),
                        );
                      }
                      // Get.to(Faremer_Devices());
                    },
                  ),
                  Positioned(
                      top: 5,
                      left: 20,
                      child: Text(
                        "Beta Release",
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              ),
            });
          } else if (element.optionName == 'ServAppFarmerDeviceTesting') {
            allwidgetsTab2.add({
              'optionName': element.optionName,
              'widget': Stack(children: [
                InkWell(
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    child: Container(
                      height: widget.heghtofscreen *
                          0.15, // Adjust the height as needed
                      width: widget.widthofscreen * 0.4,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: element.canViewYN == true
                              ? Colors.white
                              : Colors.grey,
                          border: Border.all(
                              color: element.canViewYN == true
                                  ? Colors.white
                                  : Colors.grey),
                          borderRadius: BorderRadius.circular(2)),
                      // height:  imageHeight,
                      // width: ScreenUtil.defaultSize.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // height:  imageHeight,

                          // Padding(padding: EdgeInsets.only(top: 0)),
                          Center(
                              child: Image.asset(
                            "assets/images/level_sensor.png",
                            height: imageHeight,
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Farmer Device Testing",
                            style: TextStyle(
                                color: element.canViewYN == true
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: fontSize),
                          ),
                          // FaIcon(FontAwesomeIcons.sprayCan)
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    // Fluttertoast.showToast(
                    //     msg: "Comping Up shortly",
                    //     backgroundColor: Colors.red
                    // );
                    if (element.canViewYN) {
                      Get.to(DeviceTesting(
                        farmerID: widget.farmerId,
                      ));
                      //
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => MyAlertDialog(),
                      );
                    }
                    // Get.to(Faremer_Devices());
                  },
                ),
              ])
            });
          }
          addedOptionNamesTab2.add(element.optionName.toString());
          Tab2list.add(element);
        }
      }
    });

    appAccessDataList?.forEach((element) {
      if (optionNamesTab3.contains(element.optionName)) {
        if (!addedOptionNamesTab3.contains(element.optionName)) {
          if (element.optionName == 'ServAppFarmerAcquisition') {
            allwidgetsTab3.add({
              'optionName': element.optionName,
              'widget': Stack(
                children: [
                  InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: widget.heghtofscreen *
                            0.15, // Adjust the height as needed
                        width: widget.widthofscreen * 0.4,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: element.canViewYN == true
                                ? Colors.white
                                : Colors.grey,
                            border: Border.all(
                                color: element.canViewYN == true
                                    ? Colors.white
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        // height:  imageHeight,
                        // width: ScreenUtil.defaultSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(padding: EdgeInsets.only(top: 0)),
                            Center(
                                child: Image.asset(
                              "assets/images/notepad.jpg",
                              height: imageHeight,
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Farmer Acquisition",
                              style: TextStyle(
                                  color: element.canViewYN == true
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: fontSize),
                            ),
                            // FaIcon(FontAwesomeIcons.sprayCan)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // Fluttertoast.showToast(
                      //     msg: "Comping Up shortly",
                      //     backgroundColor: Colors.red
                      // );
                      if (element.canViewYN) {
                        Get.to(Farmeracusationpage(
                          screenhight: widget.heghtofscreen,
                          screenwidth: widget.widthofscreen,
                          incerpermission: element.canCreateYN,
                        ));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => MyAlertDialog(),
                        );
                      }

                      //
                      // Get.to(Faremer_Devices());
                    },
                  ),
                ],
              ),
            });
          }

          // if (!addedOptionNames.contains(element.optionName)) {
          else if (element.optionName ==
              'ServAppFarmerAcquisitionPlotMapping') {
            allwidgetsTab3.add({
              'optionName': element.optionName,
              'widget': Stack(
                children: [
                  InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: widget.heghtofscreen *
                            0.15, // Adjust the height as needed
                        width: widget.widthofscreen * 0.4,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: element.canViewYN == true
                                ? Colors.white
                                : Colors.grey,
                            border: Border.all(
                                color: element.canViewYN == true
                                    ? Colors.white
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        // height:  imageHeight,
                        // width: ScreenUtil.defaultSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(padding: EdgeInsets.only(top: 0)),
                            Center(
                                child: Image.asset(
                              "assets/images/farm.png",
                              height: imageHeight,
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Farmer Plot Mapping",
                              style: TextStyle(
                                  color: element.canViewYN == true
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: fontSize),
                            ),
                            // FaIcon(FontAwesomeIcons.sprayCan)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // Fluttertoast.showToast(
                      //     msg: "Comping Up shortly",
                      //     backgroundColor: Colors.red
                      // );
                      if (element.canViewYN) {
                        Get.to(FarmerGoogleMapDetailsBlock(
                          fareraccuasation: true,
                          incertpermission: element.canCreateYN,
                        ));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => MyAlertDialog(),
                        );
                      }
                      //
                      // Get.to(Faremer_Devices());
                    },
                  ),

                  // Positioned(
                  //     top: 9,
                  //     left: 9,
                  //     child: Text("6", style: TextStyle(color: Colors.black,
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold),))
                ],
              )
            });
          }
          Tab3list.add(element);
          addedOptionNamesTab3.add(element.optionName.toString());
        }
      }
    });

    // for (int i=0;i<optionNames.length;i++){
    //   appAccessDataList!.forEach((element) {
    //     print("option names ${optionNames[i]}");
    //     print("option names ${optionNames[i]==element.optionName}" );
    //     if(element.optionName==optionNames[i] && element.canViewYN==true ){
    //       if(optionNames[i]=='ServAppDeviceQuery'){
    //
    //         allwidgets.add(Stack(
    //           children: [
    //             InkWell(
    //               child: Material(
    //                 borderRadius: BorderRadius.circular(10),
    //                 elevation: 10,
    //                 child: Container(
    //                   // width: MediaQuery.of(context).size.width/2.5,
    //                   height: 120,
    //                   padding: const EdgeInsets.symmetric(vertical: 5),
    //                   margin: const EdgeInsets.all(2),
    //                   decoration: BoxDecoration(
    //                       color:  Colors.white,
    //                       border: Border.all(color: desable?Colors.grey: Colors.white),
    //                       borderRadius: BorderRadius.circular(2)),
    //                   // height: 60,
    //                   // width: ScreenUtil.defaultSize.width,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       // Padding(padding: EdgeInsets.only(top: 0)),
    //                       // Row(
    //                       //   children: [
    //                       Center(child: Image.asset("assets/images/searchicon.png",height: 60,)),
    //                       //   ],
    //                       // ),
    //                       SizedBox(height: 10,),
    //                       Text("Device Query"),
    //                       // FaIcon(FontAwesomeIcons.sprayCan)
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               onTap: (){
    //                 // if((widget.visuble !='FPMO' ) &&(widget.visuble =='ALLS'|| widget.visuble =='CALL')) {
    //                 Get.to(DeviceQuery());
    //                 // }
    //                 // Get.to(Devicelocations_find());
    //               },
    //             ),
    //             Positioned(
    //                 top: 9,
    //                 left: 9,
    //                 child: Text("1",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),))
    //           ],
    //         ));
    //       }
    //       else   if(optionNames[i]=='ServAppDeviceServiceMode'){
    //         allwidgets.add(  Stack(
    //           children: [
    //             InkWell(
    //               child: Material(
    //                 borderRadius: BorderRadius.circular(10),
    //                 elevation: 10,
    //                 child: Container(
    //                   // width: MediaQuery.of(context).size.width/2.5,
    //                   height: 120,
    //                   padding: const EdgeInsets.symmetric(vertical: 5),
    //                   margin: const EdgeInsets.all(2),
    //                   decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       border: Border.all(color: desable?Colors.grey: Colors.white),
    //                       borderRadius: BorderRadius.circular(2)),
    //                   // height: 60,
    //                   // width: ScreenUtil.defaultSize.width,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       // Padding(padding: EdgeInsets.only(top: 0)),
    //                       Center(child: Image.asset("assets/images/servicemode.png",height: 60,)),
    //                       SizedBox(height: 10,),
    //                       Text("Device Servicemode",style: iostextstyle(fontSize),),
    //                       // FaIcon(FontAwesomeIcons.sprayCan)
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               onTap: (){
    //                 // Fluttertoast.showToast(
    //                 //     msg: "Comping Up shortly",
    //                 //     backgroundColor: Colors.red
    //                 // );
    //                 // if(widget.visuble !='FPMO' && (widget.visuble =='ALLS'|| widget.visuble =='CALL'))  {
    //                 Get.to(ServiceModeScreen());
    //                 // }
    //                 //
    //                 // Get.to(Faremer_Devices());
    //               },
    //             ),
    //             Positioned(
    //                 top: 9,
    //                 left: 9,
    //                 child: Text("2",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),))
    //           ],
    //         ));
    //       }
    //      else if(optionNames[i]=='ServAppDeviceCalibration'){
    //         allwidgets.add(       Stack(
    //           children: [
    //             InkWell(
    //               child: Material(
    //                 borderRadius: BorderRadius.circular(10),
    //                 elevation: 10,
    //                 child: Container(
    //                   // width: MediaQuery.of(context).size.width/2.5,
    //                   height: 120,
    //                   padding: const EdgeInsets.symmetric(vertical: 5),
    //                   margin: const EdgeInsets.all(2),
    //                   decoration: BoxDecoration(
    //                       color:  Colors.white,
    //                       border: Border.all(color: desable?Colors.grey: Colors.white),
    //                       borderRadius: BorderRadius.circular(2)),
    //                   // height: 60,
    //                   // width: ScreenUtil.defaultSize.width,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       // Padding(padding: EdgeInsets.only(top: 0)),
    //                       Center(child: Image.asset("assets/images/time_sensor.png",height: 60,)),
    //                       SizedBox(height: 10,),
    //                       Text("Device Calibration",style: iostextstyle(fontSize),),
    //                       // FaIcon(FontAwesomeIcons.sprayCan)
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               onTap: (){
    //                 // Fluttertoast.showToast(
    //                 //     msg: "Comping Up shortly",
    //                 //     backgroundColor: Colors.red
    //                 // );
    //                 // if(widget.visuble !='FPMO' && (widget.visuble !='ALLS'|| widget.visuble =='CALL')) {
    //                   Get.to(
    //                       DeviceExamination());
    //                 // }
    //                 //
    //                 // Get.to(Faremer_Devices());
    //               },
    //             ),
    //             Positioned(
    //                 top: 9,
    //                 left: 9,
    //                 child: Text("3",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),))
    //           ],
    //         ),);
    //       }
    //       else if(optionNames[i]=='ServAppScanFarmerDetails'){
    //         allwidgets.add(     Stack(
    //           children: [
    //             InkWell(
    //               child: Material(
    //                 borderRadius: BorderRadius.circular(10),
    //                 elevation: 10,
    //                 child: Container(
    //                   // width: MediaQuery.of(context).size.width/2.5,
    //                   height: 120,
    //                   padding: const EdgeInsets.symmetric(vertical: 5),
    //                   margin: const EdgeInsets.all(2),
    //                   decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       // color: (widget.visuble != 'CALL' && widget.visuble != 'ALLS'|| widget.visuble == 'FPMO' ) ? Colors.grey : Colors.white,
    //
    //                       border: Border.all(color: desable?Colors.grey: Colors.white),
    //                       borderRadius: BorderRadius.circular(2)),
    //                   // height: 60,
    //                   // width: ScreenUtil.defaultSize.width,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       // Padding(padding: EdgeInsets.only(top: 0)),
    //                       Center(child: Icon(Icons.qr_code_scanner_rounded,size: 60,)),
    //                       SizedBox(height: 10,),
    //                       Text("Scan Farmer Details",style: iostextstyle(fontSize),)
    //                       // FaIcon(FontAwesomeIcons.sprayCan)
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               onTap: (){
    //
    //                 // if((widget.visuble !='FPMO'||widget.visuble !='ALLS')&&widget.visuble =='CALL') {
    //                 Get.to(ScanfarmerDetails(farmerID: widget.farmerId,));
    //                 // }
    //                 // Navigator.pushReplacement(
    //                 //     context,
    //                 //     MaterialPageRoute(builder: (BuildContext context) => myapp()));
    //
    //               },
    //             ),
    //             Positioned(
    //                 top: 9,
    //                 left: 9,
    //                 child: Text("4",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),))
    //           ],
    //         ),);
    //       }
    //       else if(optionNames[i]=='ServAppFarmerDeviceLocation'){
    //         allwidgets.add(   Stack(
    //           children: [
    //             InkWell(
    //               child: Material(
    //                 borderRadius: BorderRadius.circular(10),
    //                 elevation: 10,
    //                 child: Container(
    //                   // width: MediaQuery.of(context).size.width/2.5,
    //                   height: 120,
    //                   padding: const EdgeInsets.symmetric(vertical: 5),
    //                   margin: const EdgeInsets.all(2),
    //                   decoration: BoxDecoration(
    //                       color:Colors.white,
    //                       border: Border.all(color: desable?Colors.grey: Colors.white),
    //                       borderRadius: BorderRadius.circular(2)),
    //                   // height: 60,
    //                   // width: ScreenUtil.defaultSize.width,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       // Padding(padding: EdgeInsets.only(top: 0)),
    //                       Center(child: Image.asset("assets/images/Google_map.svg.png",height: 60,)),
    //                       SizedBox(height: 10,),
    //                       Flexible(
    //                         child: Text(
    //                           "Farmer Device Location",
    //                           maxLines: 1,
    //
    //                           overflow: TextOverflow.ellipsis,
    //                           softWrap: false,
    //                           style:  iostextstyle(fontSize),
    //                         ),
    //                       )
    //                       // FaIcon(FontAwesomeIcons.sprayCan)
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               onTap: (){
    //                 // Fluttertoast.showToast(
    //                 //     msg: "Comping Up shortly",
    //                 //     backgroundColor: Colors.red
    //                 // );
    //                 // if((widget.visuble !='FPMO')&&(widget.visuble=='ALLS'|| widget.visuble =='CALL')) {
    //                 Get.to(Faremer_Devices());
    //                 // }
    //                 // }
    //                 // else{ );
    //
    //                 // }
    //                 //
    //                 // Get.to(Faremer_Devices());
    //               },
    //             ),
    //             Positioned(
    //                 top: 9,
    //                 left: 9,
    //                 child: Text("5",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),))
    //           ],
    //         ),);
    //       }
    //       else if(optionNames[i]=='ServAppFarmerPlotMapping'){
    //         allwidgets.add(Stack(
    //           children: [
    //             InkWell(
    //               child: Material(
    //                 borderRadius: BorderRadius.circular(10),
    //                 elevation: 10,
    //                 child: Container(
    //                   // width: MediaQuery.of(context).size.width/2.5,
    //                   height: 120,
    //                   padding: const EdgeInsets.symmetric(vertical: 5),
    //                   margin: const EdgeInsets.all(2),
    //                   decoration: BoxDecoration(
    //                       color:Colors.white,
    //                       border: Border.all(color: Colors.white),
    //                       borderRadius: BorderRadius.circular(2)),
    //                   // height: 60,
    //                   // width: ScreenUtil.defaultSize.width,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       // Padding(padding: EdgeInsets.only(top: 0)),
    //                       Center(child: Image.asset("assets/images/farm.png",height: 60,)),
    //                       SizedBox(height: 10,),
    //                       Text("Farmer Plot Mapping",style: iostextstyle(fontSize),),
    //                       // FaIcon(FontAwesomeIcons.sprayCan)
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               onTap: (){
    //                 // Fluttertoast.showToast(
    //                 //     msg: "Comping Up shortly",
    //                 //     backgroundColor: Colors.red
    //                 // );
    //                 // if(widget.visuble =='FPMO'||(widget.visuble =='CALL'||widget.visuble =='ALLS')) {
    //                 Get.to(FarmerGoogleMapDetails());
    //                 // }
    //                 //
    //                 // Get.to(Faremer_Devices());
    //               },
    //             ),
    //
    //
    //             Positioned(
    //                 top: 9,
    //                 left: 9,
    //                 child: Text("6",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),))
    //           ],
    //         ));
    //       }
    //      else if(optionNames[i]=='ServAppGPSCam'){
    //         allwidgets.add(   Stack(
    //           children: [
    //             InkWell(
    //               child: Material(
    //                 borderRadius: BorderRadius.circular(10),
    //                 elevation: 10,
    //                 child: Container(
    //                   // width: MediaQuery.of(context).size.width/2.5,
    //                   height: 120,
    //                   padding: const EdgeInsets.symmetric(vertical: 5),
    //                   margin: const EdgeInsets.all(2),
    //                   decoration: BoxDecoration(
    //                     // color: widget.visuble =='FPMO'?Colors.grey:(widget.visuble =='ALLS'|| widget.visuble =='CALL')?Colors.white:Colors.grey,
    //                       border: Border.all(color: desable?Colors.grey: Colors.white),
    //                       borderRadius: BorderRadius.circular(2)),
    //                   // height: 60,
    //                   // width: ScreenUtil.defaultSize.width,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       // Padding(padding: EdgeInsets.only(top: 0)),
    //                       Center(child: Image.asset("assets/images/gpscameraicon.png",height: 70,width: 250,)),
    //                       SizedBox(height: 10,),
    //                       Text("Gps Cam",style: iostextstyle(fontSize),),
    //                       // FaIcon(FontAwesomeIcons.sprayCan)
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               onTap: (){
    //                 // if((widget.visuble !='FPMO' )&& (widget.visuble =='ALLS'|| widget.visuble =='CALL'))  {
    //                 Get.to(Gps_Cam());
    //                 // }
    //                 // Get.to(Devicelocations_find());
    //               },
    //             ),
    //             Positioned(
    //                 top: 9,
    //                 left: 9,
    //                 child: Text("7",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),))
    //           ],
    //         ),);
    //       }
    //
    //     }
    //   });
    // }

    allwidgets.sort((a, b) {
      final String optionNameA = a['optionName'];
      final String optionNameB = b['optionName'];
      final int indexA = optionNames.indexOf(optionNameA);
      final int indexB = optionNames.indexOf(optionNameB);
      return indexA.compareTo(indexB);
    });
    allwidgetsTab3.sort((a, b) {
      final String optionNameA = a['optionName'];
      final String optionNameB = b['optionName'];
      final int indexA = optionNamesTab3.indexOf(optionNameA);
      final int indexB = optionNamesTab3.indexOf(optionNameB);
      return indexA.compareTo(indexB);
    });
    allwidgetsTab2.sort((a, b) {
      final String optionNameA = a['optionName'];
      final String optionNameB = b['optionName'];
      final int indexA = optionNamesTab2.indexOf(optionNameA);
      final int indexB = optionNamesTab2.indexOf(optionNameB);
      return indexA.compareTo(indexB);
    });
    Set<String> uniqueOptionNames = {};
    List<Map<String, dynamic>> uniqueWidgets = [];

// Iterate through the sorted allwidgets list
    for (var widgetMap in allwidgets) {
      String optionName = widgetMap['optionName'];

      // If the optionName is not a duplicate, add it to the uniqueWidgets list
      if (!uniqueOptionNames.contains(optionName)) {
        uniqueOptionNames.add(optionName);
        uniqueWidgets.add(widgetMap);
      }
    }

    // Filter the appAccessDataList based on the specified optionNames
    List<ServiceAPPlogins>? filteredOptions = Tab1list.where((element) =>
        optionNames.contains(element.optionName) &&
        element.canViewYN == true).toList();
    List<ServiceAPPlogins>? filteredtab2 = Tab2list.where((element) =>
        optionNamesTab2.contains(element.optionName) &&
        element.canViewYN == true).toList();
    List<ServiceAPPlogins>? filteredtab3 = Tab3list.where((element) =>
        optionNamesTab3.contains(element.optionName) &&
        element.canViewYN == true).toList();

    print("tab1length ${filteredOptions.length}");
    print("tab2length ${filteredtab2.length}");
    print("tab3length ${filteredtab3.length}");
    tab1active = filteredOptions.length;
    tab2active = filteredtab2.length;
    tab3active = filteredtab3.length;
    tab = (tab1active != 0 ? 1 : 0) +
        (tab2active != 0 ? 1 : 0) +
        (tab3active != 0 ? 1 : 0);
    // Return the length of the filtered list
    return filteredOptions.length;
  }

  // Filter the appAccessDataList based on the specified optionNames
  // List<ServiceAPPlogin>? filteredOptions = Appaccessdata?.where((element) => optionNames.contains(element.optionName) && element.canView == true)
  //     .toList();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final imageHeight = width * height * 0.00004;
    final fontheaders = width * height * 0.00005;
    final imageHeightall = width * height * 0.0002;
    final preferredHeight = height * 0.11;
    void openDrawer() {
      _drawerKey.currentState?.open();
      drawerIsOpen = true;
      setState(() {});
    }

    void closeDrawer() {
      _drawerKey.currentState?.close();
      drawerIsOpen = false;
      setState(() {});
    }

    // toggleDrawer() async {
    //   if (_drawerKey.currentState.) {
    //     _drawerKey.currentState.openDrawer();
    //   } else {
    //     _drawerKey.currentState.openEndDrawer();
    //   }
    // }
    void _closeDrawer() {
      Navigator.of(context).pop();
    }

    return WillPopScope(
      onWillPop: () async {
        // Close the app when back button is pressed on the dashboard
        SystemNavigator.pop();
        return false;
      },
      child: MaterialApp(
          home: tab != 0
              ? DefaultTabController(
                  length: tab,
                  child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(preferredHeight),
                        child: AppBar(
                          backgroundColor: cultLightGrey,
                          title: ListTile(
                            // leading:
                            // Builder(
                            //   builder: (context) => IconButton(
                            //     icon: Image.asset("assets/images/hamburger.png"),
                            //     onPressed: () => Scaffold.of(context).openDrawer(),
                            //   ),
                            //
                            // ),
                            title: Image.asset(
                              'assets/images/cultyvate.png',
                              height: imageHeightall,
                            ),
                            trailing: Wrap(
                              children: [
                                Text(
                                  'Version:',
                                  style: iostextstyle(fontheaders),
                                ),
                                Text(
                                  widget.Version,
                                  style: iostextstyle(fontheaders),
                                )
                              ],
                            ),
                          ),
                          actions: [
                            PopupMenuButton(
                              color: Colors.black,
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(
                                    textStyle: TextStyle(color: Colors.white),
                                    value: 'logout',
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ];
                              },
                              onSelected: (value) async {
                                if (value == 'logout') {
                                  print(value);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  int? username = await prefs.getInt('userid');
                                  final dbHelper = DatabaseHelper.instance;
                                  dbHelper.deleteTabel();
                                  prefs.remove('userid');
                                  Get.back();
                                  Get.back();
                                  Get.to(login());
                                  // Perform logout logic here
                                  // For now, let's just print a message
                                  print('User logged out');
                                }
                              },
                            ),
                          ],
                          bottom: TabBar(
                            indicatorColor: cultGreen,
                            isScrollable: true,
                            indicatorWeight:
                                2.0, // Adjust indicator weight if needed
                            indicatorSize: TabBarIndicatorSize.tab, //

                            tabs: [
                              Visibility(
                                visible: tab1active != 0,
                                child: Container(
                                  // height: height/12,
                                  width: width /
                                      2.5, // Set the width of the first tab
                                  child: Tab(
                                    child: Text(
                                      'Farmer Installation',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: cultGreen,
                                          fontSize: imageHeight),
                                    ),
                                  ),
                                ),
                              ),
                              // Tab(
                              //   child: SizedBox(width: MediaQuery.of(context).size.width/2, child: Text('Farmer Installation', maxLines: 1,
                              //       overflow: TextOverflow.ellipsis,
                              //       softWrap: false, style: TextStyle(color: cultGreen, fontSize: 16,)),),),
                              Visibility(
                                visible: tab2active != 0,
                                child: Container(
                                    width: width / 4,
                                    child: Tab(
                                        child: Text('Operations',
                                            style: TextStyle(
                                                color: cultGreen,
                                                fontSize: imageHeight)))),
                              ),
                              Visibility(
                                visible: tab3active != 0,
                                child: Container(
                                    width: width / 4,
                                    child: Tab(
                                        child: Text('Survey',
                                            style: TextStyle(
                                                color: cultGreen,
                                                fontSize: imageHeight)))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      body: TabBarView(children: [
                        Material(
                          child: SingleChildScrollView(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(color: cultLightGrey),
                              padding: const EdgeInsets.all(20),
                              child: ListView.builder(
                                itemCount: (allwidgets.length / 2).ceil(),
                                itemBuilder: (context, rowIndex) {
                                  final index1 = rowIndex * 2;
                                  final index2 = index1 + 1;
                                  final item1 = index1 < allwidgets.length
                                      ? allwidgets[index1]['widget']
                                      : null;
                                  final item2 = index2 < allwidgets.length
                                      ? allwidgets[index2]['widget']
                                      : null;
                                  // Widget widget = ;
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: item1 != null
                                              ? item1
                                              : Container(),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Add spacing between items
                                        Expanded(
                                          child: item2 != null
                                              ? item2
                                              : Container(),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              // GridView.count(
                              //   // shrinkWrap: true,
                              //   crossAxisCount: 3,
                              //   crossAxisSpacing: 40,
                              //   children: List.generate(allwidgets.length, (index) {
                              //
                              //     return Padding(
                              //       padding: EdgeInsets.symmetric(horizontal: index == 1 ? 5 : 0),
                              //       child: widget,
                              //     );
                              //   }),
                              // ),
                            ),
                          ),
                        ),
                        Material(
                            child: Stack(children: [
                          Material(
                            child: SafeArea(
                              child: SingleChildScrollView(
                                  child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(color: cultLightGrey),
                                padding: const EdgeInsets.all(20),
                                child: ListView.builder(
                                  itemCount: (allwidgetsTab2.length / 2).ceil(),
                                  itemBuilder: (context, rowIndex) {
                                    final index1 = rowIndex * 2;
                                    final index2 = index1 + 1;
                                    final item1 = index1 < allwidgetsTab2.length
                                        ? allwidgetsTab2[index1]['widget']
                                        : null;
                                    final item2 = index2 < allwidgetsTab2.length
                                        ? allwidgetsTab2[index2]['widget']
                                        : null;
                                    // Widget widget = ;
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: item1 != null
                                                ? item1
                                                : Container(),
                                          ),
                                          SizedBox(
                                              width:
                                                  10), // Add spacing between items
                                          Expanded(
                                            child: item2 != null
                                                ? item2
                                                : Container(),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                    );
                                  },
                                ),

                                // Column(
                                //   children: [
                                //
                                //     SizedBox(height: 10),
                                //
                                //
                                //     SizedBox(height: 10,),
                                //     Row(
                                //       children: [
                                //         Stack(
                                //           children: [
                                //             InkWell(
                                //               child: Material(
                                //                 borderRadius: BorderRadius.circular(10),
                                //                 elevation: 10,
                                //                 child: Container(
                                //                   width: MediaQuery.of(context).size.width/2.5,
                                //                   height: 120,
                                //                   padding: const EdgeInsets.symmetric(vertical: 5),
                                //                   margin: const EdgeInsets.all(2),
                                //                   decoration: BoxDecoration(
                                //                       color:  widget.visuble =='FPMO'?Colors.grey:widget.visuble =='ALLS'|| widget.visuble =='CALL'?Colors.white:Colors.grey,
                                //                       border: Border.all(color: desable?Colors.grey: Colors.white),
                                //                       borderRadius: BorderRadius.circular(2)),
                                //                   // height: 60,
                                //                   // width: ScreenUtil.defaultSize.width,
                                //                   child: Column(
                                //                     mainAxisAlignment: MainAxisAlignment.center,
                                //                     children: [
                                //                       // Padding(padding: EdgeInsets.only(top: 0)),
                                //                       Center(child: Image.asset("assets/images/FarmerDevicemapicon.png",height: 60,)),
                                //                       SizedBox(height: 10,),
                                //                       Text("Device Map",style: iostextstyle(fontSize),),
                                //                       // FaIcon(FontAwesomeIcons.sprayCan)
                                //                     ],
                                //                   ),
                                //                 ),
                                //               ),
                                //               onTap: (){
                                //                 // Fluttertoast.showToast(
                                //                 //     msg: "Comping Up shortly",
                                //                 //     backgroundColor: Colors.red
                                //                 // );
                                //                 if((widget.visuble !='FPMO') && (widget.visuble =='ALLS'|| widget.visuble =='CALL')) {
                                //                   Get.to(FarmerDeviceMap());
                                //                   //
                                //                 }
                                //                 // Get.to(Faremer_Devices());
                                //               },
                                //             ),
                                //             Positioned(
                                //                 top: 5,
                                //                 left: 20,
                                //                 child: Text("Beta Release",style: TextStyle(color: Colors.red),))
                                //           ],
                                //         ),
                                //
                                //         SizedBox(width: 10,),
                                //         InkWell(
                                //           child: Material(
                                //             borderRadius: BorderRadius.circular(10),
                                //             elevation: 10,
                                //             child: Container(
                                //               width: MediaQuery.of(context).size.width/2.5,
                                //               height: 120,
                                //               padding: const EdgeInsets.symmetric(vertical: 5),
                                //               margin: const EdgeInsets.all(2),
                                //               decoration: BoxDecoration(
                                //                   color:  widget.visuble =='FPMO'?Colors.grey:widget.visuble =='ALLS'|| widget.visuble =='CALL'?Colors.white:Colors.grey,
                                //                   border: Border.all(color: desable?Colors.grey: Colors.white),
                                //                   borderRadius: BorderRadius.circular(2)),
                                //               // height: 60,
                                //               // width: ScreenUtil.defaultSize.width,
                                //               child: Column(
                                //                 mainAxisAlignment: MainAxisAlignment.center,
                                //                 children: [
                                //                   // Padding(padding: EdgeInsets.only(top: 0)),
                                //                   Center(child: Image.asset("assets/images/level_sensor.png",height: 60,)),
                                //                   SizedBox(height: 10,),
                                //                   Text("Farmer Device Testing",style: iostextstyle(fontSize),),
                                //                   // FaIcon(FontAwesomeIcons.sprayCan)
                                //                 ],
                                //               ),
                                //             ),
                                //           ),
                                //           onTap: (){
                                //             // Fluttertoast.showToast(
                                //             //     msg: "Comping Up shortly",
                                //             //     backgroundColor: Colors.red
                                //             // );
                                //             if(widget.visuble !='FPMO' && (widget.visuble =='ALLS'|| widget.visuble =='CALL')) {
                                //                        Get.to(DeviceTesting(
                                //                          farmerID: widget
                                //                              .farmerId,));
                                //                        //
                                //                      }
                                //             // Get.to(Faremer_Devices());
                                //           },
                                //         ),
                                //       ],
                                //     ),
                                //     SizedBox(height: 10,),
                                //
                                //     Row(
                                //       children: [
                                //
                                //
                                //
                                //         Stack(
                                //           children: [
                                //             InkWell(
                                //               child: Material(
                                //                 borderRadius: BorderRadius.circular(10),
                                //                 elevation: 10,
                                //                 child: Container(
                                //                   width: MediaQuery.of(context).size.width/2.5,
                                //                   height: 120,
                                //                   padding: const EdgeInsets.symmetric(vertical: 5),
                                //                   margin: const EdgeInsets.all(2),
                                //                   decoration: BoxDecoration(
                                //                       color: widget.visuble =='FPMO'?Colors.grey:widget.visuble=='ALLS'|| widget.visuble =='CALL' ?Colors.white:Colors.grey,
                                //                       border: Border.all(color: desable?Colors.grey: Colors.white),
                                //                       borderRadius: BorderRadius.circular(2)),
                                //                   // height: 60,
                                //                   // width: ScreenUtil.defaultSize.width,
                                //                   child: Column(
                                //                     mainAxisAlignment: MainAxisAlignment.center,
                                //                     children: [
                                //                       // Padding(padding: EdgeInsets.only(top: 0)),
                                //                       Center(child: Image.asset("assets/images/notepad.jpg",height: 60,)),
                                //                       SizedBox(height: 10,),
                                //                       Text("Farmer Acquisition",style: iostextstyle(fontSize),),
                                //                       // FaIcon(FontAwesomeIcons.sprayCan)
                                //                     ],
                                //                   ),
                                //                 ),
                                //               ),
                                //               onTap: (){
                                //                 // Fluttertoast.showToast(
                                //                 //     msg: "Comping Up shortly",
                                //                 //     backgroundColor: Colors.red
                                //                 // );
                                //                 if(widget.visuble !='FPMO' && (widget.visuble =='ALLS'|| widget.visuble =='CALL')) {
                                //                   Get.to(Farmeracusation());
                                //                 }
                                //
                                //
                                //                 //
                                //                 // Get.to(Faremer_Devices());
                                //               },
                                //             ),
                                //
                                //
                                //           ],
                                //         ),
                                //         SizedBox(width: 10,),
                                //
                                //       ],
                                //     ),
                                //     SizedBox(height: 10,),
                                //     SizedBox(height: 10,),
                                //
                                //
                                //   ],
                                // ),
                                // GridView.count(
                                // crossAxisCount: 2, // Set the number of columns (width) to 2
                                // crossAxisSpacing: 10,
                                // //     crossAxisSpacing: 40, // Add horizontal spacing between columns
                                // // mainAxisSpacing: 10, //
                                // children: List.generate(allwidgetsTab2.length, (index) {
                                // Widget widget = allwidgetsTab2[index]['widget'];
                                // return widget;
                                // }
                                // )
                                //                         ),
                              )),
                            ),
                          )
                        ])),
                        Material(
                            child: Stack(children: [
                          Material(
                            child: SafeArea(
                                child: SingleChildScrollView(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(color: cultLightGrey),
                                padding: const EdgeInsets.all(20),
                                child: GridView.count(
                                    crossAxisCount:
                                        2, // Set the number of columns (width) to 2
                                    crossAxisSpacing:
                                        40, // Add horizontal spacing between columns
                                    // mainAxisSpacing: 10, //
                                    children: List.generate(
                                        allwidgetsTab3.length, (index) {
                                      Widget widget =
                                          allwidgetsTab3[index]['widget'];
                                      return widget;
                                    })),
                              ),
                            )),
                          ),
                        ])),
                      ])))
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: cultLightGrey,
                    title: ListTile(
                      // leading:
                      // Builder(
                      //   builder: (context) => IconButton(
                      //     icon: Image.asset("assets/images/hamburger.png"),
                      //     onPressed: () => Scaffold.of(context).openDrawer(),
                      //   ),
                      //
                      // ),
                      title: Image.asset(
                        'assets/images/cultyvate.png',
                        height: 50,
                      ),
                      trailing: Wrap(
                        children: [
                          Text(
                            'Version:',
                            style: iostextstyle(imageHeight),
                          ),
                          Text(
                            widget.Version,
                            style: iostextstyle(imageHeight),
                          )
                        ],
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 150,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            // top: -3,
                            // left: 80,
                            child: Image.asset(
                              'assets/images/access-denied.png',
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                          ),
                          Positioned(
                            bottom: 150,
                            // left: 30,
                            child: Text(
                              'No options are enabled for this user. \nPlease contact cultYvate for assistance.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.05),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))),
    );
  }
}
