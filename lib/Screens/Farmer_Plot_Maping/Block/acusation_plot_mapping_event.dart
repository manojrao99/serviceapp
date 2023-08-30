
part of  'acusation_plot_mapping_bloc.dart';
abstract class FarmerAcusationg {}


// class PostsInitialFetchEvent extends PostsEvent{}
class FarmerDetailsFeatch extends FarmerAcusationg{
  final String mobilenumber;

  FarmerDetailsFeatch({required this.mobilenumber});
}
class FarmerVillagelatlangFeatch extends FarmerAcusationg{
  final int villageID;
  final LatLng farmer_lat_lang;
  FarmerVillagelatlangFeatch({required this.villageID,required this.farmer_lat_lang});

}
class FarmerAllreadyisthere extends FarmerAcusationg{
  final int FarmerID;
  final String type;
  final int ?villageid;
  final Position userlatlang;
  final FarmerAcusation_FarmerDetails results;
  FarmerAllreadyisthere({required this.FarmerID,required this.type,required this.results, this.villageid,required this.userlatlang});

}
class  loadongnothing extends FarmerAcusationg{
   final FarmerAcusation_FarmerDetails results;
   loadongnothing({required this.results});

}


//
// class GetVillage extends PostsEvent{}
//
// class PostFarmerData extends PostsEvent{
//   final FarmerAcusationDart body;
//   final bool locally;
//   PostFarmerData({required this.body,required this.locally});
// }
