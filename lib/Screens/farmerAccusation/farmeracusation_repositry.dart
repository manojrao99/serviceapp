import 'dart:convert';
import 'dart:developer';

// import 'package:flutter_bloc_with_apis/features/posts/models/post_data_ui_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '/Screens/Innternetcheck/internet.dart';
import '/Screens/farmerAccusation/model_classes/districs.dart';
import '/Screens/farmerAccusation/model_classes/taluka_model.dart';
import '/Screens/farmerAccusation/model_classes/village_model.dart';
import '/Screens/farmerAccusation/sqllite.dart';
import '/Screens/farmerAccusation/sqllite/distics.dart';
import '/Screens/farmerAccusation/sqllite/taluka.dart';
import '/Screens/farmerAccusation/sqllite/villagesqllite.dart';
import '/Screens/farmerAccusation/widgets/state.dart';

class PostsRepo {
  static final String baseUrl =
      'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/farmeraccusation/';
  static final Dio _dio = Dio();
  static Future<List<District>> fetchData() async {
    final dbHelper = DistrictDatabase.instance;
    await dbHelper.initDatabase();
    try {
      final response = await _dio.get('$baseUrl/distics');
      if (response.statusCode == 200) {
        dbHelper.deleteAllRows();
        List<dynamic> jsonList = response.data['data'];
        for (var json in jsonList) {
          District district = District.fromJson(json);
          await dbHelper.insertDistrict(district);
        }
      }

      DistrictDatabase districtDatabase = DistrictDatabase();
      List<District> distics = await districtDatabase.getDistricts();
      return distics;
    } catch (e) {
      DistrictDatabase districtDatabase = DistrictDatabase();
      List<District> distics = await districtDatabase.getDistricts();
      if (distics.length > 0) {
        return distics;
      } else {
        return [];
      }
    }
  }

  static Future<bool> fetchTaluka() async {
    final dbHelper = TalukaDatabase.instance;
    await dbHelper.initDatabase();
    try {
      final response = await _dio.get('$baseUrl/taluk');
      if (response.statusCode == 200) {
        dbHelper.deleteAllRows();
        List<dynamic> jsonList = response.data['data'];
        for (var json in jsonList) {
          Taluka taluka = Taluka.fromJson(json);
          await dbHelper.insertDistrict(taluka);
        }
      }
      return true;
    } catch (e) {
      // emit(MyErrorState('Error fetching data: $e'));
      return true;
      // emit(MyErrorState('Error fetching data: $e'));
    }
  }

  static Future<bool> fetchVillage() async {
    final dbHelper = VillageDatabase.instance;
    await dbHelper.initDatabase();
    try {
      final response = await _dio.get('$baseUrl/villages');
      if (response.statusCode == 200) {
        dbHelper.deleteAllRows();
        List<dynamic> jsonList = response.data['data'];
        print("data ${jsonList}");
        for (var json in jsonList) {
          Village village = Village.fromJson(json);
          await dbHelper.insertDistrict(village);
        }
      }
      return true;
    } catch (e) {
      return true;
    }
  }

  static Future<bool> PostFarmerData(savedata, locally) async {
    final ConnectivityController _controller = ConnectivityController();
    Map<String, dynamic> data = {
      'FarmerName': savedata.farmerName ?? "",
      'FatherName': savedata!.fatherName ?? "",
      'MobileNumber': savedata!.mobileNumber ?? "",
      'VillageID': savedata!.villageID ?? 0,
      'CooperativeName': savedata!.cooperativeName ?? "",
      'OwnLandAreaAcres': savedata!.ownLandAreaAcres ?? 0,
      'OwnLandAreaKanal': savedata!.ownLandAreaKanal ?? 0,
      'OwnLandAreaMarala': savedata!.ownLandAreaMarala ?? 0,
      'OwnLandLatitude':
          savedata!.ownLandLatitude != null ? savedata!.ownLandLatitude : 0.0,
      'OwnLandLongitude':
          savedata!.ownLandLatitude != null ? savedata!.ownLandLongitude : 0.0,
      'OwnLandAreaUnderTPRAcres': savedata!.ownLandAreaUnderTPRAcres ?? 0,
      'OwnLandAreaUnderTPRKanal': savedata!.ownLandAreaUnderTPRKanal ?? 0,
      'OwnLandAreaUnderTPRMarala': savedata!.ownLandAreaUnderTPRMarala ?? 0,
      'OwnLandAreaUnderTPRLatitude':
          savedata!.ownLandAreaUnderTPRLatitude != null
              ? savedata!.ownLandAreaUnderTPRLatitude
              : 0.0,
      'OwnLandAreaUnderTPRLongitude':
          savedata!.ownLandAreaUnderTPRLatitude != null
              ? savedata!.ownLandAreaUnderTPRLongitude
              : 0.0,
      'OwnLandAreaUnderDSRAcres': savedata!.ownLandAreaUnderDSRAcres ?? 0,
      'OwnLandAreaUnderDSRKanal': savedata!.ownLandAreaUnderDSRKanal ?? 0,
      'OwnLandAreaUnderDSRMarala': savedata!.ownLandAreaUnderDSRMarala ?? 0,
      'OwnLandAreaUnderDSRLatitude':
          savedata!.ownLandAreaUnderDSRLatitude != null
              ? savedata!.ownLandAreaUnderDSRLatitude
              : 0.0,
      'OwnLandAreaUnderDSRLongitude':
          savedata!.ownLandAreaUnderDSRLongitude != null
              ? savedata!.ownLandAreaUnderDSRLongitude
              : 0.0,
      'OwnLandAreaUnderResidueMgmtAcres':
          savedata!.ownLandAreaUnderResidueMgmtAcres ?? 0,
      'OwnLandAreaUnderResidueMgmtKanal':
          savedata!.ownLandAreaUnderResidueMgmtKanal ?? 0,
      'OwnLandAreaUnderResidueMgmtMarala':
          savedata!.ownLandAreaUnderResidueMgmtMarala ?? 0,
      'OwnLandAreaUnderResidueMgmtLatitude':
          savedata!.ownLandAreaUnderResidueMgmtLatitude != null
              ? savedata!.ownLandAreaUnderResidueMgmtLatitude
              : 0.0,
      'OwnLandAreaUnderResidueMgmtLongitude':
          savedata!.ownLandAreaUnderResidueMgmtLongitude != null
              ? savedata!.ownLandAreaUnderResidueMgmtLongitude
              : 0.0,
      'OwnLandLaserLevelingYN': savedata!.ownLandLaserLevelingYN,
      'OwnLandLaserLevelingLastDate':
          savedata!.ownLandLaserLevelingLastDate == ""
              ? null
              : savedata!.ownLandLaserLevelingLastDate,
      'OwnLandLaserLevelingIntrestedYN':
          savedata!.ownLandLaserLevelingIntrestedYN,
      'OwnLandDSRYN': savedata!.ownLandDSRYN,
      'OwnLandDSRNoOfYearsFollowed': savedata!.ownLandDSRNoOfYearsFollowed,
      'OwnLandDSRSowingDateOfCurrentSeason':
          savedata!.ownLandDSRSowingDateOfCurrentSeason == ""
              ? null
              : savedata!.ownLandDSRSowingDateOfCurrentSeason,
      'OwnLandTransplantationDate': savedata!.ownLandTransplantationDate == ""
          ? null
          : savedata!.ownLandTransplantationDate,
      'OwnLandAWDYN': savedata!.ownLandAWDYN,
      'OwnLandAWDNoOfYearsFollowed': savedata!.ownLandAWDNoOfYearsFollowed,
      'OwnLandAWDDeploymentDate': savedata!.ownLandAWDDeploymentDate == ""
          ? null
          : savedata!.ownLandAWDDeploymentDate,
      'OwnLandNoTillageYN': savedata!.ownLandNoTillageYN,
      'OwnLandCRMBalingDate': savedata!.ownLandCRMBalingDate == ""
          ? null
          : savedata!.ownLandCRMBalingDate,
      'OwnLandCRMMulchingDate': savedata!.ownLandCRMMulchingDate == ""
          ? null
          : savedata!.ownLandCRMMulchingDate,
      'OwnLandCRMBioSprayDate': savedata!.ownLandCRMBioSprayDate == ''
          ? null
          : savedata!.ownLandCRMBioSprayDate,
      'LeaseLandAreaAcres': savedata!.leaseLandAreaAcres,
      'LeaseLandAreaKanal': savedata!.leaseLandAreaKanal,
      'LeaseLandAreaMarala': savedata!.leaseLandAreaMarala,
      'LeaseLandLatitude': savedata!.leaseLandLatitude,
      'LeaseLandLongitude': savedata!.leaseLandLongitude,
      'LeaseLandAreaUnderTPRAcres': savedata!.leaseLandAreaUnderTPRAcres,
      'LeaseLandAreaUnderTPRKanal': savedata!.leaseLandAreaUnderTPRKanal,
      'LeaseLandAreaUnderTPRMarala': savedata!.leaseLandAreaUnderTPRMarala,
      'LeaseLandAreaUnderTPRLatitude': savedata!.leaseLandAreaUnderTPRLatitude,
      'LeaseLandAreaUnderTPRLongitude':
          savedata!.leaseLandAreaUnderTPRLongitude,
      'LeaseLandAreaUnderDSRAcres': savedata!.leaseLandAreaUnderDSRAcres,
      'LeaseLandAreaUnderDSRKanal': savedata!.leaseLandAreaUnderDSRKanal,
      'LeaseLandAreaUnderDSRMarala': savedata!.leaseLandAreaUnderDSRMarala,
      'LeaseLandAreaUnderDSRLatitude': savedata!.leaseLandAreaUnderDSRLatitude,
      'LeaseLandAreaUnderDSRLongitude':
          savedata!.leaseLandAreaUnderDSRLongitude,
      'LeaseLandAreaUnderResidueMgmtAcres':
          savedata!.leaseLandAreaUnderResidueMgmtAcres,
      'LeaseLandAreaUnderResidueMgmtKanal':
          savedata!.leaseLandAreaUnderResidueMgmtKanal,
      'LeaseLandAreaUnderResidueMgmtMarala':
          savedata!.leaseLandAreaUnderResidueMgmtMarala,
      'LeaseLandAreaUnderResidueMgmtLatitude':
          savedata!.leaseLandAreaUnderResidueMgmtLatitude,
      'LeaseLandAreaUnderResidueMgmtLongitude':
          savedata!.leaseLandAreaUnderResidueMgmtLongitude,
      'LeaseLandLaserLevelingYN': savedata!.leaseLandLaserLevelingYN,
      'LeaseLandLaserLevelingLastDate':
          savedata!.leaseLandLaserLevelingLastDate == ""
              ? null
              : savedata!.leaseLandLaserLevelingLastDate,
      'LeaseLandLaserLevelingIntrestedYN':
          savedata!.leaseLandLaserLevelingIntrestedYN,
      'LeaseLandDSRYN': savedata!.leaseLandDSRYN,
      'LeaseLandDSRNoOfYearsFollowed': savedata!.leaseLandDSRNoOfYearsFollowed,
      'LeaseLandDSRSowingDateOfCurrentSeason':
          savedata!.leaseLandDSRSowingDateOfCurrentSeason == ""
              ? null
              : savedata!.leaseLandDSRSowingDateOfCurrentSeason,
      'LeaseLandTransplantationDate':
          savedata!.leaseLandTransplantationDate == ""
              ? null
              : savedata!.leaseLandTransplantationDate,
      'LeaseLandAWDYN': savedata!.leaseLandAWDYN,
      'LeaseLandAWDNoOfYearsFollowed':
          savedata!.leaseLandAWDNoOfYearsFollowed ?? 0,
      'LeaseLandAWDDeploymentDate': savedata!.leaseLandAWDDeploymentDate == ""
          ? null
          : savedata!.leaseLandAWDDeploymentDate,
      'LeaseLandNoTillageYN': savedata!.leaseLandNoTillageYN,
      'LeaseLandCRMBalingDate': savedata!.leaseLandCRMBalingDate == ""
          ? null
          : savedata!.leaseLandCRMBalingDate,
      'LeaseLandCRMMulchingDate': savedata!.leaseLandCRMMulchingDate == ""
          ? null
          : savedata!.leaseLandCRMMulchingDate,
      'LeaseLandCRMBioSprayDate': savedata!.leaseLandCRMBioSprayDate == ""
          ? null
          : savedata!.leaseLandCRMBioSprayDate,
      'ServiceAppGPSCamIDs': savedata!.serviceAppGPSCamIDs ?? 0,
      'UserMasterID': savedata!.userMasterID ?? 15,
    };

    await _controller.checkConnectivity();
    if (_controller.connectivityResult == ConnectivityResult.none) {
      final dbHelper = FarmerDatabaseHelper.instance;
      await dbHelper.initDatabase();
      dbHelper.insertDistrict(savedata);
      return true;
    } else {
      final dbHelper = FarmerDatabaseHelper.instance;
      await dbHelper.initDatabase();

      try {
        Map<String, String> header = {
          "content-type": "application/json",
          "API_KEY": "12345678"
        };
        // print(data);
        final response = await _dio.post('$baseUrl/FarmerAcusationv2',
            data: data, options: Options(headers: header), queryParameters: {});
        // print("responcasklfme ${response.data['status'] == true}");
        if (response.statusCode == 200) {
          if (response.data['status'] == true) {
            if (locally) {
              dbHelper.deletebyID(savedata!.id);
            } else {}
            return true;
          }
          // Navigator.pop(context);
          return true;
          // returnData = response.data;
        } else {
          return false;
        }
      } on DioError catch (e) {
        return false;
      }
    }
  }
}
