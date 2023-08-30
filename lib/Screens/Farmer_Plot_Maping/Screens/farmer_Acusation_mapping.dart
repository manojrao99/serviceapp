import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import '/Screens/Farmer_Plot_Maping/Block/acusation_plot_mapping_bloc.dart';
import '/Screens/Farmer_Plot_Maping/Screens/googlemapmaping.dart';
import '/Screens/Farmer_Plot_Maping/Widgets/rowtextWidgets.dart';
import '/Screens/Farmer_Plot_Maping/cubicforplotmaping/apicalling_alreaddy.dart';
import '/Screens/Farmer_Plot_Maping/cubicforplotmaping/controller_allready_mapping.dart';
import '/Screens/googlemapdraw.dart';
import 'package:location/location.dart' as pkgLocation;
import '/constants.dart';
import '/models/farmlandcordinates.dart';

import '../../../models/farmeraccuationplotmaping.dart';
import '../../../models/farmermapdata.dart';
import '../../../models/twokimradiusdata.dart';

class FarmerGoogleMapDetailsBlock extends StatelessWidget {
  final incertpermission;
  final fareraccuasation;

  const FarmerGoogleMapDetailsBlock(
      {required this.incertpermission, required this.fareraccuasation});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
        // BlocProvider<FormController>(create: (context) => FormController()),
      ],
      child: FarmerGoogleMapDetails(
          fareraccuasation: fareraccuasation,
          incertpermission: incertpermission),
    );
  }
}

class FarmerGoogleMapDetails extends StatefulWidget {
  final incertpermission;
  final fareraccuasation;
  const FarmerGoogleMapDetails(
      {required this.fareraccuasation, required this.incertpermission})
      : super();

  @override
  State<FarmerGoogleMapDetails> createState() => _FarmerGoogleMapDetailsState();
}

class _FarmerGoogleMapDetailsState extends State<FarmerGoogleMapDetails> {
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
    // super.build(context);
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
                          controller: farmermobile,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter Mobile Number',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a value.';
                            } else if (value.length < 10) {
                              return 'Value must have at least 10 digits.';
                            }
                            return null; // Validation passed
                          },
                        )

                        //
                        // TextFormField(
                        //                     // autovalidateMode: AutovalidateMode.onUserInteraction,
                        //                     inputFormatters: [
                        //                       FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                        //                       FilteringTextInputFormatter.deny(
                        //                           RegExp(r'\s')),
                        //                     ],
                        //                     controller: farmermobile,
                        //                     decoration: InputDecoration(
                        //                       labelText:'Mobile Number',
                        //                       labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                        //
                        //                       border: OutlineInputBorder(),
                        //                       // counter: Offstage(),
                        //                     ),
                        //                   ),
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
                          context.read<SearchBloc>().add(FarmerDetailsFeatch(
                              mobilenumber: farmermobile.text));
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
                  BlocConsumer<SearchBloc, SearchState>(
                      listener: (context, state) {
                    print("state is ${state.runtimeType}");
                    if (state is Farmer_Allready_LatlangLoaded) {
                      context
                          .read<SearchBloc>()
                          .add(loadongnothing(results: state.results));
                      Get.to(MapScreen(
                        accausation: true,
                        incerpermission: widget.incertpermission,
                        data: farmerprofile,
                        polygrondata: [],
                        alreadyprcent: state.polygrons,
                        isloading: true,
                      ))?.then((value) => Navigator.pop(context));
                    } else if (state is SearchLoadingDialog) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text('Loading'),
                              content: CircularProgressIndicator(),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close'),
                                ),
                              ]);
                        },
                      );
                    }
                  },
                      // listenWhen: (previous, current) => !(current is Farmer_Allready_LatlangLoaded),
                      // buildWhen: (previous, current)  => previous !=SearchLoaded,

                      builder: (context, state) {
                    if (state is SearchInitial) {
                      return Container();
                    } else if (state is SearchLoading) {
                      return Container(
                          height: MediaQuery.of(context).size.height - 300,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ));
                    } else if (state is SearchError) {
                      return Container(
                        height: MediaQuery.of(context).size.height - 300,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Image.asset(
                              'assets/images/paper.png',
                              height:
                                  MediaQuery.of(context).size.aspectRatio * 600,
                            ),
                            Text(
                              state.error,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                          // child: ,
                        ),
                      );
                    } else if (state is SearchLoaded) {
                      return Container(
                        child: SingleChildScrollView(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RowTextWidget(
                                    headerName: "Farmer Name:",
                                    outputName: state.results.farmerName,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RowTextWidget(
                                    headerName: "Mobile Number:",
                                    outputName:
                                        state.results.mobileNumber.toString(),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RowTextWidget(
                                    headerName: "Village Name:",
                                    outputName: state.results.villageName,
                                  ),
                                  Center(
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor: Colors.green),
                                      onPressed: () async {
                                        var latlang = await retrieveLocation();
                                        context.read<SearchBloc>().add(
                                            FarmerAllreadyisthere(
                                                FarmerID: state.results.iD ?? 0,
                                                type: 'FA',
                                                results: state.results,
                                                villageid:
                                                    state.results.villageID,
                                                userlatlang: latlang));
                                      },
                                      child: Text(
                                        "Map",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      );
                    } else if (state is Farmerloading) {
                      return Container(
                        child: SingleChildScrollView(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RowTextWidget(
                                      headerName: "Farmer Name:",
                                      outputName: state.results.farmerName),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RowTextWidget(
                                    headerName: "Mobile Number:",
                                    outputName:
                                        state.results.mobileNumber.toString(),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RowTextWidget(
                                    headerName: "Village Name:",
                                    outputName: state.results.villageName,
                                  ),
                                  Center(
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor: Colors.green),
                                      onPressed: () async {
                                        var latlang = await retrieveLocation();
                                        context.read<SearchBloc>().add(
                                            FarmerAllreadyisthere(
                                                FarmerID: state.results.iD ?? 0,
                                                type: 'FA',
                                                results: state.results,
                                                villageid:
                                                    state.results.villageID,
                                                userlatlang: latlang));
                                      },
                                      child: Text(
                                        "Map",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      );
                    } else {
                      // if(state is! Farmer_Allready_LatlangLoaded)
                      return Container();
                    }
                  })
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

  Future getvillagedata(villageid) async {
    List<int> Polygronsids = [];
    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var path = "";
    path =
        "http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/farmermap/villagefirstcordinates/$villageid";
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
