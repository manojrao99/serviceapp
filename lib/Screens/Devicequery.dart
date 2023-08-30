// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// // import 'package:dio/dio.dart';
// // import 'package:intl/intl.dart';
// // import '../models/devicequery.dart';
// // class DeviceQuery extends StatefulWidget {
// //   const DeviceQuery({Key? key}) : super(key: key);
// //
// //   @override
// //   State<DeviceQuery> createState() => _DeviceQueryState();
// // }
// //
// // class _DeviceQueryState extends State<DeviceQuery> {
// // List<Devicequerry> devicedata=[];
// // TextEditingController deviceid=new TextEditingController();
// // bool isloading=false;
// // String errormessage="";
// //
// //
// //
// // parsedatetime(String date){
// //   print("date $date");
// //  if(date!="null") {
// //    DateTime givendate = DateTime.parse(date);
// //          if(givendate.year!=1980 && givendate.year!=1900 ) {
// //            String formattedDate = DateFormat('yyyy-MM-dd ,hh:mm a').format(
// //                givendate);
// //            // if(formattedDate.contains('1980')){
// //            //   return "null";
// //            // }
// //            // else{
// //            return formattedDate;
// //          }
// //          else{
// //            return "null";
// //          }
// //  }
// //  else {
// //    return "null";
// //  }
// //
// //   // }
// //
// // }
// //
// //
// //
// // void initState() {
// //   datetimeconvert("2022-08-19T17:23:59");
// //   super.initState();
// // }
// //
// // datetimeconvert(date){
// //   var z=  DateTime.parse(date);
// //   var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(z.toString(), true);
// //
// //
// //   print("actualdate${dateTime.timeZoneName}");
// // }
// //
// // changeTimeTotolocal(dateUtc){
// //   if(dateUtc!="null") {
// //       var date=  DateTime.parse(dateUtc);
// //       print("example date ${date}");
// //       var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date.toString(), true);
// //       print("first date ${dateTime}");
// //
// //       var dateLocal = dateTime.toLocal();
// //       print("local time ${dateLocal}");
// //       if(dateLocal.year!=1980 && dateLocal.year!=1900 ) {
// //         String formattedDate = DateFormat('yyyy-MM-dd ,hh:mm a').format(dateLocal);
// //         // if(formattedDate.contains('1980')){
// //         //   return "null";
// //         // }
// //         // else{
// //         return formattedDate;
// //       }
// //       else{
// //         return "null";
// //       }
// //     }
// //     else {
// //       return "null";
// //     }
// // }
// //
// // Widget DeferanceDateandTine(givendata){
// //   print(givendata);
// //  // var givendate= DateFormat('yyyy-MM-dd ,hh:mm a').format(givendata);
// //   var date=  DateTime.parse(givendata);
// //   print("example date ${date}");
// //   var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date.toString(), true);
// //   print("first date ${dateTime}");
// //
// //   var dateLocal = dateTime.toLocal();
// //   print("date local${dateLocal}");
// //
// //   DateTime example=DateTime.parse(dateLocal.toString());
// //   final time = DateTime(example.year,example.month,example.day,example.hour,example.minute);
// //   final date2 = DateTime.now();
// //   final duration=date2.difference(time);
// //   final hours=duration.inMinutes;
// //
// //   String t = "";
// //
// //   double Days = (hours /(24*60)).roundToDouble() ;
// //   int daysall=double.parse(Days.toString()).round();
// //   int Hours= ((hours %(24*60)) / 60).round();
// //
// //   int minutes = (hours%(24*60)) % 60;
// //
// //
// //   t =(" $daysall days $Hours hours $minutes minutes");
// // print("Last communicated on:$t");
// //
// //   return Text( "Last communicated on:$t",style:TextStyle( color:blockcolor,color: Colors.red),);
// // }
// // bool statusfalse=false;
// // String Errormessage="";
// //
// //
// //   Future<List<Devicequerry>>Devicedata(devicenumber)async{
// //     setState((){
// //       isloading=true;
// //     });
// //     Map<String, dynamic> response = await getdata(devicenumber);
// //     print("responce is one :${response}");
// //     List<Devicequerry> telematicDataList = [];
// //     try {
// //       if (response.isNotEmpty) {
// //         print("inside try");
// //         print(response['success']);
// //         print(response is List<dynamic>);
// //         if (response['success'] != false) {
// //           for (int i = 0; i < response['data'].length; i++) {
// //             print("error one tweo");
// //             print(response['data'][i]);
// //             Devicequerry deviceQueryModel = Devicequerry.fromJson(response['data'][i]);
// //             // print(deviceQueryModel.aCI1MilliAmps);
// //            try{
// //              telematicDataList.add(deviceQueryModel);
// //
// //            }
// //            catch(e){
// //              print("error is $e");
// //            }
// //           }
// //         }
// //         else{
// //           setState(() {
// //             statusfalse=true;
// //             Errormessage=response['message'];
// //           });
// //         }
// //       }
// //       setState((){
// //         isloading=false;
// //       });
// //
// //       // telematicDataList.followedBy(devicedata.iterator())
// //
// //       return telematicDataList;
// //     }
// //     catch(e){
// //       setState((){
// //         errormessage="Invalid query... ! ";
// //         isloading=false;
// //       });
// //       print("error is $e");
// //       throw e;
// //
// //     }
// //   }
// //
// //
// //
// //   Future getdata(devicid) async {
// //
// //     Map<String, String> header = {
// //       "content-type": "application/json",
// //       "API_KEY": "12345678"
// //     };
// //     var path="";
// //     if(val==1){
// //       // path="http://192.168.199.1:8085/api/farm2fork/devicedata/devices/$devicid/DeviceEUIID";
// //       path="http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid/DeviceEUIID";
// //     }
// //     else{
// //       path="http://192.168.199.1:8085/api/farm2fork/devicedata/devices/$devicid/HardwareSerialNumber";
// //       // path="http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid/HardwareSerialNumber";
// //     }
// //     // 'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid';
// //     print(path);
// //     final dio = Dio();
// //     Map<String, dynamic> returnData = {};
// //     try {
// //       final response =
// //       await dio.get(path,  options: Options(headers: header),queryParameters: {});
// //       if (response.statusCode == 200) {
// //         returnData = response.data;
// //         print(returnData);
// //       }
// //     } catch (e) {
// //       print("error is :$e");
// //       Fluttertoast.showToast(
// //           msg: 'Cannot get requested data, please try later: ${e.toString()}');
// //       print("error ios :"+e.toString());
// //     }
// //     return returnData;
// //   }
// //
// //   Widget Paddinglistview({required String tesxtname ,required String textValue}){
// //
// //   return Padding(padding: EdgeInsets.all(5),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceAround,
// //         children: [
// //           Text(tesxtname),
// //           Spacer(),
// //           Text(textValue),
// //         ],
// //     ),
// //   );
// //
// //   }
// //
// //   Widget Textdata(Devicequerry data){
// //
// //       if(data.devicetype=='Field Controller SM+VA+WM'){
// //         return  Padding(padding: EdgeInsets.all(5),
// //           child: Column(
// //             children: [
// //               Paddinglistview(tesxtname:'Battery % :',textValue:'${data.batteryMV}' ),
// //               Paddinglistview(tesxtname:'Firmware Version:',textValue:'${data.firmwareVersion}' ),
// //               Paddinglistview(tesxtname: 'Operating Mode :',textValue:'${data.operatingMode}' ),
// //               Paddinglistview(tesxtname:'Water Flow Tick Count:',textValue:'${data.waterFlowTickLiters}' ),
// //               Paddinglistview(tesxtname:'Water Flow Tick Liters:',textValue:'${data.firmwareVersion}' ),
// //               Paddinglistview(tesxtname: 'Soil Moisture Single PointSensor :',textValue:'${data.soilMoistureSinglePoStringSensor}' ),
// //               Paddinglistview(tesxtname: 'Level 1:',textValue:'${data.soilMoistureLevelAGL3}' ),
// //               Paddinglistview(tesxtname:'Level 2:',textValue:'${data.soilMoistureLevelAGL2}' ),
// //               Paddinglistview(tesxtname:'Level 3:',textValue:'${data.soilMoistureLevelBGL6}' ),
// //               Paddinglistview(tesxtname: 'Level 4 :',textValue:'${data.soilMoistureLevelBGL7}' ),
// //             ],
// //           ),
// //         );
// //       }
// //       else if(data.devicetype=='I/O Controller Backwash'){
// //         return Column(
// //           children: [
// //             Paddinglistview(tesxtname:'RO1 Status :',textValue:'${data.rO1Status}' ),
// //             Paddinglistview(tesxtname:'RO2 Status :',textValue:'${data.rO2Status}' ),
// //             Paddinglistview(tesxtname: 'Time:',textValue:'${data.sensorDataPacketDateTime}' ),
// //           ],
// //         );
// //       }
// //       else if(data.devicetype=='I/O Controller Pump Controller'){
// //         return Column(
// //           children: [
// //             Paddinglistview(tesxtname:'Firmware Version:',textValue:'${data.firmwareVersion}' ),
// //             Paddinglistview(tesxtname:'Operating Mode :',textValue:'${data.operatingMode}' ),
// //             Paddinglistview(tesxtname: 'Water Pressure KPA:',textValue:'${data.waterPressureKPA}' ),
// //             Paddinglistview(tesxtname: 'Water Pressure MPA:',textValue:'${data.waterPressureMPA}' ),
// //           ],
// //         );
// //       }
// //       else if(data.devicetype=='Energy Meter'){
// //         return Column(
// //           children: [
// //             Paddinglistview(tesxtname:'Current B',textValue:'${data.currentB}' ),
// //             Paddinglistview(tesxtname:'Current R',textValue:'${data.currentR}' ),
// //             Paddinglistview(tesxtname: 'Current Y',textValue:'${data.currentY}' ),
// //             Paddinglistview(tesxtname: 'Frequency',textValue: '${data.EMFREQUENCY}'),
// //             Paddinglistview(tesxtname: 'Power Factor ',textValue: '${data.powerFactor}'),
// //             Paddinglistview(tesxtname: 'Voltage B ',textValue:'${data.voltageB}' ),
// //             Paddinglistview(tesxtname: 'Voltage R',textValue: '${data.voltageR}'),
// //             Paddinglistview(tesxtname: 'Voltage Y',textValue: '${data.voltageY}')
// //           ],
// //         );
// //       }
// //       else if(data.devicetype=='LSN50 MPSMS' ||data.devicetype=='LSN50 AWD' ){
// //         return Column(
// //           children: [
// //             Paddinglistview(tesxtname:'Battery % :',textValue:'${data.batteryMV}' ),
// //             Paddinglistview(tesxtname:'Firmware Version:',textValue:'${data.firmwareVersion}' ),
// //             Paddinglistview(tesxtname: 'Level 1:',textValue:'${data.soilMoistureLevelAGL3}' ),
// //             Paddinglistview(tesxtname:'Level 2:',textValue:'${data.soilMoistureLevelAGL2}' ),
// //             Paddinglistview(tesxtname:'Level 3:',textValue:'${data.soilMoistureLevelBGL6}' ),
// //             Paddinglistview(tesxtname: 'Level 4 :',textValue:'${data.soilMoistureLevelBGL7}' ),
// //           ],
// //         );
// //
// //       }
// //       else if(data.devicetype=="Field Controller Water meter"){
// //         return Column(
// //           children: [
// //             Paddinglistview(tesxtname:'Battery % :',textValue:'${data.batteryMV}' ),
// //             Paddinglistview(tesxtname:'Firmware Version:',textValue:'${data.firmwareVersion}' ),
// //             Paddinglistview(tesxtname: 'Operating Mode :',textValue:'${data.operatingMode}' ),
// //             Paddinglistview(tesxtname:'Water Flow Tick Count:',textValue:'${data.waterFlowTickLiters}' ),
// //             Paddinglistview(tesxtname:'Water Flow Tick Liters:',textValue:'${data.firmwareVersion}' ),
// //           ],
// //         );
// //       }
// //       else if (data.devicetype=='Weather Station'){
// //         return Column(
// //           children: [
// //             Paddinglistview(tesxtname:'humidity :',textValue:'${data.fHumidity}' ),
// //             Paddinglistview(tesxtname:'Radiation :',textValue:'${data.radiationWM2}' ),
// //             Paddinglistview(tesxtname:'Rain :',textValue:'${data.rainMM}' ),
// //             Paddinglistview(tesxtname:'Temperature :',textValue:'${data.fTemperature}' ),
// //             Paddinglistview(tesxtname:'Wind direction :',textValue:'${data.windDirectionDegree}' ),
// //             Paddinglistview(tesxtname:'Wind speed :',textValue:'${data.windSpeedKmHr}' ),
// //           ],
// //         );
// //
// //       }
// //       else if(data.devicetype=="LSN50 Temperature+Humidity"){
// //         return Column(
// //           children: [
// //             Paddinglistview(tesxtname:'Battery % :',textValue:'${data.batteryMV}' ),
// //             Paddinglistview(tesxtname:'humidity :',textValue:'${data.fHumidity}' ),
// //             Paddinglistview(tesxtname:'Temperature :',textValue:'${data.fTemperature}' ),          ],
// //         );
// //       }
// //       else if (data.devicetype=='LSN50 Water level Sensor'){
// //         return Column(
// //           children: [
// //             Paddinglistview(tesxtname:'Battery % :',textValue:'${data.batteryMV}' ),
// //             Paddinglistview(tesxtname:'Distance :',textValue:'${data.fDistance}'),
// //             Paddinglistview(tesxtname:'Sensor flag:',textValue:'${data.sensorFlag}' ),
// //             Paddinglistview(tesxtname:'InterruptFlag :',textValue:'${data.InterruptFlag}' ),
// //             Paddinglistview(tesxtname:'TempC_DS18B20 :',textValue:'${data.tempCDS18B20}' ),
// //             Paddinglistview(tesxtname:'SensorFlag :',textValue:'${data.sensorFlag}' ),
// //           ],
// //         );
// //       }
// //       else if(data.devicetype=='GHG Sensor'){
// //         return Column(
// //           children: [
// //             Paddinglistview(tesxtname:'CH4_PPM :',textValue:'${data.CH4_PPM}' ),
// //             Paddinglistview(tesxtname:'CO2_PPM :',textValue:'${data.CO2_PPM}' ),
// //           ],
// //         );
// //       }
// //       else if (data.devicetype=="CO2 Sensor"){
// //         return Column(
// //           children: [
// //             Paddinglistview(tesxtname:'CO2_PPM :',textValue:'${data.CO2_PPM}' ),
// //           ],
// //         );
// //       }
// //       else{
// //         return Text("Please contact Manager");
// //       }
// //
// //
// //   }
// //
// // String _scanBarcode = 'Unknown';
// //
// // Future<void> scanQRpc() async {
// //   String barcodeScanRes;
// //   try {
// //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
// //         '#228B22', 'Cancel', true, ScanMode.QR);
// //    setState((){
// //      deviceid.text =barcodeScanRes;
// //    });
// //   } on PlatformException {
// //     barcodeScanRes = 'Failed to get ';
// //   }
// // //barcode scanner flutter ant
// //
// // try{
// //   setState(() {
// //     deviceid.text = barcodeScanRes;
// //     print("after updating ${deviceid.text}");
// //     _scanBarcode = barcodeScanRes;
// //   });
// // }
// // catch(e){
// //     print("error is $e");
// // }
// // }
// //
// // int val=1;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(child:
// //
// //       Column(
// //         children: [
// //           Container(
// //             // height: MediaQuery.of(context).size.height/20,
// //               child:Column(
// //                   children: [
// //                     Container(
// //                       height: MediaQuery.of(context).size.height/15,
// //                       child: Image.asset(
// //                         'assets/images/cultyvate.png',
// //                         height: 50,
// //                       ),
// //                     ),
// //                     Container(
// //                         height: MediaQuery.of(context).size.height/15,
// //                         padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
// //                         child:Row(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children:[
// //                               Text(
// //                                 "Farmer",
// //                                 style:TextStyle( color:blockcolor,
// //                                     color: Color.fromRGBO(10 ,192 ,92,2),
// //                                     fontSize: 30,
// //                                     fontWeight: FontWeight.bold),
// //                               ),
// //                               Text(
// //                                 " Device Query",
// //                                 style:TextStyle( color:blockcolor,
// //                                     color: Colors.black,
// //                                     fontSize: 30,
// //                                     fontWeight: FontWeight.bold),
// //                               ),
// //                             ] )
// //                     ),
// //                     // SizedBox(height: 10,),
// //                     Row(
// //                       children: [
// //                         Radio(
// //                           value: 1,
// //                           groupValue: val,
// //                           onChanged: (value) {
// //                             setState(() {
// //                               val = int.parse(value.toString());
// //                             });
// //                           },
// //                           activeColor: Colors.green,
// //                         ),
// //                         Text("Device ID"),
// //                         Radio(
// //                           value: 2,
// //                           groupValue: val,
// //                           onChanged: (value) {
// //                             setState(() {
// //                               val = int.parse(value.toString());
// //                             });
// //                           },
// //                           activeColor: Colors.green,
// //                         ),
// //                         Text("Serial Number"),
// //       Switch(
// //         value: false,
// //         onChanged: (value) {
// //           setState(() {
// //             // isSwitched = value;
// //             // print(isSwitched);
// //           });
// //         },
// //         activeTrackColor: Colors.lightGreenAccent,
// //         activeColor: Colors.green,
// //       ),
// //                         Text("Grid"),
// //
// //
// //                       ],
// //                     ),
// //                     Row(
// //                         children: [
// //
// //                           Container(
// //                             // height: MediaQuery.of(context).size.height/12,
// //                             width: MediaQuery.of(context).size.width/1.4,
// //                             padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
// //                             child: TextFormField(
// //                               // autovalidateMode: AutovalidateMode.onUserInteraction,
// //                               inputFormatters: [
// //                                 FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
// //                                 FilteringTextInputFormatter.deny(
// //                                     RegExp(r'\s')),
// //                               ],
// //                               controller: deviceid,
// //                               decoration: InputDecoration(
// //                                 labelText:val==1? 'Device ID':'Serial Number',
// //                                 suffixIcon:
// //                               IconButton(
// //                               icon: Icon(MdiIcons.barcode),
// //                               onPressed: () => scanQRpc(),
// //                             ),
// //                                 border: OutlineInputBorder(),
// //                                 // counter: Offstage(),
// //                               ),
// //                             ),
// //                           ),
// //                           TextButton(
// //                             style:  TextButton.styleFrom(
// //                                 foregroundColor: Colors.black,
// //                                 backgroundColor: Colors.blueAccent
// //                             ),
// //                             onPressed: ()async{
// //                               if(deviceid.text.trim().length>3) {
// //                                 setState(() {
// //                                   devicedata = [];
// //                                   errormessage = "";
// //                                 });
// //
// //                                 devicedata = await Devicedata(deviceid.text.trim());
// //                               }
// //                               else{
// //                                 Fluttertoast.showToast(
// //                                     msg: "Please Enter Valid Device Id",
// //                                     backgroundColor: Colors.red
// //                                 );
// //                               }
// //
// //
// //                             },child: Text("Search",style:TextStyle( color:blockcolor,fontSize: 10),),),
// //                         ]
// //                     )
// //
// //                   ]
// //               )
// //           ),
// //         isloading==true?Center(
// //           child: CircularProgressIndicator(),
// //         ):
// //     devicedata.length != 0
// //     ? Flexible(
// //     child: ListView.builder(
// //     itemCount: devicedata.length,
// //     itemBuilder: (BuildContext context, int index) {
// //   Column(
// //
// //       children: [
// //         Text("data"),
// //         //
// //         // DeferanceDateandTine(devicedata[index].sensorDataPacketDateTime),
// //         // // Textdata(devicedata[index]),
// //         // // Text(keys.toString()),
// //         // Divider(),
// //
// //       ],
// //       );
// //     },
// //     ),
// //     )
// //         : Center(child: Text(Errormessage)),
// //
// //
// //     ],
// //       )
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:dio/dio.dart';
// import 'package:intl/intl.dart';
// import '../models/devicequery.dart';
// class DeviceQuery extends StatefulWidget {
//   const DeviceQuery({Key? key}) : super(key: key);
//
//   @override
//   State<DeviceQuery> createState() => _DeviceQueryState();
// }
//
// class _DeviceQueryState extends State<DeviceQuery> {
//   List<Devicequerry> devicedata=[];
//   TextEditingController deviceid=new TextEditingController();
//   bool isloading=false;
//   String errormessage="";
//
//
//
//   parsedatetime(String date){
//     print("date $date");
//     if(date!="null") {
//       DateTime givendate = DateTime.parse(date);
//       if(givendate.year!=1980 && givendate.year!=1900 ) {
//         String formattedDate = DateFormat('yyyy-MM-dd ,hh:mm a').format(
//             givendate);
//         // if(formattedDate.contains('1980')){
//         //   return "null";
//         // }
//         // else{
//         return formattedDate;
//       }
//       else{
//         return "null";
//       }
//     }
//     else {
//       return "null";
//     }
//
//     // }
//
//   }
//
//
//
//   void initState() {
//     datetimeconvert("2022-08-19T17:23:59");
//     super.initState();
//   }
//
//   datetimeconvert(date){
//     var z=  DateTime.parse(date);
//     var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(z.toString(), true);
//
//
//     print("actualdate${dateTime.timeZoneName}");
//   }
//
//   changeTimeTotolocal(dateUtc){
//     if(dateUtc!="null") {
//       var date=  DateTime.parse(dateUtc);
//       print("example date ${date}");
//       var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date.toString(), true);
//       print("first date ${dateTime}");
//
//       var dateLocal = dateTime.toLocal();
//       print("local time ${dateLocal}");
//       if(dateLocal.year!=1980 && dateLocal.year!=1900 ) {
//         String formattedDate = DateFormat('yyyy-MM-dd ,hh:mm a').format(dateLocal);
//         // if(formattedDate.contains('1980')){
//         //   return "null";
//         // }
//         // else{
//         return formattedDate;
//       }
//       else{
//         return "null";
//       }
//     }
//     else {
//       return "null";
//     }
//   }
//

//   bool statusfalse=false;
//   String Errormessage="";
//
//
//   Future<List<Devicequerry>>Devicedata(devicenumber)async{
//     setState((){
//       isloading=true;
//     });
//     Map<String, dynamic> response = await getdata(devicenumber);
//     print("responce is one :${response}");
//     List<Devicequerry> telematicDataList = [];
//     try {
//       if (response.isNotEmpty) {
//         print("inside try");
//         print(response['success']);
//         print(response is List<dynamic>);
//         if (response['success'] != false) {
//           for (int i = 0; i < response['data'].length; i++) {
//             print("error one tweo");
//             Devicequerry deviceQueryModel = Devicequerry.fromJson(response['data'][i]);
//             print(deviceQueryModel.aCI1MilliAmps);
//             try{
//               telematicDataList.add(deviceQueryModel);
//
//             }
//             catch(e){
//               print("error is $e");
//             }
//           }
//         }
//         else{
//           setState(() {
//             statusfalse=true;
//             Errormessage=response['message'];
//           });
//         }
//       }
//       setState((){
//         isloading=false;
//       });
//
//       // telematicDataList.followedBy(devicedata.iterator())
//
//       return telematicDataList;
//     }
//     catch(e){
//       setState((){
//         errormessage="Invalid query... ! ";
//         isloading=false;
//       });
//       print("error is $e");
//       throw e;
//
//     }
//   }
//
//
//
//   Future getdata(devicid) async {
//
//     Map<String, String> header = {
//       "content-type": "application/json",
//       "API_KEY": "12345678"
//     };
//     var path="";
//     if(val==1){
//       path="http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid/DeviceEUIID";
//     }
//     else{
//       path="http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid/HardwareSerialNumber";
//     }
//     // 'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid';
//     print(path);
//     final dio = Dio();
//     Map<String, dynamic> returnData = {};
//     try {
//       final response =
//       await dio.get(path,  options: Options(headers: header),queryParameters: {});
//       if (response.statusCode == 200) {
//         returnData = response.data;
//         print(returnData);
//       }
//     } catch (e) {
//       print("error is :$e");
//       Fluttertoast.showToast(
//           msg: 'Cannot get requested data, please try later: ${e.toString()}');
//       print("error ios :"+e.toString());
//     }
//     return returnData;
//   }
//
//   Widget Paddinglistview({required String tesxtname ,required String textValue}){
//
//     return Padding(padding: EdgeInsets.all(5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Text(tesxtname),
//           Spacer(),
//           Text(textValue),
//         ],
//       ),
//     );
//
//   }
//
//   Widget Textdata(Devicequerry data){
//
//     if(data.devicetype=='Field Controller SM+VA+WM'){
//       return  Padding(padding: EdgeInsets.all(5),
//         child: Column(
//           children: [
//             Paddinglistview(tesxtname:'Battery % :',textValue:'${data.batteryMV}' ),
//             Paddinglistview(tesxtname:'Firmware Version:',textValue:'${data.firmwareVersion}' ),
//             Paddinglistview(tesxtname: 'Operating Mode :',textValue:'${data.operatingMode}' ),
//             Paddinglistview(tesxtname:'Water Flow Tick Count:',textValue:'${data.waterFlowTickLiters}' ),
//             Paddinglistview(tesxtname:'Water Flow Tick Liters:',textValue:'${data.firmwareVersion}' ),
//             Paddinglistview(tesxtname: 'Soil Moisture Single PointSensor :',textValue:'${data.soilMoistureSinglePoStringSensor}' ),
//             Paddinglistview(tesxtname: 'Level 1:',textValue:'${data.soilMoistureLevelAGL3}' ),
//             Paddinglistview(tesxtname:'Level 2:',textValue:'${data.soilMoistureLevelAGL2}' ),
//             Paddinglistview(tesxtname:'Level 3:',textValue:'${data.soilMoistureLevelBGL6}' ),
//             Paddinglistview(tesxtname: 'Level 4 :',textValue:'${data.soilMoistureLevelBGL7}' ),
//           ],
//         ),
//       );
//     }
//     else if(data.devicetype=='I/O Controller Backwash'){
//       return Column(
//         children: [
//           Paddinglistview(tesxtname:'RO1 Status :',textValue:'${data.rO1Status}' ),
//           Paddinglistview(tesxtname:'RO2 Status :',textValue:'${data.rO2Status}' ),
//           Paddinglistview(tesxtname: 'Time:',textValue:'${data.sensorDataPacketDateTime}' ),
//         ],
//       );
//     }
//     else if(data.devicetype=='I/O Controller Pump Controller'){
//       return Column(
//         children: [
//           Paddinglistview(tesxtname:'Firmware Version:',textValue:'${data.firmwareVersion}' ),
//           Paddinglistview(tesxtname:'Operating Mode :',textValue:'${data.operatingMode}' ),
//           Paddinglistview(tesxtname: 'Water Pressure KPA:',textValue:'${data.waterPressureKPA}' ),
//           Paddinglistview(tesxtname: 'Water Pressure MPA:',textValue:'${data.waterPressureMPA}' ),
//         ],
//       );
//     }
//     else if(data.devicetype=='Energy Meter'){
//       return Column(
//         children: [
//           Paddinglistview(tesxtname:'Current B',textValue:'${data.currentB}' ),
//           Paddinglistview(tesxtname:'Current R',textValue:'${data.currentR}' ),
//           Paddinglistview(tesxtname: 'Current Y',textValue:'${data.currentY}' ),
//           Paddinglistview(tesxtname: 'Frequency',textValue: '${data.EMFREQUENCY}'),
//           Paddinglistview(tesxtname: 'Power Factor ',textValue: '${data.powerFactor}'),
//           Paddinglistview(tesxtname: 'Voltage B ',textValue:'${data.voltageB}' ),
//           Paddinglistview(tesxtname: 'Voltage R',textValue: '${data.voltageR}'),
//           Paddinglistview(tesxtname: 'Voltage Y',textValue: '${data.voltageY}')
//         ],
//       );
//     }
//     else if(data.devicetype=='LSN50 MPSMS' ||data.devicetype=='LSN50 AWD' ){
//       return Column(
//         children: [
//           Paddinglistview(tesxtname:'Battery % :',textValue:'${data.batteryMV}' ),
//           Paddinglistview(tesxtname:'Firmware Version:',textValue:'${data.firmwareVersion}' ),
//           Paddinglistview(tesxtname: 'Level 1:',textValue:'${data.soilMoistureLevelAGL3}' ),
//           Paddinglistview(tesxtname:'Level 2:',textValue:'${data.soilMoistureLevelAGL2}' ),
//           Paddinglistview(tesxtname:'Level 3:',textValue:'${data.soilMoistureLevelBGL6}' ),
//           Paddinglistview(tesxtname: 'Level 4 :',textValue:'${data.soilMoistureLevelBGL7}' ),
//         ],
//       );
//
//     }
//     else if(data.devicetype=="Field Controller Water meter"){
//       return Column(
//         children: [
//           Paddinglistview(tesxtname:'Battery % :',textValue:'${data.batteryMV}' ),
//           Paddinglistview(tesxtname:'Firmware Version:',textValue:'${data.firmwareVersion}' ),
//           Paddinglistview(tesxtname: 'Operating Mode :',textValue:'${data.operatingMode}' ),
//           Paddinglistview(tesxtname:'Water Flow Tick Count:',textValue:'${data.waterFlowTickLiters}' ),
//           Paddinglistview(tesxtname:'Water Flow Tick Liters:',textValue:'${data.firmwareVersion}' ),
//         ],
//       );
//     }
//     else if (data.devicetype=='Weather Station'){
//       return Column(
//         children: [
//           Paddinglistview(tesxtname:'humidity :',textValue:'${data.fHumidity}' ),
//           Paddinglistview(tesxtname:'Radiation :',textValue:'${data.radiationWM2}' ),
//           Paddinglistview(tesxtname:'Rain :',textValue:'${data.rainMM}' ),
//           Paddinglistview(tesxtname:'Temperature :',textValue:'${data.fTemperature}' ),
//           Paddinglistview(tesxtname:'Wind direction :',textValue:'${data.windDirectionDegree}' ),
//           Paddinglistview(tesxtname:'Wind speed :',textValue:'${data.windSpeedKmHr}' ),
//         ],
//       );
//
//     }
//     else if(data.devicetype=="LSN50 Temperature+Humidity"){
//       return Column(
//         children: [
//           Paddinglistview(tesxtname:'Battery % :',textValue:'${data.batteryMV}' ),
//           Paddinglistview(tesxtname:'humidity :',textValue:'${data.fHumidity}' ),
//           Paddinglistview(tesxtname:'Temperature :',textValue:'${data.fTemperature}' ),          ],
//       );
//     }
//     else if (data.devicetype=='LSN50 Water level Sensor'){
//       return Column(
//         children: [
//           Paddinglistview(tesxtname:'Battery % :',textValue:'${data.batteryMV}' ),
//           Paddinglistview(tesxtname:'Distance :',textValue:'${data.fDistance}'),
//           Paddinglistview(tesxtname:'Sensor flag:',textValue:'${data.sensorFlag}' ),
//           Paddinglistview(tesxtname:'InterruptFlag :',textValue:'${data.InterruptFlag}' ),
//           Paddinglistview(tesxtname:'TempC_DS18B20 :',textValue:'${data.tempCDS18B20}' ),
//           Paddinglistview(tesxtname:'SensorFlag :',textValue:'${data.sensorFlag}' ),
//         ],
//       );
//     }
//     else if(data.devicetype=='GHG Sensor'){
//       return Column(
//         children: [
//           Paddinglistview(tesxtname:'CH4_PPM :',textValue:'${data.CH4_PPM}' ),
//           Paddinglistview(tesxtname:'CO2_PPM :',textValue:'${data.CO2_PPM}' ),
//         ],
//       );
//     }
//     else if (data.devicetype=="CO2 Sensor"){
//       return Column(
//         children: [
//           Paddinglistview(tesxtname:'CO2_PPM :',textValue:'${data.CO2_PPM}' ),
//         ],
//       );
//     }
//     else{
//       return Text("Please contact Manager");
//     }
//
//
//   }
//
//   String _scanBarcode = 'Unknown';
//
//   Future<void> scanQRpc() async {
//     String barcodeScanRes;
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#228B22', 'Cancel', true, ScanMode.QR);
//       setState((){
//         deviceid.text =barcodeScanRes;
//       });
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get ';
//     }
// //barcode scanner flutter ant
//
//     try{
//       setState(() {
//         deviceid.text = barcodeScanRes;
//         print("after updating ${deviceid.text}");
//         _scanBarcode = barcodeScanRes;
//       });
//     }
//     catch(e){
//       print("error is $e");
//     }
//   }
//
//   final List<String> headers = [
//     'Battery %',
//     'Firmware Version:',
//     'Level 1:',
//     'Level 2:',
//     'Level 3:',
//     'Level 4:'
//   ];
//
//   int val=1;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(child:
//
//       Column(
//         children: [
//           Container(
//             // height: MediaQuery.of(context).size.height/20,
//               child:Column(
//                   children: [
//                     Container(
//                       height: MediaQuery.of(context).size.height/15,
//                       child: Image.asset(
//                         'assets/images/cultyvate.png',
//                         height: 50,
//                       ),
//                     ),
//                     Container(
//                         height: MediaQuery.of(context).size.height/15,
//                         padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
//                         child:Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children:[
//                               Text(
//                                 "Farmer",
//                                 style:TextStyle( color:blockcolor,
//                                     color: Color.fromRGBO(10 ,192 ,92,2),
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 " Device Query",
//                                 style:TextStyle( color:blockcolor,
//                                     color: Colors.black,
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ] )
//                     ),
//                     // SizedBox(height: 10,),
//                     Row(
//                       children: [
//                         Radio(
//                           value: 1,
//                           groupValue: val,
//                           onChanged: (value) {
//                             setState(() {
//                               val = int.parse(value.toString());
//                             });
//                           },
//                           activeColor: Colors.green,
//                         ),
//                         Text("Device ID"),
//                         Radio(
//                           value: 2,
//                           groupValue: val,
//                           onChanged: (value) {
//                             setState(() {
//                               val = int.parse(value.toString());
//                             });
//                           },
//                           activeColor: Colors.green,
//                         ),
//                         Text("Serial Number"),
//                         Switch(
//                           value: false,
//                           onChanged: (value) {
//                             setState(() {
//                               // isSwitched = value;
//                               // print(isSwitched);
//                             });
//                           },
//                           activeTrackColor: Colors.lightGreenAccent,
//                           activeColor: Colors.green,
//                         ),
//                         Text("Grid"),
//
//
//                       ],
//                     ),
//                     Row(
//                         children: [
//
//                           Container(
//                             // height: MediaQuery.of(context).size.height/12,
//                             width: MediaQuery.of(context).size.width/1.4,
//                             padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
//                             child: TextFormField(
//                               // autovalidateMode: AutovalidateMode.onUserInteraction,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
//                                 FilteringTextInputFormatter.deny(
//                                     RegExp(r'\s')),
//                               ],
//                               controller: deviceid,
//                               decoration: InputDecoration(
//                                 labelText:val==1? 'Device ID':'Serial Number',
//                                 suffixIcon:
//                                 IconButton(
//                                   icon: Icon(MdiIcons.barcode),
//                                   onPressed: () => scanQRpc(),
//                                 ),
//                                 border: OutlineInputBorder(),
//                                 // counter: Offstage(),
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                             style:  TextButton.styleFrom(
//                                 foregroundColor: Colors.black,
//                                 backgroundColor: Colors.blueAccent
//                             ),
//                             onPressed: ()async{
//                               if(deviceid.text.trim().length>3) {
//                                 setState(() {
//                                   devicedata = [];
//                                   errormessage = "";
//                                 });
//
//                                 devicedata = await Devicedata(deviceid.text.trim());
//                               }
//                               else{
//                                 Fluttertoast.showToast(
//                                     msg: "Please Enter Valid Device Id",
//                                     backgroundColor: Colors.red
//                                 );
//                               }
//
//
//                             },child: Text("Search",style:TextStyle( color:blockcolor,fontSize: 10),),),
//                         ]
//                     )
//
//                   ]
//               )
//           ),
//           isloading==true?Center(
//             child: CircularProgressIndicator(),
//           ):
//           devicedata.length!=0?
//           Flexible(child:
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width * 2,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: devicedata.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Column(
//                             children: [
//                           DeferanceDateandTine(devicedata[index].sensorDataPacketDateTime),
//
//                         ],
//                       );
//                     },
//                   )
//                 ),
//               ),
//             ),
//           )
//
//
//           ):Center(child: Text(Errormessage),)
//
//         ],
//       )
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../models/devicequery.dart';

const textstyle=TextStyle(fontSize: 13,color: Colors.black);
class DeviceQuery extends StatefulWidget {
  const DeviceQuery({Key? key}) : super(key: key);

  @override
  State<DeviceQuery> createState() => _DeviceQueryState();
}

class _DeviceQueryState extends State<DeviceQuery> {
  List<Devicequerry> devicedata=[];
  TextEditingController deviceid=new TextEditingController();
  bool isloading=false;
  String errormessage="";



  parsedatetime(String date){
    print("date $date");
    if(date!="null") {
      DateTime givendate = DateTime.parse(date);
      if(givendate.year!=1980 && givendate.year!=1900 ) {
        String formattedDate = DateFormat('yyyy-MM-dd ,hh:mm a').format(
            givendate);
        // if(formattedDate.contains('1980')){
        //   return "null";
        // }
        // else{
        return formattedDate;
      }
      else{
        return "null";
      }
    }
    else {
      return "null";
    }

    // }

  }



  void initState() {
    datetimeconvert("2022-08-19T17:23:59");
    super.initState();
  }

  datetimeconvert(date){
    var z=  DateTime.parse(date);
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(z.toString(), true);


    print("actualdate${dateTime.timeZoneName}");
  }

  changeTimeTotolocal(dateUtc){
    if(dateUtc!="null") {
      var date=  DateTime.parse(dateUtc);
      print("example date ${date}");
      var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date.toString(), true);
      print("first date ${dateTime}");

      var dateLocal = dateTime.toLocal();
      print("local time ${dateLocal}");
      if(dateLocal.year!=1980 && dateLocal.year!=1900 ) {
        String formattedDate = DateFormat('yyyy-MM-dd ,hh:mm a').format(dateLocal);
        // if(formattedDate.contains('1980')){
        //   return "null";
        // }
        // else{
        return formattedDate;
      }
      else{
        return "null";
      }
    }
    else {
      return "null";
    }
  }
  Widget DeferanceDateandTineonly(givendata){
    // var givendate= DateFormat('yyyy-MM-dd ,hh:mm a').format(givendata);
    var date=  DateTime.parse(givendata);
    print("example date ${date}");
    var dateTime = DateFormat("yy-MM-dd HH:mm").parse(date.toString(), true);
    // print("first date ${dateTime}");
    //
    var dateLocal = dateTime.toLocal();
 /////////////////   print("date local${dateLocal}");
 //    var dateTimelocal = DateFormat("yy-MM-dd HH:mm").parse(dateLocal.toString());

    DateTime example=DateTime.parse(dateLocal.toString());
    final time = DateTime(example.year,example.month,example.day,example.hour,example.minute);
    final date2 = DateTime.now();
    final duration=date2.difference(time);
    final hours=duration.inMinutes;

    String t = "";

    double Days = (hours /(24*60)).roundToDouble() ;
    int daysall=double.parse(Days.toString()).round();
    int Hours= ((hours %(24*60)) / 60).round();

    int minutes = (hours%(24*60)) % 60;


    t =(" $daysall days $Hours hours $minutes minutes");


    return Text( "$t",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style:TextStyle( color: Colors.red),);
    // return Text( "$dateTimelocal",style:TextStyle( color:blockcolor,color: Colors.red),);
  }
  Widget DeferanceDateandTine(givendata){
    // var givendate= DateFormat('yyyy-MM-dd ,hh:mm a').format(givendata);
    var date=  DateTime.parse(givendata);
    print("example date ${date}");
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date.toString(), true);
    print("first date ${dateTime}");

    var dateLocal = dateTime.toLocal();
    print("date local${dateLocal}");

    DateTime example=DateTime.parse(dateLocal.toString());
    final time = DateTime(example.year,example.month,example.day,example.hour,example.minute);
    final date2 = DateTime.now();
    final duration=date2.difference(time);
    final hours=duration.inMinutes;

    String t = "";

    double Days = (hours /(24*60)).roundToDouble() ;
    int daysall=double.parse(Days.toString()).round();
    int Hours= ((hours %(24*60)) / 60).round();

    int minutes = (hours%(24*60)) % 60;


    t =(" $daysall days $Hours hours $minutes minutes");


    return Text( "Last communicated on:$t",style:TextStyle(color: Colors.red),);
  }
  bool statusfalse=false;
  String Errormessage="";


  Widget DeferanceDateandTineand(givendata){
    // var givendate= DateFormat('yyyy-MM-dd ,hh:mm a').format(givendata);
    var date=  DateTime.parse(givendata);
    print("example date ${date}");
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date.toString(), true);
    print("first date ${dateTime}");

    var dateLocal = dateTime.toLocal();
    print("date local${dateLocal}");

    DateTime example=DateTime.parse(dateLocal.toString());
    final time = DateTime(example.year,example.month,example.day,example.hour,example.minute);
    final date2 = DateTime.now();
    final duration=date2.difference(time);
    final hours=duration.inMinutes;

    String t = "";

    double Days = (hours /(24*60)).roundToDouble() ;
    int daysall=double.parse(Days.toString()).round();
    int Hours= ((hours %(24*60)) / 60).round();

    int minutes = (hours%(24*60)) % 60;


    t =(" $daysall days $Hours hours $minutes minutes");


    return Text( "Last communicated on:$t",style:TextStyle(color: Colors.red),);
  }


  Future<List<Devicequerry>>Devicedata(devicenumber)async{
    setState((){
      isloading=true;
    });
    Map<String, dynamic> response = await getdata(devicenumber);
    print("responce is one :${response}");
    List<Devicequerry> telematicDataList = [];
    try {
      if (response.isNotEmpty) {
        print("inside try");
        print(response['success']);
        print(response is List<dynamic>);
        if (response['success'] != false) {
          for (int i = 0; i < response['data'].length; i++) {
            print("error one tweo");
            Devicequerry deviceQueryModel = Devicequerry.fromJson(response['data'][i]);
            print(deviceQueryModel.aCI1MilliAmps);
            try{
              telematicDataList.add(deviceQueryModel);

            }
            catch(e){
              print("error is $e");
            }
          }
        }
        else{
          setState(() {
            statusfalse=true;
            Errormessage=response['message'];
          });
        }
      }
      setState((){
        isloading=false;
      });

      // telematicDataList.followedBy(devicedata.iterator())

      return telematicDataList;
    }
    catch(e){
      setState((){
        errormessage="Invalid query... ! ";
        isloading=false;
      });
      print("error is $e");
      throw e;

    }
  }



  Future getdata(devicid) async {

    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var path="";
    if(val==1 ||alldata==true){
      path="http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid/DeviceID";
      // path="http://192.168.199.1:8085/api/farm2fork/devicedata/devices/$devicid/DeviceID";
    }
    else{
      path="http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid/HardwareSerialNumber";
    }
    // 'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/devicedata/devices/$devicid';
    print(path);
    final dio = Dio();
    Map<String, dynamic> returnData = {};
    try {
      final response =
      await dio.get(path,  options: Options(headers: header),queryParameters: {});
      if (response.statusCode == 200) {
        returnData = response.data;
        print(returnData);
      }
    } catch (e) {
      print("error is :$e");
      Fluttertoast.showToast(
          msg: 'Cannot get requested data, please try later: ${e.toString()}');
      print("error ios :"+e.toString());
    }
    return returnData;
  }

  Widget Paddinglistview({required String tesxtname ,required String textValue}){

    return Padding(padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(tesxtname),
          Spacer(),
          Text(textValue),
        ],
      ),
    );

  }

  Widget Textdata(Devicequerry data){

    if(data.devicetype=='Field Controller+Valve+MPSMS'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'RO1Status',textValue:'${data.rO1Status}' ),
              Paddinglistview(tesxtname:'W F Liters',textValue:'${data.waterFlowTickLiters}' ),
              Paddinglistview(tesxtname:'W FlowCount',textValue:'${data.waterFlowCount}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
    else if(data.devicetype=='Field Controller+MPSMS'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'Level1',textValue:'${data.soilMoistureLevelAGL3}' ),
              Paddinglistview(tesxtname:'Level2',textValue:'${data.soilMoistureLevelAGL2}' ),
              Paddinglistview(tesxtname:'Level3',textValue:'${data.soilMoistureLevelBGL6}' ),
              Paddinglistview(tesxtname:'Level4',textValue:'${data.soilMoistureLevelBGL7}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
    else if(data.devicetype=='Field Controller +Valve'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'O Mode',textValue:'${data.operatingMode}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
    else if(data.devicetype=='LUX Meter'){
      return Column(
        children: [
          Paddinglistview(tesxtname:'Current B',textValue:'${data.currentB}' ),
          Paddinglistview(tesxtname:'Current R',textValue:'${data.currentR}' ),
          Paddinglistview(tesxtname: 'Current Y',textValue:'${data.currentY}' ),
          Paddinglistview(tesxtname: 'Frequency',textValue: '${data.EMFREQUENCY}'),
          Paddinglistview(tesxtname: 'Power Factor ',textValue: '${data.powerFactor}'),
          Paddinglistview(tesxtname: 'Voltage B ',textValue:'${data.voltageB}' ),
          Paddinglistview(tesxtname: 'Voltage R',textValue: '${data.voltageR}'),
          Paddinglistview(tesxtname: 'Voltage Y',textValue: '${data.voltageY}')
        ],
      );
    }

    else if(data.devicetype=='Cooling Pad' ){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'EMCurrentR',textValue:'${data.currentR}' ),
              Paddinglistview(tesxtname:'EMFREQUENCY',textValue:'${data.sensorFrequency}' ),
              Paddinglistview(tesxtname:'EMKWH',textValue:'${data.eMKWH}' ),
              Paddinglistview(tesxtname:'EMKvah',textValue:'${data.kvah}' ),
              Paddinglistview(tesxtname:'EMPowerFactor',textValue:'${data.powerFactor}' ),
              Paddinglistview(tesxtname:'EMVoltageR',textValue:'${data.voltageR}' ),
              Paddinglistview(tesxtname:'EMRelay',textValue:'${data.eMRelay}' ),
              Paddinglistview(tesxtname:'PacketType',textValue:'${data.packetType}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );

    }
    else if(data.devicetype=="Exaust Fan"){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'EMCurrentR',textValue:'${data.currentR}' ),
              Paddinglistview(tesxtname:'EMFREQUENCY',textValue:'${data.sensorFrequency}' ),
              Paddinglistview(tesxtname:'EMKWH',textValue:'${data.eMKWH}' ),
              Paddinglistview(tesxtname:'EMKvah',textValue:'${data.kvah}' ),
              Paddinglistview(tesxtname:'EMPowerFactor',textValue:'${data.powerFactor}' ),
              Paddinglistview(tesxtname:'EMVoltageR',textValue:'${data.voltageR}' ),
              Paddinglistview(tesxtname:'EMRelay',textValue:'${data.eMRelay}' ),
              Paddinglistview(tesxtname:'PacketType',textValue:'${data.packetType}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
    else if (data.devicetype=='I/O Controller Pump Controller V3'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'EMCurrentB',textValue:'${data.currentB}' ),
              Paddinglistview(tesxtname:'EMCurrentR',textValue:'${data.currentR}' ),
              Paddinglistview(tesxtname:'EMCurrentY',textValue:'${data.currentY}' ),
              Paddinglistview(tesxtname:'EMFREQUENCY',textValue:'${data.sensorFrequency}' ),
              Paddinglistview(tesxtname:'EMKWH',textValue:'${data.eMKWH}' ),
              Paddinglistview(tesxtname:'EMKvah',textValue:'${data.kvah}' ),
              Paddinglistview(tesxtname:'EMPowerFactor',textValue:'${data.powerFactor}' ),
              Paddinglistview(tesxtname:'EMVoltageB',textValue:'${data.voltageB}' ),
              Paddinglistview(tesxtname:'EMVoltageR',textValue:'${data.voltageR}' ),
              Paddinglistview(tesxtname:'EMVoltageY',textValue:'${data.voltageY}' ),
              Paddinglistview(tesxtname:'EMRelay',textValue:'${data.eMRelay}' ),
              Paddinglistview(tesxtname:'PacketType',textValue:'${data.packetType}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );

    }
    else if(data.devicetype=="PH Sensor"){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'PHvalue',textValue:'${data.pHvalue}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
    else if (data.devicetype=='CO2 Sensor'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'CO2_PPM',textValue:'${data.CO2_PPM}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
    else if(data.devicetype=='Field Controller MP+VA+WM'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'Level1',textValue:'${data.soilMoistureLevelAGL3}' ),
              Paddinglistview(tesxtname:'Level2',textValue:'${data.soilMoistureLevelAGL2}' ),
              Paddinglistview(tesxtname:'Level3',textValue:'${data.soilMoistureLevelBGL6}' ),
              Paddinglistview(tesxtname:'Level4',textValue:'${data.soilMoistureLevelBGL7}' ),
              Paddinglistview(tesxtname:'O Mode',textValue:'${data.operatingMode}' ),
              Paddinglistview(tesxtname:'W F Liters',textValue:'${data.waterFlowTickLiters}' ),
              Paddinglistview(tesxtname:'W FlowCount',textValue:'${data.waterFlowCount}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
    else if (data.devicetype=="LSN50 AWD"){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'Level1',textValue:'${data.soilMoistureLevelAGL3}' ),
              Paddinglistview(tesxtname:'Level2',textValue:'${data.soilMoistureLevelAGL2}' ),
              Paddinglistview(tesxtname:'Level3',textValue:'${data.soilMoistureLevelBGL6}' ),
              Paddinglistview(tesxtname:'Level4',textValue:'${data.soilMoistureLevelBGL7}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
    else if (data.devicetype=="LSN50 MPSMS"){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'Level1',textValue:'${data.soilMoistureLevelAGL3}' ),
              Paddinglistview(tesxtname:'Level2',textValue:'${data.soilMoistureLevelAGL2}' ),
              Paddinglistview(tesxtname:'Level3',textValue:'${data.soilMoistureLevelBGL6}' ),
              Paddinglistview(tesxtname:'Level4',textValue:'${data.soilMoistureLevelBGL7}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),

      );
    }
    else if (data.devicetype=='Field Controller Water Meter'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'O Mode',textValue:'${data.operatingMode}' ),
              Paddinglistview(tesxtname:'W F Liters',textValue:'${data.waterFlowTickLiters}' ),
              Paddinglistview(tesxtname:'W FlowCount',textValue:'${data.waterFlowCount}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
    else if(data.devicetype=='I/O Controller Pump Controller V1'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'O Mode',textValue:'${data.operatingMode}' ),
              Paddinglistview(tesxtname:'WaterPressureKPA',textValue:'${data.waterPressureKPA}' ),
              Paddinglistview(tesxtname:'WaterPressureMPA',textValue:'${data.waterPressureMPA}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
   else if (data.devicetype=='LSN50 Water level Sensor'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'fDistance',textValue:'${data.fDistance}' ),
              Paddinglistview(tesxtname:'InterruptFlag',textValue:'${data.InterruptFlag}' ),
              Paddinglistview(tesxtname:'SensorFlag',textValue:'${data.sensorFlag}' ),
              Paddinglistview(tesxtname:'TempC_DS18B20',textValue:'${data.tempCDS18B20}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
   else if (data.devicetype=='I/O Controller Pump Controller V2'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'EMCurrentB',textValue:'${data.currentB}' ),
              Paddinglistview(tesxtname:'EMCurrentR',textValue:'${data.currentR}' ),
              Paddinglistview(tesxtname:'EMCurrentY',textValue:'${data.currentY}' ),
              Paddinglistview(tesxtname:'EMFREQUENCY',textValue:'${data.sensorFrequency}' ),
              Paddinglistview(tesxtname:'EMKWH',textValue:'${data.eMKWH}' ),
              Paddinglistview(tesxtname:'EMKvah',textValue:'${data.kvah}' ),
              Paddinglistview(tesxtname:'EMPowerFactor',textValue:'${data.powerFactor}' ),
              Paddinglistview(tesxtname:'EMVoltageB',textValue:'${data.voltageB}' ),
              Paddinglistview(tesxtname:'EMVoltageR',textValue:'${data.voltageR}' ),
              Paddinglistview(tesxtname:'EMVoltageY',textValue:'${data.voltageY}' ),
              Paddinglistview(tesxtname:'EMRelay',textValue:'${data.eMRelay}' ),
              Paddinglistview(tesxtname:'PacketType',textValue:'${data.packetType}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
   else if (data.devicetype=='I/O Controller Backwash BR1'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'RO1Status',textValue:'${data.rO1Status}' ),
              Paddinglistview(tesxtname:'W F Liters',textValue:'${data.waterFlowTickLiters}' ),
              Paddinglistview(tesxtname:'W FlowCount',textValue:'${data.waterFlowCount}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
   else if (data.devicetype=='LSN50 TemperatureHumidity'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'fTemperature',textValue:'${data.fTemperature}' ),
              Paddinglistview(tesxtname:'fHumidity',textValue:'${data.fHumidity}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
   else if (data.devicetype=='GHG Sensor'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'CH4_PPM',textValue:'${data.CH4_PPM}' ),
              Paddinglistview(tesxtname:'CO2_PPM',textValue:'${data.CO2_PPM}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
   else if(data.devicetype=='Weather Station'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'fTemperature',textValue:'${data.fTemperature}' ),
              Paddinglistview(tesxtname:'fHumidity',textValue:'${data.fHumidity}' ),
              Paddinglistview(tesxtname:'RadiationWM2',textValue:'${data.radiationWM2}' ),
              Paddinglistview(tesxtname:'RainMM',textValue:'${data.rainMM}' ),
              Paddinglistview(tesxtname:'WindDirectionDegree',textValue:'${data.windDirectionDegree}' ),
              Paddinglistview(tesxtname:'WindSpeedKmHr',textValue:'${data.windSpeedKmHr}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
   else if (data.devicetype=='Fertigation Controller R01'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'RO1Status',textValue:'${data.rO1Status}' ),
              Paddinglistview(tesxtname:'W F Liters',textValue:'${data.waterFlowTickLiters}' ),
              Paddinglistview(tesxtname:'W FlowCount',textValue:'${data.waterFlowCount}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
    else if (data.devicetype=='Fertigation Controller R02'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'RO2Status',textValue:'${data.rO2Status}' ),
              Paddinglistview(tesxtname:'W F Liters',textValue:'${data.waterFlowTickLiters}' ),
              Paddinglistview(tesxtname:'W FlowCount',textValue:'${data.waterFlowCount}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
   else if (data.devicetype=='I/O Controller Backwash BR2'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'RO2Status',textValue:'${data.rO2Status}' ),
              Paddinglistview(tesxtname:'W F Liters',textValue:'${data.waterFlowTickLiters}' ),
              Paddinglistview(tesxtname:'W FlowCount',textValue:'${data.waterFlowCount}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
   else if (data.devicetype=='LSN50 AWD Ball Sensor'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'Level1',textValue:'${data.soilMoistureLevelAGL3}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
else if (data.devicetype=='Field Controller SP+VA+WM'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'SoilMoistureSinglePointSensor',textValue:'${data.soilMoistureSinglePoStringSensor}' ),
              Paddinglistview(tesxtname:'O Mode',textValue:'${data.operatingMode}' ),
              Paddinglistview(tesxtname:'W F Liters',textValue:'${data.waterFlowTickLiters}' ),
              Paddinglistview(tesxtname:'W FlowCount',textValue:'${data.waterFlowCount}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(data.sensorDataPacketDateTime)}' ),
            ]
        ),
      );
    }
    else if (data.devicetype=='Field Controller DP+VA+WM'){
      return  Padding(padding: EdgeInsets.all(5),
        child: Column(
            children: [
              Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
              Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
              Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
              Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
              Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
              Paddinglistview(tesxtname:'Level1',textValue:'${data.soilMoistureLevelAGL3}' ),
              Paddinglistview(tesxtname:'Level2',textValue:'${data.soilMoistureLevelAGL2}' ),
              Paddinglistview(tesxtname:'O Mode',textValue:'${data.operatingMode}' ),
              Paddinglistview(tesxtname:'W F Liters',textValue:'${data.waterFlowTickLiters}' ),
              Paddinglistview(tesxtname:'W FlowCount',textValue:'${data.waterFlowCount}' ),
              Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
              Paddinglistview(tesxtname:'CreateDate',textValue:'${convertTime(convertTime(data.sensorDataPacketDateTime))}' ),
            ]
        ),
      );


    }
    else{
      return  Padding(padding: EdgeInsets.all(5),
    child: Column(
    children: [
    Paddinglistview(tesxtname:'DeviceEUIID',textValue:'${data.deviceID}' ),
    Paddinglistview(tesxtname:'ApplicationID',textValue:'${data.applicationID}' ),
    Paddinglistview(tesxtname:'HardwareSerialNumber',textValue:'${data.hardwareSerialNumber}' ),
    Paddinglistview(tesxtname:'BatteryMV',textValue:'${data.batteryMV}' ),
    Paddinglistview(tesxtname:'F Version',textValue:'${data.firmwareVersion}' ),
    Paddinglistview(tesxtname:'O Mode',textValue:'${data.operatingMode}' ),
    Paddinglistview(tesxtname:'GateWayID',textValue:'${data.gateWayID}' ),
    Paddinglistview(tesxtname:'CreateDate',textValue:'${data.createDate}' ),
    Paddinglistview(tesxtname:'Level1',textValue:'${data.soilMoistureLevelAGL3}' ),
    Paddinglistview(tesxtname:'Level2',textValue:'${data.soilMoistureLevelAGL2}' ),
    Paddinglistview(tesxtname:'Level3',textValue:'${data.soilMoistureLevelBGL6}' ),
    Paddinglistview(tesxtname:'Level4',textValue:'${data.soilMoistureLevelBGL7}' ),
    Paddinglistview(tesxtname:'EMCurrentR',textValue:'${data.currentR}' ),
    Paddinglistview(tesxtname:'EMFREQUENCY',textValue:'${data.sensorFrequency}' ),
    Paddinglistview(tesxtname:'EMKWH',textValue:'${data.eMKWH}' ),
    Paddinglistview(tesxtname:'EMKvah',textValue:'${data.kvah}' ),
    Paddinglistview(tesxtname:'EMPowerFactor',textValue:'${data.powerFactor}' ),
    Paddinglistview(tesxtname:'EMVoltageR',textValue:'${data.voltageR}' ),
    Paddinglistview(tesxtname:'EMRelay',textValue:'${data.eMRelay}' ),
    Paddinglistview(tesxtname:'PacketType',textValue:'${data.packetType}' ),
    Paddinglistview(tesxtname:'EMCurrentB',textValue:'${data.currentB}' ),
    Paddinglistview(tesxtname:'EMCurrentY',textValue:'${data.currentY}' ),
    Paddinglistview(tesxtname:'EMVoltageB',textValue:'${data.voltageB}' ),
    Paddinglistview(tesxtname:'EMVoltageY',textValue:'${data.voltageY}' ),
    Paddinglistview(tesxtname:'PHvalue',textValue:'${data.pHvalue}' ),
    Paddinglistview(tesxtname:'W F Liters',textValue:'${data.waterFlowTickLiters}' ),
    Paddinglistview(tesxtname:'W FlowCount',textValue:'${data.waterFlowCount}' ),
    Paddinglistview(tesxtname:'WaterPressureKPA',textValue:'${data.waterPressureKPA}' ),
    Paddinglistview(tesxtname:'WaterPressureMPA',textValue:'${data.waterPressureMPA}' ),
    Paddinglistview(tesxtname:'RO1Status',textValue:'${data.rO1Status}' ),
    Paddinglistview(tesxtname:'fTemperature',textValue:'${data.fTemperature}' ),
    Paddinglistview(tesxtname:'fHumidity',textValue:'${data.fHumidity}' ),
    Paddinglistview(tesxtname:'CH4_PPM',textValue:'${data.CH4_PPM}' ),
    Paddinglistview(tesxtname:'CO2_PPM',textValue:'${data.CO2_PPM}' ),
    Paddinglistview(tesxtname:'RadiationWM2',textValue:'${data.radiationWM2}' ),
    Paddinglistview(tesxtname:'RainMM',textValue:'${data.rainMM}' ),
    Paddinglistview(tesxtname:'WindDirectionDegree',textValue:'${data.windDirectionDegree}' ),
    Paddinglistview(tesxtname:'WindSpeedKmHr',textValue:'${data.windSpeedKmHr}' ),
    Paddinglistview(tesxtname:'SoilMoistureSinglePointSensor',textValue:'${data.soilMoistureSinglePoStringSensor}' ),
  ]
    ));
    }


  }

  String _scanBarcode = 'Unknown';

  convertTime(time){
    // String input = '2023-04-27T06:27:04.000Z';

    DateTime dateTime = DateTime.parse(time).toLocal();
    String formattedDateTime = DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);

    print(formattedDateTime);
    return formattedDateTime;// Output: 2023-04-27 06:27:04 AM
  }

  Future<void> scanQRpc() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#228B22', 'Cancel', true, ScanMode.QR);
      setState((){
        deviceid.text =barcodeScanRes;
      });
    } on PlatformException {
      barcodeScanRes = 'Failed to get ';
    }
//barcode scanner flutter ant

    try{
      setState(() {
        deviceid.text = barcodeScanRes;
        print("after updating ${deviceid.text}");
        _scanBarcode = barcodeScanRes;
      });
    }
    catch(e){
      print("error is $e");
    }
  }
bool isswitched=false;

double widthofgrid({required devicetype,required widthofscreen}){
print(devicetype);
  if(alldata){
    return 4700;
  }
  else {
    if (devicetype == 'Field Controller MP+VA+WM') {
      return 1850;
    }
    else if (devicetype == 'Fertigation Controller R01') {
      if (widthofscreen > 1450) {
        return widthofscreen;
      }
      else {
        return 1450;
      }
    }
    else if (devicetype == 'Fertigation Controller R02') {
      if (widthofscreen > 1450) {
        return widthofscreen;
      }
      else {
        return 1450;
      }
    }
    else if (devicetype == 'LUX Meter') {
      if (widthofscreen > 1050) {
        return widthofscreen;
      }
      else {
        return 1050;
      }
    }
    else if (devicetype == 'Cooling Pad') {
      if (widthofscreen > 1800) {
        return widthofscreen;
      }
      else {
        return 1800;
      }
    }
    else if (devicetype == 'Exaust Fan') {
      if (widthofscreen > 1800) {
        return widthofscreen;
      }
      else {
        return 1800;
      }
    }
    else if (devicetype == 'Field Controller+Valve+MPSMS') {
      if (widthofscreen > 1600) {
        return widthofscreen;
      }
      else {
        return 1600;
      }
    }
    else if (devicedata == 'Field Controller+MPSMS') {
      if (widthofscreen > 1500) {
        return widthofscreen;
      }
      else {
        return 1500;
      }
    }

    else if (devicetype == 'LSN50 TemperatureHumidity') {
      if (widthofscreen > 1280) {
        return widthofscreen;
      }
      else {
        return 1280;
      }
    }
    else if (devicetype == 'I/O Controller Backwash BR1' ||
        devicetype == 'I/O Controller Backwash BR2') {
      if (widthofscreen > 1450) {
        return widthofscreen;
      }
      else {
        return 1450;
      }
    }
    else if (devicetype == 'I/O Controller Pump Controller V1') {
      if (widthofscreen > 1400) {
        return widthofscreen;
      }
      else {
        return 1400;
      }
    }
    else if (devicetype == 'I/O Controller Pump Controller V2') {
      if (widthofscreen > 2200) {
        return widthofscreen;
      }
      else {
        return 2200;
      }
    }
    else if (devicetype == 'LSN50 AWD Ball Sensor') {
      if (widthofscreen > 1250) {
        return widthofscreen;
      }
      else {
        return 1250;
      }
    }
    else if (devicetype == 'Field Controller SP+VA+WM') {
      if (widthofscreen > 1750) {
        return widthofscreen;
      }
      else {
        return 1750;
      }
    }
    else if (devicetype == 'Field Controller DP+VA+WM') {
      if (widthofscreen > 1650) {
        return widthofscreen;
      }
      else {
        return 1650;
      }
    }
    else if (devicetype == 'LSN50 MPSMS' || devicetype == 'LSN50 AWD') {
      if (widthofscreen > 1526) {
        return widthofscreen;
      }
      else {
        return 1526;
      }
    }
    else if (devicetype == 'Field Controller Water meter') {
      if (widthofscreen > 1200) {
        return widthofscreen;
      }
      else {
        return 1200;
      }
    }
    else if (devicetype == 'I/O Controller Pump Controller V3') {
      if (widthofscreen > 2200) {
        return widthofscreen;
      }
      else {
        return 2200;
      }
    }
    else if (devicetype == 'PH Sensor') {
      if (widthofscreen > 1050) {
        return widthofscreen;
      }
      else {
        return 1050;
      }
    }

    else if (devicetype == 'Weather Station') {
      if (widthofscreen > 1700) {
        return widthofscreen;
      }
      else {
        return 1700;
      }
    }
    else if (devicetype == 'LSN50 Water level Sensor') {
      if (widthofscreen > 1500) {
        return widthofscreen;
      }
      else {
        return 1500;
      }
    }
    else if (devicetype == 'Field Controller +Valve') {
      if (widthofscreen > 1200) {
        return widthofscreen;
      }
      else {
        return 1200;
      }
    }
    else if (devicetype == 'GHG Sensor') {
      if (widthofscreen > 1150) {
        return widthofscreen;
      }
      else {
        return 1150;
      }
    }
    else {
      // if(val==3){
        return 4900;
      // }
    }
  }
}





  int val=1;
bool alldata=false;
  @override
  Widget build(BuildContext context) {
  double width=MediaQuery.of(context).size.width;
  double height=MediaQuery.of(context).size.height;
  final fontSize = width * height * 0.00004;
  // final screenWidth = MediaQuery.of(context).size.width;
  // final screenHeight = MediaQuery.of(context).size.height;
  final fontSizebold = (width * height) * 0.00008;
  // Calculate the height based on the screen width and height
  final imageHeight = width * height * 0.0045;
    return MaterialApp(
      theme: ThemeData(
        // Customizing the disabled color of the radio button
        radioTheme: Theme.of(context).radioTheme.copyWith(
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey; // Change this to the desired color for disabled state
            }
            return Colors.blue; // Change this to the desired color for enabled state
          }),
        ),
      ),
      home: Scaffold(
        body: SafeArea(child:

        Column(
          children: [
            Container(
              height: 300,
                child:Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/13.5,
                        child: Image.asset(
                          'assets/images/cultyvate.png',
                          height: imageHeight,
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height/15,
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Text(
                                  "Farmer",
                                  style:TextStyle(
                                      color: Color.fromRGBO(10 ,192 ,92,2),
                                      fontSize: fontSizebold,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " Device Query",
                                  style:TextStyle( color:blockcolor,

                                      fontSize: fontSizebold,
                                      fontWeight: FontWeight.bold),
                                ),
                              ] )
                      ),
                      // SizedBox(height: 10,),
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
                          Text("Device ID",style:iostextstyle(fontSize)),
                         Radio(
                              value: 2,
                              groupValue: val,
                              onChanged: (value) {
                               if(!alldata) {
                                 setState(() {
                                   val = int.parse(value.toString());
                                   // isswitched=true;
                                 });
                               }
                              },
                              activeColor: Colors.green,
                            ),

          Visibility(
              // visible: val,
              child: Text("Serial Number",style:iostextstyle(fontSize))),


                          Switch(
                            value: isswitched,
                            onChanged: (value) {
                              if(!alldata) {
                                setState(() {
                                  isswitched = value;
                                  // print(isSwitched);
                                });
                                // if(va)
                              }
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                          Text("Grid",style:iostextstyle(fontSize)),


                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:[
                          Text("Device Data",style:iostextstyle(fontSize)),
                          Checkbox(
                            value: alldata,
                            onChanged: (bool ?value) {
                            if(value!) {
                              setState(() {
                                alldata = value;
                                val=1;
                                isswitched = true;
                              });
                            }
                            else {
                              setState(() {
                                alldata = value;
                              });
                            }

                            },
                          ),

                        ]
                      ),
                      Row(
                          children: [

                            Container(
                              // height: MediaQuery.of(context).size.height/12,
                              width: MediaQuery.of(context).size.width/1.4,
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                              child: TextFormField(
                                // autovalidateMode: AutovalidateMode.onUserInteraction,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                ],
                                controller: deviceid,
                                  style:iostextstyle(fontSize),
                                decoration: InputDecoration(
                                  labelText:val==1 ||val==3? 'Device ID':'Serial Number',
                                  suffixIcon:
                                  IconButton(
                                    icon: Icon(MdiIcons.barcode),
                                    onPressed: () => scanQRpc(),
                                  ),
                                  border: OutlineInputBorder(),
                                  // counter: Offstage(),
                                ),
                              ),
                            ),
                            TextButton(
                              style:  TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.blueAccent
                              ),
                              onPressed: ()async{
                                if(deviceid.text.trim().length>3) {
                                  setState(() {
                                    devicedata = [];
                                    errormessage = "";
                                  });

                                  devicedata = await Devicedata(deviceid.text.trim());
                                }
                                else{
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Valid Device Id",
                                      backgroundColor: Colors.red
                                  );
                                }


                              },child: Text("Search",style:TextStyle( color:blockcolor,fontSize: fontSize ),),),
                          ]
                      )

                    ]
                )
            ),
            isloading==true?Center(
              child: CircularProgressIndicator(),
            ):
            devicedata.length!=0?

                isswitched?SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height-340, // Set a specific height
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: widthofgrid(devicetype: devicedata[0].devicetype, widthofscreen: width),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListView.builder(
                        itemCount: devicedata.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var data=devicedata[index];
                          Color selectedcolor=Colors.white;
                           if(index % 2 == 0){
                              selectedcolor=Colors.orange.shade200;
                           }
                          // print("device type =${data.devicetype}");
                          // if(data.devicetype=='Field Controller MP+VA+WM'){
      if(alldata==true ||data.devicetype=='ALL'){
        if(index==0){

          return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child:  Row(
                  children: [
                    SizedBox(
                      width: 170,
                      child: Text(
                        'DeviceEUIID',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 166,
                      child: Text(
                        'CreateDate',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'Level1',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'Level2',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'Level3',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'Level4',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'O Mode',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'EMCurrentB',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'EMCurrentR',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'EMCurrentY',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'EMVoltageB',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'EMVoltageR',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'EMVoltageY',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 110,
                      child: Text(
                        'EMFREQUENCY',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'EMKWH',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'EMKvah',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'PacketType',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 200,
                      child: Text(
                        'ApplicationID',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 160,
                      child: Text(
                        'HardwareSerialNumber',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'BatteryMV',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'F Version',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'W F Liters',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'W FlowCount',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 180,
                      child: Text(
                        'GateWayID',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 290,
                      child: Text(
                        'SoilMoistureSinglePointSensor',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'RO2Status',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'RO1Status',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 120,
                      child: Text(
                        'fTemperature',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'fHumidity',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 130,
                      child: Text(
                        'EMPowerFactor',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'EMRelay',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'fDistance',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 130,
                      child: Text(
                        'InterruptFlag',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'SensorFlag',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 130,
                      child: Text(
                        'TempC_DS18B20',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 160,
                      child: Text(
                        'WaterPressureKPA',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 160,
                      child: Text(
                        'WaterPressureMPA',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'LUX',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ]
              ),);
        }
      else {
          var dataafter=devicedata[index-1];
          return Card(
            color: selectedcolor,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child:  Row(
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text('${data.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 166,
                        child: Text('${convertTime(data.createDate)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.soilMoistureLevelAGL3}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.soilMoistureLevelAGL2}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.soilMoistureLevelBGL6}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.soilMoistureLevelBGL7}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.operatingMode}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.currentB}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.currentR}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.currentY}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.voltageB}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.voltageR}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.voltageY}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 110,
                        child: Text('${data.EMFREQUENCY}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.eMKWH}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.kvah}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.packetType}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 200,
                        child: Text('${data.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 160,
                        child: Text('${data.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.waterFlowTickLiters}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.waterFlowCount}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 180,
                        child: Text('${data.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 290,
                        child: Text('${data.soilMoistureSinglePoStringSensor}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.rO2Status}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.rO1Status}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 120,
                        child: Text('${data.fTemperature}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.fHumidity}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 130,
                        child: Text('${data.powerFactor}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.eMRelay}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.fDistance}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 130,
                        child: Text('${data.InterruptFlag}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.sensorFlag}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 130,
                        child: Text('${data.tempCDS18B20}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 160,
                        child: Text('${data.waterPressureKPA}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 160,
                        child: Text('${data.waterPressureMPA}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${data.lUXvalue}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                    ]
                )),
          );
        }
      }

                           else if (data.devicetype == 'Field Controller MP+VA+WM') {
      if (index == 0) {

      return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
      children: [
        SizedBox(
          width: 170,
          child: Text(
            'DeviceEUIID',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 200,
          child: Text(
            'ApplicationID',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 160,
          child: Text(
            'HardwareSerialNumber',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 100,
          child: Text(
            'BatteryMV',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 100,
          child: Text(
            'F Version',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 100,
          child: Text(
            'Level1',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 100,
          child: Text(
            'Level2',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 100,
          child: Text(
            'Level3',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 100,
          child: Text(
            'Level4',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 100,
          child: Text(
            'O Mode',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 100,
          child: Text(
            'W F Liters',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 100,
          child: Text(
            'W FlowCount',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 180,
          child: Text(
            'GateWayID',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 166,
          child: Text(
            'CreateDate',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle( color:blockcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),

      ],
      ),
      );
      }
      else {
        // List item widget
        // final dataIndex = index - 1; // Adjust the index to match the data
        var dataafter=devicedata[index-1];
        return Card(
          color:selectedcolor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text('${dataafter.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text('${dataafter.soilMoistureLevelAGL3}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text('${dataafter.soilMoistureLevelAGL2}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text('${dataafter.soilMoistureLevelBGL6}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text('${dataafter.soilMoistureLevelBGL7}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text('${dataafter.operatingMode}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text('${dataafter.waterFlowTickLiters}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text('${dataafter.waterFlowCount}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style:TextStyle( color:blockcolor,fontSize: 13),),
                ),
                SizedBox(height: 5),
              ],
            ),

          ),
        );
                          }
                          }
               else if (data.devicetype=='I/O Controller Pump Controller V1'){
      if (index == 0) {
        return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
                children: [
                  // SizedBox(width: 10,),
                  SizedBox(
                    width: 170,
                    child: Text(
                      'DeviceEUIID',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 150,
                    child: Text(
                      'ApplicationID',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text(
                      'HardwareSerialNumber',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text(
                      'O Mode',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text(
                      'WaterPressureKPA',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text(
                      'WaterPressureMPA',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text(
                      'CreatDate',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                ])
        );
      }
      else{
        var dataafter=devicedata[index-1];
        return Card(
          color:selectedcolor,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                  children: [
                  // SizedBox(width: 10),
                    SizedBox(
                      width: 170,
                      child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 160,
                      child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 200,
                      child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text('${dataafter.operatingMode}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 160,
                      child: Text('${dataafter.waterPressureKPA}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 160,
                      child: Text('${dataafter.waterPressureMPA}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 166,
                      child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),

                  ])),
        );
      }
      }
else if (data.devicetype=='LSN50 Water level Sensor'){
  if(index==0){
      return Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'BatteryMV',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'fDistance',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 130,
                  child: Text(
                    'InterruptFlag',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'SensorFlag',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 130,
                  child: Text(
                    'TempC_DS18B20',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),


              ]));
  }
  else {
      var dataafter=devicedata[index-1];
  return  Card(
      color:selectedcolor,
      child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.fDistance}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 130,
                    child: Text('${dataafter.InterruptFlag}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.sensorFlag}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 130,
                    child: Text('${dataafter.tempCDS18B20}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                ])),
  );
  }
      }
else if (data.devicetype=='Field Controller+MPSMS'){
        if(index==0){
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                  children: [
                    SizedBox(
                      width: 170,
                      child: Text(
                        'DeviceEUIID',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 200,
                      child: Text(
                        'ApplicationID',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 160,
                      child: Text(
                        'HardwareSerialNumber',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'BatteryMV',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'F Version',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'Level1',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'Level2',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'Level3',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'Level4',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 180,
                      child: Text(
                        'GateWayID',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'CreateDate',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),


                  ]));
        }
        else {
          var dataafter=devicedata[index-1];
          return Card(
            color:selectedcolor,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 200,
                        child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 160,
                        child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.soilMoistureLevelAGL3}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.soilMoistureLevelAGL2}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.soilMoistureLevelBGL6}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.soilMoistureLevelBGL7}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 180,
                        child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                    ])),
          );
        }
      }
      else if (data.devicetype=='Field Controller +Valve'){
        if(index==0){
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                  children: [
                    SizedBox(
                      width: 170,
                      child: Text(
                        'DeviceEUIID',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 200,
                      child: Text(
                        'ApplicationID',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 160,
                      child: Text(
                        'HardwareSerialNumber',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'BatteryMV',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'F Version',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'O Mode',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 180,
                      child: Text(
                        'GateWayID',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'CreateDate',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),

                  ]));
        }
        else {
          var dataafter=devicedata[index-1];
          return  Card(
            color:selectedcolor,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 200,
                        child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 160,
                        child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.operatingMode}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 180,
                        child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                    ])),
          );
        }
      }
      else if (data.devicetype=='Field Controller SP+VA+WM'){
        if(index==0){
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                  children: [
                    SizedBox(
                      width: 170,
                      child: Text(
                        'DeviceEUIID',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 200,
                      child: Text(
                        'ApplicationID',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 160,
                      child: Text(
                        'HardwareSerialNumber',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'BatteryMV',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'F Version',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 200,
                      child: Text(
                        'S M S PointSensor',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),

                    SizedBox(
                      width: 100,
                      child: Text(
                        'O Mode',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'W F Liters',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'W FlowCount',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 180,
                      child: Text(
                        'GateWayID',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 166,
                      child: Text(
                        'CreateDate',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle( color:blockcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ]));
        }
        else {
          var dataafter=devicedata[index-1];
          return  Card(
            color:selectedcolor,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 200,
                        child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 160,
                        child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width:200,
                        child: Text('${dataafter.soilMoistureSinglePoStringSensor}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                                     SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.operatingMode}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.waterFlowTickLiters}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.waterFlowCount}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 180,
                        child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 166,
                        child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                    ])),
          );
        }
      }
      else if(data.devicetype=="LUX Meter"){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'LUXvalue',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          // List item widget
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 200,
                        child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 160,
                        child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.lUXvalue}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 180,
                        child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 166,
                        child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                    ]
                )),
          );
        }
      }
      else if(data.devicetype=="Cooling Pad"){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMCurrentR',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 110,
                  child: Text(
                    'EMFREQUENCY',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMKWH',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMKvah',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 130,
                  child: Text(
                    'EMPowerFactor',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMVoltageR',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMRelay',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'PacketType',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          // List item widget
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 200,
                        child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 160,
                        child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.currentR}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 110,
                        child: Text('${dataafter.sensorFrequency}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.eMKWH}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.kvah}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 130,
                        child: Text('${dataafter.powerFactor}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.voltageR}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.eMRelay}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.packetType}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 180,
                        child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 166,
                        child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                    ]
                )),
          );
        }
      }
      else if(data.devicetype=="Exaust Fan"){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMCurrentR',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 110,
                  child: Text(
                    'EMFREQUENCY',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMKWH',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMKvah',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 130,
                  child: Text(
                    'EMPowerFactor',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMVoltageR',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMRelay',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'PacketType',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          // List item widget
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 200,
                        child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 160,
                        child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.currentR}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 110,
                        child: Text('${dataafter.sensorFrequency}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.eMKWH}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.kvah}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 130,
                        child: Text('${dataafter.powerFactor}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.voltageR}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.eMRelay}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.packetType}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 180,
                        child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 166,
                        child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                    ]
                )),
          );
        }
      }
      else if(data.devicetype=="PH Sensor"){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'PHvalue',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          // List item widget
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 200,
                        child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 160,
                        child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.pHvalue}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 180,
                        child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 166,
                        child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                    ]
                )),
          );
        }
      }

      else if(data.devicetype=="I/O Controller Pump Controller V3"){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMCurrentB',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMCurrentR',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMCurrentY',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 110,
                  child: Text(
                    'EMFREQUENCY',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMKWH',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMKvah',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 130,
                  child: Text(
                    'EMPowerFactor',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMVoltageB',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMVoltageR',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMVoltageY',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMRelay',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'PacketType',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          return Card(
            color:selectedcolor,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 200,
                        child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 160,
                        child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.currentB}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.currentR}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.currentY}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 110,
                        child: Text('${dataafter.sensorFrequency}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.eMKWH}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.kvah}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 130,
                        child: Text('${dataafter.powerFactor}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.voltageB}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.voltageR}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.voltageY}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.eMRelay}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.packetType}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 180,
                        child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 166,
                        child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                    ]
                )),
          );
        }
      }
                        else if(data.devicetype=="LSN50 AWD Ball Sensor"){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'BatteryMV',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'F Version',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Level1',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          // List item widget
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 200,
                        child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 160,
                        child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text('${dataafter.soilMoistureLevelAGL3}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 180,
                        child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 166,
                        child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                      ),
                      SizedBox(height: 5),
                    ]
                )),
          );
        }
      }
                          else if(data.devicetype=='I/O Controller Backwash BR1') {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Text(
                      'DeviceEUIID',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text(
                      'ApplicationID',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text(
                      'HardwareSerialNumber',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text(
                      'BatteryMV',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text(
                      'F Version',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text(
                      'RO1Status',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text(
                      'W F Liters',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text(
                      'W FlowCount',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text(
                      'GateWayID',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text(
                      'CreateDate',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle( color:blockcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),

                ],
              ),
            );
          }
          else {
            var dataafter=devicedata[index-1];
            // List item widget
            final dataIndex = index - 1; // Adjust the index to match the data
            return Card(
              color:selectedcolor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 170,
                      child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 200,
                      child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 160,
                      child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text('${dataafter.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text('${dataafter.rO1Status}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text('${dataafter.waterFlowTickLiters}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Text('${dataafter.waterFlowCount}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 180,
                      child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 166,
                      child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                    ),
                    SizedBox(height: 5),

                  ],
                ),

              ),
            );
          }
        }
      else if(data.devicetype=='I/O Controller Backwash BR2') {
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'BatteryMV',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'F Version',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'RO2Status',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'W F Liters',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'W FlowCount',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          // List item widget
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.rO2Status}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.waterFlowTickLiters}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.waterFlowCount}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                ],
              ),

            ),
          );
        }
      }
                          else if(data.devicetype=='Field Controller DP+VA+WM'){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'BatteryMV',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'F Version',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Level1',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Level2',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'O Mode',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'W F Liters',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'W FlowCount',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),


              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
// List item widget
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(width: 20),

                  SizedBox(
                    width:  150,
                    child: Text(
                      '${dataafter.firmwareVersion}',
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width:  150,
                    child: Text(dataafter.devicetype=='I/O Controller Backwash BR1'?
                      '${dataafter.rO1Status}':'${dataafter.rO2Status}'
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width:  150,
                    child: Text(
                      '${dataafter.waterPressureKPA}',
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width:  150,
                    child: Text(
                      '${dataafter.waterPressureMPA}',
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                      width:  300,
                      child:   DeferanceDateandTineonly(dataafter.sensorDataPacketDateTime)
                  ),

                ],
              ),

            ),
          );
        }
                          }
                          else if(data.devicetype=='I/O Controller Pump Controller V2'){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMCurrentB',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMCurrentR',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMCurrentY',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 110,
                  child: Text(
                    'EMFREQUENCY',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMKWH',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMKvah',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 130,
                  child: Text(
                    'EMPowerFactor',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMVoltageB',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMVoltageR',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMVoltageY',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'EMRelay',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'PacketType',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.currentB}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.currentR}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.currentY}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 110,
                    child: Text('${dataafter.sensorFrequency}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.eMKWH}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.kvah}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 130,
                    child: Text('${dataafter.powerFactor}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.voltageB}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.voltageR}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.voltageY}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.eMRelay}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.packetType}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),

                ],
              ),

            ),
          );
        }
                          }
      else if(data.devicetype=='I/O Controller Pump Controller V1'){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'O Mode',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'WaterPressureKPA',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'WaterPressureMPA',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.operatingMode}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.waterPressureKPA}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.waterPressureMPA}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),

                ],
              ),

            ),
          );
        }
      }
                          else if(data.devicetype=='LSN50 MPSMS' ||data.devicetype=='LSN50 AWD' ){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'BatteryMV',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'F Version',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Level1',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Level2',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Level3',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Level4',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  // SizedBox(width: 10),
                  SizedBox(
                    width: 170,
                    child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.soilMoistureLevelAGL3}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.soilMoistureLevelAGL2}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.soilMoistureLevelBGL6}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.soilMoistureLevelBGL7}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),

                ],
              ),

            ),
          );
        }

                          }
                          else if(data.devicetype=="Field Controller Water meter"){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'BatteryMV',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'F Version',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'O Mode',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'W F Liters',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'W FlowCount',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.operatingMode}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.waterFlowTickLiters}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.waterFlowCount}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),

                ],
              ),

            ),
          );
        }
                          }
                          else if (data.devicetype=='Weather Station'){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 120,
                  child: Text(
                    'fTemperature',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'fHumidity',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 120,
                  child: Text(
                    'RadiationWM2',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'RainMM',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 190,
                  child: Text(
                    'WindDirectionDegree',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 130,
                  child: Text(
                    'WindSpeedKmHr',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 120,
                    child: Text('${dataafter.fTemperature}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.fHumidity}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 120,
                    child: Text('${dataafter.radiationWM2}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.rainMM}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 190,
                    child: Text('${dataafter.windDirectionDegree}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 130,
                    child: Text('${dataafter.windSpeedKmHr}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),

                ],
              ),

            ),
          );
        }



      }
      else if (data.devicetype=='Field Controller+Valve+MPSMS'){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'BatteryMV',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'F Version',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Level1',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Level2',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Level3',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Level4',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'O Mode',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.soilMoistureLevelAGL3}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.soilMoistureLevelAGL2}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.soilMoistureLevelBGL6}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.soilMoistureLevelBGL7}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.operatingMode}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${convertTime(convertTime(dataafter.sensorDataPacketDateTime))}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                ],
              ),

            ),
          );
        }



      }
                          else if(data.devicetype=="LSN50 TemperatureHumidity"){
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'BatteryMV',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 120,
                  child: Text(
                    'fTemperature',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'fHumidity',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 120,
                    child: Text('${dataafter.fTemperature}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.fHumidity}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),

                ],
              ),

            ),
          );
        }
                          }
                          else if (data.devicetype=='LSN50 Water level Sensor'){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width:  100,
                  child: Text(
                    'Battery',
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width:  100,
                  child: Text(
                    'Distance',
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 150,
                  child: Text(
                    'SensorFlag',
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

                SizedBox(
                  width: 150,
                  child: Text(
                    'InterruptFlag',
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

                SizedBox(
                  width: 150,
                  child: Text(
                    'TempC_DS18B20',
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 5),



                SizedBox(
                  width:  200,
                  child: Text(
                    'DataPacket Time',
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(width: 10),

                  SizedBox(
                    width:  100,
                    child: Text(
                      '${dataafter.batteryMV}',
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width:  100,
                    child: Text(
                      '${dataafter.fDistance}',
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width:  150,
                    child: Text(
                      '${dataafter.sensorFlag}',
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width:  150,
                    child: Text(
                      '${dataafter.InterruptFlag}',
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width:  150,
                    child: Text(
                      '${dataafter.tempCDS18B20}',
                    ),
                  ),

                  SizedBox(height: 5),
                  SizedBox(
                      width:  300,
                      child:   DeferanceDateandTineonly(dataafter.sensorDataPacketDateTime)
                  ),

                ],
              ),

            ),
          );
        }

      }
                          else if(data.devicetype=='GHG Sensor'){
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'CH4_PPM',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'CO2_PPM',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.CH4_PPM}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.CO2_PPM}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                ],
              ),

            ),
          );
        }

      }
                          else if (data.devicetype=="CO2 Sensor"){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width:  100,
                  child: Text(
                    'CO2_PPM',
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),


                SizedBox(height: 5),
                SizedBox(
                  width:  200,
                  child: Text(
                    'DataPacket Time',
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          final dataIndex = index - 1; // Adjust the index to match the data
          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(width: 10),

                  SizedBox(
                    width:  100,
                    child: Text(
                      '${dataafter.CO2_PPM}',
                    ),
                  ),


                  SizedBox(height: 5),
                  SizedBox(
                      width:  300,
                      child:   DeferanceDateandTineonly(dataafter.sensorDataPacketDateTime)
                  ),

                ],
              ),

            ),
          );
        }
                          }
      else if (data.devicetype=="Fertigation Controller R01"){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'BatteryMV',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'F Version',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'RO1Status',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'W F Liters',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'W FlowCount',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          final dataIndex = index - 1; // Adjust the index to match the data
          return  Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(width: 10),

                  SizedBox(
                    width: 170,
                    child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.rO1Status}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.waterFlowTickLiters}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.waterFlowCount}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                ],
              ),

            ),
          );
        }
      }
      else if (data.devicetype=="Fertigation Controller R02"){

        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    'DeviceEUIID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Text(
                    'ApplicationID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 160,
                  child: Text(
                    'HardwareSerialNumber',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'BatteryMV',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'F Version',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'RO2Status',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'W F Liters',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    'W FlowCount',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 180,
                  child: Text(
                    'GateWayID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 166,
                  child: Text(
                    'CreateDate',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];

          return Card(
            color:selectedcolor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(width: 10),

                  SizedBox(
                    width: 170,
                    child: Text('${dataafter.deviceID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text('${dataafter.applicationID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 160,
                    child: Text('${dataafter.hardwareSerialNumber}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.batteryMV}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.firmwareVersion}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.rO2Status}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.waterFlowTickLiters}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text('${dataafter.waterFlowCount}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text('${dataafter.gateWayID}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 166,
                    child: Text('${convertTime(dataafter.sensorDataPacketDateTime)}', maxLines: 1, overflow: TextOverflow.ellipsis,style: textstyle),
                  ),
                  SizedBox(height: 5),
                ],
              ),

            ),
          );
        }
      }
      else{
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [

                SizedBox(height: 5),
                SizedBox(
                  width:  200,
                  child: Text(
                    'DataPacket Time',
                    style:TextStyle( color:blockcolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),
          );
        }
        else {
          var dataafter=devicedata[index-1];
          final dataIndex = index - 1; // Adjust the index to match the data
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(width: 10),
                SizedBox(
                    width:  300,
                    child:   convertTime(dataafter.sensorDataPacketDateTime)
                ),

              ],
            ),

          );
        }

      }

                          return Column(
                            children: [
                              DeferanceDateandTine(devicedata[index].sensorDataPacketDateTime),
                              // Other widgets here
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ):
      Flexible(child: ListView.builder(
      itemCount: devicedata.length,
      itemBuilder: (BuildContext context, int index) {
      return Column(

      children: [
            DeferanceDateandTineand(devicedata[index].sensorDataPacketDateTime),
      // DeferanceDateandTine(devicedata[index].sensorDataPacketDateTime),
   Card(
       child:  Textdata(devicedata[index]),
   elevation: 2,
   ),
        Divider(),

      ],
      );
      }

      ))

                :Center(child: Text(Errormessage),)

          ],
        )
        ),
      ),
    );
  }
}
