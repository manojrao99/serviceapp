import 'package:flutter/material.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:maps_toolkit/maps_toolkit.dart'  as mp;
const double footerFont = 12;
const double headingFont = 32;
const double heading2Font = 22;
const double bodyFont = 18;
const assetImagePath = 'assets/images/';
Color cultBlack = Color(0xff091F2F);
Color cultGrey = Color(0xff394D5C);
Color cultSoftGrey = Color(0xff88949D);
Color cultLightGrey = Color(0xffF2F5F5);
Color cultGreen = Color(0xff118F80);
Color cultOlive = Color(0xff118F80);
const Color cultRed = const Color(0xfffc3f4c);
Color cultRedOpacity = const Color.fromRGBO(252, 63, 75, 0.15);
Color cultGreenOpacity = const Color.fromRGBO(17, 143, 128, 0.15);
Color cultYellow = const Color.fromRGBO(255, 213, 96, 1);
Color progressGrey = const Color.fromRGBO(225, 234, 233, 1);
  Fontstylecustom(height ,width){
   final fontSize = width * height * 0.00004;
         return TextStyle(color: Colors.black,fontSize: fontSize);
  }





 Areacalculate( List<LatLng>data){
  print("data  joson ${data}");
  List<mp.LatLng> latlang=[];
  data.forEach((element) {
   mp.LatLng toolkitLatLng = mp.LatLng(
    element.latitude,
    element.longitude,
   );
   latlang.add(toolkitLatLng);
  });


 // List<mp.LatLng> datamap =data;
  final areaInSquareMeters =  mp.SphericalUtil.computeArea(latlang);
  // final geoJSONPolygon =await  GeoJSONPolygon(data);
  // final geoJSONPolygon1 =await  GeoJSONPolygon.fromMap(data);
// var areaInSquareMeters = await SphericalUtil.computeArea(data);
print("area in squre metters ${areaInSquareMeters}");
return areaInSquareMeters;
}