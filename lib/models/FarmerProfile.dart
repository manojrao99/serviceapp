import 'dart:convert';

class Device {
  int deviceID;
  String type;
  String deviceEUIID;
  String? name;
  String? modelNumber;
  double?latitude;
  double ?longtitude;
  String? hardwareSerialNumber;
  String? farmerSectionType;

  Device(
      {required this.deviceID,
        required this.deviceEUIID,
        required this.type,
        this.name,
        this.modelNumber,
        this.latitude,
        this.longtitude,
        this.hardwareSerialNumber,
        this.farmerSectionType});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
        deviceID: json['deviceID'],
        deviceEUIID: json['deviceEUIID']??"",
        type: json['type']??"",
        name: json['name']??"",
        latitude:json['latitude']==null?0.0: double.parse(json['latitude'].toString()),
        longtitude: json['longitude']==null?0.0:double.parse(json['longitude'].toString()),

        modelNumber: json['modelNumber'],
        hardwareSerialNumber: json['hardwareSerialNumber'],
        farmerSectionType: json['farmerSectionType']);
  }
}

class Plot {
  int id;
  String? name;
  String? alias;
  String? cropName;
  String? cropAlias;
  List<Device>? devices;
  Plot(
      {required this.id,
        this.name,
        this.devices,
        this.cropName,
        this.alias,
        this.cropAlias});

  factory Plot.fromJson(Map<String, dynamic> json) {
    List<Device> devices = [];
    var plotdevices=json['devices'];
    print("plotdevices${plotdevices}");
    for (int i = 0; i < plotdevices.length; i++) {

      Device device = Device.fromJson(plotdevices[i]);
      devices.add(device);
    }
    return Plot(
      id: json['id'],
      name: json['name'] ?? '',
      alias: json['alias'] ?? '',
      devices: devices,
      cropName: json['cropName'],
      cropAlias: json['cropAlias'] ?? '',
    );
  }
}

class Block {
  int id;
  String? name;
  String? alias;
  List<Plot>? plots;
  List<Device>? devices;
  Block({required this.id, this.name, this.devices, this.plots, this.alias});

  factory Block.fromJson(Map<String, dynamic> json) {
    List<Device> devices = [];
    var blockddata=json['devices'];
    print("blockdata ${blockddata}");
    for (int i = 0; i < blockddata.length; i++) {
      Device device = Device.fromJson(blockddata[i]);
      devices.add(device);
    }
    List<Plot> plots = [];
    var plotsdata=json['plots'];
    print("plotsdata ${plotsdata}");
    for (int i = 0; i <plotsdata.length; i++) {
      Plot plot = Plot.fromJson(plotsdata[i]);
      plots.add(plot);
    }
    return Block(
        id: json['id'],
        name: json['name'] ?? '',
        alias: json['alias'] ?? '',
        devices: devices,
        plots: plots);
  }
}

class FarmLand {
  int id;
  String? name;
  String? alias;
  List<Block>? blocks;
  List<Device>? devices;
  double? lat;
  double? long;
  String? farmlandVillageName;
  String? farmlandVillageAlias;
  FarmLand(
      {required this.id,
        this.name,
        this.alias,
        this.devices,
        this.blocks,
        this.lat,
        this.long,
        this.farmlandVillageName,
        this.farmlandVillageAlias});

  factory FarmLand.fromJson(Map<String, dynamic> json) {
    List<Device> devices = [];

    for (int i = 0; i < json['devices'].length; i++) {
      Device device = Device.fromJson(json['devices'][i]);
      devices.add(device);
    }
    List<Block> blocks = [];
    var data1 =json['blocks'];
    print("data1${data1.runtimeType}");
    for (int i = 0; i < json['blocks'].length; i++) {
      Block block = Block.fromJson(json['blocks'][i]);
      blocks.add(block);
    }
    return FarmLand(
        id: json['farmland_id'],
        name: json['farmland_name'] ?? '',
        alias: json['alias'] ?? '',
        devices: devices,
        blocks: blocks,
        lat: json['lat'].toDouble() ?? 0.0,
        long: json['long'].toDouble() ?? 0,
        farmlandVillageName: json['farmlandVillageName'] ?? 'NA',
        farmlandVillageAlias: json['villageAlias'] ?? 'NA');
  }
}

class Farmer {
  int farmerID;
  String? name;
  String? alias;
  String ?MobileNumberPrimary;
  double? lat;
  String ?Address3;
  String ?ClintName;
  double? long;
  List<FarmLand> farmlands;
  int? villageID;
  String? villageName;
  String? villageAlias;

  Farmer(
      {required this.farmerID,
        required this.farmlands,
        this.name,
        this.long,
        this.lat,
        this.Address3,
        this.MobileNumberPrimary,

        this.alias,
        this.ClintName,
        this.villageID,
        this.villageName,
        this.villageAlias});

  factory Farmer.fromJson(Map<String, dynamic> json) {
    List<FarmLand> farmlands = [];
    var data=json['farmlands'];
    print("inside ${data}");
    for (int i = 0; i < data.length; i++) {
      FarmLand farmLand = FarmLand.fromJson(data[i]);
      farmlands.add(farmLand);
    }

    return Farmer(
        farmerID: json['farmerID'],
        name: json['name'] ?? '',
        farmlands: farmlands,
        lat: json['lat'].toDouble(),
        long: json['long'].toDouble(),
        alias: json['alias'] ?? '',
        MobileNumberPrimary: json['MobileNumberPrimary'].toString(),
        ClintName: json['ClintName']??"",
        Address3: json['Address3']??"",
        villageID: json["villageID"],
        villageName: json["villageName"],
        villageAlias: json["villageAlias"] ?? '');
  }
}