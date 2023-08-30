import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '/Screens/timer.dart';
import 'package:flutter_beep/flutter_beep.dart';
import '../blocfarmerTesting/MyBloc.dart';
import '../blocfarmerTesting/Timerevent/timerblco.dart';
import '../blocfarmerTesting/api_blco.dart';
// import '../blocfarmerTesting/timer.dart';
import '../constants.dart';
import '../login/devicequrryapi.dart';
import '../models/devicetest.dart';
import '../network/api_helper.dart';
import '../utils/flutter_toast_util.dart';

class DeviceTesting extends StatefulWidget {
  final farmerID;
  const DeviceTesting({required this.farmerID}) : super();

  @override
  State<DeviceTesting> createState() => _DeviceTestingState();
}

class _DeviceTestingState extends State<DeviceTesting> {
  late Timer _timer;
  int _currentIndex = -1;
  String _stopwatchText = '';
  TextEditingController deviceid = new TextEditingController();
  bool callapi = false;
  @override
  void initState() {
    // startTimer();
    timer = TimerBloc();
    api = ApiBloc(timer);
    callapi = true;
    mylist = [];
    // TODO: implement initState
    // TODO: implement initState
    super.initState();
  }

  bool showfarmerDetails = false;
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

  int val = 1;

  List<Device> mylist = [];

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool dataloading = false;
  String Dateparce(date1) {
    DateTime date = DateTime.parse(date1.toString());
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(date);
    print('date formate ${formattedDate}');
    return formattedDate;
  }

  DashboardService dashboardService = DashboardService();

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

  //    apiupdate(index)async{
  //      var data =await dashboardService.level(mylist[index]!.DeviceID.toString(),'level1' );
  //     print("data output ${data}");
  //     print( data['Level3']>4000);
  //     print(mylist[index]!.level3tested==false);
  //     print(mylist[index]!.level3tested==false && data['Level3']>4000);
  //      if (mylist[index]!.allleveltested==false && (data['Level1']>4000 &&data['Level2']>4000 &&data['Level3']>4000 &&data['Level4']>4000 )){
  //
  //
  //
  //        if (mounted) {
  //       setState(() {
  //
  //        mylist[index]!.alllevelactive=true;
  //        mylist[index]!.level1active = false;
  //        mylist[index]!.level2active = false;
  //        mylist[index]!.level2active = false;
  //        mylist[index]!.level4active = false;
  //         mylist[index]!.stopwatch.stop();
  //         mylist[index]!.stopwatch.reset();
  //         mylist[index]!.timer?.cancel();
  //       });
  //       }
  //
  //
  //        FlutterRingtonePlayer.playNotification();
  //      }
  //      else  if (mylist[index]!.level1tested==false && data['Level1']>4000){
  //        print("level1");
  //        if (mounted) {
  //          setState(() {
  //            mylist[index]!.level1active = true;
  //            mylist[index]!.alllevelactive = false;
  //            mylist[index]!.level2active = false;
  //            mylist[index]!.level3active = false;
  //            mylist[index]!.level4active = false;
  //            mylist[index]!.stopwatch.stop();
  //            mylist[index]!.stopwatch.reset();
  //            mylist[index]!.timer?.cancel();
  //          });
  //        }
  //
  //        FlutterRingtonePlayer.playNotification();
  //      } else if (mylist[index]!.level2tested==false && data['Level2']>4000){
  //        print("level2");
  //        if (mounted) {
  //          setState(() {
  //            mylist[index]!.level2active = true;
  //            mylist[index]!.level1active = false;
  //            mylist[index]!.alllevelactive = false;
  //            mylist[index]!.level3active = false;
  //            mylist[index]!.level4active = false;
  //            mylist[index]!.stopwatch.stop();
  //            mylist[index]!.stopwatch.reset();
  //            mylist[index]!.timer?.cancel();
  //          });
  //        }
  //
  //        FlutterRingtonePlayer.playNotification();
  //      }
  //      else if(mylist[index]!.level3tested==false && data['Level3']>4000){
  //        if (mounted) {
  //          setState(() {
  //            mylist[index]!.level3active = true;
  //            mylist[index]!.level1active = false;
  //            mylist[index]!.level2active = false;
  //            mylist[index]!.level4active = false;
  //            mylist[index]!.alllevelactive = false;
  //            mylist[index]!.stopwatch.stop();
  //            mylist[index]!.stopwatch.reset();
  //            mylist[index]!.timer?.cancel();
  //          });
  //        }
  //        print("level3");
  //
  //        FlutterRingtonePlayer.playNotification();
  //      }
  //      else if(mylist[index]!.level4tested==false &&  data['Level4']>4000){
  //        print("level4");
  //        if (mounted) {
  //          setState(() {
  //            mylist[index]!.stopwatch.stop();
  //            mylist[index]!.stopwatch.reset();
  //            mylist[index]!.timer?.cancel();
  //            mylist[index]!.level4active = true;
  //            mylist[index]!.level1active = false;
  //            mylist[index]!.level2active = false;
  //            mylist[index]!.level3active = false;
  //            mylist[index]!.alllevelactive = false;
  //          });
  //        }
  //
  //        FlutterRingtonePlayer.playNotification();
  //      }
  // if(mounted){
  //   setState(() {
  //     mylist[index]!.lastCommunicated=data['LastDate'];
  //   });
  // }
  //
  //      if(data['Level1']>4000 &&data['Level2']>4000 &&data['Level3']>4000 &&data['Level4']>4000){
  //        if (mounted) {
  //          setState(() {
  //            mylist[index]!.level1 = data['Level1'];
  //            mylist[index]!.level2 = data['Level2'];
  //            mylist[index]!.level3 = data['Level3'];
  //            mylist[index]!.level4 = data['Level4'];
  //            mylist[index]!.allleveltested = true;
  //            mylist[index]!.level1active = false;
  //            mylist[index]!.level2active = false;
  //            mylist[index]!.level2active = false;
  //            mylist[index]!.level4active = false;
  //          });
  //        }
  //        // FlutterBeep.beep();
  //      }
  //
  //      else if(data['Level1']>4000){
  //        if (mounted) {
  //          setState(() {
  //            mylist[index]!.level1 = data['Level1'];
  //            mylist[index]!.level1tested = true;
  //          });
  //        }
  //        // FlutterBeep.beep();
  //      }
  //      else if(data['Level2']>4000){
  //        if (mounted) {
  //          setState(() {
  //            mylist[index]!.level2 = data['Level2'];
  //            mylist[index]!.level2tested = true;
  //          });
  //        }
  //        // FlutterBeep.beep();
  //      }
  //      else if(data['Level3']>4000){
  //        if (mounted) {
  //          setState(() {
  //            mylist[index]!.level3 = data['Level3'];
  //            mylist[index]!.level3tested = true;
  //          });
  //        }
  //        // FlutterBeep.beep();
  //      }
  //      else if(data['Level4']>4000){
  //        if (mounted) {
  //          setState(() {
  //            mylist[index]!.level4 = data['Level4'];
  //            mylist[index]!.level4tested = true;
  //          });
  //        }
  //        // FlutterBeep.beep();
  //      }
  //    }

  String Testpassed = 'Ok';
  String Textfail = 'Re test';
  String Level1 = 'Level 1:';
  String Level2 = 'Level 2:';
  String Level3 = 'Level 3:';
  String Level4 = 'Level 4:';
  String All = 'All:';
  Device? farmer;
  @override
  void dispose() {
    if (mounted) {
      setState(() {
        callapi = false;
      });
    }
    mylist.forEach((element) {
      setState(() {
        element.timer?.cancel();
        // mylist.clear();
        // _timer?.cancel();
      });
    });
    mylist.clear();
    _timer.cancel();
    print("dispose");
    // TODO: implement dispose
    super.dispose();
  }

  // void startTimer() {
  //   _timer = Timer.periodic(Duration(seconds: 45), (timer) {
  //  print("calling");
  //   if(mylist.length>0 && callapi){
  //     for(int i=0;i<mylist.length;i++){
  //       if (mounted) {
  //         if (!(mylist[i].level1tested) || !(mylist[i].level2tested) ||
  //             !(mylist[i].level3tested) || !(mylist[i].level4tested) ||
  //             !(mylist[i].allleveltested)) {
  //           apiupdate(i);
  //         }
  //       }
  //     }
  //   }
  //   });
  // }
  DashboardService dashboardService1 = DashboardService();
  final myBloc = MyBloc();
// final listBloc=ListBloc();
  late TimerBloc timer;
  late ApiBloc api;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final fontsize = width * height * 0.00004;
    final fontheaders = width * height * 0.00005;
    final imageHeightall = width * height * 0.0002;
    final preferredHeight = height * 0.11;

    return MaterialApp(
        home: MultiBlocProvider(
      providers: [
        BlocProvider<MyBloc>(
          create: (_) => myBloc,
        ),
        // BlocProvider<ListBloc>(create: (_)=>listBloc),
        BlocProvider<TimerBloc>(
          create: (_) => timer,
        ),
        BlocProvider<ApiBloc>(
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
                                fontSize: fontsize,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " Device Testing",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: fontsize,
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
                      style: iostextstyle(fontsize),
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
                    Text("Serial Number", style: iostextstyle(fontsize)),
                    SizedBox(width: 5),

                    BlocBuilder<TimerBloc, TimerState>(
                      bloc: timer,
                      builder: (context, state) {
                        // if (state is Ready) {
                        //   return _buildStartButton(context);
                        // }
                        if (state is Running) {
                          return Text(
                            'Data refresh in ${state.duration.toString()}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          );
                        } else {
                          return Text("");
                        }
                        //  else if (state is Paused) {
                        //   return _buildPausedState(context, state.duration);
                        // } else if (state is Finished) {
                        //   return _buildFinishedState(context);
                        // } else {
                        //   return Container();
                        // }
                      },
                    ),

                    // Text(bloc.)
                  ],
                ),
                Row(children: [
                  Container(
                    // height: MediaQuery.of(context).size.height/12,
                    width: MediaQuery.of(context).size.width / 1.26,
                    padding: EdgeInsets.fromLTRB(20, 0, 5, 5),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z]")),
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      controller: deviceid,
                      decoration: InputDecoration(
                        labelText: val == 1 ? 'Device ID' : 'Serial Number',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
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
                        print(farmer);
                        // devicedata = await Devicedata(deviceid.text.trim());
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please Enter Valid Device Id",
                            backgroundColor: Colors.red);
                      }
                    },
                    child: Text(
                      "Search",
                      style: TextStyle(fontSize: 10),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    45) /
                                                2,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                                    color: Colors.black))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                                'Farmer: ${state.data.FarmerName}',
                                                style: iostextstyle(fontsize)),
                                            Text(
                                                'Client   : ${state.data.ClintName}',
                                                style: iostextstyle(fontsize)),
                                            Row(
                                              children: [
                                                Text('Device Status     :',
                                                    style:
                                                        iostextstyle(fontsize)),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(10),
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
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
                                                          color: Colors.white),
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
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    65) /
                                                2,
                                        height: 150,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('DeviceID: ',
                                                style: iostextstyle(fontsize)),
                                            Text(
                                              "${state.data.DeviceID}",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            Text('Last Communicated : ',
                                                style: iostextstyle(fontsize)),
                                            Text(
                                              "${Dateparce(state.data.lastCommunicated)}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ) // Text('Device Status     : ${DatacheckDevicestatus(data.lastCommunicated.toString())}'),
                                            ,
                                            Row(
                                              children: [
                                                Text('Service Mode : ',
                                                    style:
                                                        iostextstyle(fontsize)),
                                                Text(
                                                  "${state.data.serviceMOde}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Ink(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                          Map<String, dynamic> response =
                                              await ApiHelper().get(path);
                                          print("responce innnn ${response}");
                                          if (response['success'] ?? false) {
                                            if (response['data'].length > 0) {
                                              FlutterToastUtil.showErrorToast(
                                                  "The device has already been tested and has passed quality control");
                                            } else {
                                              timer.add(StartTimer(30));
                                              final bloc =
                                                  BlocProvider.of<ApiBloc>(
                                                      context);
                                              print(
                                                  "data deviceid ${state.data.ClintName}");

                                              if (bloc.deviceList == null) {
                                                // timer.add(StartTimer(30));
                                                bloc.add(
                                                    AddItemEvent(state.data));
                                              } else {
                                                bool containsBob = bloc
                                                    .deviceList
                                                    .any((person) =>
                                                        person.DeviceID ==
                                                        state.data.DeviceID);
                                                print(
                                                    "containbob $containsBob");
                                                if (!containsBob) {
                                                  // timer.add(StartTimer(30));
                                                  if (bloc.deviceList.length >
                                                      0) {
                                                    bloc.restartTimer();
                                                  } else {
                                                    bloc.starttimer();
                                                  }
                                                  bloc.add(
                                                      AddItemEvent(state.data));
                                                  // timer.close();

                                                  FlutterToastUtil
                                                      .showSuccessToast(
                                                          "Device added to list");
                                                } else {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Alert',
                                                            style: iostextstyle(
                                                                fontsize)),
                                                        content: Text(
                                                            'This device already in list',
                                                            style: iostextstyle(
                                                                fontsize)),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: Text('OK',
                                                                style: iostextstyle(
                                                                    fontsize)),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              }

                                              setState(() {
                                                dataloading = false;

                                                showfarmerDetails = false;
                                              });
                                            }
                                          } else {}

                                          // Add button onTap action here
                                        },
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          child: Text(
                                            'Add to List',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
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
                // dataloading ? CircularProgressIndicator():DataOnline(farmer,true),
                SizedBox(
                  height: 3,
                ),
                BlocBuilder<ApiBloc, ApiState>(
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
                          DateTime date = DateTime.parse(
                              mylist[index].lastCommunicated.toString());
                          String formattedDate =
                              DateFormat('yyyy-MM-dd hh:mm a').format(date);
                          // startTimer(index);
                          // print(Dateparce(mylist[index]!.lastCommunicated.toString()));
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 18, bottom: 20, right: 20),
                                width: MediaQuery.of(context).size.width - 18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                height: 260,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 35,
                                      child: Row(
                                        children: [
                                          SizedBox(width: 20),
                                          Text(
                                              '${mylist[index].DeviceID.toString()} / ${mylist[index].hardwareserialnumber}',
                                              style: iostextstyle(fontsize)),
                                          Spacer(),
                                          Visibility(
                                            visible: ((mylist[index]
                                                        .level1tested ||
                                                    mylist[index].level1fail) &&
                                                (mylist[index].level2tested ||
                                                    mylist[index].level2fail) &&
                                                (mylist[index].level3tested ||
                                                    mylist[index].level3fail) &&
                                                (mylist[index].level4tested ||
                                                    mylist[index].level4fail) &&
                                                (mylist[index].allleveltested ||
                                                    mylist[index]
                                                        .levelallfail)),
                                            child: Container(
                                              width: 75,
                                              height: 35,
                                              child: Ink(
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
                                                    String postUrl =
                                                        '$cultyvateURL/farmer/devcetestdatapost';
                                                    Map<String, dynamic>
                                                        requestBody = {
                                                      "FarmerID": mylist[index]
                                                          .FarmerID,
                                                      "DeviceDetailsID":
                                                          mylist[index]
                                                              .DeviceDetailsID,
                                                      "DeviceTypleID":
                                                          mylist[index]
                                                              .DeviceTypeID,
                                                      "HardwareSerialNumber":
                                                          mylist[index]
                                                              .hardwareserialnumber,
                                                      "DeviceEUIID":
                                                          mylist[index]
                                                              .DeviceID,
                                                      "SoilMoistureLevelAGL3":
                                                          mylist[index].level1,
                                                      "SoilMoistureLevelAGL2":
                                                          mylist[index].level2,
                                                      "SoilMoistureLevelBGL6":
                                                          mylist[index].level3,
                                                      "SoilMoistureLevelBGL7":
                                                          mylist[index].level4,
                                                      "SoilMoistureLevelAGL3WorkingYN":
                                                          mylist[index]
                                                              .level1tested,
                                                      "SoilMoistureLevelAGL2WorkingYN":
                                                          mylist[index]
                                                              .level2tested,
                                                      "SoilMoistureLevelBGL6WorkingYN":
                                                          mylist[index]
                                                              .level3tested,
                                                      "SoilMoistureLevelBGL7WorkingYN":
                                                          mylist[index]
                                                              .level4tested,
                                                      "QCTestPassedYN": mylist[
                                                                          index]
                                                                      .level1tested ==
                                                                  true &&
                                                              mylist[index]
                                                                      .level2tested ==
                                                                  true &&
                                                              mylist[index]
                                                                      .level3tested ==
                                                                  true &&
                                                              mylist[index]
                                                                      .level4tested ==
                                                                  true &&
                                                              mylist[index]
                                                                      .allleveltested ==
                                                                  true
                                                          ? true
                                                          : false,
                                                      "TestedByUserID":
                                                          widget.farmerID,
                                                      "SoilMoistureLevelAllWorkingYN":
                                                          mylist[index]
                                                              .allleveltested
                                                    };

                                                    final niftyResponse =
                                                        await ApiHelper().post(
                                                            path: postUrl,
                                                            postData:
                                                                requestBody);
                                                    api.add(RemoveItemEvent(
                                                        mylist[index]));
                                                    // Add button onTap action here
                                                  },
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                                    child: Center(
                                                      child: Text(
                                                        'Save&close',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 220,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: 35,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  // crossAxisAlignment: CrossAxisAlignment.,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Center(
                                                        child: Text("Level 1:",
                                                            style: iostextstyle(
                                                                fontsize))),
                                                    Center(
                                                      child: Container(
                                                        height: 25,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          color: Colors.yellow,
                                                          border: Border.all(
                                                            color:
                                                                Colors.yellow,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: (mylist[index]
                                                                          .level1! >
                                                                      4000 &&
                                                                  (!(mylist[index]
                                                                              .level4! >
                                                                          4000) &&
                                                                      !(mylist[index]
                                                                              .level2! >
                                                                          4000) &&
                                                                      !(mylist[index]
                                                                              .level3! >
                                                                          4000))) ||
                                                              mylist[index]
                                                                      .level1tested ==
                                                                  true
                                                          ? Text(
                                                              "     Ok  ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          : Text(
                                                              "Re test",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                    ),
                                                    Container(
                                                        height: 25,
                                                        width: 60,
                                                        child: mylist[index]
                                                                    .level1active >
                                                                0
                                                            ? Text(
                                                                "  ${mylist[index].level1active.toString()}  ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : Row(
                                                                children: [
                                                                  Checkbox(
                                                                    activeColor:
                                                                        Colors
                                                                            .red,
                                                                    value: mylist[
                                                                            index]
                                                                        .level1fail,
                                                                    onChanged:
                                                                        (value) {
                                                                      final bloc =
                                                                          BlocProvider.of<ApiBloc>(
                                                                              context);
                                                                      bloc.add(UpdateArrayPositionEvent(
                                                                          index,
                                                                          Device(
                                                                              DeviceID: mylist[index].DeviceID,
                                                                              levelallfail: mylist[index].levelallfail,
                                                                              FarmerID: mylist[index].FarmerID,
                                                                              hardwareserialnumber: mylist[index].hardwareserialnumber,
                                                                              ClintName: mylist[index].ClintName,
                                                                              DeviceDetailsID: mylist[index].DeviceDetailsID,
                                                                              DeviceTypeID: mylist[index].DeviceTypeID,
                                                                              FarmerName: mylist[index].FarmerName,
                                                                              lastCommunicated: mylist[index].lastCommunicated,
                                                                              counter: mylist[index].counter,
                                                                              serviceMOde: mylist[index].serviceMOde,
                                                                              level1: mylist[index].level1,
                                                                              level2: mylist[index].level2,
                                                                              level3: mylist[index].level3,
                                                                              level4: mylist[index].level4,
                                                                              level1fail: value!,
                                                                              level2fail: mylist[index].level2fail,
                                                                              level3fail: mylist[index].level3fail,
                                                                              level4fail: mylist[index].level4fail,
                                                                              stopwatchtime: "",
                                                                              level1active: mylist[index].level1active,
                                                                              level2active: mylist[index].level2active,
                                                                              level3active: mylist[index].level3active,
                                                                              level4active: mylist[index].level4active,
                                                                              alllevelactive: mylist[index].alllevelactive,
                                                                              stopwatch: Stopwatch(),
                                                                              level1tested: mylist[index].level1tested,
                                                                              level2tested: mylist[index].level2tested,
                                                                              level3tested: mylist[index].level3tested,
                                                                              level4tested: mylist[index].level4tested,
                                                                              allleveltested: mylist[index].allleveltested)));
                                                                    },
                                                                  ),
                                                                  Text("Fail",
                                                                      style: iostextstyle(
                                                                          fontsize))
                                                                ],
                                                              )

                                                        // Text(".",style: TextStyle(color: Colors.green),):Text(" "),
                                                        ),
                                                    Center(
                                                      child: Container(
                                                        height: 25,
                                                        // width: 50,
                                                        child: mylist[index]
                                                                    .level1tested ==
                                                                true
                                                            ? Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                              )
                                                            : Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                color: HexColor("#f5eeed"),
                                                height: 35,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Center(
                                                        child: Text("Level 2:",
                                                            style: iostextstyle(
                                                                fontsize))),
                                                    Center(
                                                      child: Container(
                                                        height: 25,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          color: Colors.green,
                                                          border: Border.all(
                                                            color: Colors.green,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: (mylist[index]
                                                                          .level2! >
                                                                      4000 &&
                                                                  (!(mylist[index]
                                                                              .level1! >
                                                                          4000) &&
                                                                      !(mylist[index]
                                                                              .level4! >
                                                                          4000) &&
                                                                      !(mylist[index]
                                                                              .level3! >
                                                                          4000))) ||
                                                              mylist[index]
                                                                      .level2tested ==
                                                                  true
                                                          ? Text(
                                                              "     Ok  ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          : Text(
                                                              "Re test",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 60,
                                                      child: mylist[index]
                                                                  .level2active >
                                                              0
                                                          ? Text(
                                                              "  ${mylist[index].level2active.toString()}  ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Row(
                                                              children: [
                                                                Checkbox(
                                                                  activeColor:
                                                                      Colors
                                                                          .red,
                                                                  value: mylist[
                                                                          index]
                                                                      .level2fail,
                                                                  onChanged:
                                                                      (value) {
                                                                    final bloc =
                                                                        BlocProvider.of<ApiBloc>(
                                                                            context);
                                                                    bloc.add(UpdateArrayPositionEvent(
                                                                        index,
                                                                        Device(
                                                                            DeviceID: mylist[index]
                                                                                .DeviceID,
                                                                            levelallfail: mylist[index]
                                                                                .levelallfail,
                                                                            FarmerID: mylist[index]
                                                                                .FarmerID,
                                                                            hardwareserialnumber: mylist[index]
                                                                                .hardwareserialnumber,
                                                                            ClintName: mylist[index]
                                                                                .ClintName,
                                                                            DeviceDetailsID: mylist[index]
                                                                                .DeviceDetailsID,
                                                                            DeviceTypeID: mylist[index]
                                                                                .DeviceTypeID,
                                                                            FarmerName: mylist[index]
                                                                                .FarmerName,
                                                                            lastCommunicated: mylist[index]
                                                                                .lastCommunicated,
                                                                            counter: mylist[index]
                                                                                .counter,
                                                                            serviceMOde: mylist[index]
                                                                                .serviceMOde,
                                                                            level1: mylist[index]
                                                                                .level1,
                                                                            level2: mylist[index]
                                                                                .level2,
                                                                            level3: mylist[index]
                                                                                .level3,
                                                                            level4: mylist[index]
                                                                                .level4,
                                                                            level1fail: mylist[index]
                                                                                .level1fail,
                                                                            level2fail:
                                                                                value!,
                                                                            level3fail:
                                                                                mylist[index].level3fail,
                                                                            level4fail: mylist[index].level4fail,
                                                                            stopwatchtime: "",
                                                                            level1active: mylist[index].level1active,
                                                                            level2active: mylist[index].level2active,
                                                                            level3active: mylist[index].level3active,
                                                                            level4active: mylist[index].level4active,
                                                                            alllevelactive: mylist[index].alllevelactive,
                                                                            stopwatch: Stopwatch(),
                                                                            level1tested: mylist[index].level1tested,
                                                                            level2tested: mylist[index].level2tested,
                                                                            level3tested: mylist[index].level3tested,
                                                                            level4tested: mylist[index].level4tested,
                                                                            allleveltested: mylist[index].allleveltested)));
                                                                  },
                                                                ),
                                                                Text("Fail",
                                                                    style: iostextstyle(
                                                                        fontsize))
                                                              ],
                                                            ),

                                                      // Text(".",style: TextStyle(color: Colors.green),):Text(" "),
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        height: 25,
                                                        // width: 50,
                                                        child: mylist[index]
                                                                    .level2tested ==
                                                                true
                                                            ? Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                              )
                                                            : Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 50,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Center(
                                                      child: Text("Level 3:",
                                                          style: iostextstyle(
                                                              fontsize)),
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        height: 25,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          color: Colors.blue,
                                                          border: Border.all(
                                                            color: Colors.blue,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: (mylist[index]
                                                                          .level3! >
                                                                      4000 &&
                                                                  (!(mylist[index]
                                                                              .level1! >
                                                                          4000) &&
                                                                      !(mylist[index]
                                                                              .level2! >
                                                                          4000) &&
                                                                      !(mylist[index]
                                                                              .level4! >
                                                                          4000))) ||
                                                              mylist[index]
                                                                      .level3tested ==
                                                                  true
                                                          ? Text(
                                                              "     Ok  ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          : Text(
                                                              "Re test",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 60,
                                                      child: mylist[index]
                                                                  .level3active >
                                                              0
                                                          ? Text(
                                                              "  ${mylist[index].level3active.toString()}  ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Row(
                                                              children: [
                                                                Checkbox(
                                                                  activeColor:
                                                                      Colors
                                                                          .red,
                                                                  value: mylist[
                                                                          index]
                                                                      .level3fail,
                                                                  onChanged:
                                                                      (value) {
                                                                    final bloc =
                                                                        BlocProvider.of<ApiBloc>(
                                                                            context);
                                                                    bloc.add(UpdateArrayPositionEvent(
                                                                        index,
                                                                        Device(
                                                                            DeviceID:
                                                                                mylist[index].DeviceID,
                                                                            levelallfail: mylist[index].levelallfail,
                                                                            hardwareserialnumber: mylist[index].hardwareserialnumber,
                                                                            FarmerID: mylist[index].FarmerID,
                                                                            ClintName: mylist[index].ClintName,
                                                                            FarmerName: mylist[index].FarmerName,
                                                                            DeviceDetailsID: mylist[index].DeviceDetailsID,
                                                                            DeviceTypeID: mylist[index].DeviceTypeID,
                                                                            lastCommunicated: mylist[index].lastCommunicated,
                                                                            counter: mylist[index].counter,
                                                                            serviceMOde: mylist[index].serviceMOde,
                                                                            level1: mylist[index].level1,
                                                                            level2: mylist[index].level2,
                                                                            level3: mylist[index].level3,
                                                                            level4: mylist[index].level4,
                                                                            level1fail: mylist[index].level1fail,
                                                                            level2fail: mylist[index].level2fail,
                                                                            level3fail: value!,
                                                                            level4fail: mylist[index].level4fail,
                                                                            stopwatchtime: "",
                                                                            level1active: mylist[index].level1active,
                                                                            level2active: mylist[index].level2active,
                                                                            level3active: mylist[index].level3active,
                                                                            level4active: mylist[index].level4active,
                                                                            alllevelactive: mylist[index].alllevelactive,
                                                                            stopwatch: Stopwatch(),
                                                                            level1tested: mylist[index].level1tested,
                                                                            level2tested: mylist[index].level2tested,
                                                                            level3tested: mylist[index].level3tested,
                                                                            level4tested: mylist[index].level4tested,
                                                                            allleveltested: mylist[index].allleveltested)));
                                                                  },
                                                                ),
                                                                Text("Fail",
                                                                    style: iostextstyle(
                                                                        fontsize))
                                                              ],
                                                            ),

                                                      // Text(".",style: TextStyle(color: Colors.green),):Text(" "),
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        height: 25,
                                                        // width: 50,
                                                        child: mylist[index]
                                                                    .level3tested ==
                                                                true
                                                            ? Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                              )
                                                            : Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                color: HexColor("#f5eeed"),
                                                height: 35,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Center(
                                                        child: Text("Level 4:",
                                                            style: iostextstyle(
                                                                fontsize))),
                                                    Center(
                                                      child: Container(
                                                        height: 25,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          color: Colors.red,
                                                          border: Border.all(
                                                            color: Colors.red,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: (mylist[index]
                                                                          .level4! >
                                                                      4000 &&
                                                                  (!(mylist[index]
                                                                              .level1! >
                                                                          4000) &&
                                                                      !(mylist[index]
                                                                              .level2! >
                                                                          4000) &&
                                                                      !(mylist[index]
                                                                              .level3! >
                                                                          4000))) ||
                                                              mylist[index]
                                                                      .level4tested ==
                                                                  true
                                                          ? Text(
                                                              "     Ok  ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          : Text(
                                                              "Re test",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 60,
                                                      child: mylist[index]
                                                                  .level4active >
                                                              0
                                                          ? Text(
                                                              "  ${mylist[index].level4active.toString()}  ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Row(
                                                              children: [
                                                                Checkbox(
                                                                  activeColor:
                                                                      Colors
                                                                          .red,
                                                                  value: mylist[
                                                                          index]
                                                                      .level4fail,
                                                                  onChanged:
                                                                      (value) {
                                                                    final bloc =
                                                                        BlocProvider.of<ApiBloc>(
                                                                            context);
                                                                    bloc.add(UpdateArrayPositionEvent(
                                                                        index,
                                                                        Device(
                                                                            DeviceID:
                                                                                mylist[index].DeviceID,
                                                                            levelallfail: mylist[index].levelallfail,
                                                                            hardwareserialnumber: mylist[index].hardwareserialnumber,
                                                                            ClintName: mylist[index].ClintName,
                                                                            FarmerID: mylist[index].FarmerID,
                                                                            FarmerName: mylist[index].FarmerName,
                                                                            DeviceDetailsID: mylist[index].DeviceDetailsID,
                                                                            DeviceTypeID: mylist[index].DeviceTypeID,
                                                                            lastCommunicated: mylist[index].lastCommunicated,
                                                                            counter: mylist[index].counter,
                                                                            serviceMOde: mylist[index].serviceMOde,
                                                                            level1: mylist[index].level1,
                                                                            level2: mylist[index].level2,
                                                                            level3: mylist[index].level3,
                                                                            level4: mylist[index].level4,
                                                                            level1fail: mylist[index].level1fail,
                                                                            level2fail: mylist[index].level2fail,
                                                                            level3fail: mylist[index].level3fail,
                                                                            level4fail: value!,
                                                                            stopwatchtime: "",
                                                                            level1active: mylist[index].level1active,
                                                                            level2active: mylist[index].level2active,
                                                                            level3active: mylist[index].level3active,
                                                                            level4active: mylist[index].level4active,
                                                                            alllevelactive: mylist[index].alllevelactive,
                                                                            stopwatch: Stopwatch(),
                                                                            level1tested: mylist[index].level1tested,
                                                                            level2tested: mylist[index].level2tested,
                                                                            level3tested: mylist[index].level3tested,
                                                                            level4tested: mylist[index].level4tested,
                                                                            allleveltested: mylist[index].allleveltested)));
                                                                  },
                                                                ),
                                                                Text("Fail",
                                                                    style: iostextstyle(
                                                                        fontsize))
                                                              ],
                                                            ),

                                                      // Text(".",style: TextStyle(color: Colors.green),):Text(" "),
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        height: 25,
                                                        // width: 50,
                                                        child: mylist[index]
                                                                    .level4tested ==
                                                                true
                                                            ? Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                              )
                                                            : Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                child: Row(
                                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                            "    All    :",
                                                            style: iostextstyle(
                                                                fontsize))),
                                                    Center(
                                                      child: Container(
                                                        height: 25,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          color: Colors.black,
                                                          border: Border.all(
                                                            color: Colors.black,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: mylist[index]
                                                                      .level1! >
                                                                  4000 &&
                                                              mylist[index]
                                                                      .level2! >
                                                                  4000 &&
                                                              mylist[index]
                                                                      .level3! >
                                                                  4000 &&
                                                              mylist[index]
                                                                      .level4! >
                                                                  4000
                                                          ? Text(
                                                              "     Ok  ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          : Text(
                                                              "Re test",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 60,
                                                      child: mylist[index]
                                                                  .alllevelactive >
                                                              0
                                                          ? Text(
                                                              "  ${mylist[index].alllevelactive.toString()}  ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Row(
                                                              children: [
                                                                Checkbox(
                                                                  activeColor:
                                                                      Colors
                                                                          .red,
                                                                  value: mylist[
                                                                          index]
                                                                      .levelallfail,
                                                                  onChanged:
                                                                      (value) {
                                                                    final bloc =
                                                                        BlocProvider.of<ApiBloc>(
                                                                            context);
                                                                    bloc.add(UpdateArrayPositionEvent(
                                                                        index,
                                                                        Device(
                                                                            DeviceID: mylist[index]
                                                                                .DeviceID,
                                                                            levelallfail:
                                                                                value!,
                                                                            FarmerID:
                                                                                mylist[index].FarmerID,
                                                                            hardwareserialnumber: mylist[index].hardwareserialnumber,
                                                                            ClintName: mylist[index].ClintName,
                                                                            FarmerName: mylist[index].FarmerName,
                                                                            DeviceDetailsID: mylist[index].DeviceDetailsID,
                                                                            DeviceTypeID: mylist[index].DeviceTypeID,
                                                                            lastCommunicated: mylist[index].lastCommunicated,
                                                                            counter: mylist[index].counter,
                                                                            serviceMOde: mylist[index].serviceMOde,
                                                                            level1: mylist[index].level1,
                                                                            level2: mylist[index].level2,
                                                                            level3: mylist[index].level3,
                                                                            level4: mylist[index].level4,
                                                                            level1fail: mylist[index].level1fail,
                                                                            level2fail: mylist[index].level2fail,
                                                                            level3fail: mylist[index].level3fail,
                                                                            level4fail: mylist[index].level4fail,
                                                                            stopwatchtime: "",
                                                                            level1active: mylist[index].level1active,
                                                                            level2active: mylist[index].level2active,
                                                                            level3active: mylist[index].level3active,
                                                                            level4active: mylist[index].level4active,
                                                                            alllevelactive: mylist[index].alllevelactive,
                                                                            stopwatch: Stopwatch(),
                                                                            level1tested: mylist[index].level1tested,
                                                                            level2tested: mylist[index].level2tested,
                                                                            level3tested: mylist[index].level3tested,
                                                                            level4tested: mylist[index].level4tested,
                                                                            allleveltested: mylist[index].allleveltested)));
                                                                  },
                                                                ),
                                                                Text("Fail",
                                                                    style: iostextstyle(
                                                                        fontsize))
                                                              ],
                                                            ),

                                                      // Text(".",style: TextStyle(color: Colors.green),):Text(" "),
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        height: 25,
                                                        // width: 50,
                                                        child: mylist[index]
                                                                    .allleveltested ==
                                                                true
                                                            ? Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                              )
                                                            : Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  // height: 70,
                                                  child: Wrap(
                                                children: [
                                                  Text(' Last Data : ',
                                                      style: iostextstyle(
                                                          fontsize)),
                                                  Text(
                                                    "${Dateparce(mylist[index].lastCommunicated.toString())}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),

                                                  mylist[index]
                                                              .stopwatch
                                                              .isRunning ==
                                                          true
                                                      ? Text(
                                                          mylist[index]
                                                              .stopwatchtime,
                                                          style: iostextstyle(
                                                              fontsize))
                                                      : Text(""),

                                                  //     var data =await dashboardService.level(mylist[index]!.DeviceID.toString(),'level1' );
                                                  //     // setState(() {
                                                  //     //
                                                  //     // });
                                                  //
                                                  //     if(data['Level1']>4000 &&data['Level2']>4000 &&data['Level3']>4000 &&data['Level4']>4000){
                                                  //
                                                  //       setState(() {
                                                  //         mylist[index]!.level1=data['Level1'];
                                                  //         mylist[index]!.level2=data['Level2'];
                                                  //         mylist[index]!.level3=data['Level3'];
                                                  //         mylist[index]!.level4=data['Level4'];
                                                  //         mylist[index]!.allleveltested=true;
                                                  //       });
                                                  //     }
                                                  //
                                                  //     else if(data['Level1']>4000){
                                                  //       setState(() {
                                                  //         mylist[index]!.level1=data['Level1'];
                                                  //         mylist[index]!.level1tested=true;
                                                  //       });
                                                  //     }
                                                  //     else if(data['Level2']>4000){
                                                  //       setState(() {
                                                  //         mylist[index]!.level2=data['Level2'];
                                                  //         mylist[index]!.level2tested=true;
                                                  //       });
                                                  //     }
                                                  //     else if(data['Level3']>4000){
                                                  //       setState(() {
                                                  //         mylist[index]!.level3=data['Level3'];
                                                  //         mylist[index]!.level3tested=true;
                                                  //       });
                                                  //     }
                                                  //     else if(data['Level4']>4000){
                                                  //       setState(() {
                                                  //         mylist[index]!.level4=data['Level4'];
                                                  //         mylist[index]!.level4tested=true;
                                                  //       });
                                                  //     }
                                                  // }
                                                  //        )
                                                ],
                                              ))
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: mylist[index].level2tested ==
                                                  true &&
                                              mylist[index].level1tested ==
                                                  true &&
                                              mylist[index].level3tested ==
                                                  true &&
                                              mylist[index].level4tested ==
                                                  true &&
                                              mylist[index].allleveltested ==
                                                  true,
                                          child: Positioned(
                                              top: 50,
                                              left: 120,
                                              child: (Image.asset(
                                                'assets/images/QCPassed.png',
                                                height: 100,
                                              ))),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                  }
                  // else {
                  //   return Container();
                  // }
                })
              ],
            )),
      ),
    ));
  }
}
