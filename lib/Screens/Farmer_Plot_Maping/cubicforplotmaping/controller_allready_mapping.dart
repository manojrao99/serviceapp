import 'package:flutter_bloc/flutter_bloc.dart';
import '/Screens/Farmer_Plot_Maping/Block/acusation_plot_mapping_bloc.dart';
import '/Screens/Farmer_Plot_Maping/repositry/repositry.dart';

import '../../../models/farmlandcordinates.dart';
import 'apicalling_alreaddy.dart';

class DataCubit extends Cubit<DataModel> {
  DataCubit() : super(DataModel(false, []));

  Future<void> fetchData(
      {required int farmerID, required String type, int? Villageid}) async {
    emit(DataModel(true, state.modelList)); // Show loading

    final List<AlreadyFarmlands>? data =
        await FarmerRepasitry.Featch_Polygron_Farmer_Acusation_Tabel(
            farmerID: farmerID, type: type);

    // Simulate API call delay
    // await Future.delayed(Duration(seconds: 2));

    emit(DataModel(false, data ?? [])); // Data fetched, loading false
  }
}
