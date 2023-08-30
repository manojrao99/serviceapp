import 'dart:ui';

import 'package:google_maps_controller/google_maps_controller.dart';

class Farmermobile {
  String? farmerID;
  String? iD;
  String? name;
  String? fatherName;
  String? parent;
  String? under;
  String? clintname;
  String? address1;
  String? address2;
  String? mobileNumberPrimary;
  String? mobileNumberSecondary;
  String? fEmail;
  String? villageID;
  String? clientID;
  String? numberOfBlocks;
  String? numberOfFarmLands;
  String? numberOfPlots;
  String? sizeOfLand;
  double? latitude;
  double? longitude;
  String? gPSBoundary;
  String? expr2;
  String? plotArea;
  double? expr3;
  double? expr4;
  String? expr5;
  List<LatLng>? mapboundries=[];
  Polygon ?polygran;
  double ?area;
  Farmermobile(
      {this.farmerID,
        this.iD,
        this.name,
        this.fatherName,
        this.parent,
        this.under,
        this.clintname,
        this.address1,
        this.address2,
        this.mobileNumberPrimary,
        this.mobileNumberSecondary,
        this.fEmail,
        this.villageID,
        this.clientID,
        this.mapboundries,
        this.numberOfBlocks,
        this.numberOfFarmLands,
        this.numberOfPlots,
        this.sizeOfLand,
        this.latitude,
        this.longitude,
        this.gPSBoundary,
        this.expr2,
        this.plotArea,
        this.expr3,
        this.expr4,
        this.polygran,
        this.expr5});

  Farmermobile.fromJson(Map<String?, dynamic> json) {
    farmerID = json['FarmerID'].toString();
    iD = json['ID'].toString();
    name = json['Name'].toString();
    fatherName = json['FatherName'].toString();
    parent = json['Parent'].toString();
    under = json['under'].toString();
    clintname = json['clintname'].toString();
    address1 = json['Address1'].toString();
    address2 = json['Address2'].toString();
    mobileNumberPrimary = json['MobileNumberPrimary'].toString();
    mobileNumberSecondary = json['MobileNumberSecondary'].toString();
    fEmail = json['fEmail'].toString();
    villageID = json['VillageID'].toString();
    clientID = json['ClientID'].toString();
    numberOfBlocks = json['NumberOfBlocks'].toString();
    numberOfFarmLands = json['NumberOfFarmLands'].toString();
    numberOfPlots = json['NumberOfPlots'].toString();
    sizeOfLand = json['SizeOfLand'].toString();
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    gPSBoundary = json['GPSBoundary'].toString();
    expr2 = json['Expr2'].toString();
    plotArea = json['PlotArea'].toString();
    expr3 = json['Expr3'];
    expr4 = json['Expr4'];
    expr5 = json['Expr5'].toString();
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['FarmerID'] = this.farmerID;
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['FatherName'] = this.fatherName;
    data['Parent'] = this.parent;
    data['under'] = this.under;
    data['clintname'] = this.clintname;
    data['Address1'] = this.address1;
    data['Address2'] = this.address2;
    data['MobileNumberPrimary'] = this.mobileNumberPrimary;
    data['MobileNumberSecondary'] = this.mobileNumberSecondary;
    data['fEmail'] = this.fEmail;
    data['VillageID'] = this.villageID;
    data['ClientID'] = this.clientID;
    data['NumberOfBlocks'] = this.numberOfBlocks;
    data['NumberOfFarmLands'] = this.numberOfFarmLands;
    data['NumberOfPlots'] = this.numberOfPlots;
    data['SizeOfLand'] = this.sizeOfLand;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['GPSBoundary'] = this.gPSBoundary;
    data['Expr2'] = this.expr2;
    data['PlotArea'] = this.plotArea;
    data['Expr3'] = this.expr3;
    data['Expr4'] = this.expr4;
    data['Expr5'] = this.expr5;
    return data;
  }
}




class Farmlanddata{
  Farmermobile? farmland;
 List<Blocksdata> ?blocksdata=[];
 Farmlanddata({this.blocksdata,this.farmland});
}
class Blocksdata{
  Farmermobile? blockdata;
List<Farmermobile> ?plotsdata;
Blocksdata({this.plotsdata,this.blockdata});
}

class Farmarraay{
  List<LatLng> mapboundrieslat=[];
  Color? color;
  String? Plottype;
  LatLng?Sensorlatlang;
  Polygon ?polygran;
  double ?area;
  List<Marker> marker=[];
  String ?name;
   bool ? direct;
   bool ?inrange;
  Farmarraay({
    required this.mapboundrieslat,
    this.polygran,
    this.area,
    this.color,
    this.Plottype,
    this.Sensorlatlang,
   required this.marker,
    this.name,
    this.inrange,
    this.direct
  });
}







