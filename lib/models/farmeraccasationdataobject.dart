import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_controller/google_maps_controller.dart';

class FarmerData {
  String FarmerName;
  String FatherName;
  int selectedindex;
  double? index1size;
  double? index2size;
  String MobileNumber;
  String Distic;
  String Taluk;
  String Village;
  int? Disticid;
  int? Talukaid;
  int? VillageID;
  String? Co_operatieName;
  int ownland_in_acaras;
  int ownland_in_kanal;
  int ownland_in_Marala;
  LatLng? ownland_latlang;
  Color ownland_latlang_color;
  int? own_tpr_in_acaras;
  int? own_tpr_kanal;
  int? own_tpr_Marala;
  LatLng? own_area_under_tpr_latlang;
  Color own_area_under_tpr_latlang_color;
  int? own_dsr_acaras;
  int? own_dsr_in_kanal;
  int? own_dsr_in_Marala;
  LatLng? own_area_under_dsr_latlang;
  Color? own_area_under_dsr_latlang_color;
  int? own_mangedby_in_acaras;
  int? own_mangedby_in_kanal;
  int? own_mangedby_in_Marala;
  LatLng? own_area_under_mangemnet_latlang;
  Color? own_area_under_mangemnet_latlang_color;
  int leaseland_in_acaras;
  int leaseland_in_kanal;
  int leaseland_in_Marala;
  LatLng? leaseland_latlang;
  Color? leaseland_latlang_color;
  int? lease_tpr_in_acaras;
  int? lease_tpr_kanal;
  int? lease_tpr_Marala;
  LatLng? lease_tpr_latlang;
  Color? lease_tpr_latlang_color;
  int? lease_dsr_acaras;
  int? lease_dsr_in_kanal;
  int? lease_dsr_in_Marala;
  LatLng? lease_dsr_latlang;
  Color? lease_dsr_latlang_color;
  int? lease_mangedby_in_acaras;
  int? lease_mangedby_in_kanal;
  int? lease_mangedby_in_Marala;
  LatLng? lease_mangedby_latlang;
  Color? lease_mangedby_latlang_color;
  bool own_laser_leveling;
  bool own_laser_leveling_are_you_intrested;
  String? own_laser_leveling_date;
  bool own_dsr;
  bool own_dsr_are_you_intrested;
  double? own_dsr_number_of_years_fallowed;
  String? own_Somaring_Current_sesson_Date;
  String? own_transplatation_date;
  bool own_awd_are_you_intrested;
  bool own_awd;
  String? own_awd_deploymentDate;
  double? own_awd_number_of_years_sinse;
  bool own_NoTillage;
  String? ownNotillage_date;
  bool own_Notillage_are_you_intrested;
  bool own_crm_balling;
  bool own_crm_malhing;
  bool own_crm_bio_spray;
  String? own_crm_ballingdate;
  String? own_crm_malhing_date;
  String? own_crm_bio_spray_date;
  bool lease_laser_leveling;
  bool lease_laser_leveling_are_you_intrested;
  String? lease_laser_leveling_date;
  bool lease_dsr;
  bool lease_dsr_are_you_intrested;
  double lease_dsr_number_of_years_fallowed;
  String? lease_Somaring_Current_sesson_Date;
  String? lease_transplatation_date;
  bool lease_awd_are_you_intrested;
  bool lease_awd;
  String? lease_awd_deploymentDate;
  double? lease_awd_number_of_years_sinse;

  bool lease_NoTillage;
  String? lease_Notillage_date;
  bool lease_Notillage_are_you_intrested;
  bool lease_crm_balling;
  bool lease_crm_malhing;
  bool lease_crm_bio_spray;
  String? lease_crm_ballingdate;
  String? lease_crm_malhing_date;
  String? lease_crm_bio_spray_date;

  List<Uint8List>? images;

  FarmerData({
    this.selectedindex = 0,
    this.FarmerName = '',
    this.FatherName = '',
    this.index1size,
    this.index2size,
    this.MobileNumber = '',
    this.Distic = '',
    this.Taluk = '',
    this.Village = '',
    this.Disticid,
    this.Talukaid,
    this.VillageID,
    this.Co_operatieName,
    this.ownland_in_acaras = 0,
    this.ownland_in_kanal = 0,
    this.ownland_in_Marala = 0,
    this.ownland_latlang,
    this.ownland_latlang_color = Colors.red,
    this.own_tpr_in_acaras = 0,
    this.own_tpr_kanal = 0,
    this.own_tpr_Marala = 0,
    this.own_area_under_tpr_latlang,
    this.own_area_under_tpr_latlang_color = Colors.red,
    this.own_dsr_acaras = 0,
    this.own_dsr_in_kanal = 0,
    this.own_dsr_in_Marala = 0,
    this.own_area_under_dsr_latlang,
    this.own_area_under_dsr_latlang_color,
    this.own_mangedby_in_acaras = 0,
    this.own_mangedby_in_kanal = 0,
    this.own_mangedby_in_Marala = 0,
    this.own_area_under_mangemnet_latlang,
    this.own_area_under_mangemnet_latlang_color = Colors.red,
    this.leaseland_in_acaras = 0,
    this.leaseland_in_kanal = 0,
    this.leaseland_in_Marala = 0,
    this.leaseland_latlang,
    this.leaseland_latlang_color = Colors.red,
    this.lease_tpr_in_acaras = 0,
    this.lease_tpr_kanal = 0,
    this.lease_tpr_Marala = 0,
    this.lease_tpr_latlang,
    this.lease_tpr_latlang_color = Colors.red,
    this.lease_dsr_acaras = 0,
    this.lease_dsr_in_kanal = 0,
    this.lease_dsr_in_Marala = 0,
    this.lease_dsr_latlang,
    this.lease_dsr_latlang_color = Colors.red,
    this.lease_mangedby_in_acaras = 0,
    this.lease_mangedby_in_kanal = 0,
    this.lease_mangedby_in_Marala = 0,
    this.lease_mangedby_latlang,
    this.lease_mangedby_latlang_color = Colors.red,
    this.own_laser_leveling = false,
    this.own_laser_leveling_are_you_intrested = false,
    this.own_laser_leveling_date,
    this.own_dsr = false,
    this.own_dsr_are_you_intrested = false,
    this.own_dsr_number_of_years_fallowed,
    this.own_Somaring_Current_sesson_Date,
    this.own_transplatation_date,
    this.own_awd_are_you_intrested = false,
    this.own_awd = false,
    this.own_awd_deploymentDate,
    this.own_awd_number_of_years_sinse,
    this.own_NoTillage = false,
    this.ownNotillage_date,
    this.own_Notillage_are_you_intrested = false,
    this.own_crm_balling = false,
    this.own_crm_malhing = false,
    this.own_crm_bio_spray = false,
    this.own_crm_ballingdate,
    this.own_crm_malhing_date,
    this.own_crm_bio_spray_date,
    this.lease_laser_leveling = false,
    this.lease_laser_leveling_are_you_intrested = false,
    this.lease_laser_leveling_date,
    this.lease_dsr = false,
    this.lease_dsr_are_you_intrested = false,
    this.lease_dsr_number_of_years_fallowed = 0.0,
    this.lease_Somaring_Current_sesson_Date,
    this.lease_transplatation_date,
    this.lease_awd_are_you_intrested = false,
    this.lease_awd = false,
    this.lease_awd_deploymentDate,
    this.lease_awd_number_of_years_sinse,
    this.lease_NoTillage = false,
    this.lease_Notillage_date,
    this.lease_Notillage_are_you_intrested = false,
    this.lease_crm_balling = false,
    this.lease_crm_malhing = false,
    this.lease_crm_bio_spray = false,
    this.lease_crm_ballingdate,
    this.lease_crm_malhing_date,
    this.lease_crm_bio_spray_date,
  });
  Map<String, dynamic> toMap() {
    return {
      'FarmerName': FarmerName,
      'selectedindex=0': selectedindex = 0,
      'FatherName': FatherName,
      'index1size': index1size,
      'index2size': index2size,
      'MobileNumber': MobileNumber,
      'Distic': Distic,
      'Taluk': Taluk,
      'Village': Village,
      'Disticid': Disticid,
      'Talukaid': Talukaid,
      'VillageID': VillageID,
      'Co_operatieName': Co_operatieName,
      'ownland_in_acaras': ownland_in_acaras,
      'ownland_in_kanal': ownland_in_kanal,
      'ownland_in_Marala': ownland_in_Marala,
      'ownland_latlang': ownland_latlang,
      'ownland_latlang_color': ownland_latlang_color,
      'own_tpr_in_acaras': own_tpr_in_acaras,
      'own_tpr_kanal': own_tpr_kanal,
      'own_tpr_Marala': own_tpr_Marala,
      'own_area_under_tpr_latlang': own_area_under_tpr_latlang,
      'own_area_under_tpr_latlang_color': own_area_under_tpr_latlang_color,
      'own_dsr_acaras': own_dsr_acaras,
      'own_dsr_in_kanal': own_dsr_in_kanal,
      'own_dsr_in_Marala': own_dsr_in_Marala,
      'own_area_under_dsr_latlang': own_area_under_dsr_latlang,
      'own_area_under_dsr_latlang_color': own_area_under_dsr_latlang_color,
      'own_mangedby_in_acaras': own_mangedby_in_acaras,
      'own_mangedby_in_kanal': own_mangedby_in_kanal,
      'own_mangedby_in_Marala': own_mangedby_in_Marala,
      'own_area_under_mangemnet_latlang': own_area_under_mangemnet_latlang,
      'own_area_under_mangemnet_latlang_color':
          own_area_under_mangemnet_latlang_color,
      'leaseland_in_acaras': leaseland_in_acaras,
      'leaseland_in_kanal': leaseland_in_kanal,
      'leaseland_in_Marala': leaseland_in_Marala,
      'leaseland_latlang': leaseland_latlang,
      'leaseland_latlang_color': leaseland_latlang_color,
      'lease_tpr_in_acaras': lease_tpr_in_acaras,
      'lease_tpr_kanal': lease_tpr_kanal,
      'lease_tpr_Marala': lease_tpr_Marala,
      'lease_tpr_latlang': lease_tpr_latlang,
      'lease_tpr_latlang_color': lease_tpr_latlang_color,
      'lease_dsr_acaras': lease_dsr_acaras,
      'lease_dsr_in_kanal': lease_dsr_in_kanal,
      'lease_dsr_in_Marala': lease_dsr_in_Marala,
      'lease_dsr_latlang': lease_dsr_latlang,
      'lease_dsr_latlang_color': lease_dsr_latlang_color,
      'lease_mangedby_in_acaras': lease_mangedby_in_acaras,
      'lease_mangedby_in_kanal': lease_mangedby_in_kanal,
      'lease_mangedby_in_Marala': lease_mangedby_in_Marala,
      'lease_mangedby_latlang': lease_mangedby_latlang,
      'lease_mangedby_latlang_color': lease_mangedby_latlang_color,
      'own_laser_leveling': own_laser_leveling,
      'own_laser_leveling_are_you_intrested':
          own_laser_leveling_are_you_intrested,
      'own_laser_leveling_date': own_laser_leveling_date,
      'own_dsr': own_dsr,
      'own_dsr_are_you_intrested': own_dsr_are_you_intrested,
      'own_dsr_number_of_years_fallowed=0.0': own_dsr_number_of_years_fallowed =
          0.0,
      'own_Somaring_Current_sesson_Date': own_Somaring_Current_sesson_Date,
      'own_transplatation_date': own_transplatation_date,
      'own_awd_are_you_intrested': own_awd_are_you_intrested,
      'own_awd': own_awd,
      'own_awd_deploymentDate': own_awd_deploymentDate,
      'own_awd_number_of_years_sinse': own_awd_number_of_years_sinse,
      'own_NoTillage': own_NoTillage,
      'ownNotillage_date': ownNotillage_date,
      'own_Notillage_are_you_intrested': own_Notillage_are_you_intrested,
      'own_crm_balling': own_crm_balling,
      'own_crm_malhing': own_crm_malhing,
      'own_crm_bio_spray': own_crm_bio_spray,
      'own_crm_ballingdate': own_crm_ballingdate,
      'own_crm_malhing_date': own_crm_malhing_date,
      'own_crm_bio_spray_date': own_crm_bio_spray_date,
      'lease_laser_leveling': lease_laser_leveling,
      'lease_laser_leveling_are_you_intrested':
          lease_laser_leveling_are_you_intrested,
      'lease_laser_leveling_date': lease_laser_leveling_date,
      'lease_dsr': lease_dsr,
      'lease_dsr_are_you_intrested': lease_dsr_are_you_intrested,
      'lease_dsr_number_of_years_fallowed': lease_dsr_number_of_years_fallowed,
      'lease_Somaring_Current_sesson_Date': lease_Somaring_Current_sesson_Date,
      'lease_transplatation_date': lease_transplatation_date,
      'lease_awd_are_you_intrested': lease_awd_are_you_intrested,
      'lease_awd': lease_awd,
      'lease_awd_deploymentDate': lease_awd_deploymentDate,
      'lease_awd_number_of_years_sinse': lease_awd_number_of_years_sinse,
      'lease_NoTillage': lease_NoTillage,
      'lease_Notillage_date': lease_Notillage_date,
      'lease_Notillage_are_you_intrested': lease_Notillage_are_you_intrested,
      'lease_crm_balling': lease_crm_balling,
      'lease_crm_malhing': lease_crm_malhing,
      'lease_crm_bio_spray': lease_crm_bio_spray,
      'lease_crm_ballingdate': lease_crm_ballingdate,
      'lease_crm_malhing_date': lease_crm_malhing_date,
      'lease_crm_bio_spray_date': lease_crm_bio_spray_date,
    };
  }

  FarmerData copyWith({
    String? FarmerName,
    int selectedindex = 0,
    String? FatherName,
    double? index1size,
    double? index2size,
    String? MobileNumber,
    String? Distic,
    String? Taluk,
    String? Village,
    int? Disticid,
    int? Talukaid,
    int? VillageID,
    String? Co_operatieName,
    int? ownland_in_acaras,
    int? ownland_in_kanal,
    int? ownland_in_Marala,
    LatLng? ownland_latlang,
    Color? ownland_latlang_color,
    int? own_tpr_in_acaras,
    int? own_tpr_kanal,
    int? own_tpr_Marala,
    LatLng? own_area_under_tpr_latlang,
    Color? own_area_under_tpr_latlang_color,
    int? own_dsr_acaras,
    int? own_dsr_in_kanal,
    int? own_dsr_in_Marala,
    LatLng? own_area_under_dsr_latlang,
    Color? own_area_under_dsr_latlang_color,
    int? own_mangedby_in_acaras,
    int? own_mangedby_in_kanal,
    int? own_mangedby_in_Marala,
    LatLng? own_area_under_mangemnet_latlang,
    Color? own_area_under_mangemnet_latlang_color,
    int? leaseland_in_acaras,
    int? leaseland_in_kanal,
    int? leaseland_in_Marala,
    LatLng? leaseland_latlang,
    Color? leaseland_latlang_color,
    int? lease_tpr_in_acaras,
    int? lease_tpr_kanal,
    int? lease_tpr_Marala,
    LatLng? lease_tpr_latlang,
    Color? lease_tpr_latlang_color,
    int? lease_dsr_acaras,
    int? lease_dsr_in_kanal,
    int? lease_dsr_in_Marala,
    LatLng? lease_dsr_latlang,
    Color? lease_dsr_latlang_color,
    int? lease_mangedby_in_acaras,
    int? lease_mangedby_in_kanal,
    int? lease_mangedby_in_Marala,
    LatLng? lease_mangedby_latlang,
    Color? lease_mangedby_latlang_color,
    bool? own_laser_leveling,
    bool? own_laser_leveling_are_you_intrested,
    String? own_laser_leveling_date,
    bool? own_dsr,
    bool? own_dsr_are_you_intrested,
    double own_dsr_number_of_years_fallowed = 0.0,
    String? own_Somaring_Current_sesson_Date,
    String? own_transplatation_date,
    bool? own_awd_are_you_intrested,
    bool? own_awd,
    String? own_awd_deploymentDate,
    double? own_awd_number_of_years_sinse,
    bool? own_NoTillage,
    String? ownNotillage_date,
    bool? own_Notillage_are_you_intrested,
    bool? own_crm_balling,
    bool? own_crm_malhing,
    bool? own_crm_bio_spray,
    String? own_crm_ballingdate,
    String? own_crm_malhing_date,
    String? own_crm_bio_spray_date,
    bool? lease_laser_leveling,
    bool? lease_laser_leveling_are_you_intrested,
    String? lease_laser_leveling_date,
    bool? lease_dsr,
    bool? lease_dsr_are_you_intrested,
    double? lease_dsr_number_of_years_fallowed,
    String? lease_Somaring_Current_sesson_Date,
    String? lease_transplatation_date,
    bool? lease_awd_are_you_intrested,
    bool? lease_awd,
    String? lease_awd_deploymentDate,
    double? lease_awd_number_of_years_sinse,
    bool? lease_NoTillage,
    String? lease_Notillage_date,
    bool? lease_Notillage_are_you_intrested,
    bool? lease_crm_balling,
    bool? lease_crm_malhing,
    bool? lease_crm_bio_spray,
    String? lease_crm_ballingdate,
    String? lease_crm_malhing_date,
    String? lease_crm_bio_spray_date,
    List<Uint8List>? images,
  }) {
    return FarmerData(
      FarmerName: FarmerName ?? this.FarmerName,
      FatherName: FatherName ?? this.FatherName,
      index1size: index1size ?? this.index1size,
      index2size: index2size ?? this.index2size,
      selectedindex: selectedindex,
      MobileNumber: MobileNumber ?? this.MobileNumber,
      Distic: Distic ?? this.Distic,
      Taluk: Taluk ?? this.Taluk,
      Village: Village ?? this.Village,
      Disticid: Disticid ?? this.Disticid,
      Talukaid: Talukaid ?? this.Talukaid,
      VillageID: VillageID ?? this.VillageID,
      Co_operatieName: Co_operatieName ?? this.Co_operatieName,
      ownland_in_acaras: ownland_in_acaras ?? this.ownland_in_acaras,
      ownland_in_kanal: ownland_in_kanal ?? this.ownland_in_kanal,
      ownland_in_Marala: ownland_in_Marala ?? this.ownland_in_Marala,
      ownland_latlang: ownland_latlang ?? this.ownland_latlang,
      ownland_latlang_color:
          ownland_latlang_color ?? this.ownland_latlang_color,
      own_tpr_in_acaras: own_tpr_in_acaras ?? this.own_tpr_in_acaras,
      own_tpr_kanal: own_tpr_kanal ?? this.own_tpr_kanal,
      own_tpr_Marala: own_tpr_Marala ?? this.own_tpr_Marala,
      own_area_under_tpr_latlang:
          own_area_under_tpr_latlang ?? this.own_area_under_tpr_latlang,
      own_area_under_tpr_latlang_color: own_area_under_tpr_latlang_color ??
          this.own_area_under_tpr_latlang_color,
      own_dsr_acaras: own_dsr_acaras ?? this.own_dsr_acaras,
      own_dsr_in_kanal: own_dsr_in_kanal ?? this.own_dsr_in_kanal,
      own_dsr_in_Marala: own_dsr_in_Marala ?? this.own_dsr_in_Marala,
      own_area_under_dsr_latlang:
          own_area_under_dsr_latlang ?? this.own_area_under_dsr_latlang,
      own_area_under_dsr_latlang_color: own_area_under_dsr_latlang_color ??
          this.own_area_under_dsr_latlang_color,
      own_mangedby_in_acaras:
          own_mangedby_in_acaras ?? this.own_mangedby_in_acaras,
      own_mangedby_in_kanal:
          own_mangedby_in_kanal ?? this.own_mangedby_in_kanal,
      own_mangedby_in_Marala:
          own_mangedby_in_Marala ?? this.own_mangedby_in_Marala,
      own_area_under_mangemnet_latlang: own_area_under_mangemnet_latlang ??
          this.own_area_under_mangemnet_latlang,
      own_area_under_mangemnet_latlang_color:
          own_area_under_mangemnet_latlang_color ??
              this.own_area_under_mangemnet_latlang_color,
      leaseland_in_acaras: leaseland_in_acaras ?? this.leaseland_in_acaras,
      leaseland_in_kanal: leaseland_in_kanal ?? this.leaseland_in_kanal,
      leaseland_in_Marala: leaseland_in_Marala ?? this.leaseland_in_Marala,
      leaseland_latlang: leaseland_latlang ?? this.leaseland_latlang,
      leaseland_latlang_color:
          leaseland_latlang_color ?? this.leaseland_latlang_color,
      lease_tpr_in_acaras: lease_tpr_in_acaras ?? this.lease_tpr_in_acaras,
      lease_tpr_kanal: lease_tpr_kanal ?? this.lease_tpr_kanal,
      lease_tpr_Marala: lease_tpr_Marala ?? this.lease_tpr_Marala,
      lease_tpr_latlang: lease_tpr_latlang ?? this.lease_tpr_latlang,
      lease_tpr_latlang_color:
          lease_tpr_latlang_color ?? this.lease_tpr_latlang_color,
      lease_dsr_acaras: lease_dsr_acaras ?? this.lease_dsr_acaras,
      lease_dsr_in_kanal: lease_dsr_in_kanal ?? this.lease_dsr_in_kanal,
      lease_dsr_in_Marala: lease_dsr_in_Marala ?? this.lease_dsr_in_Marala,
      lease_dsr_latlang: lease_dsr_latlang ?? this.lease_dsr_latlang,
      lease_dsr_latlang_color:
          lease_dsr_latlang_color ?? this.lease_dsr_latlang_color,
      lease_mangedby_in_acaras:
          lease_mangedby_in_acaras ?? this.lease_mangedby_in_acaras,
      lease_mangedby_in_kanal:
          lease_mangedby_in_kanal ?? this.lease_mangedby_in_kanal,
      lease_mangedby_in_Marala:
          lease_mangedby_in_Marala ?? this.lease_mangedby_in_Marala,
      lease_mangedby_latlang:
          lease_mangedby_latlang ?? this.lease_mangedby_latlang,
      lease_mangedby_latlang_color:
          lease_mangedby_latlang_color ?? this.lease_mangedby_latlang_color,
      own_laser_leveling: own_laser_leveling ?? this.own_laser_leveling,
      own_laser_leveling_are_you_intrested:
          own_laser_leveling_are_you_intrested ??
              this.own_laser_leveling_are_you_intrested,
      own_laser_leveling_date:
          own_laser_leveling_date ?? this.own_laser_leveling_date,
      own_dsr: own_dsr ?? this.own_dsr,
      own_dsr_are_you_intrested:
          own_dsr_are_you_intrested ?? this.own_dsr_are_you_intrested,
      own_dsr_number_of_years_fallowed: own_dsr_number_of_years_fallowed,
      own_Somaring_Current_sesson_Date: own_Somaring_Current_sesson_Date ??
          this.own_Somaring_Current_sesson_Date,
      own_transplatation_date:
          own_transplatation_date ?? this.own_transplatation_date,
      own_awd_are_you_intrested:
          own_awd_are_you_intrested ?? this.own_awd_are_you_intrested,
      own_awd: own_awd ?? this.own_awd,
      own_awd_deploymentDate:
          own_awd_deploymentDate ?? this.own_awd_deploymentDate,
      own_awd_number_of_years_sinse:
          own_awd_number_of_years_sinse ?? this.own_awd_number_of_years_sinse,
      own_NoTillage: own_NoTillage ?? this.own_NoTillage,
      ownNotillage_date: ownNotillage_date ?? this.ownNotillage_date,
      own_Notillage_are_you_intrested: own_Notillage_are_you_intrested ??
          this.own_Notillage_are_you_intrested,
      own_crm_balling: own_crm_balling ?? this.own_crm_balling,
      own_crm_malhing: own_crm_malhing ?? this.own_crm_malhing,
      own_crm_bio_spray: own_crm_bio_spray ?? this.own_crm_bio_spray,
      own_crm_ballingdate: own_crm_ballingdate ?? this.own_crm_ballingdate,
      own_crm_malhing_date: own_crm_malhing_date ?? this.own_crm_malhing_date,
      own_crm_bio_spray_date:
          own_crm_bio_spray_date ?? this.own_crm_bio_spray_date,
      lease_laser_leveling: lease_laser_leveling ?? this.lease_laser_leveling,
      lease_laser_leveling_are_you_intrested:
          lease_laser_leveling_are_you_intrested ??
              this.lease_laser_leveling_are_you_intrested,
      lease_laser_leveling_date:
          lease_laser_leveling_date ?? this.lease_laser_leveling_date,
      lease_dsr: lease_dsr ?? this.lease_dsr,
      lease_dsr_are_you_intrested:
          lease_dsr_are_you_intrested ?? this.lease_dsr_are_you_intrested,
      lease_dsr_number_of_years_fallowed: lease_dsr_number_of_years_fallowed ??
          this.lease_dsr_number_of_years_fallowed,
      lease_Somaring_Current_sesson_Date: lease_Somaring_Current_sesson_Date ??
          this.lease_Somaring_Current_sesson_Date,
      lease_transplatation_date:
          lease_transplatation_date ?? this.lease_transplatation_date,
      lease_awd_are_you_intrested:
          lease_awd_are_you_intrested ?? this.lease_awd_are_you_intrested,
      lease_awd: lease_awd ?? this.lease_awd,
      lease_awd_deploymentDate:
          lease_awd_deploymentDate ?? this.lease_awd_deploymentDate,
      lease_awd_number_of_years_sinse: lease_awd_number_of_years_sinse ??
          this.lease_awd_number_of_years_sinse,
      lease_NoTillage: lease_NoTillage ?? this.lease_NoTillage,
      lease_Notillage_date: lease_Notillage_date ?? this.lease_Notillage_date,
      lease_Notillage_are_you_intrested: lease_Notillage_are_you_intrested ??
          this.lease_Notillage_are_you_intrested,
      lease_crm_balling: lease_crm_balling ?? this.lease_crm_balling,
      lease_crm_malhing: lease_crm_malhing ?? this.lease_crm_malhing,
      lease_crm_bio_spray: lease_crm_bio_spray ?? this.lease_crm_bio_spray,
      lease_crm_ballingdate:
          lease_crm_ballingdate ?? this.lease_crm_ballingdate,
      lease_crm_malhing_date:
          lease_crm_malhing_date ?? this.lease_crm_malhing_date,
      lease_crm_bio_spray_date:
          lease_crm_bio_spray_date ?? this.lease_crm_bio_spray_date,
    );
  }
}
