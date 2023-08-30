import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '/constants.dart';
import '/servicemodeblock/ServiceMode.dart';

import '../blocfarmerTesting/MyBloc.dart';
import '../network/api_helper.dart';
import '../utils/flutter_toast_util.dart';

class ServiceModeScreen extends StatefulWidget {
  const ServiceModeScreen({Key? key}) : super(key: key);

  @override
  State<ServiceModeScreen> createState() => _ServiceModeScreenState();
}

class _ServiceModeScreenState extends State<ServiceModeScreen> {
  final myBloc = MyBloc();
  final api = ServiceMode();
  bool dataloading = false;
  bool showfarmerDetails = false;
  int val = 1;
  TextEditingController deviceid = new TextEditingController();
  DatacheckDevicestatus(String date1) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String dateWithoutZ = date1.substring(0, date1.length - 1);
    // DateTime parseDate =
    // DateFormat('yyyy-MM-dd – kk:mm').parse(date1.toString());
    var inputDate = DateTime.parse(dateWithoutZ.toString());
    DateTime end = DateTime.now();
    // DateTime date = DateTime.parse(dateWithoutZ.toString());
    var startdate = dateFormat.format(inputDate);
    var endate = dateFormat.format(end);
    DateTime dt1 = DateTime.parse(startdate);
    DateTime dt2 = DateTime.parse(endate);

    Duration diff = dt2.difference(dt1);
    // Duration difference = startdate.difference(endate);
    print(diff.inMinutes.abs());
    // DateTime start = DateTime(date);

    // print(end-date);

    Duration difference = end.difference(inputDate);

    // Duration difference = date2.difference(date1);
    // int days = difference.inDays;
    // int hours = difference.inHours % 24;
    // int minutes = difference.inMinutes.remainder(60);
    // int seconds = difference.inSeconds % 60;
    int totalDays = difference.inDays;
    int totalHours = difference.inHours - totalDays * 24;
    int totalMinutes =
        difference.inMinutes - (totalDays * 24 * 60) - (totalHours * 60);
    print(totalMinutes);
    // if(diff.inMinutes.abs()<60){
    //
    //   return "Online";
    // }
    // else {
    //   return "Offline";
    // }
    return diff.inMinutes.abs();
  }

  String Dateparce(date1) {
    DateTime date = DateTime.parse(date1.toString());
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(date);
    print('date formate ${formattedDate}');
    return formattedDate;
  }

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate the height based on the screen width and height
    final imageHeight = screenWidth * screenHeight * 0.00004;
    final fontSizebold = (screenWidth * screenHeight) * 0.00008;

    return MaterialApp(
        home: MultiBlocProvider(
            providers: [
          BlocProvider<MyBloc>(
            create: (_) => myBloc,
          ),
          BlocProvider<ServiceMode>(
            create: (_) => api,
          ),
        ],
            child: Scaffold(
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
                            height: 30,
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
                                        fontSize: fontSizebold,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " Device Servicemode",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: fontSizebold,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ])),
                        Row(
                          children: [
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
                              style: iostextstyle(imageHeight),
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
                              style: iostextstyle(imageHeight),
                            ),
                            SizedBox(width: 5),

                            // Text(bloc.)
                          ],
                        ),
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
                                labelText:
                                    val == 1 ? 'Device ID' : 'Serial Number',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: blockcolor,
                                    fontSize: imageHeight),
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
                                // setState(() {
                                //   devicedata = [];
                                //   errormessage = "";
                                // });
                                myBloc.add(FetchDataButtonPressedEvent(
                                    shouldCallApi1: val == 1 ? true : false,
                                    farmerID: deviceid.text));
                                // BlocProvider.of<MyBloc>(context).add(
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
                                setState(() {
                                  dataloading = false;
                                  showfarmerDetails = true;
                                });
                                // print(farmer);
                                // devicedata = await Devicedata(deviceid.text.trim());
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please Enter Valid Device Id",
                                    backgroundColor: Colors.red);
                              }
                            },
                            child: Text(
                              "Search",
                              style: TextStyle(fontSize: 10, color: blockcolor),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ]),
                        Container(
                          // height: 200,
                          child: BlocBuilder<MyBloc, MyBlocState>(
                              builder: (context, state) {
                            print(state is MyBlocLoadingState);
                            print("state $state");
                            if (state is MyBlocLoadingState) {
                              return CircularProgressIndicator();
                            } else if (state is MyBlocLoadedState) {
                              return showfarmerDetails
                                  ? Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20, top: 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 2.0,
                                            ),
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 100,
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(5),
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        45) /
                                                    2,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        right: BorderSide(
                                                            color:
                                                                Colors.black))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      'Farmer: ${state.data.FarmerName}',
                                                      style: iostextstyle(
                                                          imageHeight),
                                                    ),
                                                    Text(
                                                      'Client   : ${state.data.ClintName}',
                                                      style: iostextstyle(
                                                          imageHeight),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Device Status     :',
                                                          style: iostextstyle(
                                                              imageHeight),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft:
                                                                      Radius.circular(
                                                                          10),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                          10)),
                                                              color: DatacheckDevicestatus(state
                                                                          .data
                                                                          .lastCommunicated
                                                                          .toString()) >
                                                                      60
                                                                  ? Colors.red
                                                                  : Colors.green),
                                                          height: 25,
                                                          width: 50,
                                                          child: Center(
                                                            child: Text(
                                                              DatacheckDevicestatus(state
                                                                          .data
                                                                          .lastCommunicated
                                                                          .toString()) >
                                                                      60
                                                                  ? "Offline"
                                                                  : "Online",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.blue,
                                              ),
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        65) /
                                                    2,
                                                height: 150,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      'DeviceID: ',
                                                      style: iostextstyle(
                                                          imageHeight),
                                                    ),
                                                    Text(
                                                      "${state.data.DeviceID}",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: blockcolor),
                                                    ),
                                                    Text(
                                                      'Last Communicated : ',
                                                      style: iostextstyle(
                                                          imageHeight),
                                                    ),
                                                    Text(
                                                      "${Dateparce(state.data.lastCommunicated)}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: blockcolor),
                                                    ) // Text('Device Status     : ${DatacheckDevicestatus(data.lastCommunicated.toString())}'),
                                                    ,
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Service Mode : ',
                                                          style: iostextstyle(
                                                              imageHeight),
                                                        ),
                                                        Text(
                                                          "${state.data.serviceMOde}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  blockcolor),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          // crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          // crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Ink(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xff118F80),
                                                    Color(0xff118F80),
                                                  ],
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.blue[900]!,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 5),
                                                  ),
                                                ],
                                              ),
                                              child: InkWell(
                                                onTap: () async {
                                                  String path =
                                                      '$cultyvateURL/farmer/devicetestedornot/' +
                                                          state.data.DeviceID
                                                              .toString();
                                                  Map<String, dynamic>
                                                      response =
                                                      await ApiHelper()
                                                          .get(path);
                                                  print(
                                                      "responce innnn ${response}");
                                                  if (response['success'] ??
                                                      false) {
                                                    if (response['data']
                                                            .length >
                                                        0) {
                                                      FlutterToastUtil
                                                          .showErrorToast(
                                                              "The device has already been tested and has passed quality control");
                                                    } else {
                                                      final bloc = BlocProvider
                                                          .of<ServiceMode>(
                                                              context);
                                                      print(
                                                          "data deviceid ${state.data.ClintName}");

                                                      if (bloc.deviceList ==
                                                          null) {
                                                        // timer.add(StartTimer(30));
                                                        bloc.add(AddItemEvent(
                                                            state.data));
                                                      } else {
                                                        bool containsBob = bloc
                                                            .deviceList
                                                            .any((person) =>
                                                                person
                                                                    .DeviceID ==
                                                                state.data
                                                                    .DeviceID);
                                                        print(
                                                            "containbob $containsBob");
                                                        if (!containsBob) {
                                                          bloc.add(AddItemEvent(
                                                              state.data));
                                                          // timer.close();

                                                          FlutterToastUtil
                                                              .showSuccessToast(
                                                                  "Device added to list");
                                                        } else {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                  'Alert',
                                                                  style: iostextstyle(
                                                                      imageHeight),
                                                                ),
                                                                content: Text(
                                                                  'This device already in list',
                                                                  style: iostextstyle(
                                                                      imageHeight),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context),
                                                                    child: Text(
                                                                      'OK',
                                                                      style: iostextstyle(
                                                                          imageHeight),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        }
                                                      }

                                                      setState(() {
                                                        dataloading = false;

                                                        showfarmerDetails =
                                                            false;
                                                      });
                                                    }
                                                  } else {}

                                                  // Add button onTap action here
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 10),
                                                  child: Text(
                                                    'Add to List',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // onPressed: (){
                                            //
                                            //   // DataOnline(farmer,false);
                                            // }, child: Text("Add to List",style: TextStyle(color: Colors.white),)),
                                            SizedBox(
                                              width: 20,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    )
                                  : SizedBox();
                            } else {
                              return Container();
                            }
                          }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  api.add(FetchData());
                                },
                                child: Text(
                                  "CLick",
                                  style: iostextstyle(imageHeight),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<ServiceMode, ServiceModeState>(
                            // bloc: ,
                            builder: (context, state) {
                          print("State ${state}");
                          if (state is ApiLoading) {
                            // _timerBloc.cancelTimer();
                            return CircularProgressIndicator();
                          } else {
                            // final api= ApiBloc(timer);
                            final mylist = api.deviceList;
                            // if(state is ApiLoading ){
                            //   return CircularProgressIndicator();
                            // }
                            // else if(state is ApiLoaded ){
                            return ListView.builder(
                                // List<Device> faildevices=[]
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: mylist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var datainlist = mylist[index];
                                  return Card(
                                    color: HexColor('#e4e6eb'),
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 5),
                                    child: ListTile(
                                      title: Text(
                                        "Device ID : ${datainlist.DeviceID}",
                                        style: iostextstyle(imageHeight),
                                      ),
                                      trailing: Text(
                                        "Status: ${datainlist.lastCommunicated!.length > 7 ? false : datainlist.lastCommunicated}",
                                        style: iostextstyle(imageHeight),
                                      ),
                                    ),
                                  );
                                });
                          }
                        })
                      ],
                    )))));
  }
}
