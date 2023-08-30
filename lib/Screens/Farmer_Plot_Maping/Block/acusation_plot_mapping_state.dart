
part of  'acusation_plot_mapping_bloc.dart';
// @immutable

abstract class SearchState {

}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final FarmerAcusation_FarmerDetails results;
  SearchLoaded({required this.results});
}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}

class SearchLoadingDialog extends SearchState{}
class FarmerLatlangFeatch extends SearchState {
}
class Farmer_Allready_LatlangLoaded extends SearchState {
  final FarmerAcusation_FarmerDetails results;
final List<AlreadyFarmlands> ?polygrons;
  final List<Twokimradiusdata> ?polygrons2km;
  // FarmerLatlang_2_kmLoaded({this.polygrons});
Farmer_Allready_LatlangLoaded({this.polygrons,required this.results,this.polygrons2km}) ;
}
// class FarmerLatlang_2_kmLoaded extends SearchState {
//   final List<Polygon> ?polygrons;
//   FarmerLatlang_2_kmLoaded({this.polygrons});
// }

class Farmerloading extends SearchState {
  final FarmerAcusation_FarmerDetails results;
  Farmerloading({required this.results});
}