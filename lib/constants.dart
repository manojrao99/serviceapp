import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import '/models/loginAppaccess.dart';
// ;
import 'package:location/location.dart' as pkgLocation;

String cultyvateURL = 'http://20.219.2.201/farmer_mobile_uat';
// String cultyvateURL = 'http://192.168.199.1:3003';
String apiKey = "12345678";
// List <ServiceAPPlogin>? Appaccessdata;
const blockcolor = Colors.black;
double hieghthieght = 12.0;

double normaltext = 0.032;
// const size =hieghthieght;
iostextstyle(size) {
  return TextStyle(color: Colors.black, fontSize: size);
}

iostextstylebold(size) {
  return TextStyle(color: Colors.black, fontSize: size);
}

iostextstyleboldgrey(size) {
  return TextStyle(color: Colors.grey, fontSize: size);
}

iostextstylegrey(size) {
  return TextStyle(color: Colors.grey, fontSize: size);
}

double calculateDistance(
    {required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude}) {
  double distanceInMeters = Geolocator.distanceBetween(
    startLatitude,
    startLongitude,
    endLatitude,
    endLongitude,
  );

  // Convert distance from meters to kilometers
  double distanceInKm = distanceInMeters / 1000;
  print("km ${distanceInKm}");
  return distanceInKm;
}

Future retrieveLocation() async {
  pkgLocation.Location location = pkgLocation.Location();
  bool serviceEnabled;
  pkgLocation.PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      // Handle the case when the user doesn't enable the location service.
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == pkgLocation.PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != pkgLocation.PermissionStatus.granted) {
      // Handle the case when the user doesn't grant location permissions.
      return;
    }
  }

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  return position;
}
