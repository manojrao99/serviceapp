import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:http/http.dart' as http;
import '/Screens/Farmer_Plot_Maping/Screens/farmer_Acusation_mapping.dart';
import '/Screens/Farmer_Plot_Maping/modelclass/farmeracusationdart.dart';
import '/Screens/Farmer_Plot_Maping/repositry/repositry.dart';
import '/models/farmlandcordinates.dart';
import '/models/twokimradiusdata.dart';
import 'dart:convert';

import '../../../utils/ErrorMessages.dart';
part 'acusation_plot_mapping_event.dart';
part './acusation_plot_mapping_state.dart';
// import 'search_state.dart';

class SearchBloc extends Bloc<FarmerAcusationg, SearchState> {
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(FarmerAcusationg event) async* {
    if (event is FarmerDetailsFeatch) {
      yield SearchLoading();
      try {
        final FarmerAcusation_FarmerDetails? farmerdetails =
            await FarmerRepasitry.FeatchFarmer_from_Acusation(
                mobilenumber: event.mobilenumber);
        if (farmerdetails != null) {
          yield SearchLoaded(results: farmerdetails);
        } else {
          yield SearchError(
              ErrorMessages.farmer_accusation_no_farmer_on_mobile);
        }
      } catch (e) {
        yield SearchError(e.toString());
      }
    } else if (event is FarmerAllreadyisthere) {
      yield SearchLoadingDialog();
      try {
        final List<AlreadyFarmlands>? farmerdetails =
            await FarmerRepasitry.Featch_Polygron_Farmer_Acusation_Tabel(
                farmerID: event.FarmerID, type: event.type);

        if (farmerdetails != null) {
          yield Farmer_Allready_LatlangLoaded(
              polygrons: farmerdetails, results: event.results);
        } else {
          List<int> polygronsids = await FarmerRepasitry.getvillagedata(
              villageid: event.villageid ?? 0, userlat: event.userlatlang);
          if (polygronsids.length > 0) {
            final List<Twokimradiusdata>? kmdata =
                await FarmerRepasitry.sendIntArray(
                    polygronsids, event.villageid);
            if (kmdata!.length > 0) {
              yield Farmer_Allready_LatlangLoaded(
                  polygrons: [], results: event.results, polygrons2km: kmdata);
            } else {
              yield Farmer_Allready_LatlangLoaded(
                polygrons: [],
                results: event.results,
                polygrons2km: [],
              );
            }
          } else {
            yield Farmer_Allready_LatlangLoaded(
                polygrons: [], results: event.results, polygrons2km: []);
          }
        }
      } catch (e) {
        //   yield SearchError(
        //       ErrorMessages.farmer_accusation_no_farmer_on_mobile);
        // }
        yield SearchError(e.toString());
      }
    } else if (event is loadongnothing) {
      FarmerAcusation_FarmerDetails farmer = event.results;

      yield Farmerloading(results: farmer);
    }
  }
}
