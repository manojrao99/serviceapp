class FarmerAccuastionPlotmaping {
  int ? iD;
  String ? farmerName;
  String ? fatherName;
  int ? mobileNumber;
  int ? villageID;
  int ? clientID;
  int ? operateArea;
  int ? areaUnderPaddy;
  int ? areaUnderResidueManagement;
  int ? areaManagerByClient;
  double ? latitude;
  double ? longitude;
  bool ? laserLevelingYN;
  String ? laserLevelingLastDate;
  bool ? laserLevelingIntrestedYN;
  bool ? dSRYN;
  String ? dSRLastDate;
  bool ? dSRIntrestedYN;
  bool ? transplantationYN;
  String ? transplantationLastDate;
  bool ? transplantationIntrestedYN;
  bool ? aWDYN;
  String ? aWDLastDate;
  bool ? aWDIntrestedYN;
  bool ? noTillageYN;
  String ? noTillageLastDate;
  bool ? noTillageIntrestedYN;
  bool ? cRMYN;
  String ? cRMLastDate;
  bool ? cRMIntrestedYN;
  String ? serviceAppGPSCamIDs;
  String ? name;
  String ? cilintName;

  FarmerAccuastionPlotmaping(
      {this.iD,
        this.farmerName,
        this.fatherName,
        this.mobileNumber,
        this.villageID,
        this.clientID,
        this.operateArea,
        this.areaUnderPaddy,
        this.areaUnderResidueManagement,
        this.areaManagerByClient,
        this.latitude,
        this.longitude,
        this.laserLevelingYN,
        this.laserLevelingLastDate,
        this.laserLevelingIntrestedYN,
        this.dSRYN,
        this.dSRLastDate,
        this.dSRIntrestedYN,
        this.transplantationYN,
        this.transplantationLastDate,
        this.transplantationIntrestedYN,
        this.aWDYN,
        this.aWDLastDate,
        this.aWDIntrestedYN,
        this.noTillageYN,
        this.noTillageLastDate,
        this.noTillageIntrestedYN,
        this.cRMYN,
        this.cRMLastDate,
        this.cRMIntrestedYN,
        this.serviceAppGPSCamIDs,
        this.name,
        this.cilintName});

  FarmerAccuastionPlotmaping.fromJson(Map<String ?, dynamic> json) {
    iD = json['ID'];
    farmerName = json['FarmerName'];
    fatherName = json['FatherName'];
    mobileNumber = json['MobileNumber'];
    villageID = json['VillageID'];
    clientID = json['ClientID'];
    operateArea = json['OperateArea'];
    areaUnderPaddy = json['AreaUnderPaddy'];
    areaUnderResidueManagement = json['AreaUnderResidueManagement'];
    areaManagerByClient = json['AreaManagerByClient'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    laserLevelingYN = json['LaserLevelingYN'];
    laserLevelingLastDate = json['LaserLevelingLastDate']??"";
    laserLevelingIntrestedYN = json['LaserLevelingIntrestedYN'];
    dSRYN = json['DSRYN'];
    dSRLastDate = json['DSRLastDate']??"";
    dSRIntrestedYN = json['DSRIntrestedYN'];
    transplantationYN = json['TransplantationYN'];
    transplantationLastDate = json['TransplantationLastDate']??'';
    transplantationIntrestedYN = json['TransplantationIntrestedYN'];
    aWDYN = json['AWDYN'];
    aWDLastDate = json['AWDLastDate']??"";
    aWDIntrestedYN = json['AWDIntrestedYN'];
    noTillageYN = json['NoTillageYN'];
    noTillageLastDate = json['NoTillageLastDate']??"";
    noTillageIntrestedYN = json['NoTillageIntrestedYN'];
    cRMYN = json['CRMYN'];
    cRMLastDate = json['CRMLastDate']??"";
    cRMIntrestedYN = json['CRMIntrestedYN'];
    serviceAppGPSCamIDs = json['ServiceAppGPSCamIDs'];
    name = json['Name'];
    cilintName = json['CilintName'];
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['ID'] = this.iD;
    data['FarmerName'] = this.farmerName;
    data['FatherName'] = this.fatherName;
    data['MobileNumber'] = this.mobileNumber;
    data['VillageID'] = this.villageID;
    data['ClientID'] = this.clientID;
    data['OperateArea'] = this.operateArea;
    data['AreaUnderPaddy'] = this.areaUnderPaddy;
    data['AreaUnderResidueManagement'] = this.areaUnderResidueManagement;
    data['AreaManagerByClient'] = this.areaManagerByClient;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['LaserLevelingYN'] = this.laserLevelingYN;
    data['LaserLevelingLastDate'] = this.laserLevelingLastDate;
    data['LaserLevelingIntrestedYN'] = this.laserLevelingIntrestedYN;
    data['DSRYN'] = this.dSRYN;
    data['DSRLastDate'] = this.dSRLastDate;
    data['DSRIntrestedYN'] = this.dSRIntrestedYN;
    data['TransplantationYN'] = this.transplantationYN;
    data['TransplantationLastDate'] = this.transplantationLastDate;
    data['TransplantationIntrestedYN'] = this.transplantationIntrestedYN;
    data['AWDYN'] = this.aWDYN;
    data['AWDLastDate'] = this.aWDLastDate;
    data['AWDIntrestedYN'] = this.aWDIntrestedYN;
    data['NoTillageYN'] = this.noTillageYN;
    data['NoTillageLastDate'] = this.noTillageLastDate;
    data['NoTillageIntrestedYN'] = this.noTillageIntrestedYN;
    data['CRMYN'] = this.cRMYN;
    data['CRMLastDate'] = this.cRMLastDate;
    data['CRMIntrestedYN'] = this.cRMIntrestedYN;
    data['ServiceAppGPSCamIDs'] = this.serviceAppGPSCamIDs;
    data['Name'] = this.name;
    data['CilintName'] = this.cilintName;
    return data;
  }
}
