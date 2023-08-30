class AlreadyFarmlands {
  int? iD;
  int? farmerID;
  String? farmLandName;
  double? totalAreaInSqMeter;
  String? polygonBoundaryes;
  String? creatDate;
  String ?sectionType;
  int ?Under;
  String ?SensorType;
  double ?sensorlat;
  double ?sensorlang;

  AlreadyFarmlands(
      {this.iD,
        this.farmerID,
        this.farmLandName,
        this.totalAreaInSqMeter,
        this.polygonBoundaryes,
        this.sensorlang,
        this.sensorlat,
        this.sectionType,
        this.SensorType,
        this.Under,
        this.creatDate});

  AlreadyFarmlands.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    farmerID = json['FarmerID'];
    farmLandName = json['FarmLandName'];
    totalAreaInSqMeter = json['TotalAreaInSqMeter'];
    polygonBoundaryes = json['PolygonBoundaryes'];
    creatDate = json['CreatDate'];
    sectionType='FL';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['FarmerID'] = this.farmerID;
    data['FarmLandName'] = this.farmLandName;
    data['TotalAreaInSqMeter'] = this.totalAreaInSqMeter;
    data['PolygonBoundaryes'] = this.polygonBoundaryes;
    data['CreatDate'] = this.creatDate;
    return data;
  }
}