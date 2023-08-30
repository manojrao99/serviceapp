// //
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:camera/camera.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:permission_handler/permission_handler.dart' as permission;
// import 'package:geolocator/geolocator.dart';
import 'package:screenshot/screenshot.dart';
import 'package:http/http.dart' as http;
// import 'package:connectivity/connectivity.dart';
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
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
// import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resize/resize.dart';
import '/Screens/Deviceexamination.dart';
import '/Screens/farmerAccusation/Farmeraccasation.dart';
import '/models/Utility.dart';
// import 'package:screenshot/screenshot.dart';
import 'package:photo_view/photo_view.dart';
import '../sqllite/Db_helper/camera.dart';
import '../sqllite/Db_helper_model/cameramodel.dart';
// class LocationCamera extends StatefulWidget {
//   int Farmerid;
//   int FieldofficerId;
//   String ?from;
//   int FieldmanagerID;
//   LocationCamera({this.from,required this.Farmerid,required this.FieldmanagerID,required this.FieldofficerId});
//
//   @override
//   State<LocationCamera> createState() => _LocationCameraState();
// }
//
// class _LocationCameraState extends State<LocationCamera>  with TickerProviderStateMixin {
//   final camerahelper = Camera_sqllite_database.instance;
//   CameraController ?controller;
//   XFile? capturedFile;
//   Location ?location;
//   bool savelocally = false;
//   Position ?mylocation;
//   bool preview = false;
//   bool clickcapture = false;
//   GoogleMapController ?mapController;
//   Uint8List ? ai;
//
//   ScreenshotController screenshotController = ScreenshotController();
//   double _zoom = 15;
//   String shortaddress = '',
//       mainadress = '',
//       clickdate = '';
//   List ?cameras;
//   CameraPosition ?initialcameraposition;
//   bool isPrecessing = false;
//   bool is_loading = false;
//   bool caapthured = false;
//   Uint8List? capturedimage;
//   FlashMode ?falsh;
//   bool flash = false;
//   int ?selectedCameraIdx = 0;
//   bool _isFrontCamera = false;
//
//   @override
//   void initState() {
//     myloc1();
//     initializeCamera();
//
//
//     super.initState();
//
//     // availableCameras().then((availableCameras) {
//     //   cameras = availableCameras;
//     //   _initCameraController(cameras!.first).then((void v) {});
//     //   if (cameras!.length > 0) {
//     //     setState(() {
//     //       selectedCameraIdx = 0;
//     //     });
//     //     CameraDescription selectedCamera = cameras![0];
//     //     _initCameraController(selectedCamera);
//     //   } else {
//     //     print("No camera available");
//     //   }
//     // }).catchError((err) {
//     //   print('Error manojj: $err.code\nError Message: $err.message');
//     // });
//   }
//
//   Future<bool> check() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.mobile) {
//       return true;
//     } else if (connectivityResult == ConnectivityResult.wifi) {
//       return true;
//     }
//     return false;
//   }
//
//   bool _isCameraPermissionRequestOngoing = false;
//
//   Future<bool> _requestCameraPermissions() async {
//     final status = await Permission.camera.request();
//
//     if (status.isGranted) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   Future<void> initializeCamera() async {
//
//    try{
//      setState(() {
//        preview=true;
//      });
//      final cameras = await availableCameras();
//      CameraDescription cameraToUse;
//      if (cameras.length > 0) {
//        cameraToUse = _isFrontCamera ? cameras[1] : cameras[0];
//        controller = CameraController(cameraToUse, ResolutionPreset.high);
//        await controller!.initialize();
//      }
//    }
//    catch(e){
//
//    }
//    finally{
//      setState(() {
//        preview=false;
//      });
//    }
//   }
//
//
//   Future _initCameraController(CameraDescription cameraDescription) async {
//     print("camera position $cameraDescription");
//     setState(() {
//       isPrecessing = true;
//     });
//
//     try {
//       controller = CameraController(cameraDescription, ResolutionPreset.high);
//
//       controller?.addListener(() {
//         if (mounted) {
//           setState(() {});
//         }
//
//         if (controller!.value.hasError) {
//           print('Camera error: ${controller!.value.errorDescription}');
//         }
//       });
//
//       await controller!.initialize();
//
//       setState(() {
//         isPrecessing = false;
//       });
//     } catch (e) {
//       print('Error initializing camera: $e');
//       setState(() {
//         isPrecessing = false;
//       });
//     }
//   }
//
//   // Future _initCameraController(CameraDescription cameraDescription) async {
//   //   print("camera posittion $cameraDescription ");
//   //   setState(() {
//   //     isPrecessing = true;
//   //   });
//   //
//   //
//   //   controller = CameraController(cameraDescription, ResolutionPreset.high);
//   //
//   //   controller?.addListener(() {
//   //     if (mounted) {
//   //       setState(() {});
//   //     }
//   //
//   //     if (controller!.value.hasError) {
//   //       print('Camera error ${controller!.value.errorDescription}');
//   //     }
//   //   });
//   //
//   //   try {
//   //     await controller!.initialize();
//   //   } on CameraException catch (e) {
//   //     print("camera exception $e");
//   //     // _showCameraException(e);
//   //   }
//   //
//   //   if (mounted) {
//   //     setState(() {
//   //       isPrecessing = false;
//   //     });
//   //   }
//   // }
//   void _onSwitchCamera() async {
//     setState(() {
//       _isFrontCamera = !_isFrontCamera;
//       controller!.dispose();
//       initializeCamera();
//     });
//   }
//   Future Postdata(phonenumberone, row, context) async {
//     Map<String, String> header = {
//       "content-type": "application/json",
//       "API_KEY": "12345678"
//     };
//     var path = 'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/Imagepost/post';
//     // var  path= 'http://192.168.1.10:8085/api/farm2fork/Imagepost/post';
//     print(path);
//     final dio = Dio();
//     Map<String, dynamic> returnData = {};
//     try {
//       final response =
//       await dio.post(path, data: phonenumberone,
//           options: Options(headers: header),
//           queryParameters: {});
//       print("responcasklfme ${response.data}");
//       if (response.statusCode == 200) {
//         if (widget.from == 'Farmeraccasation') {
//           setState(() {
//             print('manoj' + response.data['data'][0]['ImageNV']);
//             FarmeracusationState.instance!.imagesid.add(
//                 response.data['data'][0]['ID'].toString());
//             String image = response.data['data'][0]['ImageNV'];
//             FarmeracusationState.instance!.images.add(base64.decode(image));
//           });
//         }
//         print(response.data);
//         Fluttertoast.showToast(
//             backgroundColor: Colors.green,
//             textColor: Colors.black,
//             msg: "Image Upload successfully");
//         Navigator.pop(context);
//         return response.statusCode;
//         returnData = response.data;
//       }
//       else {
//         return response.statusCode;
//       }
//     } catch (e) {
//       print("error one is ${e}");
//       Fluttertoast.showToast(
//           msg: 'Cannot post  data, please try later: ${e.toString()}');
//     }
//     return returnData;
//   }
//
//
//
//   Future<Widget> imagewithlocation(ctx, File _image, File map) async {
//     return Stack(
//       children: [
//         Image.file(
//           _image,
//           height: MediaQuery
//               .of(context)
//               .size
//               .height,
//           width: MediaQuery
//               .of(context)
//               .size
//               .width,
//         ),
//         Positioned(
//           bottom: 5,
//           child: Row(
//             children: [
//               Column(
//                 children: [
//                   Container(
//
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(
//                           width: 2,
//                           color: Colors.grey,
//                         ),
//                         borderRadius: BorderRadius.circular(10)),
//                     width: MediaQuery
//                         .of(ctx)
//                         .size
//                         .width * 0.28,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(9),
//                       child: Image.file(
//                         map,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                     height: 150,
//                   )
//                 ],
//               ),
//               Container(
//                 height: 150,
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                       width: 2,
//                       color: Colors.grey,
//                     ),
//                     color: Colors.black87,
//                     borderRadius: BorderRadius.circular(10)),
//                 padding: const EdgeInsets.only(left: 5.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(shortaddress,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                             fontSize: 16)),
//                     Text(mainadress,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           color: Colors.white,
//                           fontSize: 12,
//                         )),
//                     Text(
//                         'Lat "${mylocation?.latitude}" Long "${mylocation
//                             ?.longitude}"',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w300,
//                           color: Colors.white,
//                           fontSize: 12,
//                         )),
//                     Text(
//                         '${DateFormat('EEEE, d MMM, yyyy, h:mm:ss a').format(
//                             DateTime.now())}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w300,
//                           color: Colors.white,
//                           fontSize: 12,
//                         )),
//                   ],
//                 ),
//
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//   Future getAddressFromCoordinates(LatLng position) async {
//     final url =
//         'https://nominatim.openstreetmap.org/reverse?format=json&lat=${position
//         .latitude}&lon=${position.longitude}&zoom=18&addressdetails=1';
//
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         // setState(() {
//         var datarempce = formatAddress(data);
//         String modifiedString = datarempce.replaceAll('{', '').replaceAll(
//             '}', '');
//         return modifiedString;
//         // Get.to(CameraScreen());
//         // });
//       } else {
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       return e.toString();
//       print('Error: $e');
//     }
//     finally {
//       setState(() {
//         is_loading = false;
//       });
//     }
//   }
//   Widget _cameraTogglesRowWidget(BuildContext ctx) {
//     // if (cameras == null || cameras!.isEmpty) {
//     //   return Spacer();
//     // }
//     print(_isFrontCamera);
//     // CameraDescription selectedCamera = cameras?[0];
//     // print("selected camera ${selectedCamera}");
//     // CameraLensDirection lensDirection = selectedCamera.lensDirection;
//
//     return Padding(
//       padding: const EdgeInsets.all(0.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           preview == false ? ElevatedButton.icon(
//               onPressed: isPrecessing
//                   ? null
//                   : () {
//                 _onSwitchCamera();
//               },
//               icon: Icon(
//                 _isFrontCamera ? Icons.camera_rear : Icons.camera_front,
//                 size: 35,
//               ),
//               label: Text(_isFrontCamera ? "Back" : "Front")
//             // "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)=="front"?"back":"front"}"),
//           ) :
//           ElevatedButton.icon(
//             onPressed: isPrecessing
//                 ? null
//                 : () async {
//               var dataone = {
//                 "farmerID": widget.Farmerid == 0 ? null : widget.Farmerid,
//                 "FieldOfficerID": widget.FieldofficerId == 0 ? null : widget
//                     .FieldofficerId,
//                 "FieldmanagerID": widget.FieldmanagerID == 0 ? null : widget
//                     .FieldmanagerID,
//                 "image": null,
//                 "imagenv": base64Url.encode(capturedimage!),
//                 "Latitude": mylocation!.latitude,
//                 "Longtitude": mylocation!.longitude,
//               };
//               Map<String, dynamic> row = {
//                 Camera_sqllite_database.columnfarmerID: widget.Farmerid == 0
//                     ? null
//                     : widget.Farmerid,
//                 Camera_sqllite_database.columnFieldmanagerID: widget
//                     .FieldmanagerID == 0 ? null : widget.FieldmanagerID,
//                 Camera_sqllite_database.columnFieldOfficerID: widget
//                     .FieldofficerId == 0 ? null : widget.FieldofficerId,
//                 Camera_sqllite_database.columnimagenv: base64Url.encode(
//                     capturedimage!),
//                 Camera_sqllite_database.columLatitude: mylocation!.latitude,
//                 Camera_sqllite_database.columLongtitude: mylocation!.longitude
//               };
//               check().then((intenet) async {
//                 if (intenet != null && intenet) {
//                   await Postdata(dataone, row, context);
//                 }
//                 else {
//                   await camerahelper.cratepostdatatable();
//                   Cameramodel camera = Cameramodel
//                       .fromMap(row);
//                   var z = await camerahelper.insert(camera);
//                   if (z == z.toInt()) {
//                     if (widget.from == 'Farmeraccasation') {
//                       setState(() {
//                         FarmeracusationState.instance!.imagesid.add(
//                             z.toString());
//                         String image = camera.imagenv.toString();
//                         FarmeracusationState.instance!.images.add(
//                             base64.decode(image));
//                       });
//                     }
//                     Fluttertoast.showToast(
//                         msg: 'Saved successfully in local database');
//                     Navigator.pop(context);
//                   }
//                 }
//               }
//               );
//             },
//             icon: Icon(
//               Icons.save,
//               size: 35,
//             ),
//             label: Text('Save'),
//           ),
//           // Spacer(),
//           ElevatedButton.icon(
//             onPressed: isPrecessing
//                 ? null
//                 : () async {
//               if (!preview) {
//                 capturedFile = await controller!.takePicture();
//                 print("captured file ${capturedFile}");
//                 setState(() {
//                   clickcapture = true;
//                   caapthured = true;
//                   // isPrecessing=true;
//                 });
//                 ai = await mapController?.takeSnapshot();
//                 clickdate = '${DateFormat('d-M-y').format(DateTime.now())}';
//                 final ai1 = await File("${capturedFile!.path}2").create();
//                 final file = File(capturedFile!.path);
//
//
//                 String imgString = Utility.base64String(file.readAsBytesSync());
//                 print("imaeg $imgString");
//                 await ai1.writeAsBytes(ai!);
//                 final image1 = await screenshotController.captureFromWidget(
//                     await imagewithlocation(
//                         context, File(capturedFile!.path), ai1),
//                     delay: Duration(seconds: 2));
//                 setState(() {
//                   capturedimage = image1;
//                   caapthured = false;
//                   clickcapture = false;
//                   preview = true;
//                   // isPrecessing=false;
//
//
//                 });
//                 // Navigator.of(context).pop();
//               }
//               else {
//                 setState(() {
//                   preview = !preview;
//                 });
//               }
//             },
//             icon: Icon(
//               preview ? Icons.camera : Icons.save,
//               size: 35,
//             ),
//             label: preview ? Text('Recapture') : Text("capture"),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//
//   Future<bool> myloc1() async {
//     setState(() {
//       is_loading = true;
//     });
//     Permission? permission;
//     permission_handler.PermissionStatus stutus = await Permission.location
//         .request();
//     // permission = await Permission.location.serviceStatus;
//     print(stutus.isGranted);
//     if (stutus.isGranted) {
//       // cam();
//       var permission = await Permission.location.isGranted;
//       print("${permission} permission");
//       if (!permission) {
//         await Permission.location.request();
//         myloc1();
//       } else {
//         final position = await Geolocator.getCurrentPosition();
//         setState(() {
//           mylocation = position;
//         });
//         // getAddressFromCoordinates(LatLng(mylocation!.latitude, mylocation!.longitude));
//
//         // await Location.instance.getLocation().then((value) {
//         //   setState(() {
//         //     mylocation=value;
//         initialcameraposition = CameraPosition(
//           target: LatLng(mylocation!.latitude!, mylocation!.longitude!),
//           zoom: 2,
//         );
//
//
//         print("indial camera $initialcameraposition");
//         final coordinates = new LatLng(mylocation!.latitude!.toDouble(),
//             mylocation!.longitude!.toDouble());
//         // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//         // var first = addresses.first;
//         // print(
//         //     ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
//         // // return first;
//         var address = await getAddressFromCoordinates(coordinates);
//         setState(() {
//           // shortaddress =
//           // '${first.subLocality}, ${first.locality},${first.countryName}';
//           mainadress = '${address}';
//         });
//       }
//     } else {
//       await Location().requestService();
//       if (stutus.isGranted) {
//         myloc1();
//       }
//       // else {
//       //   Navigator.pop(context);
//       // }
//     }
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//     body:
//       isPrecessing || preview
//         ?
//     Center(child: CircularProgressIndicator(),)
//         :
//     Column(
//       children: [
//
//        // Container(
//        //   height: MediaQuery.of(context).size.height-100,
//        //   width:MediaQuery.of(context).size.width,
//        //   child: CameraPreview(controller!,
//            child: Stack(
//              children: [
//                Positioned(
//                  top: 30,
//                  left: 15,
//
//                  child: InkWell(
//                    onTap: () async {
//                      setState(() {
//                        flash = !flash;
//
//                        print("flashmode ${FlashMode.always}");
//                      });
//                      await flash
//                          ? controller?.setFlashMode(FlashMode.always)
//                          : controller?.setFlashMode(FlashMode.off);
//                    },
//                    child: Icon(flash ? Icons.flash_auto : Icons.flash_off,
//                      color: Colors.white,),
//                  ),),
//                Positioned(
//                  bottom: 5,
//                  child: Row(
//                    children: [
//                      Container(
//                          height: 20.vh,
//                          width: 40.vw,
//                          color: Colors.grey,
//
//                          child: is_loading ? SizedBox() : GoogleMap(
//                            // initialCameraPosition: _latLng,
//                            zoomControlsEnabled: false,
//                            initialCameraPosition: initialcameraposition!,
//
//                            onMapCreated: (GoogleMapController a) async {
//                              setState(() {
//                                mapController = a;
//                              });
//                            },
//                            myLocationEnabled: true,
//
//                          )
//                      ),
//
//                      Container(
//                        color: Colors.black,
//                        height: 20.vh,
//                        width: 60.vw,
//                        child: Column(
//                          // mainAxisAlignment: MainAxisAlignment.start,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Text(shortaddress, style: TextStyle(
//                                color: Colors.white
//                            ),),
//                            Text(mainadress, style: TextStyle(
//                                color: Colors.white
//                            ),),
//                            Text("Lat ${mylocation?.latitude}",
//                              style: TextStyle(
//                                  color: Colors.white
//                              ),),
//                            Text("Long ${mylocation?.longitude}",
//                              style: TextStyle(
//                                  color: Colors.white
//                              ),)
//                          ],
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//              ],
//            ),
//        //
//        //   ),
//        // ),
//
//         // Expanded(
//         //   child: AspectRatio(
//         //     aspectRatio: controller!.value.aspectRatio,
//         //     child:
//         //   ),
//         // ),
//         // Container(
//         //     height: 100,
//         //     color: Colors.grey,
//         //     child: _cameraTogglesRowWidget(context)
//         // )
//
//         Expanded(
//           // flex: 9,
//           child: AspectRatio(
//             aspectRatio: controller!.value.aspectRatio,
//             child: CameraPreview(controller!),
//           ),
//         ),
//         Expanded(
//           flex: 1, // 10% of the available height
//           child: Container(
//             color: Colors.grey,
//             child: _cameraTogglesRowWidget(context),
//           ),
//         ),
//
//
//
//
//
//
//
//
//
//
//
//   ],
//       // ),
//     ));
// //
// // //              isPrecessing ?Center(child: CircularProgressIndicator(),)
// //                 : Material(
// //               child: SingleChildScrollView(
// //                 child: Container(
// //                   child:clickcapture?Center(
// //                     child: CircularProgressIndicator(),
// //                   ) :Column(
// //                     // alignment: ,
// //                     children: [
// //
// //                       preview?Image.memory(capturedimage!):
// //                       CameraPreview(controller!,
// //                           child: Stack(
// //                             children: [
// //                               Positioned(
// //                                 top:30,
// //                                 left: 15,
// //
// //                                 child: InkWell(
// //                                   onTap: ()async{
// //                                     setState(() {
// //                                       flash=!flash;
// //
// //                                       print("flashmode ${FlashMode.always}");
// //                                     });
// //                                     await flash? controller?.setFlashMode(FlashMode.always):controller?.setFlashMode(FlashMode.off);
// //                                   },
// //                                   child: Icon(flash?Icons.flash_auto:Icons.flash_off,color: Colors.white,),
// //                                 ),),
// //                               Positioned(
// //                                 bottom: 5,
// //                                 child: Row(
// //                                   children: [
// //                                     Container(
// //                                         height: 20.vh,
// //                                         width: 40.vw,
// //                                         color: Colors.grey,
// //
// //                                         child: is_loading ? SizedBox() : GoogleMap(
// //                                           // initialCameraPosition: _latLng,
// //                                           zoomControlsEnabled: false,
// //                                           initialCameraPosition: initialcameraposition!,
// //
// //                                           onMapCreated: (GoogleMapController a) async {
// //                                             setState(() {
// //                                               mapController = a;
// //                                             });
// //                                           },
// //                                           myLocationEnabled: true,
// //
// //                                         )
// //                                     ),
// //
// //                                     Container(
// //                                       color: Colors.black,
// //                                       height: 20.vh,
// //                                       width: 60.vw,
// //                                       child: Column(
// //                                         // mainAxisAlignment: MainAxisAlignment.start,
// //                                         crossAxisAlignment: CrossAxisAlignment.start,
// //                                         children: [
// //                                           Text(shortaddress, style: TextStyle(
// //                                               color: Colors.white
// //                                           ),),
// //                                           Text(mainadress, style: TextStyle(
// //                                               color: Colors.white
// //                                           ),),
// //                                           Text("Lat ${mylocation?.latitude}",
// //                                             style: TextStyle(
// //                                                 color: Colors.white
// //                                             ),),
// //                                           Text("Long ${mylocation?.longitude}",
// //                                             style: TextStyle(
// //                                                 color: Colors.white
// //                                             ),)
// //                                         ],
// //                                       ),
// //                                     )
// //                                   ],
// //                                 ),
// //                               ),
// //                             ],
// //                           )
// //                       ),
// //                       Container(
// //                           height: 100,
// //                           color: Colors.grey,
// //                           child: _cameraTogglesRowWidget(context)
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             );
// //
//
//
//     // Scaffold(
//     //   body: SingleChildScrollView(
//     //     child: Container(
//     //       child: clickcapture||isPrecessing
//     //           ? Center(child: CircularProgressIndicator())
//     //           : Column(
//     //         mainAxisSize: MainAxisSize.max,
//     //         children: [
//     //           preview
//     //               ? Image.memory(capturedimage!)
//     //               : controller != null
//     //               ?
//     //           // Container(
//     //           //   height: MediaQuery.of(context).size.height-100,
//     //           //   // Wrap CameraPreview with Expanded to take available space
//     //           //   child:
//     //     // AspectRatio(
//     //     // aspectRatio: controller.value.aspectRatio,
//     //     //     child:
//     //           AspectRatio(
//     //             aspectRatio: controller!.value.aspectRatio,
//     //             child: CameraPreview(controller!),
//     //           )
//     //             // CameraPreview(controller)
//     //     // )
//     //           // )
//     //               : Container(
//     //             height: MediaQuery.of(context).size.height - 200,
//     //             child: Center(child: Text("Null data")),
//     //           ),
//     //           Container(
//     //             height: 100,
//     //             color: Colors.grey,
//     //             child: _cameraTogglesRowWidget(context),
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //   ),
//     // );
//
//   }
//
// }

class LocationCamera extends StatefulWidget {
  int Farmerid;
  int FieldofficerId;
  String? from;
  int FieldmanagerID;
  LocationCamera(
      {this.from,
      required this.Farmerid,
      required this.FieldmanagerID,
      required this.FieldofficerId});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<LocationCamera> {
  CameraController? _controller;
  bool _isFlashOn = false;
  bool _isFrontCamera = false;
  final camerahelper = Camera_sqllite_database.instance;
  CameraController? controller;
  XFile? capturedFile;
  // Location ?location;
  bool savelocally = false;
  LatLng? mylocation = LatLng(0.0, 0.0);
  bool preview = false;
  bool clickcapture = false;
  GoogleMapController? mapController;
  Uint8List? ai;

  ScreenshotController screenshotController = ScreenshotController();
  double _zoom = 15;
  String shortaddress = '', mainadress = '', clickdate = '';
  List? cameras;
  CameraPosition? initialcameraposition;
  bool isPrecessing = false;
  bool is_loading = false;
  bool caapthured = false;
  Uint8List? capturedimage;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    CameraDescription cameraToUse;
    if (cameras.length > 0) {
      cameraToUse = _isFrontCamera ? cameras[1] : cameras[0];
      _controller = CameraController(cameraToUse, ResolutionPreset.high);
      await _controller!.initialize();
      controller?.setFocusMode(FocusMode.auto);
      controller?.setExposureMode(ExposureMode.auto);
      setState(() {});
    }
  }

  Future Postdata(phonenumberone, row, context) async {
    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var path =
        'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/Imagepost/post';
    // var  path= 'http://192.168.1.10:8085/api/farm2fork/Imagepost/post';
    print(path);
    final dio = Dio();
    Map<String, dynamic> returnData = {};
    try {
      final response = await dio.post(path,
          data: phonenumberone,
          options: Options(headers: header),
          queryParameters: {});
      print("responcasklfme ${response.data}");
      if (response.statusCode == 200) {
        if (widget.from == 'Farmeraccasation') {
          setState(() {
            print('manoj' + response.data['data'][0]['ImageNV']);
            FarmeracusationState.instance!.imagesid
                .add(response.data['data'][0]['ID'].toString());
            String image = response.data['data'][0]['ImageNV'];
            FarmeracusationState.instance!.images.add(base64.decode(image));
          });
        }
        print(response.data);
        Fluttertoast.showToast(
            backgroundColor: Colors.green,
            textColor: Colors.black,
            msg: "Image Upload successfully");
        Navigator.pop(context);
        return response.statusCode;
        returnData = response.data;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print("error one is ${e}");
      Fluttertoast.showToast(
          msg: 'Cannot post  data, please try later: ${e.toString()}');
    }
    return returnData;
  }

  Future<Widget> imagewithlocation(ctx, File _image, File map) async {
    return Stack(
      children: [
        Image.file(
          _image,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          bottom: 5,
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(ctx).size.width * 0.28,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.file(
                        map,
                        fit: BoxFit.fill,
                      ),
                    ),
                    height: 150,
                  )
                ],
              ),
              Container(
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.grey,
                    ),
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Flexible(
                    //   child: Text(
                    //     mainadress,
                    //     maxLines: 4,
                    //     softWrap: true,
                    //     overflow: TextOverflow.ellipsis,
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w400,
                    //       color: Colors.white,
                    //       fontSize: 10,
                    //     ),
                    //   ),
                    // ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          children: [
                            TextSpan(
                              text: mainadress,
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        maxLines: 4,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                        'Lat "${mylocation?.latitude}" Long "${mylocation?.longitude}"',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 12,
                        )),
                    Text(
                        '${DateFormat('EEEE, d MMM, yyyy, h:mm:ss a').format(DateTime.now())}',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future getAddressFromCoordinates(LatLng position) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}&zoom=18&addressdetails=1';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // setState(() {
        var datarempce = formatAddress(data);
        String modifiedString =
            datarempce.replaceAll('{', '').replaceAll('}', '');
        return modifiedString;
        // Get.to(CameraScreen());
        // });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      return e.toString();
      print('Error: $e');
    } finally {
      setState(() {
        is_loading = false;
      });
    }
  }

  // Future<void> _getCurrentLocation() async {
  //   await requestPermissions();
  //   if(statuses?[Permission.location]==PermissionStatus.granted){
  //     try {
  //       setState((){
  //         loading=true;
  //       });
  //
  //       final position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high,
  //       );
  //       setState(() {
  //         _currentPosition = position;
  //       });
  //       getAddressFromCoordinates(position);
  //     } catch (e) {
  //       print('Error getting current location: $e');
  //     }
  //   }
  //   else {
  //     requestPermissions();
  //   }
  //
  // }
  //
  Future<void> getCurrentLocation() async {
    setState(() {
      is_loading = true;
    });

    var permission = await Permission.location.isGranted;
    print("${permission} permission");
    if (!permission) {
      await Permission.location.request();
      getCurrentLocation();
    } else {
      // void _getUserLocation() async {

      // setState(() {
      //   currentPostion = LatLng(position.latitude, position.longitude);
      // });
      // }
      // var location = Location();
      // var location =

      try {
        final data =
            await await GeolocatorPlatform.instance.getCurrentPosition();
        mylocation = LatLng(
          data.latitude,
          data.longitude,
        );
      } catch (e) {
        mylocation = LatLng(0.0, 0.0);
      }
      print("my location is ${mylocation}");
      initialcameraposition = CameraPosition(
        target: LatLng(mylocation!.latitude, mylocation!.longitude),
        zoom: 2,
      );
      var address = await getAddressFromCoordinates(mylocation!);
      mainadress = '${address}';
      // setState(() {
      // shortaddress =
      // '${first.subLocality}, ${first.locality},${first.countryName}';
      setState(() {
        is_loading = false;
      });
    }
  }
  // Future<void> myloc1() async {
  // setState(() {
  // is_loading = true;
  // });
  // Permission? permission;
  // permission_handler.PermissionStatus stutus = await Permission.location
  //     .request();
  // // permission = await Permission.location.serviceStatus;
  // print(stutus.isGranted);
  // if (stutus.isGranted) {
  // // cam();
  //  var permission = await Permission.location.isGranted;
  //  print("${permission} permission");
  //  if (!permission) {
  //  await Permission.location.request();
  //  myloc1();
  //  }
  //  else { print("print before");
  //  Position position = await Geolocator.getCurrentPosition(
  //    desiredAccuracy: LocationAccuracy.high,
  //  );
  //  // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //  // final position = await Geolocator.getCurrentPosition();
  // print("print ${position}");
  //  setState(() {
  //  mylocation = position;
  //  });
  // getAddressFromCoordinates(LatLng(mylocation!.latitude, mylocation!.longitude));

  // await Location.instance.getLocation().then((value) {
  //   setState(() {
  //     mylocation=value;

  // print("indial camera $initialcameraposition");
  // final coordinates = new LatLng(mylocation!.latitude!.toDouble(),
  // mylocation!.longitude!.toDouble());
  // // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  // // var first = addresses.first;
  // // print(
  // //     ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
  // // // return first;
  // var address = await getAddressFromCoordinates(coordinates);
  // setState(() {
  // // shortaddress =
  // // '${first.subLocality}, ${first.locality},${first.countryName}';
  // mainadress = '${address}';
  // });
  // }
  // }
  // else {
  // await Location().requestService();
  // if (stutus.isGranted) {

  // }
  // else {
  //   Navigator.pop(context);
  // }
  // }
  // return true;
  // }

  void _toggleCamera() {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _controller!.dispose();
      initializeCamera();
    });
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      _isFlashOn
          ? _controller!.setFlashMode(FlashMode.torch)
          : _controller!.setFlashMode(FlashMode.off);
    });
  }

  Widget _cameraTogglesRowWidget(BuildContext ctx) {
    // if (cameras == null || cameras!.isEmpty) {
    //   return Spacer();
    // }
    print(_isFrontCamera);
    // CameraDescription selectedCamera = cameras?[0];
    // print("selected camera ${selectedCamera}");
    // CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          preview == false
              ? ElevatedButton.icon(
                  onPressed: isPrecessing
                      ? null
                      : () {
                          _toggleCamera();
                        },
                  icon: Icon(
                    _isFrontCamera ? Icons.camera_rear : Icons.camera_front,
                    size: 35,
                  ),
                  label: Text(_isFrontCamera ? "Back" : "Front")
                  // "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)=="front"?"back":"front"}"),
                  )
              : ElevatedButton.icon(
                  onPressed: isPrecessing
                      ? null
                      : () async {
                          var dataone = {
                            "farmerID":
                                widget.Farmerid == 0 ? null : widget.Farmerid,
                            "FieldOfficerID": widget.FieldofficerId == 0
                                ? null
                                : widget.FieldofficerId,
                            "FieldmanagerID": widget.FieldmanagerID == 0
                                ? null
                                : widget.FieldmanagerID,
                            "image": null,
                            "imagenv": base64Url.encode(capturedimage!),
                            "Latitude": mylocation!.latitude,
                            "Longtitude": mylocation!.longitude,
                          };
                          Map<String, dynamic> row = {
                            Camera_sqllite_database.columnfarmerID:
                                widget.Farmerid == 0 ? null : widget.Farmerid,
                            Camera_sqllite_database.columnFieldmanagerID:
                                widget.FieldmanagerID == 0
                                    ? null
                                    : widget.FieldmanagerID,
                            Camera_sqllite_database.columnFieldOfficerID:
                                widget.FieldofficerId == 0
                                    ? null
                                    : widget.FieldofficerId,
                            Camera_sqllite_database.columnimagenv:
                                base64Url.encode(capturedimage!),
                            Camera_sqllite_database.columLatitude:
                                mylocation!.latitude,
                            Camera_sqllite_database.columLongtitude:
                                mylocation!.longitude
                          };
                          check().then((intenet) async {
                            if (intenet != null && intenet) {
                              await Postdata(dataone, row, context);
                            } else {
                              await camerahelper.cratepostdatatable();
                              Cameramodel camera = Cameramodel.fromMap(row);
                              var z = await camerahelper.insert(camera);
                              if (z == z.toInt()) {
                                if (widget.from == 'Farmeraccasation') {
                                  setState(() {
                                    FarmeracusationState.instance!.imagesid
                                        .add(z.toString());
                                    String image = camera.imagenv.toString();
                                    FarmeracusationState.instance!.images
                                        .add(base64.decode(image));
                                  });
                                }
                                Fluttertoast.showToast(
                                    msg:
                                        'Saved successfully in local database');
                                Navigator.pop(context);
                              }
                            }
                          });
                        },
                  icon: Icon(
                    Icons.save,
                    size: 35,
                  ),
                  label: Text('Save'),
                ),
          // Spacer(),
          ElevatedButton.icon(
            onPressed: isPrecessing
                ? null
                : () async {
                    if (!preview) {
                      capturedFile = await _controller!.takePicture();
                      print("captured file ${capturedFile}");
                      setState(() {
                        clickcapture = true;
                        caapthured = true;
                        // isPrecessing=true;
                      });
                      ai = await mapController?.takeSnapshot();
                      clickdate =
                          '${DateFormat('d-M-y').format(DateTime.now())}';
                      final ai1 = await File("${capturedFile!.path}2").create();
                      final file = File(capturedFile!.path);

                      String imgString =
                          Utility.base64String(file.readAsBytesSync());
                      print("imaeg $imgString");
                      await ai1.writeAsBytes(ai!);
                      final image1 =
                          await screenshotController.captureFromWidget(
                              await imagewithlocation(
                                  context, File(capturedFile!.path), ai1),
                              delay: Duration(seconds: 2));
                      setState(() {
                        capturedimage = image1;
                        caapthured = false;
                        clickcapture = false;
                        preview = true;
                        // isPrecessing=false;
                      });
                      // Navigator.of(context).pop();
                    } else {
                      setState(() {
                        preview = !preview;
                      });
                    }
                  },
            icon: Icon(
              preview ? Icons.camera : Icons.save,
              size: 35,
            ),
            label: preview ? Text('Recapture') : Text("capture"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Camera Example'),
      // ),
      body: clickcapture || isPrecessing
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: preview
                      ? PhotoView(
                          imageProvider: MemoryImage(capturedimage!),
                          backgroundDecoration: BoxDecoration(
                              color:
                                  Colors.black), // Customize background color
                          minScale: PhotoViewComputedScale.contained *
                              0.8, // Minimum scale value
                          maxScale: PhotoViewComputedScale.covered *
                              2.0, // Maximum scale value
                        )
                      : AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: InteractiveViewer(
                            scaleEnabled: true,
                            child: CameraPreview(
                              _controller!,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 30,
                                    left: 15,
                                    child: InkWell(
                                      onTap: () async {
                                        _toggleFlash();
                                      },
                                      child: Icon(
                                        _isFlashOn
                                            ? Icons.flash_auto
                                            : Icons.flash_off,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  // Positioned(
                                  //     bottom: 5,
                                  //     child:
                                  //
                                  // Container(
                                  //   child: Text("data",style: TextStyle(color: Colors.red),),
                                  // )
                                  // )

                                  Positioned(
                                    bottom: 5,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.2, // Set height to 20% of the screen height
                                        child: Row(children: [
                                          Expanded(
                                            flex:
                                                2, // Use 1/4 of the available width (25%)
                                            child: Container(
                                              color: Colors.grey,
                                              child: is_loading
                                                  ? SizedBox()
                                                  : GoogleMap(
                                                      zoomControlsEnabled:
                                                          false,
                                                      initialCameraPosition:
                                                          initialcameraposition!,
                                                      onMapCreated:
                                                          (GoogleMapController
                                                              a) async {
                                                        setState(() {
                                                          mapController = a;
                                                        });
                                                      },
                                                      myLocationEnabled: true,
                                                    ),
                                            ),
                                          ),
                                          Expanded(
                                            flex:
                                                3, // Use 3/4 of the available width (75%)
                                            child: Container(
                                              color: Colors.black,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text(
                                                  //   shortaddress,
                                                  //   style: TextStyle(color: Colors.white),
                                                  // ),
                                                  Text(
                                                    mainadress,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Lat ${mylocation?.latitude}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Long ${mylocation?.longitude}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          //   ],
                                          // ),
                                          // is_loading
                                          //     ? SizedBox()
                                          //     :
                                        ])),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                _cameraTogglesRowWidget(context),
              ],
            ),
    );
  }
}
