import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_phone_number/get_phone_number.dart';
import '/constants.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:phoneinformations/phoneinformations.dart';
import 'package:permission_handler/permission_handler.dart';
import '../apihelper/apihelper.dart';
import '../models/FarmerProfile.dart';
import '../scanpage.dart';

class ScanfarmerDetails extends StatefulWidget {
  final farmerID;
  final updateparmission;
  final incetpermission;
  const ScanfarmerDetails(
      {required this.incetpermission,
      required this.updateparmission,
      this.farmerID})
      : super();

  @override
  State<ScanfarmerDetails> createState() => _ScanfarmerDetailsDetailsState();
}

class _ScanfarmerDetailsDetailsState extends State<ScanfarmerDetails> {
  // List<Farmer> farmerprofile=[];
  String phonenumner = '';
  String imeinumner = '';

  Farmer? farmer;
  List<Device>? gatewayDevices;
  PhoneInfo? phoneInfos;
  bool loading = false;
  TextEditingController farmermobile = new TextEditingController();
  String _identifier = 'Unknown';
  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    setState(() {
      imeinumner = identifier;
    });
  }

  void getDeviceInformation() async {
    phonenumner = await GetPhoneNumber().get();

    // print('getPhoneNumber result: $phoneNumber');
    await initUniqueIdentifierState();
    // await FlutterDeviceIdentifier.requestPermission();
    // var _serialNumber = await FlutterDeviceIdentifier.serialCode;
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // print(androidInfo.serialNumber);
    // print(androidInfo.data);
    // phoneInfos = await Phoneinformations.getPhoneInformation();
    // phoneInfos = await Phoneinformations.getPhoneInformation();
//    String  platformVersion =
//         await FlutterDeviceIdentifier.imeiCode ?? 'Unknown platform version';
// print(platformVersion);
//     print(_serialNumber);

    var data = {
      "ProcessName": "Process started",
      "UserName": '${widget.farmerID}',
      "IMEINumber": '${imeinumner}',
      "IMEIPhoneNumber": '${phonenumner}',
      "fLog": "Process started",
    };
    bool responce = await FarmerDeviceDetailsLog(data, "NO", context);
    if (responce) {
      farmer = await getFarmer(farmermobile.text.trim());
      if (farmer != null) {
        setState(() {
          error = false;
          errormessage = '';
        });
        gatewayDevices = farmer!.farmlands
            .expand((element) => element.devices!)
            .where((device) => device.type == 'GWY')
            .toList();
      } else {
        setState(() {
          error = true;
          errormessage = 'Farmer Master Not found \nContact Cultyvate';
        });
      }
    }
    // String simCardNumber = androidInfo.data.; // SIM card number
    // print('IMEI: $imei');
    // print('SIM Card Number: $simCardNumber');
  }

  void requestPhonePermission() async {
    final status = await Permission.phone.request();

    if (status.isGranted) {
      // Permission granted, proceed with retrieving device information
      getDeviceInformation();
    } else {
      // Permission denied, handle accordingly
      if (status.isPermanentlyDenied) {
        // User has permanently denied the permission, navigate to app settings
        openAppSettings();
      } else {
        // Permission denied for now, show a message or handle the situation
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Permission Denied'),
            content: Text('You have denied access to phone state.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  bool error = false;
  String errormessage = '';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final fontsize = width * height * 0.00004;
    final fontheaders = width * height * 0.00005;
    final imageHeightall = width * height * 0.0002;
    final preferredHeight = height * 0.11;
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
                      height: imageHeightall,
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
                                  fontSize: fontheaders,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " Details",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: fontheaders,
                                  fontWeight: FontWeight.bold),
                            ),
                          ])),
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
                        controller: farmermobile,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),

                          border: OutlineInputBorder(),
                          // counter: Offstage(),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.green),
                      onPressed: () async {
                        // BlocProvider.of<TimerBloc>(context).add(StartTimer(30));
                        // farmerprofile=[];
                        if (farmermobile.text.trim().length > 9) {
                          requestPhonePermission();
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please Enter Valid Phone Number",
                              backgroundColor: Colors.red);
                        }
                      },
                      child: Text(
                        "Search",
                        style: TextStyle(fontSize: fontsize),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ]),
                  Container(
                    child: loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : error
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: Center(
                                  child: Text(
                                    errormessage,
                                    style: iostextstyle(fontsize),
                                  ),
                                ),
                              )
                            : Visibility(
                                visible: farmer != null,
                                child: SingleChildScrollView(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 20, right: 20, top: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      "Farmer Name:",
                                                      style: iostextstyle(
                                                          fontsize),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      farmer != null
                                                          ? farmer!.name
                                                              .toString()
                                                          : "",
                                                      style: iostextstyle(
                                                          fontsize),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          //
                                          // ListTile(
                                          //   leading: Text("Farmer Name:"),
                                          //   trailing: Text(farmerprofile.length > 0 ? farmerprofile![0]!.name.toString() : ""),
                                          // ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      "Mobile Number:",
                                                      style: iostextstyle(
                                                          fontsize),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      farmer != null
                                                          ? farmer!
                                                              .MobileNumberPrimary
                                                              .toString()
                                                          : "",
                                                      style: iostextstyle(
                                                          fontsize),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Center(
                                                      child: Text(
                                                    "Client Name:",
                                                    style:
                                                        iostextstyle(fontsize),
                                                  )),
                                                  Center(
                                                      child: Text(
                                                    farmer != null
                                                        ? farmer!.ClintName
                                                            .toString()
                                                        : "",
                                                    style:
                                                        iostextstyle(fontsize),
                                                  )),
                                                ]),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: farmer != null
                                                ? farmer!.farmlands.length
                                                : 0,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20, right: 20),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Center(
                                                                child: Text(
                                                              "Farmland Name:",
                                                              style:
                                                                  iostextstyle(
                                                                      fontsize),
                                                            )),
                                                            Center(
                                                                child: Text(
                                                              farmer!
                                                                  .farmlands[
                                                                      index]
                                                                  .name
                                                                  .toString(),
                                                              style:
                                                                  iostextstyle(
                                                                      fontsize),
                                                            )),
                                                          ])),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: farmer != null
                                                        ? farmer!
                                                            .farmlands[index]
                                                            .blocks!
                                                            .length
                                                        : 0,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, ind) {
                                                      return Column(
                                                        children: [
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Center(
                                                                        child:
                                                                            Text(
                                                                      "Block Name:",
                                                                      style: iostextstyle(
                                                                          fontsize),
                                                                    )),
                                                                    Center(
                                                                        child:
                                                                            Text(
                                                                      farmer!
                                                                          .farmlands[
                                                                              index]
                                                                          .blocks![
                                                                              ind]
                                                                          .name
                                                                          .toString(),
                                                                      style: iostextstyle(
                                                                          fontsize),
                                                                    )),
                                                                  ])),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          ListView.builder(
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount: farmer !=
                                                                    null
                                                                ? farmer!
                                                                    .farmlands[
                                                                        index]
                                                                    .blocks![
                                                                        ind]
                                                                    .plots!
                                                                    .length
                                                                : 0,
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context,
                                                                    inde) {
                                                              return Column(
                                                                children: [
                                                                  Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20),
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Center(
                                                                                child: Text(
                                                                              "Plot Name:",
                                                                              style: iostextstyle(fontsize),
                                                                            )),
                                                                            Center(
                                                                                child: Text(
                                                                              farmer!.farmlands[index].blocks![ind].plots![inde].name.toString(),
                                                                              style: iostextstyle(fontsize),
                                                                            )),
                                                                          ])),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ),

                                          Center(
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  backgroundColor:
                                                      Colors.green),
                                              onPressed: () async {
                                                Get.to(MyHomePagescanner(
                                                  farmer: farmer,
                                                  incertpermission:
                                                      widget.incetpermission,
                                                  updatepermission:
                                                      widget.updateparmission,
                                                  imeinumber: imeinumner,
                                                  gatewayisthere:
                                                      gatewayDevices!.isEmpty
                                                          ? false
                                                          : true,
                                                  simnumber: phonenumner,
                                                  farmid: widget.farmerID,
                                                ));
                                              },
                                              child: Text(
                                                "Update Device",
                                                style: iostextstyle(fontsize),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                  )
                ])));
  }

  Future<Farmer?> getFarmer(String mobilenumber) async {
    setState(() {
      loading = true;
    });

    try {
      String path =
          'http://20.219.2.201/servicesF2Fapp/api/farm2fork/farmerdevicedata/farmerprofile/${mobilenumber}';
      Map<String, dynamic> response = await ApiHelper().get(path);
      if (response['success'] ?? false) {
        try {
          var data = {
            "ProcessName": "Farmer data fetched",
            "UserName": '${widget.farmerID}',
            "IMEINumber": '${imeinumner}',
            "IMEIPhoneNumber": '${phonenumner}',
            "fLog": "Farmer Details Fetched",
          };
          bool responce = await FarmerDeviceDetailsLog(data, "No", context);
          print("responce manoj ${response}");
          return Farmer.fromJson(response['data']);
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
}
