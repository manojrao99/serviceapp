import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import '/Screens/googlemapdraw.dart';
import 'package:location/location.dart' as pkgLocation;
import '/constants.dart';
import '/models/farmlandcordinates.dart';

import '../models/farmeraccuationplotmaping.dart';
import '../models/farmermapdata.dart';
import '../models/twokimradiusdata.dart';
import 'dummydart.dart';

class FarmerGoogleMapDetailss extends StatefulWidget {
  final incertpermission;
  final fareraccuasation;
  const FarmerGoogleMapDetailss(
      {required this.fareraccuasation, required this.incertpermission})
      : super();

  @override
  State<FarmerGoogleMapDetailss> createState() =>
      _FarmerGoogleMapDetailsState();
}

class _FarmerGoogleMapDetailsState extends State<FarmerGoogleMapDetailss> {
  List<Farmermobile> farmerprofile = [];
  List<FarmerAccuastionPlotmaping> farmerdarafromacuation = [];
  Position? _currentLocation;
  List<Polygronclass> lists = [];
  bool loading = false;
  bool error = false;
  String errormessage = '';
  TextEditingController farmermobile = new TextEditingController();
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
                                  fontSize: fontheaders,
                                  fontWeight: FontWeight.bold),
                            ),
                            Visibility(
                              visible: widget.fareraccuasation,
                              child: Text(
                                "Acquisition",
                                style: TextStyle(
                                    color: Color.fromRGBO(10, 192, 92, 2),
                                    fontSize: fontheaders,
                                    fontWeight: FontWeight.bold),
                              ),
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
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),

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
                        farmerprofile = [];
                        if (farmermobile.text.trim().length > 9 &&
                            containsOnlyIntegers(farmermobile.text)) {
                          if (widget.fareraccuasation) {
                            getdataFarmeracuastion(farmermobile.text);
                          } else {
                            await getdata(farmermobile.text);
                          }
                          // devicedata = await Devicedata(deviceid.text.trim());
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please Enter Valid Phone Number",
                              backgroundColor: Colors.red);
                        }
                      },
                      child: Text(
                        "Search",
                        style: TextStyle(color: Colors.white, fontSize: 10),
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
                              : widget.fareraccuasation
                                  ? Visibility(
                                      visible:
                                          farmerdarafromacuation.length > 0,
                                      child: SingleChildScrollView(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        top: 20),
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
                                                            farmerdarafromacuation
                                                                        .length >
                                                                    0
                                                                ? farmerdarafromacuation[
                                                                        0]
                                                                    .farmerName
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
                                                            farmerdarafromacuation
                                                                        .length >
                                                                    0
                                                                ? farmerdarafromacuation[
                                                                        0]
                                                                    .mobileNumber
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
                                                          style: iostextstyle(
                                                              fontsize),
                                                        )),
                                                        Center(
                                                            child: Text(
                                                          farmerdarafromacuation
                                                                      .length >
                                                                  0
                                                              ? farmerdarafromacuation[
                                                                      0]
                                                                  .cilintName
                                                                  .toString()
                                                              : "",
                                                          style: iostextstyle(
                                                              fontsize),
                                                        )),
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
                                                          "Village Name:",
                                                          style: iostextstyle(
                                                              fontsize),
                                                        )),
                                                        Center(
                                                            child: Text(
                                                          farmerdarafromacuation
                                                                      .length >
                                                                  0
                                                              ? farmerdarafromacuation[
                                                                      0]
                                                                  .name
                                                                  .toString()
                                                              : "",
                                                          style: iostextstyle(
                                                              fontsize),
                                                        )),
                                                      ]),
                                                ),

                                                // ListView.builder(
                                                //   physics: NeverScrollableScrollPhysics(),
                                                //   itemCount: farmerprofile.length,
                                                //   shrinkWrap: true,
                                                //   itemBuilder: (BuildContext context, int index) {
                                                //     return  Column(
                                                //       children: [
                                                //         Container(
                                                //             margin: EdgeInsets.only(left: 20,right: 20),
                                                //             child: Row(
                                                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //                 children: [
                                                //                   Center(child: Text(farmerprofile[index].expr2.toString())),
                                                //                   Center(child:Text(farmerprofile![index]!.plotArea.toString())),
                                                //
                                                //                 ]
                                                //             )
                                                //         ),
                                                //         SizedBox(height: 5,)
                                                //       ],
                                                //     );
                                                //   },
                                                // ),

                                                Center(
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.black,
                                                        backgroundColor:
                                                            Colors.green),
                                                    onPressed: () async {
                                                      await retrieveLocation();
                                                      lists = [];

                                                      List<AlreadyFarmlands>?
                                                          farmdata =
                                                          await getfarmerallreadyprecentdata(widget
                                                                  .fareraccuasation
                                                              ? farmerdarafromacuation[
                                                                      0]
                                                                  .iD
                                                              : farmerprofile[0]
                                                                  .farmerID);
                                                      if (farmdata!.length >
                                                          0) {
                                                        // Get.to(RotatingMap());
                                                        Get.to(MapScreen(
                                                          accausation: false,
                                                          incerpermission: widget
                                                              .incertpermission,
                                                          data: farmerprofile,
                                                          polygrondata: lists,
                                                          alreadyprcent:
                                                              farmdata,
                                                          isloading: true,
                                                        ));
                                                      } else {
                                                        // print(farmdata!.length);
                                                        final polygronsids =
                                                            await getvillagedata(widget
                                                                    .fareraccuasation
                                                                ? farmerdarafromacuation[
                                                                        0]
                                                                    .villageID
                                                                : farmerprofile[
                                                                        0]
                                                                    .villageID);
                                                        print(polygronsids);
                                                        if (polygronsids
                                                                .length >
                                                            0) {
                                                          final polyfrolist2kmdata =
                                                              await sendIntArray(
                                                                  polygronsids);
                                                          print(
                                                              "data ${polyfrolist2kmdata}");

                                                          for (int j = 0;
                                                              j <
                                                                  polyfrolist2kmdata
                                                                      .length;
                                                              j++) {
                                                            if (lists.isEmpty) {
                                                              lists.add(Polygronclass(
                                                                  id: polyfrolist2kmdata[
                                                                          j]
                                                                      .polygonID,
                                                                  latlist: [
                                                                    LatLng(
                                                                        polyfrolist2kmdata[j]
                                                                            .latitude!
                                                                            .toDouble(),
                                                                        polyfrolist2kmdata[j]
                                                                            .longitude!
                                                                            .toDouble())
                                                                  ]));
                                                            } else {
                                                              if (hasId(
                                                                  polyfrolist2kmdata[
                                                                          j]
                                                                      .polygonID!
                                                                      .toInt())) {
                                                                lists.forEach(
                                                                    (element) {
                                                                  if (element
                                                                          .id ==
                                                                      polyfrolist2kmdata[
                                                                              j]
                                                                          .polygonID) {
                                                                    element.latlist.add(LatLng(
                                                                        polyfrolist2kmdata[j]
                                                                            .latitude!
                                                                            .toDouble(),
                                                                        polyfrolist2kmdata[j]
                                                                            .longitude!
                                                                            .toDouble()));
                                                                  }
                                                                });
                                                              } else {
                                                                lists.add(Polygronclass(
                                                                    id: polyfrolist2kmdata[
                                                                            j]
                                                                        .polygonID,
                                                                    latlist: [
                                                                      LatLng(
                                                                          polyfrolist2kmdata[j]
                                                                              .latitude!
                                                                              .toDouble(),
                                                                          polyfrolist2kmdata[j]
                                                                              .longitude!
                                                                              .toDouble())
                                                                    ]));
                                                              }
                                                            }
                                                          }
                                                          lists.forEach(
                                                              (element) {
                                                            print(
                                                                "elements id ${element.id}");
                                                          });
                                                          // Get.to(RotatingMap());
                                                          Get.to(MapScreen(
                                                            accausation: false,
                                                            incerpermission: widget
                                                                .incertpermission,
                                                            data: farmerprofile,
                                                            polygrondata: lists,
                                                            isloading: false,
                                                            alreadyprcent: [],
                                                          ));
                                                        } else {
                                                          // Get.to(RotatingMap());
                                                          Get.to(MapScreen(
                                                            accausation: false,
                                                            incerpermission: widget
                                                                .incertpermission,
                                                            data: farmerprofile,
                                                            polygrondata: [],
                                                            isloading: false,
                                                            alreadyprcent: [],
                                                          ));
                                                        }
                                                      }
                                                    },
                                                    child: Text(
                                                      "Map",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                    )
                                  : Visibility(
                                      visible: farmerprofile.length > 0,
                                      child: SingleChildScrollView(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        top: 20),
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
                                                            farmerprofile
                                                                        .length >
                                                                    0
                                                                ? farmerprofile[
                                                                        0]
                                                                    .name
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
                                                            farmerprofile
                                                                        .length >
                                                                    0
                                                                ? farmerprofile[
                                                                        0]
                                                                    .mobileNumberPrimary
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
                                                          style: iostextstyle(
                                                              fontsize),
                                                        )),
                                                        Center(
                                                            child: Text(
                                                          farmerprofile.length >
                                                                  0
                                                              ? farmerprofile[0]
                                                                  .clintname
                                                                  .toString()
                                                              : "",
                                                          style: iostextstyle(
                                                              fontsize),
                                                        )),
                                                      ]),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      farmerprofile.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Column(
                                                      children: [
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 20),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Center(
                                                                      child:
                                                                          Text(
                                                                    farmerprofile[
                                                                            index]
                                                                        .expr2
                                                                        .toString(),
                                                                    style: iostextstyle(
                                                                        fontsize),
                                                                  )),
                                                                  Center(
                                                                      child:
                                                                          Text(
                                                                    farmerprofile[
                                                                            index]
                                                                        .plotArea
                                                                        .toString(),
                                                                    style: iostextstyle(
                                                                        fontsize),
                                                                  )),
                                                                ])),
                                                        SizedBox(
                                                          height: 5,
                                                        )
                                                      ],
                                                    );
                                                  },
                                                ),

                                                Center(
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.black,
                                                        backgroundColor:
                                                            Colors.green),
                                                    onPressed: () async {
                                                      await retrieveLocation();
                                                      lists = [];

                                                      List<AlreadyFarmlands>?
                                                          farmdata =
                                                          await getfarmerallreadyprecentdata(
                                                              farmerprofile[0]
                                                                  .farmerID);
                                                      if (farmdata!.length >
                                                          0) {
                                                        // Get.to(RotatingMap());
                                                        Get.to(MapScreen(
                                                          accausation: false,
                                                          incerpermission: widget
                                                              .incertpermission,
                                                          data: farmerprofile,
                                                          polygrondata: lists,
                                                          alreadyprcent:
                                                              farmdata,
                                                          isloading: true,
                                                        ));
                                                      } else {
                                                        // print(farmdata!.length);
                                                        final polygronsids =
                                                            await getvillagedata(
                                                                farmerprofile[0]
                                                                    .villageID);
                                                        print(polygronsids);
                                                        if (polygronsids
                                                                .length >
                                                            0) {
                                                          final polyfrolist2kmdata =
                                                              await sendIntArray(
                                                                  polygronsids);
                                                          print(
                                                              "data ${polyfrolist2kmdata}");

                                                          for (int j = 0;
                                                              j <
                                                                  polyfrolist2kmdata
                                                                      .length;
                                                              j++) {
                                                            if (lists.isEmpty) {
                                                              lists.add(Polygronclass(
                                                                  id: polyfrolist2kmdata[
                                                                          j]
                                                                      .polygonID,
                                                                  latlist: [
                                                                    LatLng(
                                                                        polyfrolist2kmdata[j]
                                                                            .latitude!
                                                                            .toDouble(),
                                                                        polyfrolist2kmdata[j]
                                                                            .longitude!
                                                                            .toDouble())
                                                                  ]));
                                                            } else {
                                                              if (hasId(
                                                                  polyfrolist2kmdata[
                                                                          j]
                                                                      .polygonID!
                                                                      .toInt())) {
                                                                lists.forEach(
                                                                    (element) {
                                                                  if (element
                                                                          .id ==
                                                                      polyfrolist2kmdata[
                                                                              j]
                                                                          .polygonID) {
                                                                    element.latlist.add(LatLng(
                                                                        polyfrolist2kmdata[j]
                                                                            .latitude!
                                                                            .toDouble(),
                                                                        polyfrolist2kmdata[j]
                                                                            .longitude!
                                                                            .toDouble()));
                                                                  }
                                                                });
                                                              } else {
                                                                lists.add(Polygronclass(
                                                                    id: polyfrolist2kmdata[
                                                                            j]
                                                                        .polygonID,
                                                                    latlist: [
                                                                      LatLng(
                                                                          polyfrolist2kmdata[j]
                                                                              .latitude!
                                                                              .toDouble(),
                                                                          polyfrolist2kmdata[j]
                                                                              .longitude!
                                                                              .toDouble())
                                                                    ]));
                                                              }
                                                            }
                                                          }
                                                          lists.forEach(
                                                              (element) {
                                                            print(
                                                                "elements id ${element.id}");
                                                          });
                                                          // Get.to(RotatingMap());
                                                          Get.to(MapScreen(
                                                            accausation: false,
                                                            incerpermission: widget
                                                                .incertpermission,
                                                            data: farmerprofile,
                                                            polygrondata: lists,
                                                            isloading: false,
                                                            alreadyprcent: [],
                                                          ));
                                                        } else {
                                                          // Get.to(RotatingMap());
                                                          Get.to(MapScreen(
                                                            accausation: false,
                                                            incerpermission: widget
                                                                .incertpermission,
                                                            data: farmerprofile,
                                                            polygrondata: [],
                                                            isloading: false,
                                                            alreadyprcent: [],
                                                          ));
                                                        }
                                                      }
                                                    },
                                                    child: Text(
                                                      "Map",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                    ))
                ])));
  }

  bool hasId(int id) {
    return lists.any((polygron) => polygron.id == id);
  }

  Future<List<Twokimradiusdata>> sendIntArray(array) async {
    List<Twokimradiusdata> Twokilomiterdata = [];

    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var body = {
      "listpolygronsid": array,
      "villageId": farmerprofile[0].villageID
    };
    final dio = Dio();
    final response = await dio.post(
        'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/farmermap/2kmdata',
        options: Options(headers: header),
        data: body,
        queryParameters: {});

    if (response.statusCode == 200) {
      if (response.data['susess']) {
        print(response.data['data']);
        final responcedata = response.data['data'];
        for (int i = 0; i < responcedata.length; i++) {
          Twokilomiterdata.add(Twokimradiusdata(
            latitude: responcedata[i]['Latitude'],
            longitude: responcedata[i]['Longitude'],
            polygonID: responcedata[i]['PolygonID'],
            villageID: responcedata[i]['VillageID'],
          ));
        }
        return Twokilomiterdata;
      }
      return Twokilomiterdata;
      print('Array sent successfully!');
    } else {
      return Twokilomiterdata;
      print('Error sending array. Status code: ${response.statusCode}');
    }
  }

  Future getdata(devicid) async {
    List<Farmermobile> farmerdata = [];
    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var path = "";
    path =
        "http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/farmermap/profile/$devicid";
    print(path);
    final dio = Dio();
    try {
      setState(() {
        loading = true;
      });
      final response = await dio
          .get(path, options: Options(headers: header), queryParameters: {});
      if (response.statusCode == 200) {
        if (response.data['success'] != false) {
          // print();
          if (response.data['data'].length > 0) {
            setState(() {
              error = false;
              errormessage = '';
            });
            for (int i = 0; i < response.data['data'].length; i++) {
              Farmermobile deviceQueryModel =
                  Farmermobile.fromJson(response.data['data'][i]);
              farmerprofile.add(deviceQueryModel);
            }
            return farmerdata;
          } else {
            setState(() {
              error = true;
              errormessage = 'Farmer Master Not found\nContact Cultyvate';
            });
            print("null datat ");
          }
        } else {
          return null;
        }
        // print(returnData);
      }
    } catch (e) {
      print("error is :$e");
      Fluttertoast.showToast(
          msg: 'Cannot get requested data, please try later: ${e.toString()}');
      print("error ios :" + e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
    // return returnData;
  }

  Future getdataFarmeracuastion(mobilenumber) async {
    List<Farmermobile> farmerdata = [];
    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var path = "";
    path =
        "http://192.168.199.1:8085/api/farm2fork/farmermap/farmerplotmappingfarmeraccuatuon/$mobilenumber";
    //  path ="http://192.168.199.1:8085/api/farm2fork/farmermap/profile/$devicid";
    // path="http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid/HardwareSerialNumber";

    // 'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid';
    print(path);
    final dio = Dio();
    try {
      setState(() {
        loading = true;
      });
      final response = await dio
          .get(path, options: Options(headers: header), queryParameters: {});
      if (response.statusCode == 200) {
        if (response.data['success'] != false) {
          // print(response.data['data']);
          if (response.data['data'].length > 0) {
            setState(() {
              error = false;
              errormessage = '';
            });
            for (int i = 0; i < response.data['data'].length; i++) {
              // print(response.data['data'][i]);
              FarmerAccuastionPlotmaping deviceQueryModel =
                  FarmerAccuastionPlotmaping.fromJson(response.data['data'][i]);
              print(deviceQueryModel.mobileNumber);
              farmerdarafromacuation.add(deviceQueryModel);
            }
            return farmerdata;
          } else {
            setState(() {
              error = true;
              errormessage = 'Farmer Master Not found\nContact Cultyvate';
            });
            print("null datat ");
          }
        } else {
          return null;
        }
        // print(returnData);
      }
    } catch (e) {
      print("error is :$e");
      Fluttertoast.showToast(
          msg: 'Cannot get requested data, please try later: ${e.toString()}');
      print("error ios :" + e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
    // return returnData;
  }

  double calculateDistance(
      {required double startLatitude,
      required double startLongitude,
      required double endLatitude,
      required double endLongitude}) {
    double distanceInMeters = Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );

    // Convert distance from meters to kilometers
    double distanceInKm = distanceInMeters / 1000;
    print("km ${distanceInKm}");
    return distanceInKm;
  }

// Future getFarmefarmlanddetails(FarmerID) async {
//   List <int> Polygronsids=[];
//   Map<String, String> header = {
//     "content-type": "application/json",
//     "API_KEY": "12345678"
//   };
//   var path="";
//   path ="http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/farmermap/featchfarmland/$FarmerID";
//
//   // path="http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid/HardwareSerialNumber";
//
//   // 'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid';
//   print("path ${path}");
//   final dio = Dio();
//   try {
//
//     final response =
//     await dio.get(path,  options: Options(headers: header),queryParameters: {});
//     if (response.statusCode == 200) {
//
//       if(response.data['success'] != false){
//         for (int i = 0; i < response.data['data'].length; i++) {
//           final values=response.data['data'][i];
//           // 11.134126262,"Longitude":77.7804585859
//
//           final distance= calculateDistance(startLatitude:29.9244884332,startLongitude: 75.6255605150,endLatitude:values['Latitude'] ,endLongitude:values['Longitude']);
//           // final distance= calculateDistance(startLatitude:_currentLocation!.latitude,startLongitude: _currentLocation!.longitude,endLatitude:values['Latitude'] ,endLongitude:values['Longitude']);
//           print("distance ${distance}");
//           if(distance<2){
//             Polygronsids.add(values['PolygonID']);
//           }
//         }
//         Polygronsids.forEach((element) {
//           print(element);
//         });
//         return Polygronsids ;
//       }
//       else {
//         return null;
//       }
//       // print(returnData);
//     }
//   } catch (e) {
//     print("error is :$e");
//     Fluttertoast.showToast(
//         msg: 'Cannot get requested data, please try later: ${e.toString()}');
//     print("error ios :"+e.toString());
//   }
//   finally{
//     setState(() {
//       loading=false;
//     });
//   }
//   // return returnData;
// }
  bool containsOnlyIntegers(String text) {
    final regex = RegExp(r'^\d+$');
    return regex.hasMatch(text);
  }

  Future<void> retrieveLocation() async {
    pkgLocation.Location location = pkgLocation.Location();
    bool serviceEnabled;
    pkgLocation.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Handle the case when the user doesn't enable the location service.
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == pkgLocation.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != pkgLocation.PermissionStatus.granted) {
        // Handle the case when the user doesn't grant location permissions.
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = position;
    });
    print("current position ${_currentLocation!.latitude}");
  }

  Future getvillagedata(villageid) async {
    List<int> Polygronsids = [];
    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var path = "";
    path =
        "http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/farmermap/villagefirstcordinates/$villageid";

    // path="http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid/HardwareSerialNumber";

    // 'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid';
    print(path);
    final dio = Dio();
    try {
      final response = await dio
          .get(path, options: Options(headers: header), queryParameters: {});
      if (response.statusCode == 200) {
        if (response.data['success'] != false) {
          for (int i = 0; i < response.data['data'].length; i++) {
            final values = response.data['data'][i];
            // , 78.014167
            // final distance= calculateDistance(startLatitude: 11.073572,startLongitude: 78.014167,endLatitude:values['Latitude'] ,endLongitude:values['Longitude']);
            final distance = calculateDistance(
                startLatitude: _currentLocation!.latitude,
                startLongitude: _currentLocation!.longitude,
                endLatitude: values['Latitude'],
                endLongitude: values['Longitude']);
            print("distance ${distance}");
            if (distance < 4) {
              Polygronsids.add(values['PolygonID']);
            }
          }
          Polygronsids.forEach((element) {
            print(element);
          });
          return Polygronsids;
        } else {
          return null;
        }
        // print(returnData);
      }
    } catch (e) {
      print("error is :$e");
      Fluttertoast.showToast(
          msg: 'Cannot get requested data, please try later: ${e.toString()}');
      print("error ios :" + e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
    // return returnData;
  }

  Future<List<AlreadyFarmlands>?> getfarmerallreadyprecentdata(FarmerID) async {
    List<AlreadyFarmlands> Polygronsids = [];
    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var path = "";
    path =
        "http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/farmermap/featchfarmland/$FarmerID";

    // path="http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid/HardwareSerialNumber";

    // 'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid';
    print(path);
    final dio = Dio();
    try {
      final response = await dio
          .get(path, options: Options(headers: header), queryParameters: {});
      if (response.statusCode == 200) {
        if (response.data['success'] != false) {
          // print(response.data);
          for (int i = 0; i < response.data['data'].length; i++) {
            final values = response.data['data'][i];
            print(values);
            Polygronsids.add(AlreadyFarmlands(
                iD: values["ID"],
                creatDate: values["CreatDate"],
                farmerID: values["FarmerID"],
                farmLandName: values["FarmLandName"],
                polygonBoundaryes: values["PolygonBoundaryes"],
                totalAreaInSqMeter: values["TotalAreaInSqMeter"].toDouble(),
                sensorlang: values['sensorlang'].toDouble(),
                sensorlat: values['sensorlat'].toDouble(),
                SensorType: values['SensorType'],
                Under: values['Under']));
            // print(values);
            //
            // return Polygronsids ;
          }
          return Polygronsids;
        } else {
          return Polygronsids;
        }
        // print(returnData);
      }
    } catch (e) {
      print("error is :$e");
      Fluttertoast.showToast(
          msg: 'Cannot get requested data, please try later: ${e.toString()}');
      print("error ios :" + e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
    // return returnData;
  }
}

class PolygrontIDs {
  int polyid;
  int villageID;
  PolygrontIDs({required this.polyid, required this.villageID});
}

class Polygronclass {
  int? id;
  List<LatLng> latlist = [];
  Polygronclass({this.id, required this.latlist});
}
