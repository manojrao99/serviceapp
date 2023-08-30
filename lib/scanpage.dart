import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:imei_plugin/imei_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import '../apihelper/apihelper.dart';
import '../constants.dart';
import '../models/FarmerProfile.dart';

import 'Screens/Permissiondenydiloag.dart';

class MyHomePagescanner extends StatefulWidget {
  Farmer? farmer;
  String? simnumber;
  bool? gatewayisthere;
  String? imeinumber;
  bool? updatepermission;
  bool? incertpermission;
  final farmid;
  MyHomePagescanner(
      {required incertpermission,
      required this.updatepermission,
      this.gatewayisthere,
      this.farmer,
      this.simnumber,
      this.imeinumber,
      this.farmid});
  @override
  State<MyHomePagescanner> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePagescanner> {
  GlobalKey<FormState> _key = new GlobalKey();

  late PermissionStatus _permissionGranted;
  Map<String, TextEditingController> textControllers = {};
  bool loading = false;
  // LocationPermission permission;

  TextEditingController gatway = new TextEditingController();

  late PermissionStatus status;

  askPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isDenied == true) {
      askPermission();
    } else {
      return status;
    }
  }

  String _scanBarcode = 'Unknown';

  LatLng gatewaylat = LatLng(0.0, 0.0);
  TextEditingController gatewaytext = TextEditingController();

  //Qr code
  Future scanQRgatway(controller, DevicetypeName) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#228B22',
        'Cancel',
        true,
        ScanMode.QR,
      );
      print(barcodeScanRes);
      var data = {
        "ProcessName": "device scan",
        "UserName": '${widget.farmid}',
        "IMEINumber": '${widget.imeinumber}',
        "IMEIPhoneNumber": '${widget.simnumber}',
        "fLog": "${DevicetypeName} scanned",
      };
      // print("contoller ${controller}");
      // alldevicedata
      //     .where((element) =>
      // element.DeviceID ==DevicetypeName)
      //     .forEach((element) {
      //       setState(() {
      //         controller=barcodeScanRes;
      //         element.DeviceEuID=barcodeScanRes;
      //       });
      //   print("Filtered Data: ${element.DeviceID}, ${element.DeviceEuID}, ${element.DeviceLatlang}");
      // });
      //

      await FarmerDeviceDetailsLog(data, "no", context);
      return barcodeScanRes;
    } on PlatformException {
      barcodeScanRes = 'Failed to get ';
    }
    // return barcodeScanRes;
// barcode scanner flutter ant

    setState(() {
      controller.text = barcodeScanRes;
      // _scanBarcode = barcodeScanRes;
    });
  }

  void initState() {
    super.initState();
    itteratot();
    // getimei();
  }

  List<Alllist> alldevicedata = [];
  itteratot() {
    // var data=widget!.farmer!.farmlands;
    try {
      setState(() {
        loading = true;
      });
      widget.farmer!.farmlands.forEach((farmland) {
        farmland.devices!.forEach((farmlanddevices) {
          alldevicedata.add(Alllist(
            DeviceID: farmlanddevices.deviceID,
            color: farmlanddevices.latitude != null &&
                    farmlanddevices.latitude != 0.0
                ? Colors.green
                : Colors.red,
            DeviceName: farmlanddevices.name,
            Devicetype: farmlanddevices.type,
            DeviceLatlang: LatLng(farmlanddevices.latitude ?? 0.0,
                farmlanddevices.longtitude ?? 0.0),
            DeviceEuID: farmlanddevices.deviceEUIID != '1234'
                ? farmlanddevices.deviceEUIID
                : "",
            HardWareSerialNumber: '',
            // DeviceLatlang: LatLng(farmlanddevices.latitude??0.0,farmlanddevices.longtitude??0.0)
          ));
        });
        farmland.blocks!.forEach((blocks) {
          blocks.plots!.forEach((plots) {
            plots.devices!.forEach((plotdevices) {
              alldevicedata.add(Alllist(
                DeviceID: plotdevices.deviceID,
                // color: Colors.red,
                color:
                    plotdevices.latitude != null && plotdevices.latitude != 0.0
                        ? Colors.green
                        : Colors.red,
                DeviceName: plotdevices.name,
                Devicetype: plotdevices.type,
                DeviceEuID: plotdevices.deviceEUIID != '1234'
                    ? plotdevices.deviceEUIID
                    : "",
                HardWareSerialNumber: '',
                DeviceLatlang: LatLng(
                    plotdevices.latitude ?? 0.0, plotdevices.longtitude ?? 0.0),
                // DeviceLatlang: LatLng(plotdevices.latitude??0.0,plotdevices.longtitude??0.0)
              ));
            });
          });
        });
      });
    } catch (e) {
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<LatLng> _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // debugPrint('location: ${position.latitude} ${position.longitude}');
    // getAddressFromCoordinates(position);
    final coordinates = new LatLng(position.latitude, position.longitude);
    // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // var first = addresses.first;
    // print("${first.featureName} : ${first.addressLine}");
    return LatLng(position.latitude, position.longitude);
  }

  // clear() {
  //   setState(() {
  //     gateway_latlng = LatLng(0.0, 0.0);
  //     mpsms_latlang = LatLng(0.0, 0.0);
  //     pump_latlang = LatLng(0.0, 0.0);
  //     valve_latlang = LatLng(0.0, 0.0);
  //     watermeter_latlang = LatLng(0.0, 0.0);
  //     backwash_latlang = LatLng(0.0, 0.0);
  //     others_latlang = LatLng(0.0, 0.0);
  //     gateway_location_color = Colors.red;
  //     mpsms_location_color = Colors.red;
  //     pump_location_color = Colors.red;
  //     valve_location_color = Colors.red;
  //     warermetter_location_color = Colors.red;
  //     backwash_location_color = Colors.red;
  //     others_location_color = Colors.red;
  //
  //     fnumber.text = "";
  //     gatway.text = "";
  //     wm.text = "";
  //     mpsms.text = "";
  //     pc.text = "";
  //     valve.text = "";
  //     others.text = "";
  //     backwash.text = "";
  //     dataupdating = false;
  //   });
  // }

  // datasave() async {
  //   // setState((){
  //   //   dataupdating=true;
  //   // });
  //   var response = await http.post(
  //       Uri.parse(
  //         // "http://192.168.1.121:8085/api/farm2fork/service/appfarmerdetails"
  //           "http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/service/appfarmerdetails"
  //       ),
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json'
  //       },
  //       body: json.encode({
  //
  //         "FarmerPhoneNumber": fnumber.text,
  //         "GatewaySerialNo": gatway.text,
  //         "GatewayLatitude": gateway_latlng.latitude,
  //         "GatewayLongitude": gateway_latlng.longitude,
  //         "PumpcontrollerSerialNo": pc.text,
  //         "PumpcontrollerLatitude": pump_latlang.latitude,
  //         "PumpcontrollerLongitude": pump_latlang.longitude,
  //         "BackWashSerialNo": backwash.text,
  //         "BackWashLatitude": backwash_latlang.latitude,
  //         "BackWashLongitude": backwash_latlang.longitude,
  //         "WatermeterSerialNo": wm.text,
  //         "WatermeterLatitude": watermeter_latlang.latitude,
  //         "WatermeterLongitude": watermeter_latlang.longitude,
  //         "ValveSerialNo": valve.text,
  //         "ValveLatitude": valve_latlang.latitude,
  //         "ValveLongitude": valve_latlang.longitude,
  //         "SoilMoisterSensorSerialNo": mpsms.text,
  //         "SoilMoisterSensorLatitude": mpsms_latlang.latitude,
  //         "SoilMoisterSensorLongitude": mpsms_latlang.longitude,
  //         "OthersSerialNo": others.text,
  //         "OthersLatitude": others_latlang.latitude,
  //         "OthersLongitude": others_latlang.longitude,
  //         "MobileDeviceIMEINo": MobileDeviceIMEINo,
  //         "CompanyID": 0,
  //         "BranchID": 0
  //         //
  //         //
  //         // "Phonenumber": fnumber.text,
  //         // "Gateway": gatway.text,
  //         // "Pumpcontroller": pc.text,
  //         // "Valve": valve.text,
  //         // "Watermeter": wm.text,
  //         // "Mpsms": mpsms.text,
  //         // "BackWash": backwash.text,
  //         // "Others": others.text
  //       }));
  //   var responsee = json.decode(response.body);
  //   if (responsee['status'] == "Success") {
  //     clear();
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text("Data Saved Successfully"),
  //             actions: [
  //               TextButton(
  //                 child: Text("OK"),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               )
  //             ],
  //           );
  //         }
  //     );
  //
  //     // Fluttertoast.showToast(
  //     //     msg: 'Data Save Successfully', toastLength: Toast.LENGTH_LONG);
  //
  //   } else {
  //     setState(() {
  //       dataupdating = false;
  //     });
  //     Fluttertoast.showToast(
  //         msg: 'please check internet connection',
  //         toastLength: Toast.LENGTH_LONG);
  //   }
  // }

  var width, hieght;
  static const IconData qr_code_scanner_rounded =
      IconData(0xf00cc, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    // width = MediaQuery
    //     .of(context)
    //     .size
    //     .width;
    hieght = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // var height =MediaQuery.of(context).size.height;
    final fontsize = width * hieght * 0.00004;
    final fontheaders = width * hieght * 0.00005;
    final imageHeightall = width * hieght * 0.0002;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Form(
                key: _key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/cultyvate.png',
                      height: 50,
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Farmer",
                                style: TextStyle(
                                    color: Color.fromRGBO(10, 192, 92, 2),
                                    fontSize: fontheaders,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " Device Details",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: fontheaders,
                                    fontWeight: FontWeight.bold),
                              ),
                            ])),
                    loading
                        ? CircularProgressIndicator()
                        : Column(
                            children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.farmer != null
                                      ? widget.farmer!.farmlands.length
                                      : 0,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      color: HexColor('#b8c8e3'),
                                      elevation: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
// ?                                  Visibility(

                                          // child:
                                          Container(
                                            child: Text(
                                              widget
                                                  .farmer!.farmlands[index].name
                                                  .toString(),
                                              style: iostextstyle(fontsize),
                                            ),
                                            margin: EdgeInsets.only(left: 20),
                                          ),
                                          // visible: widget.gatewayisthere!?false:true,
                                          // ),

                                          Visibility(
                                            visible: widget.gatewayisthere!
                                                ? false
                                                : true,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: Text(
                                                    "Latitude:${gatewaylat.latitude} Longitude:${gatewaylat.longitude}",
                                                    style:
                                                        iostextstyle(fontsize)),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.gatewayisthere!
                                                ? false
                                                : true,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              color: Colors.white,
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 10, 20, 5),
                                              child: AutofillGroup(
                                                child: TextFormField(
                                                  controller: gatewaytext,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            "[0-9a-zA-Z]")),
                                                    FilteringTextInputFormatter
                                                        .deny(RegExp(r'\s')),
                                                  ],
                                                  decoration: InputDecoration(
                                                      labelText: 'GateWay',
                                                      suffixIcon: Wrap(
                                                        children: [
                                                          IconButton(
                                                              icon: Icon(
                                                                  MdiIcons
                                                                      .barcode),
                                                              onPressed:
                                                                  () async {
                                                                scanQRgatway(
                                                                    gatewaytext,
                                                                    "Gateway");
                                                                // setState(() {
                                                                //   controller.text = data;
                                                                // });
                                                              }),
                                                          InkWell(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 13,
                                                                      right: 5),
                                                              child:
                                                                  ColorFiltered(
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/locationping.jpg",
                                                                  height: 20,
                                                                ),
                                                                colorFilter: ColorFilter.mode(
                                                                    gatewaylat !=
                                                                            LatLng(0.0,
                                                                                0.0)
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red,
                                                                    BlendMode
                                                                        .color),
                                                              ),
                                                            ),
                                                            onTap: () async {
                                                              PermissionStatus
                                                                  status =
                                                                  await askPermission();
                                                              if (status
                                                                      .isGranted &&
                                                                  !status
                                                                      .isNull) {
                                                                LatLng lat =
                                                                    await _getLocation();
                                                                setState(() {
                                                                  gatewaylat =
                                                                      lat;
                                                                });
                                                              } else {
                                                                print("error");
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      border:
                                                          OutlineInputBorder()),
                                                ),
                                              ),
                                            ),
                                          ),

                                          ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: widget.farmer != null
                                                  ? widget
                                                      .farmer!
                                                      .farmlands[index]
                                                      .devices!
                                                      .length
                                                  : 0,
                                              reverse: true,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int ind) {
                                                var controllerKey =
                                                    '${widget.farmer!.farmlands[index].devices![ind].deviceID}';
                                                if (!textControllers
                                                    .containsKey(
                                                        controllerKey)) {
                                                  textControllers[
                                                          controllerKey] =
                                                      TextEditingController();
                                                }
                                                TextEditingController?
                                                    controller =
                                                    textControllers[
                                                        controllerKey];
                                                bool isFirstTime =
                                                    controller?.text.isEmpty ??
                                                        true;

                                                // TextEditingController ? controller = textControllers[controllerKey];
                                                // bool isFirstTime = controller?.text.isEmpty ?? true;

                                                LatLng? lang = LatLng(
                                                    widget
                                                            .farmer!
                                                            .farmlands[index]
                                                            .devices![ind]
                                                            .latitude ??
                                                        0.0,
                                                    widget
                                                            .farmer!
                                                            .farmlands[index]
                                                            .devices![ind]
                                                            .longtitude ??
                                                        0.0);
                                                // Color? color1=lang!=LatLng(0.0,0.0)?Colors.green:Colors.red;
                                                Color? color =
                                                    lang != LatLng(0.0, 0.0)
                                                        ? Colors.green
                                                        : Colors.red;
                                                ;
                                                // LatLng ?lang=LatLng(0.0, 0.0);
                                                if (isFirstTime) {
                                                  alldevicedata
                                                      .forEach((element) {
                                                    if (widget
                                                            .farmer!
                                                            .farmlands[index]
                                                            .devices![ind]
                                                            .deviceID ==
                                                        element.DeviceID) {
                                                      controller?.text =
                                                          element.DeviceEuID
                                                              .toString();
                                                      color = element.DeviceLatlang !=
                                                                  null &&
                                                              element.DeviceLatlang !=
                                                                  LatLng(
                                                                      0.0, 0.0)
                                                          ? Colors.green
                                                          : Colors.red;
                                                      lang =
                                                          element.DeviceLatlang;
                                                      print("latlang${color}");
                                                      // });
                                                    }
                                                  });
                                                }
                                                // else{
                                                //   controller?.text='-1';
                                                // }
                                                //      var controller1= '${widget.farmer!.farmlands![index].devices![ind].deviceID}';
                                                // textControllers[controller1]=new TextEditingController();
                                                //     TextEditingController controller = textControllers[widget.farmer!.farmlands![index].devices![ind].deviceID];

                                                return Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10),
                                                        child: Text(
                                                            "Latitude:${lang?.latitude ?? 0.0} Longitude:${lang?.longitude ?? 0.0}",
                                                            style: iostextstyle(
                                                                fontsize)),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      color: Colors.white,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20, 10, 20, 5),
                                                      child: AutofillGroup(
                                                        child: TextFormField(
                                                          controller:
                                                              controller,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                    "[0-9a-zA-Z]")),
                                                            FilteringTextInputFormatter
                                                                .deny(RegExp(
                                                                    r'\s')),
                                                          ],
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      '${widget.farmer!.farmlands[index].devices![ind].name}',
                                                                  suffixIcon:
                                                                      Wrap(
                                                                    children: [
                                                                      IconButton(
                                                                          icon: Icon(MdiIcons
                                                                              .barcode),
                                                                          onPressed:
                                                                              () async {
                                                                            var data =
                                                                                await scanQRgatway(controller, widget.farmer!.farmlands[index].devices![ind].name);

                                                                            alldevicedata.where((element) => element.DeviceID == widget.farmer!.farmlands[index].devices![ind].deviceID).forEach((element) {
                                                                              setState(() {
                                                                                element.DeviceEuID = data.toLowerCase();
                                                                                controller?.text = data.toLowerCase();
                                                                              });
                                                                            });

                                                                            // alldevicedata
                                                                            //     .forEach((
                                                                            //     element) {
                                                                            //   if (widget.farmer!.farmlands![index].blocks![ind].plots![indplot].devices![indplotsdev].deviceID ==
                                                                            //       element
                                                                            //           .DeviceID) {
                                                                            //     setState(() {
                                                                            //       element
                                                                            //           .DeviceEuID =
                                                                            //           data;
                                                                            //     });
                                                                            //   }
                                                                            // });
                                                                          }
                                                                          // scanQRgatway(controller)},
                                                                          ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      InkWell(
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 13,
                                                                              right: 5),
                                                                          child:
                                                                              ColorFiltered(
                                                                            child:
                                                                                Image.asset(
                                                                              "assets/images/locationping.jpg",
                                                                              height: 20,
                                                                            ),
                                                                            colorFilter:
                                                                                ColorFilter.mode(color!, BlendMode.color),
                                                                          ),
                                                                        ),
                                                                        onTap:
                                                                            () async {
                                                                          PermissionStatus
                                                                              status =
                                                                              await askPermission();
                                                                          print(
                                                                              status.isGranted);

                                                                          if (status.isGranted &&
                                                                              !status.isNull) {
                                                                            lang =
                                                                                await _getLocation();
                                                                            print(lang);
                                                                            alldevicedata.forEach((element) {
                                                                              print(widget.farmer!.farmlands[index].devices![ind].deviceID == element.DeviceID);
                                                                              if (widget.farmer!.farmlands[index].devices![ind].deviceID == element.DeviceID) {
                                                                                setState(() {
                                                                                  element.color = Colors.green;
                                                                                  color = Colors.green;
                                                                                  widget.farmer!.farmlands[index].devices![ind].latitude = lang?.latitude;
                                                                                  widget.farmer!.farmlands[index].devices![ind].longtitude = lang?.longitude;
                                                                                  element.DeviceLatlang = lang;
                                                                                });
                                                                              }
                                                                            });
                                                                          } else {
                                                                            print("error");
                                                                          }
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  border:
                                                                      OutlineInputBorder()),
                                                          onChanged:
                                                              (datafhhf) {
                                                            print(
                                                                "all data $datafhhf");

                                                            alldevicedata
                                                                .where((element) =>
                                                                    element
                                                                        .DeviceID ==
                                                                    widget
                                                                        .farmer!
                                                                        .farmlands[
                                                                            index]
                                                                        .devices![
                                                                            ind]
                                                                        .deviceID)
                                                                .forEach(
                                                                    (element) {
                                                              element.DeviceEuID =
                                                                  datafhhf
                                                                      .toLowerCase();

                                                              print(
                                                                  "Filtered Data: ${element.DeviceID}, ${element.DeviceEuID}, ${element.DeviceLatlang}");
                                                            });
                                                            // alldevicedata.forEach((element) {
                                                            //   print(element.DeviceID);
                                                            //   print(widget.farmer!.farmlands![index].blocks![ind].plots![indplot]!.devices![indplotsdev].deviceID);
                                                            //   print(element.DeviceID==widget.farmer!.farmlands![index].blocks![ind].plots![indplot]!.devices![indplotsdev].deviceID);
                                                            //   if(widget.farmer!.farmlands![index].blocks![ind].plots![indplot]!.devices![indplotsdev].deviceID==element.DeviceID){
                                                            //     // setState(() {
                                                            //     // widget.farmer!.farmlands![index].blocks![ind].plots![indplot]!.devices![indplotsdev].deviceID=datafhhf;
                                                            //       element.DeviceEuID=datafhhf;
                                                            //     // });
                                                            //     print("elemrnt device id${element.DeviceEuID}");
                                                            //
                                                            //   }
                                                            //   else {
                                                            //
                                                            //
                                                            //   }
                                                            // });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    )

                                                    //        Container(
                                                    //          margin: EdgeInsets.only(left: 10,right: 10),
                                                    //          color:Colors.white,
                                                    //          padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                                                    //          child: AutofillGroup(
                                                    //            child: TextFormField(
                                                    //              controller: controller,
                                                    //
                                                    //              // inputFormatters: [
                                                    //              //   FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                                                    //              //   FilteringTextInputFormatter.deny(
                                                    //              //       RegExp(r'\s')),
                                                    //              // ],
                                                    //
                                                    //              decoration: InputDecoration(
                                                    //
                                                    //                  labelText: '${widget.farmer!
                                                    //                      .farmlands![index].devices![ind].name}',
                                                    //                  suffixIcon:
                                                    //                  Wrap(
                                                    //                    children: [
                                                    //                      IconButton(
                                                    //                        icon: Icon(MdiIcons.barcode),
                                                    //                        onPressed: ()async {
                                                    //                          var data = await scanQRgatway(controller!,widget.farmer!.farmlands![index].devices![ind].name);
                                                    // print("sdatattata ${data}");
                                                    //                          alldevicedata
                                                    //                              .where((element) =>
                                                    //                          element.DeviceID ==widget.farmer!.farmlands![index].devices![ind].deviceID).forEach((element) {
                                                    //                            setState(() {
                                                    //                              element.DeviceEuID=data;
                                                    //                              controller?.text=data;
                                                    //                            });
                                                    //                          });
                                                    //
                                                    //                        //
                                                    //                        //   var data= await  scanQRgatway(controller,widget.farmer!.farmlands![index].devices![ind].name);
                                                    //                        //    print("farmland barcode scan ${data}");
                                                    //                        //  alldevicedata.where((element) =>
                                                    //                        // element.DeviceID ==widget.farmer!.farmlands![index].devices![ind].deviceID).forEach((element) {
                                                    //                        // setState(() {
                                                    //                        //   element.DeviceEuID=data;
                                                    //                        //   controller.text=data;
                                                    //                        // });
                                                    //                        // });
                                                    //                        // alldevicedata.forEach((element) {
                                                    //                        //   if(widget.farmer!.farmlands![index].devices![ind].deviceID==element.DeviceID){
                                                    //                        //  setState(() {
                                                    //                        //
                                                    //                        //
                                                    //                        //  });
                                                    //
                                                    //                        //   }
                                                    //                        // });
                                                    //
                                                    //
                                                    //
                                                    //                        }
                                                    //
                                                    //                      ),
                                                    //                      InkWell(
                                                    //                        child: Padding(padding: EdgeInsets.only(top: 13,right: 5),child: ColorFiltered(
                                                    //                          child: Image.asset("assets/images/locationping.jpg" ,height: 20,),
                                                    //                          colorFilter:  ColorFilter.mode(color!, BlendMode.color),
                                                    //                        ),),
                                                    //                        onTap: () async {
                                                    //                          PermissionStatus   status=await askPermission();
                                                    //                          if(status.isGranted &&!status.isNull) {
                                                    //                            lang = await _getLocation();
                                                    //                            if (lang!.latitude != 0.0 &&
                                                    //                                lang!.longitude != 0.0) {
                                                    //                              alldevicedata.forEach((element) {
                                                    //                                if(widget.farmer!.farmlands![index].devices![ind].deviceID==element.DeviceID){
                                                    //                                 setState(() {
                                                    //                                   element.color=Colors.green;
                                                    //                                   color=Colors.green;
                                                    //                                   element.DeviceLatlang=lang;
                                                    //                                   widget.farmer!.farmlands![index].devices![ind].latitude=lang?.latitude;
                                                    //                                   widget.farmer!.farmlands![index].devices![ind].longtitude=lang?.longitude;
                                                    //                                 });
                                                    //                                }
                                                    //                              });
                                                    //                            }
                                                    //                          }
                                                    //                          else{
                                                    //                            print("error");
                                                    //                          }
                                                    //                        },
                                                    //                      ),
                                                    //                    ],
                                                    //                  ),
                                                    //
                                                    //                  border: OutlineInputBorder()),
                                                    //              onChanged: (datafhhf){
                                                    //                alldevicedata.forEach((element) {
                                                    //                  if(widget.farmer!.farmlands![index].devices![ind].deviceID==element.DeviceID){
                                                    //                    // setState(() {
                                                    //                      element.DeviceEuID=datafhhf;
                                                    //                    // });
                                                    //                     print("element is id ${ element.DeviceEuID}");
                                                    //                  }
                                                    //                });
                                                    //
                                                    //              },
                                                    //            ),
                                                    //          ),
                                                    //        ),
                                                  ],
                                                );
                                              }),

                                          ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: widget.farmer != null
                                                  ? widget
                                                      .farmer!
                                                      .farmlands[index]
                                                      .blocks!
                                                      .length
                                                  : 0,
                                              shrinkWrap: true,
                                              reverse: false,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int ind) {
                                                return Card(
                                                  elevation: 3,
                                                  color: HexColor('#c3cbd9'),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                            widget
                                                                .farmer!
                                                                .farmlands[
                                                                    index]
                                                                .blocks![ind]
                                                                .name
                                                                .toString(),
                                                            style: iostextstyle(
                                                                fontsize)),
                                                        margin: EdgeInsets.only(
                                                            left: 20),
                                                      ),
                                                      ListView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemCount: widget
                                                                      .farmer !=
                                                                  null
                                                              ? widget
                                                                  .farmer!
                                                                  .farmlands[
                                                                      index]
                                                                  .blocks![ind]
                                                                  .plots!
                                                                  .length
                                                              : 0,
                                                          reverse: true,
                                                          shrinkWrap: true,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int indplot) {
                                                            return Card(
                                                              color: HexColor(
                                                                  '#ecf2d8'),
                                                              elevation: 5,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                        widget
                                                                            .farmer!
                                                                            .farmlands[
                                                                                index]
                                                                            .blocks![
                                                                                ind]
                                                                            .plots![
                                                                                indplot]
                                                                            .name
                                                                            .toString(),
                                                                        style: iostextstyle(
                                                                            fontsize)),
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                20),
                                                                  ),
                                                                  ListView.builder(
                                                                      physics: NeverScrollableScrollPhysics(),
                                                                      itemCount: widget.farmer != null ? widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices!.length : 0,
                                                                      reverse: true,
                                                                      shrinkWrap: true,
                                                                      itemBuilder: (BuildContext context, int indplotsdev) {
                                                                        var controllerKey =
                                                                            '${widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices![indplotsdev].deviceID}';
                                                                        if (!textControllers
                                                                            .containsKey(controllerKey)) {
                                                                          textControllers[controllerKey] =
                                                                              TextEditingController();
                                                                        }
                                                                        TextEditingController?
                                                                            controller =
                                                                            textControllers[controllerKey];
                                                                        bool
                                                                            isFirstTime =
                                                                            controller?.text.isEmpty ??
                                                                                true;
                                                                        LatLng? lang1 = LatLng(
                                                                            widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices![indplotsdev].latitude ??
                                                                                0.0,
                                                                            widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices![indplotsdev].longtitude ??
                                                                                0.0);
                                                                        Color? color1 = lang1 !=
                                                                                LatLng(0.0, 0.0)
                                                                            ? Colors.green
                                                                            : Colors.red;

                                                                        if (isFirstTime) {
                                                                          for (var element
                                                                              in alldevicedata) {
                                                                            if (widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices![indplotsdev].deviceID ==
                                                                                element.DeviceID) {
                                                                              print("element is ${element.DeviceEuID}");
                                                                              controller!.text = element.DeviceEuID.toString();
                                                                              lang1 = element.DeviceLatlang;
                                                                              print("element latlang ${lang1}");
                                                                              color1 = element.DeviceLatlang != null && element.DeviceLatlang != LatLng(0.0, 0.0) ? Colors.green : Colors.red;
                                                                            }
                                                                          }
                                                                        }
                                                                        // });

                                                                        // WidgetsBinding.instance?.addPostFrameCallback((_) {
                                                                        //   controller?.selection = TextSelection.fromPosition(TextPosition(offset: cursorPosition!));
                                                                        // });
                                                                        return Column(
                                                                          children: [
                                                                            Align(
                                                                              alignment: Alignment.centerRight,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(right: 10),
                                                                                child: Text("Latitude:${lang1?.latitude ?? 0.0} Longitude:${lang1?.longitude ?? 0.0}", style: iostextstyle(fontsize)),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              margin: EdgeInsets.only(left: 10, right: 10),
                                                                              color: Colors.white,
                                                                              padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                                                                              child: AutofillGroup(
                                                                                child: TextFormField(
                                                                                  controller: controller,
                                                                                  inputFormatters: [
                                                                                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                                                                                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                                                                                  ],
                                                                                  decoration: InputDecoration(
                                                                                      labelText: '${widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices![indplotsdev].name}',
                                                                                      suffixIcon: Wrap(
                                                                                        children: [
                                                                                          IconButton(
                                                                                              icon: Icon(MdiIcons.barcode),
                                                                                              onPressed: () async {
                                                                                                var data = await scanQRgatway(controller, widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices![indplotsdev].name);

                                                                                                alldevicedata.where((element) => element.DeviceID == widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices![indplotsdev].deviceID).forEach((element) {
                                                                                                  setState(() {
                                                                                                    element.DeviceEuID = data.toLowerCase();
                                                                                                    controller?.text = data.toLowerCase();
                                                                                                  });
                                                                                                });

                                                                                                // alldevicedata
                                                                                                //     .forEach((
                                                                                                //     element) {
                                                                                                //   if (widget.farmer!.farmlands![index].blocks![ind].plots![indplot].devices![indplotsdev].deviceID ==
                                                                                                //       element
                                                                                                //           .DeviceID) {
                                                                                                //     setState(() {
                                                                                                //       element
                                                                                                //           .DeviceEuID =
                                                                                                //           data;
                                                                                                //     });
                                                                                                //   }
                                                                                                // });
                                                                                              }
                                                                                              // scanQRgatway(controller)},
                                                                                              ),
                                                                                          SizedBox(
                                                                                            width: 5,
                                                                                          ),
                                                                                          InkWell(
                                                                                            child: Padding(
                                                                                              padding: EdgeInsets.only(top: 13, right: 5),
                                                                                              child: ColorFiltered(
                                                                                                child: Image.asset(
                                                                                                  "assets/images/locationping.jpg",
                                                                                                  height: 20,
                                                                                                ),
                                                                                                colorFilter: ColorFilter.mode(color1!, BlendMode.color),
                                                                                              ),
                                                                                            ),
                                                                                            onTap: () async {
                                                                                              PermissionStatus status = await askPermission();
                                                                                              print(status.isGranted);

                                                                                              if (status.isGranted && !status.isNull) {
                                                                                                lang1 = await _getLocation();
                                                                                                print(lang1);
                                                                                                alldevicedata.forEach((element) {
                                                                                                  print(widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices![indplotsdev].deviceID == element.DeviceID);
                                                                                                  if (widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices![indplotsdev].deviceID == element.DeviceID) {
                                                                                                    setState(() {
                                                                                                      element.color = Colors.green;
                                                                                                      color1 = Colors.green;
                                                                                                      widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices![indplotsdev].latitude = lang1?.latitude;
                                                                                                      widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices![indplotsdev].longtitude = lang1?.longitude;
                                                                                                      element.DeviceLatlang = lang1;
                                                                                                    });
                                                                                                  }
                                                                                                });
                                                                                              } else {
                                                                                                print("error");
                                                                                              }
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      border: OutlineInputBorder()),
                                                                                  onChanged: (datafhhf) {
                                                                                    print("all data $datafhhf");

                                                                                    alldevicedata.where((element) => element.DeviceID == widget.farmer!.farmlands[index].blocks![ind].plots![indplot].devices![indplotsdev].deviceID).forEach((element) {
                                                                                      element.DeviceEuID = datafhhf.toLowerCase();

                                                                                      print("Filtered Data: ${element.DeviceID}, ${element.DeviceEuID}, ${element.DeviceLatlang}");
                                                                                    });
                                                                                    // alldevicedata.forEach((element) {
                                                                                    //   print(element.DeviceID);
                                                                                    //   print(widget.farmer!.farmlands![index].blocks![ind].plots![indplot]!.devices![indplotsdev].deviceID);
                                                                                    //   print(element.DeviceID==widget.farmer!.farmlands![index].blocks![ind].plots![indplot]!.devices![indplotsdev].deviceID);
                                                                                    //   if(widget.farmer!.farmlands![index].blocks![ind].plots![indplot]!.devices![indplotsdev].deviceID==element.DeviceID){
                                                                                    //     // setState(() {
                                                                                    //     // widget.farmer!.farmlands![index].blocks![ind].plots![indplot]!.devices![indplotsdev].deviceID=datafhhf;
                                                                                    //       element.DeviceEuID=datafhhf;
                                                                                    //     // });
                                                                                    //     print("elemrnt device id${element.DeviceEuID}");
                                                                                    //
                                                                                    //   }
                                                                                    //   else {
                                                                                    //
                                                                                    //
                                                                                    //   }
                                                                                    // });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            )
                                                                          ],
                                                                        );
                                                                      }),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    ],
                                                  ),
                                                );
                                              })
                                        ],
                                      ),
                                    );
                                  }),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green),
                                      child: Text(
                                        "Update",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontsize),
                                      ),
                                      onPressed: () async {
                                        if (widget.updatepermission ?? false) {
                                          List<String> deviceids = [];
                                          List<Alllist> funckingdevices = [];
                                          bool alldevices = false;

                                          alldevicedata.forEach((element) {
                                            if (element.DeviceEuID != null &&
                                                element.DeviceEuID != '' &&
                                                element.DeviceEuID!.length >
                                                    3 &&
                                                element.DeviceEuID != '1234') {
                                              deviceids
                                                  .add('${element.DeviceEuID}');
                                              funckingdevices.add(element);
                                            }
                                            print("deviceids ${deviceids}");
                                            funckingdevices.forEach((element) =>
                                                print(
                                                    "all deviceid${element.DeviceEuID}"));
                                          });
                                          List<Alllist> latlangemoty =
                                              funckingdevices
                                                  .where((element) =>
                                                      element.DeviceLatlang ==
                                                      LatLng(0.0, 0.0))
                                                  .toList();

                                          if (latlangemoty.length > 0) {
                                            var latlanglist = latlangemoty
                                                .map((element) =>
                                                    element.DeviceEuID)
                                                .join(',');
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      content: Text(
                                                          ' DeviceID "${latlanglist.toString()}" \n Missing Latitude & Longitude\nPlease update Latitude & Longitude to continue',
                                                          style: iostextstyle(
                                                              fontsize)),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text("Ok",
                                                              style:
                                                                  iostextstyle(
                                                                      fontsize)),
                                                        ),
                                                      ]);
                                                });
                                          } else {
                                            if (widget.gatewayisthere ==
                                                false) {
                                              if (gatewaytext.text.isEmpty) {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content: ResponsiveText(
                                                          text:
                                                              'Gateway details not entered for "${widget.farmer!.name}"\nAre you sure you want to continue\n without GatewayID ?',
                                                          widthScaleFactor:
                                                              0.02,
                                                          // Adjust this value according to your preference
                                                          heightScaleFactor:
                                                              0.01, // Adjust this value according to your preference
                                                        ),

                                                        // Text('',style: TextStyle(fontSize: 12),),
                                                        actions: [
                                                          Row(
                                                            children: [
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.pop(
                                                                      context);
                                                                  // Action to perform when OK button is pressed
                                                                  checkDuplicateDeviceIDs(
                                                                      context:
                                                                          context,
                                                                      deviceids:
                                                                          deviceids,
                                                                      devices:
                                                                          alldevicedata,
                                                                      funckingdevices:
                                                                          funckingdevices);
                                                                  // if (funckingdevices!.length ==deviceids.length) {
                                                                  //   var duplicates = findDuplicates(funckingdevices);
                                                                  //   print(
                                                                  //       "all duplicates data ${duplicates
                                                                  //           .length}");
                                                                  //   print(duplicates
                                                                  //       .length >
                                                                  //       0);
                                                                  //   if (duplicates
                                                                  //       .length >
                                                                  //       0) {
                                                                  //     // Navigator.pop(context);
                                                                  //
                                                                  //     showDialog(
                                                                  //       context: context,
                                                                  //       builder: (
                                                                  //           BuildContext context) {
                                                                  //         return AlertDialog(
                                                                  //           content: Text(
                                                                  //               "DeviceID Duplicate Found\n$duplicates \nCannot continue."),
                                                                  //           actions: [
                                                                  //             Row(
                                                                  //               children: [
                                                                  //                 TextButton(
                                                                  //                   onPressed: () {
                                                                  //                     Navigator
                                                                  //                         .pop(
                                                                  //                         context);
                                                                  //                     Navigator
                                                                  //                         .pop(
                                                                  //                         context);
                                                                  //                   },
                                                                  //                   style: TextButton
                                                                  //                       .styleFrom(
                                                                  //                     backgroundColor: Colors
                                                                  //                         .green,
                                                                  //                   ),
                                                                  //                   child: Text(
                                                                  //                     'OK',
                                                                  //                     style: TextStyle(
                                                                  //                       color: Colors
                                                                  //                           .white,
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 ),
                                                                  //               ],
                                                                  //               mainAxisAlignment: MainAxisAlignment
                                                                  //                   .spaceAround,
                                                                  //             )
                                                                  //           ],
                                                                  //         );
                                                                  //       },
                                                                  //     );
                                                                  //     print(
                                                                  //         "manoj");
                                                                  //     showDialog(
                                                                  //       context: context,
                                                                  //       builder: (
                                                                  //           BuildContext context) {
                                                                  //         return AlertDialog(
                                                                  //           content: Text(
                                                                  //               "DeviceID Duplicate Found\n$duplicates \nCannot continue."),
                                                                  //           actions: [
                                                                  //             Row(
                                                                  //               children: [
                                                                  //                 TextButton(
                                                                  //                   onPressed: () {
                                                                  //                     Navigator
                                                                  //                         .pop(
                                                                  //                         context);
                                                                  //                     Navigator
                                                                  //                         .pop(
                                                                  //                         context);
                                                                  //                   },
                                                                  //                   style: TextButton
                                                                  //                       .styleFrom(
                                                                  //                     backgroundColor: Colors
                                                                  //                         .green,
                                                                  //                   ),
                                                                  //                   child: Text(
                                                                  //                     'Ok',
                                                                  //                     style: TextStyle(
                                                                  //                       color: Colors
                                                                  //                           .white,
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 ),
                                                                  //               ],
                                                                  //               mainAxisAlignment: MainAxisAlignment
                                                                  //                   .spaceAround,
                                                                  //             )
                                                                  //           ],
                                                                  //         );
                                                                  //       },
                                                                  //     );
                                                                  //   }
                                                                  //   else {
                                                                  //     final data = await getDeviceID(
                                                                  //         deviceids);
                                                                  //     print(data
                                                                  //         .length ==
                                                                  //         deviceids
                                                                  //             .length);
                                                                  //     print(
                                                                  //         "data sucess${data}");
                                                                  //     if (data
                                                                  //         .length ==
                                                                  //         deviceids
                                                                  //             .length) {
                                                                  //       if (data
                                                                  //           .length >
                                                                  //           0) {
                                                                  //         for (int i = 0; i <
                                                                  //             data
                                                                  //                 .length; i++) {
                                                                  //           print(
                                                                  //               'majnfaskfnj ${data[i]['DeviceEUIID']}');
                                                                  //           for (int j = 0; j <
                                                                  //               alldevicedata
                                                                  //                   .length; j++) {
                                                                  //             if (data[i]['DeviceEUIID'] ==
                                                                  //                 alldevicedata[j]
                                                                  //                     .DeviceEuID ||
                                                                  //             data[i]['HardwareSerialNumber'] ==alldevicedata[j].DeviceEuID) {
                                                                  //               // setState(() {
                                                                  //               alldevicedata[j]
                                                                  //                   .DeviceEuID =
                                                                  //               data[i]['DeviceEUIID'];
                                                                  //               alldevicedata[j]
                                                                  //                   .HardWareSerialNumber =
                                                                  //               data[i]['HardwareSerialNumber'];
                                                                  //               alldevicedata[j]
                                                                  //                   .TTIApplicatonID =
                                                                  //               data[i]['TTIApplicatonID'];
                                                                  //               alldevicedata[j]
                                                                  //                   .TTIDeviceID =
                                                                  //               data[i]['TTIDeviceID'];
                                                                  //               // });
                                                                  //             }
                                                                  //             else {
                                                                  //
                                                                  //             }
                                                                  //             print(
                                                                  //                 "one tiweorw ${alldevicedata[j].DeviceEuID}");
                                                                  //           }
                                                                  //         }
                                                                  //
                                                                  //         alldevicedata
                                                                  //             .forEach((
                                                                  //             alldata) async {
                                                                  //           var data = {
                                                                  //             "DeviceEUIID": alldata
                                                                  //                 .DeviceEuID,
                                                                  //             "TTIApplicatonID": alldata
                                                                  //                 .TTIApplicatonID,
                                                                  //             "HardwareSerialNumber": alldata.HardWareSerialNumber,
                                                                  //             "TTIDeviceID": alldata
                                                                  //                 .TTIDeviceID,
                                                                  //             "ID": alldata
                                                                  //                 .DeviceID,
                                                                  //             "Latitude": alldata
                                                                  //                 .DeviceLatlang!
                                                                  //                 .latitude,
                                                                  //             "Longitude": alldata
                                                                  //                 .DeviceLatlang!
                                                                  //                 .longitude,
                                                                  //             "UserName": '${widget
                                                                  //                 .farmid}',
                                                                  //             "IMEINumber": '${widget
                                                                  //                 .imeinumber}',
                                                                  //             "IMEIPhoneNumber": '${widget
                                                                  //                 .simnumber}',
                                                                  //           };
                                                                  //           if (alldevicedata
                                                                  //               .indexOf(
                                                                  //               alldata) ==
                                                                  //               alldevicedata
                                                                  //                   .length -
                                                                  //                   1) {
                                                                  //             print(
                                                                  //                 "Last item: $alldata");
                                                                  //             var responce = await UpdateData(
                                                                  //                 data);
                                                                  //
                                                                  //             var datagaga = {
                                                                  //               "ProcessName": "Process end ",
                                                                  //               "UserName": '${widget
                                                                  //                   .farmid}',
                                                                  //               "IMEINumber": '${widget
                                                                  //                   .imeinumber}',
                                                                  //               "IMEIPhoneNumber": '${widget
                                                                  //                   .simnumber}',
                                                                  //               "fLog": "Process completed",
                                                                  //
                                                                  //             };
                                                                  //             var log = await FarmerDeviceDetailsLog(
                                                                  //                 datagaga,
                                                                  //                 "Yes",
                                                                  //                 context);
                                                                  //             print(
                                                                  //                 "log ${log}");
                                                                  //             if (log) {
                                                                  //               Get
                                                                  //                   .defaultDialog(
                                                                  //                 title: "Data saved Successfully",
                                                                  //                 backgroundColor: Colors
                                                                  //                     .white,
                                                                  //                 middleText: "                                                          ",
                                                                  //                 titleStyle: TextStyle(
                                                                  //                     color: Colors
                                                                  //                         .green),
                                                                  //                 radius: 30,
                                                                  //                 actions: [
                                                                  //                   Container(
                                                                  //                     color: Colors
                                                                  //                         .green,
                                                                  //                     child: TextButton(
                                                                  //
                                                                  //                       onPressed: () {
                                                                  //                         Get
                                                                  //                             .back(); // Equivalent to Navigator.pop(context)
                                                                  //                         Get
                                                                  //                             .back(); // Pop twice to go back to the previous screen
                                                                  //                       },
                                                                  //
                                                                  //                       child: Text(
                                                                  //                         "Ok",
                                                                  //                         style: TextStyle(
                                                                  //                             color: Colors
                                                                  //                                 .white),),
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 ],
                                                                  //               );
                                                                  //             }
                                                                  //           }
                                                                  //           else {
                                                                  //             var responce = await UpdateData(
                                                                  //                 data);
                                                                  //             if (responce) {
                                                                  //               alldevicedata
                                                                  //                   .remove(
                                                                  //                   alldata);
                                                                  //             }
                                                                  //           }
                                                                  //         });
                                                                  //       }
                                                                  //     }
                                                                  //     else {
                                                                  //       for (int i = 0; i <
                                                                  //           funckingdevices
                                                                  //               .length; i++) {
                                                                  //         bool isPresent = false;
                                                                  //
                                                                  //         for (int j = 0; j <
                                                                  //             data
                                                                  //                 .length; j++) {
                                                                  //           if (funckingdevices[i]
                                                                  //               .DeviceEuID ==
                                                                  //               data[j]['DeviceEUIID']) {
                                                                  //             isPresent =
                                                                  //             true;
                                                                  //             break;
                                                                  //           }
                                                                  //         }
                                                                  //
                                                                  //         if (!isPresent) {
                                                                  //           // The value in 'data' array is not present in 'alldevicedata' array
                                                                  //           // Perform the desired action here
                                                                  //           // For example, add the value to 'alldevicedata' array
                                                                  //           List newDevice = [
                                                                  //           ];
                                                                  //
                                                                  //           newDevice
                                                                  //               .add(
                                                                  //               funckingdevices[i]
                                                                  //                   .DeviceEuID);
                                                                  //
                                                                  //           print(
                                                                  //               "Missing device id ${newDevice}");
                                                                  //         }
                                                                  //       }
                                                                  //       // List<dynamic> missingValues = data.where((jsonValue) => !alldevicedata.any((modelValue) => modelValue.DeviceEuID == jsonValue['DeviceEUIID'])).toList();
                                                                  //       List<
                                                                  //           Alllist> missingValues = funckingdevices
                                                                  //           .where((
                                                                  //           modelValue) =>
                                                                  //       !data.any((
                                                                  //           jsonValue) =>
                                                                  //       modelValue
                                                                  //           .DeviceEuID ==
                                                                  //           jsonValue['DeviceEUIID']))
                                                                  //           .toList();
                                                                  //       var alldata = missingValues
                                                                  //           .map((
                                                                  //           item) =>
                                                                  //       item
                                                                  //           .DeviceEuID)
                                                                  //           .join(
                                                                  //           ", ");
                                                                  //
                                                                  //       if (missingValues
                                                                  //           .length >
                                                                  //           0) {
                                                                  //         Future
                                                                  //             .microtask(() {
                                                                  //           showDialog(
                                                                  //             context: context,
                                                                  //
                                                                  //             builder: (
                                                                  //                 BuildContext context) {
                                                                  //               return
                                                                  //                 AlertDialog(
                                                                  //                   content: Text(
                                                                  //                       '${alldata} \nThis device not found in Master \nPlease contact cultYvate to finish installation'),
                                                                  //                   actions: [
                                                                  //                     Center(
                                                                  //                       child: TextButton(
                                                                  //                         onPressed: () {
                                                                  //                           // Action to perform when OK button is pressed
                                                                  //                           Navigator
                                                                  //                               .pop(
                                                                  //                               context);
                                                                  //                           // Navigator
                                                                  //                           //     .pop(
                                                                  //                           //     context);
                                                                  //                           // Navigator.pop(context);
                                                                  //                         },
                                                                  //                         style: TextButton
                                                                  //                             .styleFrom(
                                                                  //                           backgroundColor: Colors
                                                                  //                               .green, // Set the background color
                                                                  //                         ),
                                                                  //                         child: Text(
                                                                  //                           'Ok',
                                                                  //                           style: TextStyle(
                                                                  //                             color: Colors
                                                                  //                                 .white, // Set the text color
                                                                  //                           ),),
                                                                  //                       ),
                                                                  //                     )
                                                                  //                   ],
                                                                  //                 );
                                                                  //             },
                                                                  //             useRootNavigator: true,
                                                                  //           );
                                                                  //         }
                                                                  //         );
                                                                  //       }
                                                                  //
                                                                  //       // print("missing values ${missingValues.}");
                                                                  //       // List<String> missingElements = funckingdevices.where((element) => !firstArray.contains(element)).toList();
                                                                  //     }
                                                                  //   }
                                                                  // }
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green, // Set the background color
                                                                ),
                                                                child: Text(
                                                                  'Yes',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    // Set the text color
                                                                  ),
                                                                ),
                                                              ),
                                                              // Spacer(),
                                                              TextButton(
                                                                onPressed: () {
                                                                  // Action to perform when OK button is pressed
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red, // Set the background color
                                                                ),
                                                                child: Text(
                                                                  'No',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white, // Set the text color
                                                                  ),
                                                                ),
                                                                // child: Text('No'),
                                                              ),
                                                            ],
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                          )
                                                        ],
                                                      );
                                                    });
                                              } else {
                                                if (widget.incertpermission ??
                                                    false) {
                                                  List<String> gatway = [
                                                    '${gatewaytext.text}'
                                                  ];
                                                  final gatewaydata =
                                                      await getDeviceID(gatway);
                                                  if (gatewaydata.length > 0) {
                                                    for (int g = 0;
                                                        g < gatewaydata.length;
                                                        g++) {
                                                      var databody = {
                                                        "DeviceEUIID":
                                                            gatewaydata[g][
                                                                    'DeviceEUIID']
                                                                .toLowerCase(),
                                                        "HardwareSerialNumber":
                                                            gatewaydata[g][
                                                                'HardwareSerialNumber'],
                                                        "Latitude":
                                                            gatewaylat.latitude,
                                                        "Longitude": gatewaylat
                                                            .longitude,
                                                        "FarmerSectionDetailsID":
                                                            widget
                                                                .farmer!
                                                                .farmlands[0]
                                                                .id,
                                                        "UserName":
                                                            '${widget.farmid}',
                                                        "IMEINumber":
                                                            '${widget.imeinumber}',
                                                        "IMEIPhoneNumber":
                                                            '${widget.simnumber}',
                                                      };

                                                      var gatewaydatarespomce =
                                                          await GatewayIncert(
                                                              databody);
                                                      if (gatewaydatarespomce) {
                                                        if (deviceids.length >
                                                            0) {
                                                          checkDuplicateDeviceIDs(
                                                              context: context,
                                                              deviceids:
                                                                  deviceids,
                                                              devices:
                                                                  alldevicedata,
                                                              funckingdevices:
                                                                  funckingdevices);
                                                          // var duplicates = findDuplicates(alldevicedata);

                                                          // if (duplicates.length >0) {
                                                          //   showDialog(
                                                          //       context: context,
                                                          //       builder: (
                                                          //           BuildContext context) {
                                                          //         return
                                                          //           AlertDialog(
                                                          //             content:Text("DeviceID Duplicate Found\n$duplicates \nCannot continue."),
                                                          //             actions: [
                                                          //               Row(
                                                          //
                                                          //                 children: [
                                                          //                   TextButton(
                                                          //                     onPressed: () {
                                                          //                       // Action to perform when OK button is pressed
                                                          //                       Navigator
                                                          //                           .pop(
                                                          //                           context);
                                                          //                     },
                                                          //                     style: TextButton
                                                          //                         .styleFrom(
                                                          //                       backgroundColor: Colors
                                                          //                           .green, // Set the background color
                                                          //                     ),
                                                          //                     child: Text(
                                                          //                       'Yes',
                                                          //                       style: TextStyle(
                                                          //                         color: Colors
                                                          //                             .white, // Set the text color
                                                          //                       ),),
                                                          //                   ),
                                                          //                   // Spacer(),
                                                          //                   TextButton(
                                                          //                     onPressed: () {
                                                          //                       // Action to perform when OK button is pressed
                                                          //                       Navigator
                                                          //                           .pop(
                                                          //                           context);
                                                          //                     },
                                                          //                     style: TextButton
                                                          //                         .styleFrom(
                                                          //                       backgroundColor: Colors
                                                          //                           .red, // Set the background color
                                                          //                     ),
                                                          //                     child: Text(
                                                          //                       'No',
                                                          //                       style: TextStyle(
                                                          //                         color: Colors
                                                          //                             .white, // Set the text color
                                                          //                       ),),
                                                          //                     // child: Text('No'),
                                                          //                   ),
                                                          //                 ],
                                                          //                 mainAxisAlignment: MainAxisAlignment
                                                          //                     .spaceAround,
                                                          //               )
                                                          //             ],
                                                          //           );
                                                          //       }
                                                          //   );
                                                          // }
                                                          // else {
                                                          //   final data = await getDeviceID(
                                                          //       deviceids);
                                                          //   if (data.length >0) {
                                                          //     for (int i = 0; i <data.length; i++) {
                                                          //       for (int j = 0; j <alldevicedata.length; j++) {
                                                          //         if (data[i]['DeviceEUIID'] == alldevicedata[j].DeviceEuID||data[i]['HardwareSerialNumber'] == alldevicedata[j].DeviceEuID) {
                                                          //           // setState(() {
                                                          //           alldevicedata[j]
                                                          //               .DeviceEuID ==
                                                          //               data[i]['DeviceEUIID'];
                                                          //           alldevicedata[j]
                                                          //               .HardWareSerialNumber =
                                                          //           data[i]['HardwareSerialNumber'];
                                                          //           alldevicedata[j]
                                                          //               .TTIApplicatonID =
                                                          //           data[i]['TTIApplicatonID'];
                                                          //           alldevicedata[j]
                                                          //               .TTIDeviceID =
                                                          //           data[i]['TTIDeviceID'];
                                                          //
                                                          //           // });
                                                          //         }
                                                          //       }
                                                          //     }
                                                          //
                                                          //     alldevicedata.forEach((alldata) async {
                                                          //       var data = {
                                                          //         "DeviceEUIID": alldata
                                                          //             .DeviceEuID,
                                                          //         "TTIApplicatonID": alldata
                                                          //             .TTIApplicatonID,
                                                          //         "HardwareSerialNumber": alldata
                                                          //             .HardWareSerialNumber,
                                                          //         "TTIDeviceID": alldata
                                                          //             .TTIDeviceID,
                                                          //         "ID": alldata
                                                          //             .DeviceID,
                                                          //         "Latitude": alldata
                                                          //             .DeviceLatlang!
                                                          //             .latitude,
                                                          //         "Longitude": alldata
                                                          //             .DeviceLatlang!
                                                          //             .longitude,
                                                          //         "UserName":'${widget.farmid}',
                                                          //         "IMEINumber":'${widget.imeinumber}',
                                                          //         "IMEIPhoneNumber":'${widget.simnumber}',
                                                          //       };
                                                          //       var responce = await UpdateData(data);
                                                          //
                                                          //       print("incert responce${responce}");
                                                          //       if (responce) {
                                                          //         setState(() {
                                                          //           alldata.status==true;
                                                          //         });
                                                          //
                                                          //       }
                                                          //     });
                                                          //     if (alldevicedata.length == 0) {
                                                          //       var data={
                                                          //         "ProcessName":"Process end ",
                                                          //         "UserName":'${widget.farmid}',
                                                          //         "IMEINumber":'${widget.imeinumber}',
                                                          //         "IMEIPhoneNumber":'${widget.simnumber}',
                                                          //         "fLog":"Process completed",
                                                          //
                                                          //       };
                                                          //       bool responce= await FarmerDeviceDetailsLog(data,"No",context);
                                                          //       showDialog(
                                                          //           context: context,
                                                          //           builder: (
                                                          //               BuildContext context) {
                                                          //             return
                                                          //               AlertDialog(
                                                          //                 content: Text(
                                                          //                     'Data saved successfully'),
                                                          //                 actions: [
                                                          //                   Row(
                                                          //
                                                          //                     children: [
                                                          //                       TextButton(
                                                          //                         onPressed: () {
                                                          //                           // Action to perform when OK button is pressed
                                                          //                           Navigator
                                                          //                               .pop(
                                                          //                               context);
                                                          //                           Navigator
                                                          //                               .pop(
                                                          //                               context);
                                                          //                         },
                                                          //                         style: TextButton
                                                          //                             .styleFrom(
                                                          //                           backgroundColor: Colors
                                                          //                               .green, // Set the background color
                                                          //                         ),
                                                          //                         child: Text(
                                                          //                           'Ok',
                                                          //                           style: TextStyle(
                                                          //                             color: Colors
                                                          //                                 .white, // Set the text color
                                                          //                           ),),
                                                          //                       ),
                                                          //                       // Spacer(),
                                                          //                     ],
                                                          //                     mainAxisAlignment: MainAxisAlignment
                                                          //                         .spaceAround,
                                                          //                   )
                                                          //                 ],
                                                          //               );
                                                          //           });
                                                          //     }
                                                          //     else{
                                                          //
                                                          //       List<String> DeviceDetails=[];
                                                          //       alldevicedata.forEach((element) {
                                                          //         if(element.status==false) {
                                                          //           DeviceDetails
                                                          //               .add(
                                                          //               element
                                                          //                   .DeviceEuID
                                                          //                   .toString());
                                                          //         }
                                                          //       });
                                                          //       print("length ${DeviceDetails.length}");
                                                          //       if(DeviceDetails.length>0) {
                                                          //         showDialog(
                                                          //             context: context,
                                                          //             builder: (
                                                          //                 BuildContext context) {
                                                          //               return
                                                          //                 AlertDialog(
                                                          //                   content: Text(
                                                          //                       'DeviceID:${DeviceDetails}\n Not found is Master Database\nCorrect the DeviceID and try again or contact cultivate'),
                                                          //                   actions: [
                                                          //                     Row(
                                                          //
                                                          //                       children: [
                                                          //                         TextButton(
                                                          //                           onPressed: () {
                                                          //                             // Action to perform when OK button is pressed
                                                          //                             Navigator
                                                          //                                 .pop(
                                                          //                                 context);
                                                          //                             Navigator
                                                          //                                 .pop(
                                                          //                                 context);
                                                          //                           },
                                                          //                           style: TextButton
                                                          //                               .styleFrom(
                                                          //                             backgroundColor: Colors
                                                          //                                 .green, // Set the background color
                                                          //                           ),
                                                          //                           child: Text(
                                                          //                             'Ok',
                                                          //                             style: TextStyle(
                                                          //                               color: Colors
                                                          //                                   .white, // Set the text color
                                                          //                             ),),
                                                          //                         ),
                                                          //                         // Spacer(),
                                                          //                       ],
                                                          //                       mainAxisAlignment: MainAxisAlignment
                                                          //                           .spaceAround,
                                                          //                     )
                                                          //                   ],
                                                          //                 );
                                                          //             });
                                                          //       }
                                                          //       else{
                                                          //         var data={
                                                          //           "ProcessName":"Process end ",
                                                          //           "UserName":'${widget.farmid}',
                                                          //           "IMEINumber":'${widget.imeinumber}',
                                                          //           "IMEIPhoneNumber":'${widget.simnumber}',
                                                          //           "fLog":"Process completed",
                                                          //
                                                          //         };
                                                          //         bool responce= await FarmerDeviceDetailsLog(data,"No",context);
                                                          //         showDialog(
                                                          //             context: context,
                                                          //             builder: (
                                                          //                 BuildContext context) {
                                                          //               return
                                                          //                 AlertDialog(
                                                          //                   content: Text(
                                                          //                       'Data saved successfully'),
                                                          //                   actions: [
                                                          //                     Row(
                                                          //
                                                          //                       children: [
                                                          //                         TextButton(
                                                          //                           onPressed: () {
                                                          //                             // Action to perform when OK button is pressed
                                                          //                             Navigator
                                                          //                                 .pop(
                                                          //                                 context);
                                                          //                             Navigator
                                                          //                                 .pop(
                                                          //                                 context);
                                                          //                           },
                                                          //                           style: TextButton
                                                          //                               .styleFrom(
                                                          //                             backgroundColor: Colors
                                                          //                                 .green, // Set the background color
                                                          //                           ),
                                                          //                           child: Text(
                                                          //                             'Ok',
                                                          //                             style: TextStyle(
                                                          //                               color: Colors
                                                          //                                   .white, // Set the text color
                                                          //                             ),),
                                                          //                         ),
                                                          //                         // Spacer(),
                                                          //                       ],
                                                          //                       mainAxisAlignment: MainAxisAlignment
                                                          //                           .spaceAround,
                                                          //                     )
                                                          //                   ],
                                                          //                 );
                                                          //             });
                                                          //       }
                                                          //     }
                                                          //   }
                                                          //
                                                          //   if (data.isEmpty) {
                                                          //     showDialog(
                                                          //         context: context,
                                                          //         builder: (
                                                          //             BuildContext context) {
                                                          //           return
                                                          //             AlertDialog(
                                                          //               content: Text(
                                                          //                   '${deviceids} This device not found in Master \n Please contact cultYvate to finish installation'),
                                                          //               actions: [
                                                          //                 TextButton(
                                                          //                   onPressed: () {
                                                          //                     // Action to perform when OK button is pressed
                                                          //                     Navigator
                                                          //                         .pop(
                                                          //                         context);
                                                          //                   },
                                                          //                   child: Text(
                                                          //                       'OK'),
                                                          //                 ),
                                                          //               ],
                                                          //             );
                                                          //         }
                                                          //     );
                                                          //   }
                                                          // }
                                                        }
                                                      }
                                                    }
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            content: Text(
                                                                '${gatewaytext.text} This Gateway device not found in Master \n Please contact cultYvate to finish installation',
                                                                style: iostextstyle(
                                                                    fontsize)),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  // Action to perform when OK button is pressed
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'OK',
                                                                    style: iostextstyle(
                                                                        fontsize)),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  }
                                                } else {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        MyAlertDialogNamed(
                                                            parametter: 'add'),
                                                  );
                                                }
                                              }
                                            } else {
                                              if (gatewaytext.text.isEmpty) {
                                                checkDuplicateDeviceIDs(
                                                    context: context,
                                                    deviceids: deviceids,
                                                    devices: alldevicedata,
                                                    funckingdevices:
                                                        funckingdevices);
                                                print(
                                                    "all devices ${alldevicedata.length == deviceids.length}");
                                                // if (deviceids.length>0) {
                                                //   var duplicates = findDuplicates(alldevicedata);
                                                //
                                                //   if (duplicates.length >0) {
                                                //     showDialog(
                                                //         context: context,
                                                //         builder: (
                                                //             BuildContext context) {
                                                //           return
                                                //             AlertDialog(
                                                //               content:Text("DeviceID Duplicate Found\n$duplicates \nCannot continue."),
                                                //               actions: [
                                                //                 Row(
                                                //
                                                //                   children: [
                                                //                     TextButton(
                                                //                       onPressed: () {
                                                //                         // Action to perform when OK button is pressed
                                                //                         Navigator
                                                //                             .pop(
                                                //                             context);
                                                //                       },
                                                //                       style: TextButton
                                                //                           .styleFrom(
                                                //                         backgroundColor: Colors
                                                //                             .green, // Set the background color
                                                //                       ),
                                                //                       child: Text(
                                                //                         'Yes',
                                                //                         style: TextStyle(
                                                //                           color: Colors
                                                //                               .white, // Set the text color
                                                //                         ),),
                                                //                     ),
                                                //                     // Spacer(),
                                                //                     TextButton(
                                                //                       onPressed: () {
                                                //                         // Action to perform when OK button is pressed
                                                //                         Navigator
                                                //                             .pop(
                                                //                             context);
                                                //                       },
                                                //                       style: TextButton
                                                //                           .styleFrom(
                                                //                         backgroundColor: Colors
                                                //                             .red, // Set the background color
                                                //                       ),
                                                //                       child: Text(
                                                //                         'No',
                                                //                         style: TextStyle(
                                                //                           color: Colors
                                                //                               .white, // Set the text color
                                                //                         ),),
                                                //                       // child: Text('No'),
                                                //                     ),
                                                //                   ],
                                                //                   mainAxisAlignment: MainAxisAlignment
                                                //                       .spaceAround,
                                                //                 )
                                                //               ],
                                                //             );
                                                //         }
                                                //     );
                                                //   }
                                                //   else {
                                                //     final data = await getDeviceID(deviceids);
                                                //  print(data);
                                                //     if (data.length >
                                                //         0) {
                                                //       for (int i = 0; i <
                                                //           data
                                                //               .length; i++) {
                                                //         for (int j = 0; j <
                                                //             alldevicedata
                                                //                 .length; j++) {
                                                //           if (data[i]['DeviceEUIID'] == alldevicedata[j].DeviceEuID||data[i]['HardwareSerialNumber'] == alldevicedata[j].DeviceEuID) {
                                                //             // setState(() {
                                                //             alldevicedata[j]
                                                //                 .DeviceEuID ==
                                                //                 data[i]['DeviceEUIID'];
                                                //             alldevicedata[j]
                                                //                 .HardWareSerialNumber =
                                                //             data[i]['HardwareSerialNumber'];
                                                //             alldevicedata[j]
                                                //                 .TTIApplicatonID =
                                                //             data[i]['TTIApplicatonID'];
                                                //             alldevicedata[j]
                                                //                 .TTIDeviceID =
                                                //             data[i]['TTIDeviceID'];
                                                //
                                                //             // });
                                                //           }
                                                //         }
                                                //       }
                                                //
                                                //       alldevicedata.forEach((alldata) async {
                                                //         var data = {
                                                //           "DeviceEUIID": alldata
                                                //               .DeviceEuID,
                                                //           "TTIApplicatonID": alldata
                                                //               .TTIApplicatonID,
                                                //           "HardwareSerialNumber": alldata
                                                //               .HardWareSerialNumber,
                                                //           "TTIDeviceID": alldata
                                                //               .TTIDeviceID,
                                                //           "ID": alldata
                                                //               .DeviceID,
                                                //           "Latitude": alldata
                                                //               .DeviceLatlang!
                                                //               .latitude,
                                                //           "Longitude": alldata
                                                //               .DeviceLatlang!
                                                //               .longitude,
                                                //           "UserName":'${widget.farmid}',
                                                //           "IMEINumber":'${widget.imeinumber}',
                                                //           "IMEIPhoneNumber":'${widget.simnumber}',
                                                //         };
                                                //         var responce = await UpdateData(data);
                                                //
                                                //         print("incert responce${responce}");
                                                //         if (responce) {
                                                //           setState(() {
                                                //             alldata.status==true;
                                                //           });
                                                //
                                                //         }
                                                //       });
                                                //       if (alldevicedata.length == 0) {
                                                //         var data={
                                                //           "ProcessName":"Process end ",
                                                //           "UserName":'${widget.farmid}',
                                                //           "IMEINumber":'${widget.imeinumber}',
                                                //           "IMEIPhoneNumber":'${widget.simnumber}',
                                                //           "fLog":"Process completed",
                                                //
                                                //         };
                                                //         bool responce= await FarmerDeviceDetailsLog(data,"No",context);
                                                //         showDialog(
                                                //             context: context,
                                                //             builder: (
                                                //                 BuildContext context) {
                                                //               return
                                                //                 AlertDialog(
                                                //                   content: Text(
                                                //                       'Data saved successfully'),
                                                //                   actions: [
                                                //                     Row(
                                                //
                                                //                       children: [
                                                //                         TextButton(
                                                //                           onPressed: () {
                                                //                             // Action to perform when OK button is pressed
                                                //                             Navigator
                                                //                                 .pop(
                                                //                                 context);
                                                //                             Navigator
                                                //                                 .pop(
                                                //                                 context);
                                                //                           },
                                                //                           style: TextButton
                                                //                               .styleFrom(
                                                //                             backgroundColor: Colors
                                                //                                 .green, // Set the background color
                                                //                           ),
                                                //                           child: Text(
                                                //                             'Ok',
                                                //                             style: TextStyle(
                                                //                               color: Colors
                                                //                                   .white, // Set the text color
                                                //                             ),),
                                                //                         ),
                                                //                         // Spacer(),
                                                //                       ],
                                                //                       mainAxisAlignment: MainAxisAlignment
                                                //                           .spaceAround,
                                                //                     )
                                                //                   ],
                                                //                 );
                                                //             });
                                                //       }
                                                //       else{
                                                //
                                                //         List<String> DeviceDetails=[];
                                                //         alldevicedata.forEach((element) {
                                                //           if(element.status==false) {
                                                //             DeviceDetails
                                                //                 .add(
                                                //                 element
                                                //                     .DeviceEuID
                                                //                     .toString());
                                                //           }
                                                //         });
                                                //         print("length ${DeviceDetails.length}");
                                                //         if(DeviceDetails.length>0) {
                                                //           showDialog(
                                                //               context: context,
                                                //               builder: (
                                                //                   BuildContext context) {
                                                //                 return
                                                //                   AlertDialog(
                                                //                     content: Text(
                                                //                         'DeviceID:${DeviceDetails}\n Not found is Master Database\nCorrect the DeviceID and try again or contact cultivate'),
                                                //                     actions: [
                                                //                       Row(
                                                //
                                                //                         children: [
                                                //                           TextButton(
                                                //                             onPressed: () {
                                                //                               // Action to perform when OK button is pressed
                                                //                               Navigator
                                                //                                   .pop(
                                                //                                   context);
                                                //                               Navigator
                                                //                                   .pop(
                                                //                                   context);
                                                //                             },
                                                //                             style: TextButton
                                                //                                 .styleFrom(
                                                //                               backgroundColor: Colors
                                                //                                   .green, // Set the background color
                                                //                             ),
                                                //                             child: Text(
                                                //                               'Ok',
                                                //                               style: TextStyle(
                                                //                                 color: Colors
                                                //                                     .white, // Set the text color
                                                //                               ),),
                                                //                           ),
                                                //                           // Spacer(),
                                                //                         ],
                                                //                         mainAxisAlignment: MainAxisAlignment
                                                //                             .spaceAround,
                                                //                       )
                                                //                     ],
                                                //                   );
                                                //               });
                                                //         }
                                                //         else{
                                                //           var data={
                                                //             "ProcessName":"Process end ",
                                                //             "UserName":'${widget.farmid}',
                                                //             "IMEINumber":'${widget.imeinumber}',
                                                //             "IMEIPhoneNumber":'${widget.simnumber}',
                                                //             "fLog":"Process completed",
                                                //
                                                //           };
                                                //           bool responce= await FarmerDeviceDetailsLog(data,"No",context);
                                                //           showDialog(
                                                //               context: context,
                                                //               builder: (
                                                //                   BuildContext context) {
                                                //                 return
                                                //                   AlertDialog(
                                                //                     content: Text(
                                                //                         'Data saved successfully'),
                                                //                     actions: [
                                                //                       Row(
                                                //
                                                //                         children: [
                                                //                           TextButton(
                                                //                             onPressed: () {
                                                //                               // Action to perform when OK button is pressed
                                                //                               Navigator
                                                //                                   .pop(
                                                //                                   context);
                                                //                               Navigator
                                                //                                   .pop(
                                                //                                   context);
                                                //                             },
                                                //                             style: TextButton
                                                //                                 .styleFrom(
                                                //                               backgroundColor: Colors
                                                //                                   .green, // Set the background color
                                                //                             ),
                                                //                             child: Text(
                                                //                               'Ok',
                                                //                               style: TextStyle(
                                                //                                 color: Colors
                                                //                                     .white, // Set the text color
                                                //                               ),),
                                                //                           ),
                                                //                           // Spacer(),
                                                //                         ],
                                                //                         mainAxisAlignment: MainAxisAlignment
                                                //                             .spaceAround,
                                                //                       )
                                                //                     ],
                                                //                   );
                                                //               });
                                                //         }
                                                //       }
                                                //     }
                                                //
                                                //     if (data.isEmpty) {
                                                //       showDialog(
                                                //           context: context,
                                                //           builder: (
                                                //               BuildContext context) {
                                                //             return
                                                //               AlertDialog(
                                                //                 content: Text(
                                                //                     '${deviceids} This device not found in Master \n Please contact cultYvate to finish installation'),
                                                //                 actions: [
                                                //                   TextButton(
                                                //                     onPressed: () {
                                                //                       // Action to perform when OK button is pressed
                                                //                       Navigator
                                                //                           .pop(
                                                //                           context);
                                                //                     },
                                                //                     child: Text(
                                                //                         'OK'),
                                                //                   ),
                                                //                 ],
                                                //               );
                                                //           }
                                                //       );
                                                //     }
                                                //   }
                                                // }
                                              } else {
                                                List<String> gatway = [
                                                  '${gatewaytext.text}'
                                                ];
                                                final gatewaydata =
                                                    await getDeviceID(gatway);
                                                if (gatewaydata.length > 0) {
                                                  for (int g = 0;
                                                      g < gatewaydata.length;
                                                      g++) {
                                                    var databody = {
                                                      "DeviceEUIID":
                                                          gatewaydata[g]
                                                              ['DeviceEUIID'],
                                                      "HardwareSerialNumber":
                                                          gatewaydata[g][
                                                              'HardwareSerialNumber'],
                                                      "Latitude":
                                                          gatewaylat.latitude,
                                                      "Longitude":
                                                          gatewaylat.longitude,
                                                      "FarmerSectionDetailsID":
                                                          widget.farmer!
                                                              .farmlands[0].id,
                                                      "UserName":
                                                          '${widget.farmid}',
                                                      "IMEINumber":
                                                          '${widget.imeinumber}',
                                                      "IMEIPhoneNumber":
                                                          '${widget.simnumber}',
                                                    };

                                                    var gatewaydatarespomce =
                                                        await GatewayIncert(
                                                            databody);
                                                    if (gatewaydatarespomce) {
                                                      if (alldevicedata
                                                              .length ==
                                                          deviceids.length) {
                                                        var duplicates =
                                                            findDuplicates(
                                                                alldevicedata);

                                                        if (duplicates.length >
                                                            0) {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  content: Text(
                                                                      "DeviceID Duplicate Found\n$duplicates \nCannot continue.",
                                                                      style: iostextstyle(
                                                                          fontsize)),
                                                                  actions: [
                                                                    Row(
                                                                      children: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            // Action to perform when OK button is pressed
                                                                            Navigator.pop(context);
                                                                          },
                                                                          style:
                                                                              TextButton.styleFrom(
                                                                            backgroundColor:
                                                                                Colors.green, // Set the background color
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            'Yes',
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: fontsize
                                                                                // Set the text color
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        // Spacer(),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            // Action to perform when OK button is pressed
                                                                            Navigator.pop(context);
                                                                          },
                                                                          style:
                                                                              TextButton.styleFrom(
                                                                            backgroundColor:
                                                                                Colors.red, // Set the background color
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            'No',
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: fontsize
                                                                                // Set the text color
                                                                                ),
                                                                          ),
                                                                          // child: Text('No'),
                                                                        ),
                                                                      ],
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                    )
                                                                  ],
                                                                );
                                                              });
                                                        } else {
                                                          final data =
                                                              await getDeviceID(
                                                                  deviceids);
                                                          if (data.length > 0) {
                                                            for (int i = 0;
                                                                i < data.length;
                                                                i++) {
                                                              for (int j = 0;
                                                                  j <
                                                                      alldevicedata
                                                                          .length;
                                                                  j++) {
                                                                if (data[i]['DeviceEUIID'] ==
                                                                        alldevicedata[j]
                                                                            .DeviceEuID ||
                                                                    data[i]['HardwareSerialNumber'] ==
                                                                        alldevicedata[j]
                                                                            .DeviceEuID) {
                                                                  // setState(() {
                                                                  alldevicedata[
                                                                              j]
                                                                          .DeviceEuID ==
                                                                      data[i][
                                                                          'DeviceEUIID'];
                                                                  alldevicedata[
                                                                          j]
                                                                      .HardWareSerialNumber = data[
                                                                          i][
                                                                      'HardwareSerialNumber'];
                                                                  alldevicedata[
                                                                          j]
                                                                      .TTIApplicatonID = data[
                                                                          i][
                                                                      'TTIApplicatonID'];
                                                                  alldevicedata[
                                                                          j]
                                                                      .TTIDeviceID = data[
                                                                          i][
                                                                      'TTIDeviceID'];

                                                                  // });
                                                                }
                                                              }
                                                            }

                                                            alldevicedata.forEach(
                                                                (alldata) async {
                                                              var data = {
                                                                "DeviceEUIID":
                                                                    alldata
                                                                        .DeviceEuID,
                                                                "TTIApplicatonID":
                                                                    alldata
                                                                        .TTIApplicatonID,
                                                                "HardwareSerialNumber":
                                                                    alldata
                                                                        .HardWareSerialNumber,
                                                                "TTIDeviceID":
                                                                    alldata
                                                                        .TTIDeviceID,
                                                                "ID": alldata
                                                                    .DeviceID,
                                                                "Latitude": alldata
                                                                    .DeviceLatlang!
                                                                    .latitude,
                                                                "Longitude": alldata
                                                                    .DeviceLatlang!
                                                                    .longitude,
                                                                "UserName":
                                                                    '${widget.farmid}',
                                                                "IMEINumber":
                                                                    '${widget.imeinumber}',
                                                                "IMEIPhoneNumber":
                                                                    '${widget.simnumber}',
                                                              };
                                                              var responce =
                                                                  await UpdateData(
                                                                      data);

                                                              print(
                                                                  "incert responce${responce}");
                                                              if (responce) {
                                                                setState(() {
                                                                  alldata.status ==
                                                                      true;
                                                                });
                                                              }
                                                            });
                                                            if (alldevicedata
                                                                    .length ==
                                                                0) {
                                                              var data = {
                                                                "ProcessName":
                                                                    "Process end ",
                                                                "UserName":
                                                                    '${widget.farmid}',
                                                                "IMEINumber":
                                                                    '${widget.imeinumber}',
                                                                "IMEIPhoneNumber":
                                                                    '${widget.simnumber}',
                                                                "fLog":
                                                                    "Process completed",
                                                              };
                                                              bool responce =
                                                                  await FarmerDeviceDetailsLog(
                                                                      data,
                                                                      "No",
                                                                      context);
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      content: Text(
                                                                          'Data saved successfully',
                                                                          style:
                                                                              iostextstyle(fontsize)),
                                                                      actions: [
                                                                        Row(
                                                                          children: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                // Action to perform when OK button is pressed
                                                                                Navigator.pop(context);
                                                                                Navigator.pop(context);
                                                                              },
                                                                              style: TextButton.styleFrom(
                                                                                backgroundColor: Colors.green, // Set the background color
                                                                              ),
                                                                              child: Text(
                                                                                'Ok',
                                                                                style: TextStyle(color: Colors.white, fontSize: fontsize
                                                                                    // Set the text color
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            // Spacer(),
                                                                          ],
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                        )
                                                                      ],
                                                                    );
                                                                  });
                                                            } else {
                                                              List<String>
                                                                  DeviceDetails =
                                                                  [];
                                                              alldevicedata
                                                                  .forEach(
                                                                      (element) {
                                                                if (element
                                                                        .status ==
                                                                    false) {
                                                                  DeviceDetails
                                                                      .add(element
                                                                              .DeviceEuID
                                                                          .toString());
                                                                }
                                                              });
                                                              print(
                                                                  "length ${DeviceDetails.length}");
                                                              if (DeviceDetails
                                                                      .length >
                                                                  0) {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        content: Text(
                                                                            'DeviceID:${DeviceDetails}\n Not found is Master Database\nCorrect the DeviceID and try again or contact cultivate',
                                                                            style:
                                                                                iostextstyle(fontsize)),
                                                                        actions: [
                                                                          Row(
                                                                            children: [
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  // Action to perform when OK button is pressed
                                                                                  Navigator.pop(context);
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                style: TextButton.styleFrom(
                                                                                  backgroundColor: Colors.green, // Set the background color
                                                                                ),
                                                                                child: Text(
                                                                                  'Ok',
                                                                                  style: TextStyle(color: Colors.white, fontSize: fontsize
                                                                                      // Set the text color
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              // Spacer(),
                                                                            ],
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                          )
                                                                        ],
                                                                      );
                                                                    });
                                                              } else {
                                                                var data = {
                                                                  "ProcessName":
                                                                      "Process end ",
                                                                  "UserName":
                                                                      '${widget.farmid}',
                                                                  "IMEINumber":
                                                                      '${widget.imeinumber}',
                                                                  "IMEIPhoneNumber":
                                                                      '${widget.simnumber}',
                                                                  "fLog":
                                                                      "Process completed",
                                                                };
                                                                bool responce =
                                                                    await FarmerDeviceDetailsLog(
                                                                        data,
                                                                        "No",
                                                                        context);
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        content: Text(
                                                                            'Data saved successfully',
                                                                            style:
                                                                                iostextstyle(fontsize)),
                                                                        actions: [
                                                                          Row(
                                                                            children: [
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  // Action to perform when OK button is pressed
                                                                                  Navigator.pop(context);
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                style: TextButton.styleFrom(
                                                                                  backgroundColor: Colors.green, // Set the background color
                                                                                ),
                                                                                child: Text(
                                                                                  'Ok',
                                                                                  style: TextStyle(
                                                                                    color: Colors.white, // Set the text color
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              // Spacer(),
                                                                            ],
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                          )
                                                                        ],
                                                                      );
                                                                    });
                                                              }
                                                            }
                                                          }

                                                          if (data.isEmpty) {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    content: Text(
                                                                        '${deviceids} This device not found in Master \n Please contact cultYvate to finish installation',
                                                                        style: iostextstyle(
                                                                            fontsize)),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          // Action to perform when OK button is pressed
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            'OK',
                                                                            style:
                                                                                iostextstyle(fontsize)),
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          content: Text(
                                                              '${gatewaytext.text} This Gateway device not found in Master \n Please contact cultYvate to finish installation',
                                                              style:
                                                                  iostextstyle(
                                                                      fontsize)),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                // Action to perform when OK button is pressed
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text('OK',
                                                                  style: iostextstyle(
                                                                      fontsize)),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                }
                                              }
                                            }
                                          }

                                          // if (_key.currentState!.validate()) {
                                          // if (fnumber.text.length >= 10)
                                          //   // datasave();
                                          // else {
                                          //   Fluttertoast.showToast(
                                          //       msg: "Enter 10 digits valid phone number",
                                          //       backgroundColor: Colors.red
                                          //   );
                                          // }

                                          // }
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                MyAlertDialogNamed(
                                                    parametter: 'update'),
                                          );
                                        }
                                      },
                                    ),
                                  ])
                            ],
                          ),
                  ],
                ))),
      ),
    );
  }

  void checkDuplicateDeviceIDs(
      {required List<Alllist> devices,
      required BuildContext context,
      required List<Alllist> funckingdevices,
      required List<String> deviceids}) {
    List<dynamic> duplicates = findDuplicates(devices);

    if (duplicates.length > 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "DeviceID Duplicate Found\n$duplicates \nCannot continue.",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              )
            ],
          );
        },
      );
    } else {
      updateDeviceData(
          alldevicedata,
          funckingdevices,
          deviceids,
          widget.farmid.toString(),
          widget.imeinumber.toString(),
          widget.simnumber.toString(),
          context);
    }
  }
//   Future<void> updateDeviceData(List<Alllist> alldevicedata, List<Alllist> funckingdevices, List<dynamic> deviceids, String farmid, String imeinumber, String simnumber, BuildContext context) async {
// List<bool> successtest=[];
//     final data = await getDeviceID(deviceids);
//     if (data.length == deviceids.length) {
//       if (data.length > 0) {
//         for (int i = 0; i < data.length; i++) {
//           for (int j = 0; j < alldevicedata.length; j++) {
//             if (data[i]['DeviceEUIID'] == alldevicedata[j].DeviceEuID ||
//                 data[i]['HardwareSerialNumber'] ==
//                     alldevicedata[j].DeviceEuID) {
//               alldevicedata[j].DeviceEuID = data[i]['DeviceEUIID'];
//               alldevicedata[j].HardWareSerialNumber =
//               data[i]['HardwareSerialNumber'];
//               alldevicedata[j].TTIApplicatonID = data[i]['TTIApplicatonID'];
//               alldevicedata[j].TTIDeviceID = data[i]['TTIDeviceID'];
//             }
//           }
//         }
//
//         alldevicedata.forEach((alldata) async {
//           var data = {
//             "DeviceEUIID": alldata.DeviceEuID,
//             "TTIApplicatonID": alldata.TTIApplicatonID,
//             "HardwareSerialNumber": alldata.HardWareSerialNumber,
//             "TTIDeviceID": alldata.TTIDeviceID,
//             "ID": alldata.DeviceID,
//             "Latitude": alldata.DeviceLatlang!.latitude,
//             "Longitude": alldata.DeviceLatlang!.longitude,
//             "UserName": farmid,
//             "IMEINumber": imeinumber,
//             "IMEIPhoneNumber": simnumber,
//           };
//           var responce = await UpdateData(data);
//          print("responce update  is ${responce}");
//           if (responce) {
//             successtest.add(true);
//             // alldevicedata.remove(alldata);
//           }
//         });
//       }
//     }
//     else {
//       List<
//           Alllist> missingValues = funckingdevices.where((modelValue) =>!data.any((jsonValue) =>modelValue.DeviceEuID == jsonValue['DeviceEUIID'])).toList();
//       var alldata = missingValues.map((item) => item.DeviceEuID).join(", ");
//
//       if (missingValues.length > 0) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               content: Text(
//                 '$alldata \nThis device is not found in Master. \nPlease contact cultYvate to finish installation.',
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.green,
//                   ),
//                   child: Text(
//                     'Ok',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//           useRootNavigator: true,
//         );
//       }
//
//     }
//     print("all length is${successtest.length } ${alldevicedata.length}");
//     if(successtest.length==funckingdevices.length){
//       var datagaga = {
//         "ProcessName": "Process end ",
//         "UserName": farmid,
//         "IMEINumber": imeinumber,
//         "IMEIPhoneNumber": simnumber,
//         "fLog": "Process completed",
//       };
//       var log = await FarmerDeviceDetailsLog(datagaga, "Yes", context);
//
//       if (log) {
//         Get.defaultDialog(
//           title: "Data saved Successfully",
//           backgroundColor: Colors.white,
//           middleText: "                                                          ",
//           titleStyle: TextStyle(color: Colors.green),
//           radius: 30,
//           actions: [
//             Container(
//               color: Colors.green,
//               child: TextButton(
//                 onPressed: () {
//                   Get.back();
//                   Get.back();
//                 },
//                 child: Text(
//                   "Ok",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }
//     }
//
//   }

  Future<void> updateDeviceData(
      List<Alllist> alldevicedata,
      List<Alllist> funckingdevices,
      List<dynamic> deviceids,
      String farmid,
      String imeinumber,
      String simnumber,
      BuildContext context) async {
    List<bool> successtest = [];
    final data = await getDeviceID(deviceids);
    print("Ll devicces ${data}");
    print("funckig devices ${funckingdevices.length}");
    print("all device ${data.length}");
    List<Alllist> missingValues = funckingdevices
        .where((modelValue) => !data.any(
            (jsonValue) => modelValue.DeviceEuID == jsonValue['DeviceEUIID']))
        .toList();
    if (missingValues.length == 0) {
      if (data.length > 0) {
        for (int i = 0; i < data.length; i++) {
          for (int j = 0; j < funckingdevices.length; j++) {
            if (data[i]['DeviceEUIID'] == funckingdevices[j].DeviceEuID ||
                data[i]['HardwareSerialNumber'] ==
                    funckingdevices[j].DeviceEuID) {
              funckingdevices[j].DeviceEuID =
                  data[i]['DeviceEUIID'].toLowerCase();
              funckingdevices[j].HardWareSerialNumber =
                  data[i]['HardwareSerialNumber'];
              funckingdevices[j].TTIApplicatonID = data[i]['TTIApplicatonID'];
              funckingdevices[j].TTIDeviceID = data[i]['TTIDeviceID'];
            }
          }
        }

        for (int i = 0; i < funckingdevices.length; i++) {
          var data = {
            "DeviceEUIID": funckingdevices[i].DeviceEuID?.toLowerCase(),
            "TTIApplicatonID": funckingdevices[i].TTIApplicatonID,
            "HardwareSerialNumber": funckingdevices[i].HardWareSerialNumber,
            "TTIDeviceID": funckingdevices[i].TTIDeviceID,
            "ID": funckingdevices[i].DeviceID,
            "Latitude": funckingdevices[i].DeviceLatlang!.latitude,
            "Longitude": funckingdevices[i].DeviceLatlang!.longitude,
            "UserName": farmid,
            "IMEINumber": imeinumber,
            "IMEIPhoneNumber": simnumber,
          };
          var response = await UpdateData(data);
          print("response update is $response");
          if (response) {
            successtest.add(true);
          }
        }
      }
    } else {
      List<Alllist> missingValues = funckingdevices
          .where((modelValue) => !data.any(
              (jsonValue) => modelValue.DeviceEuID == jsonValue['DeviceEUIID']))
          .toList();
      print("missing values ${missingValues}");
      var alldata = missingValues.map((item) => item.DeviceEuID).join(", ");

      if (missingValues.length > 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                '$alldata \nThis device is not found in Master. \nPlease contact cultYvate to finish installation.',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
          useRootNavigator: true,
        );
      }
    }
    print(
        "all the responce is ${successtest.length} :${funckingdevices.length}");
    if (successtest.length >= funckingdevices.length) {
      var datagaga = {
        "ProcessName": "Process end ",
        "UserName": farmid,
        "IMEINumber": imeinumber,
        "IMEIPhoneNumber": simnumber,
        "fLog": "Process completed",
      };
      var log = FarmerDeviceDetailsLog(datagaga, "Yes", context);
      print("log is ${log}");
      // if (log) {
      Get.defaultDialog(
        title: "Data saved Successfully",
        backgroundColor: Colors.white,
        middleText:
            "                                                          ",
        titleStyle: TextStyle(color: Colors.green),
        radius: 30,
        actions: [
          Container(
            color: Colors.green,
            child: TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
      // }
    }
  }

  List findDuplicates(List<Alllist> array) {
    List<String> duplicates = [];
    Map<String, int> counter = {};
    Set<dynamic> uniqueItems = Set<dynamic>();

    for (var item in array) {
      if (item.Devicetype == "BR1" ||
          item.Devicetype == "BR2" ||
          item.Devicetype == 'FR1' ||
          item.Devicetype == 'FR2') {
        counter[item.DeviceEuID.toString()] =
            (counter[item.DeviceEuID] ?? 0) + 1;
        if (counter[item.DeviceEuID]! > 2 &&
            !uniqueItems.contains(item.DeviceEuID)) {
          uniqueItems.add(item.DeviceEuID);
          if (item.DeviceEuID != '-1') {
            duplicates.add(item.DeviceEuID.toString());
          }
        }
      } else {
        counter[item.DeviceEuID.toString()] =
            (counter[item.DeviceEuID] ?? 0) + 1;

        if (!uniqueItems.contains(item.DeviceEuID)) {
          if (item.DeviceEuID != '-1') {
            uniqueItems.add(item.DeviceEuID);
          }
        } else {
          duplicates.add(item.DeviceEuID.toString());
        }
      }
    }

    return duplicates;
  }

  Future UpdateData(body) async {
    print("update body${body}");
    // Map<String, dynamic> body = {'deviceList': DeviceID};
    setState(() {
      loading = true;
    });
    try {
      String path =
          'http://20.219.2.201/servicesF2Fapp/api/farm2fork/farmerdevicedata/farmerupdatedara';
      Map<String, dynamic> response =
          await ApiHelper().post(postData: body, path: path);
      if (response['success'] ?? false) {
        try {
          print("responce manoj ${response['data'].runtimeType}");
          return true;
        } catch (e) {
          print("error $e");
        }
      }
      return false;
    } catch (e) {
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future GatewayIncert(body) async {
    print(body);
    // Map<String, dynamic> body = {'deviceList': DeviceID};
    setState(() {
      loading = true;
    });
    try {
      String path =
          'http://20.219.2.201/servicesF2Fapp/api/farm2fork/farmerdevicedata/gatewaysave';
      // String path = 'http://192.168.199.1:8085/api/farm2fork/farmerdevicedata/gatewaysave';

      Map<String, dynamic> response =
          await ApiHelper().post(postData: body, path: path);
      if (response['success'] ?? false) {
        try {
          // print("responce manoj ${response['data'].runtimeType}");
          return true;
        } catch (e) {
          print("error $e");
        }
      }
      return false;
    } catch (e) {
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future getDeviceID(List DeviceID) async {
    setState(() {
      loading = true;
    });
    Map<String, dynamic> body = {'deviceList': DeviceID};

    try {
      // String path = 'http://192.168.199.1:8085/api/farm2fork/farmerdevicedata/farmerDeviceData';
      String path =
          'http://20.219.2.201/servicesF2Fapp/api/farm2fork/farmerdevicedata/farmerDeviceData';
      Map<String, dynamic> response =
          await ApiHelper().post(postData: body, path: path);
      if (response['success'] ?? false) {
        try {
          print("responce manoj ${response['data']}");
          return response['data'];
        } catch (e) {
          print("error $e");
        }
      }
      return null;
    } catch (e) {
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<PermissionStatus>(
        '_permissionGranted', _permissionGranted));
  }
}

Future FarmerDeviceDetailsLog(body, last, contex) async {
  print(body);
  // Map<String, dynamic> body = {'deviceList': DeviceID};

  try {
    String path =
        'http://20.219.2.201/servicesF2Fapp/api/farm2fork/farmerdevicedata/updatelog';
    Map<String, dynamic> response =
        await ApiHelper().post(postData: body, path: path);

    if (response['success'] ?? false) {
      try {
        if (last == 'Yes') {}
        // print("responce manoj ${response['data'].runtimeType}");
        return true;
      } catch (e) {
        print("error $e");
      }
    }
    return false;
  } catch (e) {
  } finally {}
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final double widthScaleFactor;
  final double heightScaleFactor;

  const ResponsiveText({
    required this.text,
    this.widthScaleFactor = 0.05,
    this.heightScaleFactor = 0.05,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize =
        (screenWidth * widthScaleFactor) + (screenHeight * heightScaleFactor);

    return Text(
      text,
      style: TextStyle(color: Colors.black, fontSize: fontSize),
    );
  }
}

class Alllist {
  Color? color;
  String? DeviceEuID;
  String? HardWareSerialNumber;
  LatLng? DeviceLatlang;
  int DeviceID;
  String? DeviceName;
  String? Devicetype;
  String? TTIApplicatonID;
  String? TTIDeviceID;
  bool? status;
  Alllist(
      {required this.DeviceID,
      this.DeviceEuID,
      this.DeviceLatlang,
      this.HardWareSerialNumber,
      this.DeviceName,
      this.Devicetype,
      this.color,
      this.TTIApplicatonID,
      this.TTIDeviceID,
      this.status});
}

class SecondDialog extends StatefulWidget {
  final content;
  SecondDialog({this.content});
  @override
  _SecondDialogState createState() => _SecondDialogState();
}

class _SecondDialogState extends State<SecondDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Show the second dialog when the widget has been fully built
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              widget.content,
              style: TextStyle(color: Colors.black),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder widget, not used for rendering
  }
}
