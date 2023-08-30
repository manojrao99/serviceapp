import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import '/Screens/Innternetcheck/internet.dart';
import '/Screens/farmerAccusation/sqllite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import '../Screens/farmerAccusation/bloc/acausationblock.dart';
import '../Screens/farmerAccusation/model_classes/farmer_model_saving.dart';
import '../utils/ErrorMessages.dart';
import '../models/farmeraccasationdataobject.dart';

class FormController extends Cubit<FarmerData> {
  FormController() : super(FarmerData());

  FarmerData formData = FarmerData();
  var selectedIndexs = 0;
  onMobileNumberChanged(dynamic value) {
    formData = state.copyWith(MobileNumber: value);
    emit(formData);
  }

  onMobileindex1Sized(double value) {
    print("size inside ${value}");
    formData = state.copyWith(index1size: value);
    emit(formData);
  }

  onMobileIndex2Sized(double value) {
    print("size inside ${value}");
    formData = state.copyWith(index2size: value);
    emit(formData);
  }

  onFarmerName(dynamic value) {
    formData = state.copyWith(FarmerName: value);
    emit(formData);
  }

  onFarmerFatherName(dynamic value) {
    formData = state.copyWith(FatherName: value);
    emit(formData);
  }

  onFarmerDistic({required String value, required int id}) {
    formData = state.copyWith(Distic: value, Disticid: id);
    emit(formData);
  }

  onFarmerTaluka({required String value, required int id}) {
    formData = state.copyWith(Taluk: value, Talukaid: id);
    emit(formData);
  }

  onFarmerVillage({required String value, required int id}) {
    formData =
        state.copyWith(Village: value, VillageID: id, Co_operatieName: value);

    emit(formData);
  }

  onFarmerCooperateName(dynamic value) {
    formData = state.copyWith(Co_operatieName: value);
    emit(formData);
  }

  onItemTapped(int index) {
    formData = state.copyWith(selectedindex: index);
    selectedIndexs = index;
    emit(formData);
  }

  onFarmer_ownland(
      {required int acres, required int kanal, required int marala}) {
    formData = state.copyWith(
        ownland_in_acaras: acres,
        ownland_in_kanal: kanal,
        ownland_in_Marala: marala);
    emit(formData);
  }

  onFarmer_own_under_managed(
      {required int acres, required int kanal, required int marala}) {
    formData = state.copyWith(
        own_mangedby_in_acaras: acres,
        own_mangedby_in_kanal: kanal,
        own_mangedby_in_Marala: marala);
    emit(formData);
  }

  onFarmer_Own_Tpr(
      {required int acres, required int kanal, required int marala}) {
    formData = state.copyWith(
        own_tpr_in_acaras: acres, own_tpr_kanal: kanal, own_tpr_Marala: marala);
    emit(formData);
  }

  onFarmer_own_Dsr(
      {required int acres, required int kanal, required int marala}) {
    formData = state.copyWith(
        own_dsr_acaras: acres,
        own_dsr_in_kanal: kanal,
        own_dsr_in_Marala: marala);
    emit(formData);
  }

  onFarmer_own_residueMgmt(
      {required int acres, required int kanal, required int marala}) {
    formData = state.copyWith(
        own_mangedby_in_acaras: acres,
        own_mangedby_in_kanal: kanal,
        own_mangedby_in_Marala: marala);
    emit(formData);
  }

  onFarmer_lease_land(
      {required int acres, required int kanal, required int marala}) {
    formData = state.copyWith(
        leaseland_in_acaras: acres,
        leaseland_in_kanal: kanal,
        leaseland_in_Marala: marala);
    emit(formData);
  }

  onFarmer_ownland_latlang_update(LatLng latlang, dynamic latlangcolor) {
    formData = state.copyWith(
        ownland_latlang: latlang, ownland_latlang_color: latlangcolor);
    emit(formData);
  }

  onFarmer_leaseland_latlang_update(LatLng latlang, dynamic latlangcolor) {
    formData = state.copyWith(
        leaseland_latlang: latlang, leaseland_latlang_color: latlangcolor);
    emit(formData);
  }

  onFarmer_own_area_under_tpr_update(LatLng latlang, dynamic latlangcolor) {
    formData = state.copyWith(
        own_area_under_tpr_latlang: latlang,
        own_area_under_tpr_latlang_color: latlangcolor);
    emit(formData);
  }

  onFarmer_lease_area_under_tpr_update(LatLng latlang, dynamic latlangcolor) {
    formData = state.copyWith(
        lease_tpr_latlang: latlang, lease_tpr_latlang_color: latlangcolor);
    emit(formData);
  }

  onFarmer_own_area_under_dsr_update(LatLng latlang, dynamic latlangcolor) {
    formData = state.copyWith(
        own_area_under_dsr_latlang: latlang,
        own_area_under_dsr_latlang_color: latlangcolor);
    emit(formData);
  }

  onFarmer_lease_area_under_dsr_latlang_update(
      LatLng latlang, dynamic latlangcolor) {
    formData = state.copyWith(
        lease_dsr_latlang: latlang, lease_dsr_latlang_color: latlangcolor);
    emit(formData);
  }

  onFarmer_own_area_under_residue_mgmt_update(
      LatLng latlang, dynamic latlangcolor) {
    formData = state.copyWith(
        own_area_under_mangemnet_latlang: latlang,
        own_area_under_mangemnet_latlang_color: latlangcolor);
    emit(formData);
  }

  onFarmer_own_area_under_residue_mgmt_latlang_update(
      LatLng latlang, dynamic latlangcolor) {
    formData = state.copyWith(
        lease_mangedby_latlang: latlang,
        lease_mangedby_latlang_color: latlangcolor);
    emit(formData);
  }

  onFarmer_own_area_under_mangemnet_update(
      {required LatLng latlang, required latlangcolor}) {
    formData = state.copyWith(
        own_area_under_mangemnet_latlang: latlang,
        own_area_under_mangemnet_latlang_color: latlangcolor);
    emit(formData);
  }

  onFarmer_lease_under_managed(
      {required int acres, required int kanal, required int marala}) {
    formData = state.copyWith(
        lease_mangedby_in_acaras: acres,
        lease_mangedby_in_kanal: kanal,
        lease_mangedby_in_Marala: marala);
    emit(formData);
  }

  onFarmer_lease_Tpr(
      {required int acres, required int kanal, required int marala}) {
    formData = state.copyWith(
        lease_tpr_in_acaras: acres,
        lease_tpr_kanal: kanal,
        lease_tpr_Marala: marala);
    emit(formData); // Notify listeners after changing data
  }

  onFarmer_lease_Dsr(
      {required int acres, required int kanal, required int marala}) {
    formData = state.copyWith(
        lease_dsr_acaras: acres,
        lease_dsr_in_kanal: kanal,
        lease_dsr_in_Marala: marala);
    emit(formData);
  }

  own_onRadio_laser_leveling_ValueChanged(bool value) {
    print("leaser leaving${value}");
    formData = state.copyWith(own_laser_leveling: value);
    emit(formData);
  }

  lease_onRadio_laser_leveling_ValueChanged(bool value) {
    formData = state.copyWith(lease_laser_leveling: value);
    emit(formData);
  }

  own_onRadio_dsr_leveling_ValueChanged(bool value) {
    print("dsr inside ${value}");
    formData = state.copyWith(own_dsr: value);
    emit(formData);
  }

  lease_onRadio_dsr_leveling_ValueChanged(bool value) {
    print("dsr inside ${value}");
    formData = state.copyWith(lease_dsr: value);
    emit(formData);
  }

  own_onRadio_awd_ValueChanged(bool value) {
    formData = state.copyWith(own_awd: value);
    emit(formData);
    // emit(state.copyWith(formData.awd = value));
    // //notifyListeners(); // Notify listeners after changing data
  }

  lease_onRadio_awd_ValueChanged(bool value) {
    formData = state.copyWith(lease_awd: value);
    emit(formData);
  }

  own_onRadio_NoTillage_ValueChanged(bool value) {
    formData = state.copyWith(own_NoTillage: value);
    emit(formData);
  }

  lease_onRadio_NoTillage_ValueChanged(bool value) {
    formData = state.copyWith(lease_NoTillage: value);
    emit(formData);
    // emit(state.copyWith(formData.NoTillage = value));
    // //notifyListeners(); // Notify listeners after changing data
  }

  own_onRadio_crm_ValueChanged(bool value) {
    // formData  = state.copyWith(own_crm :value);
    emit(formData);
    // emit(state.copyWith(formData.crm = value));
    // Notify listeners after changing data
  }

  lease_onRadio_crm_ValueChanged(bool value) {
    // formData  = state.copyWith(lease_crm :value);
    emit(formData);
    // emit(state.copyWith(formData.crm = value));
    // Notify listeners after changing data
  }

  onFarmer_Farmer_Images(Uint8List value) {
    List<Uint8List>? currentImages = state.images;

    if (currentImages == null) {
      currentImages = []; // Initialize the list if it's null
    }

    List<Uint8List> updatedImages =
        List.from(currentImages); // Create a copy of the existing list
    updatedImages.add(value); // Add the new image to the list

    formData = state.copyWith(images: updatedImages);
    emit(formData);
    // }
    // formData  = state.copyWith(formData.images:formData.images.add(value));
    // emit(state.copyWith(formData.images?.add(value)));
// Notify listeners after changing data
  }

  own_onFarmer_laser_leveling_intrested(bool value) {
    formData = state.copyWith(own_laser_leveling_are_you_intrested: value);
    emit(formData);
  }

  lease_onFarmer_laser_leveling_intrested(bool value) {
    formData = state.copyWith(lease_laser_leveling_are_you_intrested: value);
    emit(formData);
  }

  own_onFarmer_dsr_are_you_intrested(bool value) {
    formData = state.copyWith(own_dsr_are_you_intrested: value);
    emit(formData);
  }

  lease_onFarmer_dsr_are_you_intrested(bool value) {
    formData = state.copyWith(lease_dsr_are_you_intrested: value);
    emit(formData);
  }

  own_onFarmer_transplatation_are_you_intrested(bool value) {
    // formData  = state.copyWith(own_transplatation_are_you_intrested :value);
    // emit(formData);
  }
  lease_onFarmer_transplatation_are_you_intrested(bool value) {
    // formData  = state.copyWith(lease_transplatation_are_you_intrested :value);
    // emit(formData);
  }
  own_onFarmer_awd_are_you_intrested(bool value) {
    formData = state.copyWith(own_awd_are_you_intrested: value);
    emit(formData);
  }

  lease_onFarmer_awd_are_you_intrested(bool value) {
    formData = state.copyWith(lease_awd_are_you_intrested: value);
    emit(formData);
  }

  own_onFarmer_Notillage_are_you_intrested(bool value) {
    formData = state.copyWith(own_Notillage_are_you_intrested: value);
    emit(formData);
  }

  lease_onFarmer_Notillage_are_you_intrested(bool value) {
    formData = state.copyWith(lease_Notillage_are_you_intrested: value);
    emit(formData);
  }

  own_onFarmer_crm_are_you_intrested(bool value) {
    // formData  = state.copyWith(own_crm_are_you_intrested :value);
    emit(formData);
  }

  lease_onFarmer_crm_are_you_intrested(bool value) {
    // formData  = state.copyWith(lease_crm_are_you_intrested :value);
    emit(formData);
  }

  own_onFarmer_laser_leveling_date(String value) {
    formData = state.copyWith(own_laser_leveling_date: value);
    emit(formData);
  }

  lease_onFarmer_laser_leveling_date(String value) {
    formData = state.copyWith(lease_laser_leveling_date: value);
    emit(formData);
  }

  own_onFarmer_dsr_last_date(String value) {
    formData = state.copyWith(own_Somaring_Current_sesson_Date: value);
    emit(formData);
  }

  own_onFarmer_dsr_numberofyesrs(double value) {
    formData = state.copyWith(own_dsr_number_of_years_fallowed: value);
    emit(formData);
  }

  own_onFarmer_awd_numberofyesrs(double value) {
    formData = state.copyWith(own_awd_number_of_years_sinse: value);
    emit(formData);
  }

  lease_onFarmer_dsr_numberofyesrs(double value) {
    formData = state.copyWith(lease_dsr_number_of_years_fallowed: value);
    emit(formData);
  }

  lease_onFarmer_awd_numberofyesrs(double value) {
    formData = state.copyWith(lease_awd_number_of_years_sinse: value);
    emit(formData);
  }

  lease_onFarmer_laser_dsr_SolingDate(String value) {
    formData = state.copyWith(lease_Somaring_Current_sesson_Date: value);
    emit(formData);
  }

  own_onFarmer_dsr_date(String value) {
    formData = state.copyWith(own_Somaring_Current_sesson_Date: value);
    emit(formData);
  }

  lease_onFarmer_dsr_date(String value) {
    formData = state.copyWith(lease_Somaring_Current_sesson_Date: value);
    emit(formData);
  }

  own_onFarmer_transplantayion_tpr(bool value) {
    // formData  = state.copyWith(own_tpr :value);
    emit(formData);
  }

  lease_onFarmer_transplantayion_tpr(bool value) {
    // formData  = state.copyWith(lease_tpr :value);
    emit(formData);
  }

  own_onFarmer_transplantayion_date(String value) {
    // formData  = state.copyWith(own_dateof_trasplatation :value);
    emit(formData);
  }

  lease_onFarmer_transplantayion_date(String value) {
    // formData  = state.copyWith(lease_dateof_trasplatation :value);
    emit(formData);
  }

  own_onFarmer_awd_date(String value) {
    formData = state.copyWith(own_awd_deploymentDate: value);
    emit(formData);
  }

  lease_onFarmer_awd_date(String value) {
    formData = state.copyWith(lease_awd_deploymentDate: value);
    emit(formData);
  }

  own_onFarmer_awd_sinse(double value) {
    formData = state.copyWith(own_awd_number_of_years_sinse: value);
    emit(formData);
  }

  lease_onFarmer_awd_sinse(double value) {
    formData = state.copyWith(lease_awd_number_of_years_sinse: value);
    emit(formData);
  }

  onFarmer_own_transplatation_date(String value) {
    formData = state.copyWith(own_transplatation_date: value);
    emit(formData);
  }

  onFarmer_lease_transplatation_date(String value) {
    formData = state.copyWith(lease_transplatation_date: value);
    emit(formData);
  }

  onFarmer_own_awd_date(String value) {
    formData = state.copyWith(own_awd_deploymentDate: value);
    emit(formData);
  }

  onFarmer_lease_awd_date(String value) {
    formData = state.copyWith(lease_awd_deploymentDate: value);
    emit(formData);
  }

  own_onFarmer_Notillage_date(String value) {
    formData = state.copyWith(ownNotillage_date: value);
    emit(formData);
  }

  lease_onFarmer_Notillage_date(String value) {
    formData = state.copyWith(lease_Notillage_date: value);
    emit(formData);
  }

  onFarmer_own_crm_balling(bool value) {
    formData = state.copyWith(own_crm_balling: value);
    emit(formData);
  }

  onFarmer_own_crm_balling_lastdate(String value) {
    formData = state.copyWith(own_crm_ballingdate: value);
    emit(formData);
  }

  onFarmer_own_crm_mulching_date(String value) {
    formData = state.copyWith(own_crm_malhing_date: value);
    emit(formData);
  }

  onFarmer_own_crm_bio_spray_date(String value) {
    formData = state.copyWith(own_crm_bio_spray_date: value);
    emit(formData);
  }

  onFarmer_lease_crm_balling_lastdate(String value) {
    formData = state.copyWith(lease_crm_ballingdate: value);
    emit(formData);
  }

  onFarmer_lease_crm_mulching_date(String value) {
    formData = state.copyWith(lease_crm_malhing_date: value);
    emit(formData);
  }

  onFarmer_lease_crm_bio_spray_date(String value) {
    formData = state.copyWith(lease_crm_bio_spray_date: value);
    emit(formData);
  }

  onFarmer_lease_crm_balling(bool value) {
    formData = state.copyWith(lease_crm_balling: value);
    emit(formData);
  }

  onFarmer_own_crm_malhing(bool value) {
    formData = state.copyWith(own_crm_malhing: value);
    emit(formData);
  }

  onFarmer_lease_crm_malhing(bool value) {
    formData = state.copyWith(lease_crm_malhing: value);
    emit(formData);
  }

  onFarmer_own_crm_bio_spray(bool value) {
    formData = state.copyWith(own_crm_bio_spray: value);
    emit(formData);
  }

  onFarmer_lease_crm_bio_spray(bool value) {
    formData = state.copyWith(lease_crm_bio_spray: value);
    emit(formData);
  }

  onFarmer_crm_date(String value) {
    // formData  = state.copyWith(crm_date :value);
    emit(formData);
  }

  bool _isname(String? name) {
    return name!.isNotEmpty;
  }

  bool _isvillageID(int name) {
    return name.isNaN;
  }

  bool _isownland(
      {required int? aceras,
      required int? kanal,
      required int? marala,
      LatLng? lat}) {
    if ((aceras != null && aceras != 0) ||
        (kanal != null && kanal != 0) ||
        (marala != null && marala != 0)) {
      if (lat != null) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool _islandactive(
      {required int? aceras,
      required int? kanal,
      required int? marala,
      LatLng? lat}) {
    if ((aceras != null && aceras != 0) ||
        (kanal != null && kanal != 0) ||
        (marala != null && marala != 0)) {
      if (lat != null) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  bool _ischeckdata_true({required bool status, required String? date}) {
    if (status) {
      if (date == '' || date == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  bool _ischeck_date_number_of_years(
      {required bool status,
      required String? date,
      required double? numberofyears}) {
    if (status) {
      if (date == '' ||
          date == null ||
          numberofyears == 0 ||
          numberofyears == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  void NoIntent(
      {required BuildContext context,
      required String message,
      required FarmerAcusationDart data}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Connection Error'),
          content: Text('${ErrorMessages.interner_error_message}'),
          actions: <Widget>[
            TextButton(
              child: Container(
                color: Colors.green, // Set the background color
                padding: EdgeInsets.all(10), // Adjust padding as needed
                child: Text(
                  'Save Locally',
                  style: TextStyle(color: Colors.white), // Set the text color
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Container(
                color: Colors.red, // Set the background color
                padding: EdgeInsets.all(10), // Adjust padding as needed
                child: Text(
                  'NO',
                  style: TextStyle(color: Colors.white), // Set the text color
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void showValidationDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Validation Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  postdate(context, postsBloc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? username = await prefs.getInt('userid');

    FarmerAcusationDart savedata = FarmerAcusationDart(
      farmerName: state.FarmerName,
      fatherName: state.FatherName,
      mobileNumber: state.MobileNumber,
      villageID: state.VillageID ?? 0,
      cooperativeName: state.Co_operatieName ?? "",
      ownLandAreaAcres: state.ownland_in_acaras,
      ownLandAreaKanal: state.ownland_in_kanal,
      ownLandAreaMarala: state.ownland_in_Marala,
      ownLandLatitude:
          state.ownland_latlang != null ? state.ownland_latlang!.latitude : 0.0,
      ownLandLongitude: state.ownland_latlang != null
          ? state.ownland_latlang!.longitude
          : 0.0,
      ownLandAreaUnderTPRAcres: state.own_tpr_in_acaras ?? 0,
      ownLandAreaUnderTPRKanal: state.own_tpr_kanal ?? 0,
      ownLandAreaUnderTPRMarala: state.own_tpr_Marala ?? 0,
      ownLandAreaUnderTPRLatitude: state.own_area_under_tpr_latlang != null
          ? state.own_area_under_tpr_latlang!.latitude
          : 0.0,
      ownLandAreaUnderTPRLongitude: state.own_area_under_tpr_latlang != null
          ? state.own_area_under_tpr_latlang!.longitude
          : 0.0,
      ownLandAreaUnderDSRAcres: state.own_dsr_acaras ?? 0,
      ownLandAreaUnderDSRKanal: state.own_dsr_in_kanal ?? 0,
      ownLandAreaUnderDSRMarala: state.own_dsr_in_Marala ?? 0,
      ownLandAreaUnderDSRLatitude: state.own_area_under_dsr_latlang != null
          ? state.own_area_under_dsr_latlang!.latitude
          : 0.0,
      ownLandAreaUnderDSRLongitude: state.own_area_under_dsr_latlang != null
          ? state.own_area_under_dsr_latlang!.longitude
          : 0.0,
      ownLandAreaUnderResidueMgmtAcres: state.own_mangedby_in_acaras ?? 0,
      ownLandAreaUnderResidueMgmtKanal: state.own_mangedby_in_kanal ?? 0,
      ownLandAreaUnderResidueMgmtMarala: state.own_mangedby_in_Marala ?? 0,
      ownLandAreaUnderResidueMgmtLatitude:
          state.own_area_under_mangemnet_latlang != null
              ? state.own_area_under_mangemnet_latlang!.latitude
              : 0.0,
      ownLandAreaUnderResidueMgmtLongitude:
          state.own_area_under_mangemnet_latlang != null
              ? state.own_area_under_mangemnet_latlang!.longitude
              : 0.0,
      ownLandLaserLevelingYN: state.own_laser_leveling ? 1 : 0,
      ownLandLaserLevelingLastDate:
          state.own_laser_leveling ? state.own_laser_leveling_date ?? "" : "",
      ownLandLaserLevelingIntrestedYN:
          state.own_laser_leveling_are_you_intrested ? 1 : 0,
      ownLandDSRYN: state.own_dsr ? 1 : 0,
      ownLandDSRNoOfYearsFollowed:
          state.own_dsr ? state.own_dsr_number_of_years_fallowed ?? 0 : 0.0,
      ownLandDSRSowingDateOfCurrentSeason:
          state.own_dsr ? state.own_Somaring_Current_sesson_Date ?? "" : "",
      ownLandTransplantationDate: state.own_transplatation_date ?? "",
      ownLandAWDYN: state.own_awd ? 1 : 0,
      ownLandAWDNoOfYearsFollowed:
          state.own_awd ? state.own_awd_number_of_years_sinse ?? 0.0 : 0.0,
      ownLandAWDDeploymentDate:
          state.own_awd ? state.own_awd_deploymentDate ?? "" : "",
      ownLandNoTillageYN: state.own_NoTillage ? 1 : 0,
      ownLandCRMBalingDate:
          state.own_crm_balling ? state.own_crm_ballingdate ?? "" : "",
      ownLandCRMMulchingDate:
          state.own_crm_malhing ? state.own_crm_malhing_date ?? "" : "",
      ownLandCRMBioSprayDate:
          state.own_crm_bio_spray ? state.own_crm_bio_spray_date ?? "" : "",
      leaseLandAreaAcres: state.leaseland_in_acaras,
      leaseLandAreaKanal: state.leaseland_in_kanal,
      leaseLandAreaMarala: state.leaseland_in_Marala,
      leaseLandLatitude: state.leaseland_latlang != null
          ? state.leaseland_latlang?.latitude ?? 0
          : 0.0,
      leaseLandLongitude: state.leaseland_latlang != null
          ? state.leaseland_latlang?.longitude ?? 0.0
          : 0.0,
      leaseLandAreaUnderTPRAcres: state.lease_tpr_in_acaras ?? 0,
      leaseLandAreaUnderTPRKanal: state.lease_tpr_kanal ?? 0,
      leaseLandAreaUnderTPRMarala: state.lease_tpr_Marala ?? 0,
      leaseLandAreaUnderTPRLatitude: state.lease_tpr_latlang != null
          ? state.lease_tpr_latlang!.latitude
          : 0.0,
      leaseLandAreaUnderTPRLongitude: state.lease_tpr_latlang != null
          ? state.lease_tpr_latlang!.longitude
          : 0.0,
      leaseLandAreaUnderDSRAcres: state.lease_dsr_acaras ?? 0,
      leaseLandAreaUnderDSRKanal: state.lease_dsr_in_kanal ?? 0,
      leaseLandAreaUnderDSRMarala: state.lease_tpr_Marala ?? 0,
      leaseLandAreaUnderDSRLatitude: state.lease_dsr_latlang != null
          ? state.lease_dsr_latlang!.latitude
          : 0.0,
      leaseLandAreaUnderDSRLongitude: state.lease_dsr_latlang != null
          ? state.lease_dsr_latlang!.longitude
          : 0.0,
      leaseLandAreaUnderResidueMgmtAcres: state.lease_mangedby_in_acaras ?? 0,
      leaseLandAreaUnderResidueMgmtKanal: state.lease_mangedby_in_kanal ?? 0,
      leaseLandAreaUnderResidueMgmtMarala: state.lease_mangedby_in_Marala ?? 0,
      leaseLandAreaUnderResidueMgmtLatitude:
          state.lease_mangedby_latlang != null
              ? state.lease_mangedby_latlang!.latitude
              : 0.0,
      leaseLandAreaUnderResidueMgmtLongitude:
          state.lease_mangedby_latlang != null
              ? state.lease_mangedby_latlang!.longitude
              : 0.0,
      leaseLandLaserLevelingYN: state.lease_laser_leveling ? 1 : 0,
      leaseLandLaserLevelingLastDate: state.lease_laser_leveling
          ? state.lease_laser_leveling_date ?? ""
          : "",
      leaseLandLaserLevelingIntrestedYN:
          state.lease_laser_leveling_are_you_intrested ? 1 : 0,
      leaseLandDSRYN: state.lease_dsr ? 1 : 0,
      leaseLandDSRNoOfYearsFollowed:
          state.lease_dsr ? state.lease_dsr_number_of_years_fallowed : 0.0,
      leaseLandDSRSowingDateOfCurrentSeason:
          state.lease_dsr ? state.lease_Somaring_Current_sesson_Date ?? "" : "",
      leaseLandTransplantationDate: state.lease_transplatation_date ?? "",
      leaseLandAWDYN: state.lease_awd ? 1 : 0,
      leaseLandAWDNoOfYearsFollowed:
          state.lease_awd ? state.lease_awd_number_of_years_sinse ?? 0.0 : 0.0,
      leaseLandAWDDeploymentDate:
          state.lease_awd ? state.lease_awd_deploymentDate ?? "" : "",
      leaseLandNoTillageYN: state.lease_NoTillage ? 1 : 0,
      leaseLandCRMBalingDate:
          state.lease_crm_balling ? state.lease_crm_ballingdate ?? "" : "",
      leaseLandCRMMulchingDate:
          state.lease_crm_malhing ? state.lease_crm_malhing_date ?? "" : "",
      leaseLandCRMBioSprayDate:
          state.lease_crm_bio_spray ? state.lease_crm_bio_spray_date ?? "" : "",
      serviceAppGPSCamIDs: '0',
      userMasterID: username ?? 0,
    );

    // final PostsBloc postsBloc = PostsBloc();
    postsBloc.add(PostFarmerData(body: savedata, locally: false));
  }

  onSaveButtonPressed(context, postsBloc) async {
    if (state.FarmerName == null || !_isname(state.FarmerName)) {
      print("inside ");
      showValidationDialog(context, ErrorMessages.FarmerName_mandatory);
    } else if (state.FatherName == null || !_isname(state.FatherName)) {
      print("inside ");
      showValidationDialog(context, ErrorMessages.FatherName_mandatory);
    } else if (state.MobileNumber == null || !_isname(state.MobileNumber)) {
      print("inside ");
      showValidationDialog(context, ErrorMessages.Farmermobile_mandatory);
    } else if (state.own_transplatation_date == null ||
        !_isname(state.own_transplatation_date ?? null)) {
      print("inside ");
      showValidationDialog(context, "Transplantation  Date is compulsory");
    } else if (state.Distic == null || !_isname(state.Distic)) {
      print("inside ");
      showValidationDialog(context, ErrorMessages.Distiic_mandatory);
    } else if (state.Taluk == null || !_isname(state.Taluk)) {
      print("inside ");
      showValidationDialog(context, ErrorMessages.Taluk_mandatory);
    } else if (state.Village == null || !_isname(state.Village)) {
      print("inside ");
      showValidationDialog(context, ErrorMessages.Village_mandatory);
    } else if (!_isownland(
        aceras: state.ownland_in_acaras,
        marala: state.ownland_in_Marala,
        kanal: state.ownland_in_kanal,
        lat: state.ownland_latlang)) {
      showValidationDialog(context, ErrorMessages.own_Land_mandatory);
    } else if (!_isownland(
        aceras: state.own_tpr_in_acaras,
        marala: state.own_tpr_Marala,
        kanal: state.own_tpr_kanal,
        lat: state.own_area_under_tpr_latlang)) {
      showValidationDialog(context, ErrorMessages.own_Tpr_mandatory);
    } else if (!_islandactive(
        aceras: state.own_dsr_acaras,
        kanal: state.own_dsr_in_kanal,
        marala: state.own_dsr_in_Marala,
        lat: state.own_area_under_dsr_latlang)) {
      showValidationDialog(context, ErrorMessages.own_Dsr_lat_mandatory);
    } else if (!_islandactive(
        aceras: state.own_mangedby_in_acaras,
        kanal: state.own_mangedby_in_kanal,
        marala: state.own_mangedby_in_Marala,
        lat: state.own_area_under_mangemnet_latlang)) {
      showValidationDialog(context, ErrorMessages.own_residue_lat_mandatory);
    } else if (!_islandactive(
        aceras: state.leaseland_in_acaras,
        kanal: state.leaseland_in_kanal,
        marala: state.leaseland_in_Marala,
        lat: state.leaseland_latlang)) {
      showValidationDialog(context, ErrorMessages.lease_Land_mandatory);
    } else if (!_islandactive(
        aceras: state.lease_tpr_in_acaras,
        kanal: state.lease_tpr_kanal,
        marala: state.lease_tpr_Marala,
        lat: state.lease_tpr_latlang)) {
      showValidationDialog(context, ErrorMessages.lease_Tpr_mandatory);
    } else if (!_islandactive(
        aceras: state.lease_dsr_acaras,
        kanal: state.lease_dsr_in_kanal,
        marala: state.lease_dsr_in_Marala,
        lat: state.lease_dsr_latlang)) {
      showValidationDialog(context, ErrorMessages.lease_Dsr_lat_mandatory);
    } else if (!_islandactive(
        aceras: state.lease_mangedby_in_acaras,
        kanal: state.lease_mangedby_in_kanal,
        marala: state.lease_mangedby_in_Marala,
        lat: state.lease_mangedby_latlang)) {
      showValidationDialog(context, ErrorMessages.lease_residue_lat_mandatory);
    } else if (!_ischeckdata_true(
        status: state.own_laser_leveling,
        date: state.own_laser_leveling_date ?? null)) {
      showValidationDialog(
          context, ErrorMessages.own_laser_leveling_date_mandatory);
    } else if (!_ischeck_date_number_of_years(
        status: state.own_dsr,
        date: state.own_Somaring_Current_sesson_Date ?? null,
        numberofyears: state.own_dsr_number_of_years_fallowed ?? null)) {
      showValidationDialog(
          context, ErrorMessages.own_dsr_number_of_years_date_mandatory);
    } else if (!_ischeck_date_number_of_years(
        status: state.own_awd,
        date: state.own_awd_deploymentDate ?? null,
        numberofyears: state.own_awd_number_of_years_sinse ?? null)) {
      showValidationDialog(
          context, ErrorMessages.own_awd_number_of_years_date_mandatory);
    } else if (!_ischeckdata_true(
        status: state.lease_laser_leveling,
        date: state.lease_laser_leveling_date ?? null)) {
      showValidationDialog(
          context, ErrorMessages.lease_laser_leveling_date_mandatory);
    } else if (!_ischeck_date_number_of_years(
        status: state.lease_dsr,
        date: state.lease_Somaring_Current_sesson_Date ?? null,
        numberofyears: state.lease_dsr_number_of_years_fallowed)) {
      showValidationDialog(
          context, ErrorMessages.own_dsr_number_of_years_date_mandatory);
    } else if (!_ischeck_date_number_of_years(
        status: state.lease_awd,
        date: state.lease_awd_deploymentDate ?? null,
        numberofyears: state.lease_awd_number_of_years_sinse ?? null)) {
      showValidationDialog(
          context, ErrorMessages.lease_awd_number_of_years_date_mandatory);
    } else if (!_ischeckdata_true(
        status: state.own_NoTillage, date: state.ownNotillage_date ?? null)) {
      showValidationDialog(context, ErrorMessages.own_notillage_date);
    } else if (!_ischeckdata_true(
        status: state.lease_NoTillage,
        date: state.lease_Notillage_date ?? null)) {
      showValidationDialog(context, ErrorMessages.lease_notillage_date);
    } else if (!_ischeckdata_true(
        status: state.own_crm_balling,
        date: state.own_crm_ballingdate ?? null)) {
      showValidationDialog(context, ErrorMessages.own_crm_baling_date);
    } else if (!_ischeckdata_true(
        status: state.own_crm_malhing,
        date: state.own_crm_malhing_date ?? null)) {
      showValidationDialog(context, ErrorMessages.own_crm_Mulching_date);
    } else if (!_ischeckdata_true(
        status: state.own_crm_bio_spray,
        date: state.own_crm_bio_spray_date ?? null)) {
      showValidationDialog(context, ErrorMessages.own_crm_bio_spray_date);
    } else if (!_ischeckdata_true(
        status: state.lease_crm_balling,
        date: state.lease_crm_ballingdate ?? null)) {
      showValidationDialog(context, ErrorMessages.lease_crm_baling_date);
    } else if (!_ischeckdata_true(
        status: state.lease_crm_malhing,
        date: state.lease_crm_malhing_date ?? null)) {
      showValidationDialog(context, ErrorMessages.lease_crm_Mulching_date);
    } else if (!_ischeckdata_true(
        status: state.lease_crm_bio_spray,
        date: state.lease_crm_bio_spray_date ?? null)) {
      showValidationDialog(context, ErrorMessages.lease_crm_bio_spray_date);
    } else {
      postdate(context, postsBloc);
    }
  }
  // When you call onSaveButtonPressed() and save the data, the values will be printed to the console, allowing you to see the saved data. Remember that this will only display the values in the debug console, so make sure you're running your app in a debug environment to see the printed output.

  Future getLocation() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // debugPrint('location: ${position.latitude} ${position.longitude}');
      // getAddressFromCoordinates(position);
      final coordinates = new LatLng(position.latitude, position.longitude);
      // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      // var first = addresses.first;
      // print("${first.featureName} : ${first.addressLine}");
      return LatLng(position.latitude, position.longitude);

      // Permission granted, handle your location logic here
      // For example, update the UI with the user's location
    } else if (status.isDenied) {
      getLocation();
      // Permission denied for the first time
    } else if (status.isPermanentlyDenied) {
      // Permission denied permanently, show user a settings dialog
      // _showSettingsDialog();
    }
  }

  // Future<LatLng> getLocation() async {
  //
  // }
}
