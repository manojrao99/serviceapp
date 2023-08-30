import 'dart:async';
import 'dart:convert';

class Device {
  String? lastCommunicated;
  Timer?timer;
  bool level1fail;
  bool level2fail;
  bool level3fail;
  bool level4fail;
  bool levelallfail;
  String stopwatchtime;
  String ?DeviceID;
  bool? serviceMOde;
  Stopwatch stopwatch;
  int level1active;
  int level2active;
  int level3active;
  int level4active;
  int alllevelactive;
  int DeviceDetailsID;
  int DeviceTypeID;
  String ?hardwareserialnumber;
  int? level1;
  int  counter;
  int FarmerID;
  int? level2;
  int? level3;
  int? level4;
  bool level1tested=false;
  bool level2tested=false;
  String ?FarmerName;
  String ?ClintName;
  bool level3tested=false;
  bool level4tested=false;
  bool allleveltested=false;

  Device(
      {required this.lastCommunicated,
      required this.counter,
        required this.serviceMOde,
        required this.level1,
required this.FarmerID,
        required this.stopwatchtime,
        required this.level1active,
        required this.level2active,
        required this.level3active,
        required this.level4active,
        required this.alllevelactive,
        required this.DeviceDetailsID,
        required this.DeviceTypeID,
        this.FarmerName,
        this.ClintName,
        this.timer,
        required this.level1fail,
        required  this.level2fail,
        required this.level3fail,
        required this.level4fail,
        required this.levelallfail,
        this.DeviceID,
        required this.stopwatch,
        this.level2,
        this.hardwareserialnumber,
       required this.level1tested,
        required this.level2tested,
        required this.level3tested,
        required this.level4tested,
        required this.allleveltested,
        this.level3,
        this.level4});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      stopwatch: Stopwatch(),
        lastCommunicated :json['LastCommunicated'],
        serviceMOde : json['serviceMOde'],
        level1 : json['Level1'],
        FarmerID: json['FarmerID'],
        DeviceDetailsID: json['DeviceDetailsID'],
        DeviceTypeID: json['DeviceTypleID'],
        counter: 0,
        DeviceID: json['DeviceID'],
        stopwatchtime: "",
        level1tested: false,
        level1fail: false,
        level2fail: false,
        level3fail: false,
        level4fail: false,
        levelallfail: false,
        level2tested: false,
        alllevelactive: 0,
        level1active: 0,
        level2active: 0,
        level3active: 0,
        level4active: 0,
        level3tested: false,
        level4tested: false,
        allleveltested: false,

        FarmerName: json['FarmerName'],
        ClintName:json['ClintName'],
        level2 : json['Level2'],
        level3 : json['Level3'],
        hardwareserialnumber: json['Hardwareserialnumber'],
        level4 :json['Level4']);
  }
}

