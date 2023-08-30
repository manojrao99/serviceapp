import 'package:flutter/material.dart';
import 'package:google_maps_controller/google_maps_controller.dart';

import '../../selectlandareadilaog.dart';

class OwnLandRow extends StatelessWidget {
  final String label;
  final bool compulsory;
  final Function() getLocation;
  final  Function(LatLng lat, dynamic color) ?onFarmerOwnArealatUpdate;
  final Function({required int acres,required int kanal,required int marala})? onLandTap;
  // final Function() onLocationTap;
  final double imageHeight;
  final double imageWidth;
  final Color? latLngColor;
  final String? acreasText;
  final String? kanalText;
  final String? maralaText;
  final int maxacreas;
  final int maxkanal;
  final int maxmarala;
  final LatLng? latlang;

  OwnLandRow({
    required this.getLocation,
     this.onFarmerOwnArealatUpdate,
    required this.label,
    required this.compulsory,
    required this.onLandTap,
    required this.imageHeight,
    required this.imageWidth,
    this.latLngColor,
    this.acreasText,
    this.kanalText,
    this.maralaText,
    required this.maxacreas,
    required this.maxkanal,
    required this.maxmarala,
    required this.latlang
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            label=='Area Under Residue Mgmt:'? Flexible(child: Text("$label",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.shortestSide * 0.032,fontWeight: FontWeight.bold),)):Text("$label", style:TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.shortestSide * 0.032,fontWeight: FontWeight.bold,),),

           Visibility(
               visible: compulsory,
               child: Text("*", style: TextStyle(color: Colors.red))),
            Spacer(),
            InkWell(
              child: Container(
                height: MediaQuery.of(context).size.height / 14,
                width: MediaQuery.of(context).size.width / 2.15,
                child: Row(
                  children: [
                    Flexible(child: _buildSmallBox(acreasText,context)),
                    SizedBox(width: 10),
                    Flexible(child: _buildSmallBox(kanalText,context)),
                    SizedBox(width: 10),
                    Flexible(child: _buildSmallBox(maralaText,context)),
                  ],
                ),
              ),
              onTap: ()async{
        String? value=    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
        return MyAlertDialogjfj(maxacreas: maxacreas,maxkanal: maxkanal,maxmarala: maxmarala);
        },
        );
        if (value != null) {
          List<String> parts = value.split('.');
          var selectedNumber = int.tryParse(parts[0]) ?? 0;
          var selectedDecimal = int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0;
          var selectedkanal = int.tryParse(parts.length > 2 ? parts[2] : '0') ?? 0;

          // Call the onLandTap function here
          if (onLandTap != null) {
            onLandTap!(acres:selectedNumber.toInt() ,kanal: selectedkanal.toInt(),marala: selectedDecimal.toInt());
            // onLandTap!({
            //   'acres': selectedNumber.toInt(),
            //   'marala': selectedkanal.toInt(),
            //   'kanal': selectedDecimal.toInt(),
            // });
          }
        }


              },
            ),
            SizedBox(width: MediaQuery.of(context).size.width / 30),
            InkWell(
              child: Container(
                height: imageHeight,
                width: imageWidth,
                child: ColorFiltered(
                  child: Image.asset(
                    "assets/images/locationping.jpg",
                    fit: BoxFit.contain,
                  ),
                  colorFilter: ColorFilter.mode(latLngColor ?? Colors.red, BlendMode.color),
                ),
              ),
              onTap: ()async{
                LatLng lat = await getLocation();
                // onFarmerOwnAreaUpdate(lat: lat, color:Colors.green : Colors.red);

                onFarmerOwnArealatUpdate!( lat, lat != null ? Colors.green : Colors.red);
              },
            ),
          ],
        ),
        Row(
            children:[
              Text(""),
              Spacer(),
              latlang !=null? Text("Latitude and Longitude:${latlang!.latitude} ${latlang!.longitude}",style:TextStyle(color:Colors.green)):Text(""),
            ]
        ),
      ],
    );
  }

  Widget _buildSmallBox(String? text,context ) {
    return Container(
      width: (MediaQuery.of(context).size.width / 2.05 / 3) - 10,
      height: MediaQuery.of(context).size.height / 16,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Center(
        child: Text(
          text ?? "",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}
