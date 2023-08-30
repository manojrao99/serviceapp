import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serviceapp/Screens/farmerAccusation/model_classes/districs.dart';
import 'package:serviceapp/Screens/farmerAccusation/model_classes/taluka_model.dart';
import 'package:serviceapp/Screens/farmerAccusation/model_classes/village_model.dart';
import 'package:serviceapp/Screens/farmerAccusation/sqllite/distics.dart';
import 'package:serviceapp/Screens/farmerAccusation/sqllite/taluka.dart';
import 'package:serviceapp/Screens/farmerAccusation/sqllite/villagesqllite.dart';
import 'package:serviceapp/Screens/farmerAccusation/widgets/state.dart';
import 'package:dio/dio.dart';

class MyBloc extends Cubit<MyState> {
  MyBloc() : super(MyInitialState());

  final Dio _dio = Dio();
  final String baseUrl =
      'http://192.168.226.1:8085/api/farm2fork/farmeraccusation/';
  Future fetchData() async {
    emit(MyLoadingState());
    final dbHelper = DistrictDatabase.instance;
    await dbHelper.initDatabase();

    // DistrictDatabase districtDatabase = DistrictDatabase();

    try {
      final response = await _dio.get('$baseUrl/distics');
      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data['data'];
        for (var json in jsonList) {
          District district = District.fromJson(json);
          await dbHelper.insertDistrict(district);
        }
      }

      emit(MySuccessState());
    } catch (e) {
      emit(MyErrorState('Error fetching data: $e'));
    }
  }

  fetchTaluka() async {
    final dbHelper = TalukaDatabase.instance;
    await dbHelper.initDatabase();
    // emit(MyLoadingState());
    // DistrictDatabase districtDatabase = DistrictDatabase();

    try {
      final response = await _dio.get('$baseUrl/taluk');
      if (response.statusCode == 200) {
        // if(response)
        List<dynamic> jsonList = response.data['data'];
        print("data ${jsonList}");
        for (var json in jsonList) {
          Taluka taluka = Taluka.fromJson(json);
          await dbHelper.insertDistrict(taluka);
        }
      }
      // Parse the 'data' as needed and emit the success state
      // fetchDistricts();

      // emit(MySuccessState(parsedData));
    } catch (e) {
      // emit(MyErrorState('Error fetching data: $e'));
    }
  }

  fetchVillage() async {
    final dbHelper = VillageDatabase.instance;
    await dbHelper.initDatabase();
    // emit(MyLoadingState());
    // DistrictDatabase districtDatabase = DistrictDatabase();

    try {
      final response = await _dio.get('$baseUrl/villages');
      if (response.statusCode == 200) {
        // if(response)
        List<dynamic> jsonList = response.data['data'];
        print("data ${jsonList}");
        for (var json in jsonList) {
          Village village = Village.fromJson(json);
          await dbHelper.insertDistrict(village);
        }
      }
      // Parse the 'data' as needed and emit the success state
      // fetchDistricts();

      // emit(MySuccessState(parsedData));
    } catch (e) {
      // emit(MyErrorState('Error fetching data: $e'));
    }
  }

  Future<List<Village>> fetchDistricts() async {
    VillageDatabase districtDatabase = VillageDatabase();
    List<Village> distics = await districtDatabase.getVillage();
    distics.forEach((element) {
      print("block distic ${element.villageName}");
    });
    // await districtDatabase.close();
    return distics;
    // setState(() {}); // Refresh the UI
  }
}
