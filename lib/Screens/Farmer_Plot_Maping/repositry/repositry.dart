import 'dart:convert';
import 'dart:developer';

// import 'package:flutter_bloc_with_apis/features/posts/models/post_data_ui_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:http/http.dart' as http;
import '/Screens/Farmer_Plot_Maping/Screens/farmer_Acusation_mapping.dart';
import '/Screens/Farmer_Plot_Maping/modelclass/farmeracusationdart.dart';
import '/Screens/Innternetcheck/internet.dart';
import '/Screens/farmerAccusation/model_classes/districs.dart';
import '/Screens/farmerAccusation/model_classes/taluka_model.dart';
import '/Screens/farmerAccusation/model_classes/village_model.dart';
import '/Screens/farmerAccusation/sqllite.dart';
import '/Screens/farmerAccusation/sqllite/distics.dart';
import '/Screens/farmerAccusation/sqllite/taluka.dart';
import '/Screens/farmerAccusation/sqllite/villagesqllite.dart';
import '/Screens/farmerAccusation/widgets/state.dart';
import '/constants.dart';

import '../../../models/farmlandcordinates.dart';
import '../../../models/twokimradiusdata.dart';

class FarmerRepasitry {
  static final String baseUrl =
      'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api';
  static final Dio _dio = Dio();
  static Future<FarmerAcusation_FarmerDetails?> FeatchFarmer_from_Acusation(
      {required String mobilenumber}) async {
    final dbHelper = FarmerDatabaseHelper.instance;
    await dbHelper.initDatabase();
    print('$baseUrl/farm2fork/farmeraccusation/farmeracusation/$mobilenumber');
    try {
      final response = await _dio.get(
          '$baseUrl/farm2fork/farmeraccusation/farmeracusation/$mobilenumber');
      print("responce is ${response}");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        print(data);
        // if (data is List) {
        if (data.isNotEmpty) {
          final singleRecord = FarmerAcusation_FarmerDetails.fromJson(data);
          print(singleRecord);
          return singleRecord;
        } else {
          return null;
        }

        // }
      }
    } catch (e) {
      return throw e;
    }
    // else {
    //   return [];
    // }

    // }
  }

  static Future<List<AlreadyFarmlands>?> Featch_Polygron_Farmer_Acusation_Tabel(
      {required int farmerID, required String type}) async {
    try {
      print('$baseUrl/specialdata/farmerplotmapping/$farmerID/$type');
      final response = await _dio
          .get('$baseUrl/specialdata/farmerplotmapping/$farmerID/$type');
      print("responce is ${response}");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        print(data);
        if (data is List) {
          if (data.isNotEmpty) {
            List<AlreadyFarmlands> result =
                data.map((item) => AlreadyFarmlands.fromJson(item)).toList();
            return result;
          } else {
            return null;
          }
        } else {
          return null;
        }
      }
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<AlreadyFarmlands>?> getfarmerallreadyprecentdata(
      FarmerID) async {
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
    } finally {}
    // return returnData;
  }

  static Future getvillagedata(
      {required int villageid, required Position userlat}) async {
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
                startLatitude: userlat.latitude,
                startLongitude: userlat.longitude,
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
    } finally {}
    // return returnData;
  }

  static Future<List<Twokimradiusdata>> sendIntArray(array, villageid) async {
    List<Twokimradiusdata> Twokilomiterdata = [];

    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var body = {"listpolygronsid": array, "villageId": villageid};
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
}
