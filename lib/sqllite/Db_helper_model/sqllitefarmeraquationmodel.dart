import '../Db_helper/vilagesdbhelper.dart';

class Postsqllitemodel {
  int ?Id;
  String ?farmerName;
  String ?MobileNumber;
  String ?FatherName;
  int ?VillageID;
  int ? ClientID;
  double ?OperateArea;
  double ? AreaUnderPaddy;
  double? AreaUnderResidueManagement;
  double ?AreaManagerByClient;
  double? Latitude;
  double ?Longitude;
  int ?LaserLevelingYN;
  String ?LaserLevelingLastDate;
  int ?LaserLevelingIntrestedYN;
  int ? DSRYN;

  String ? DSRLastDate;
  int ?DSRIntrestedYN;
  int ?TransplantationYN;
  String ?TransplantationLastDate;
  int ?TransplantationIntrestedYN;
  int ?AWDYN;
  String ?AWDLastDate;
  int ?AWDIntrestedYN;
  int ?NoTillageYN;
  String ?NoTillageLastDate;
  int ?NoTillageIntrestedYN;
  int ?CRMYN;
  String ?CRMLastDate;
  int ?CRMIntrestedYN;
  String ?ServiceAppGPSCamIDs;

  Postsqllitemodel(
      {this.VillageID, this.AreaManagerByClient, this.AreaUnderPaddy, this.AreaUnderResidueManagement, this.AWDIntrestedYN, this.AWDYN, this.ClientID
        , this.CRMIntrestedYN, this.CRMLastDate, this.CRMYN, this.DSRIntrestedYN, this.DSRLastDate, this.DSRYN, this.farmerName, this.FatherName, this.Id, this.LaserLevelingIntrestedYN,
        this.LaserLevelingLastDate, this.LaserLevelingYN, this.Latitude, this.Longitude, this.MobileNumber, this.NoTillageIntrestedYN, this.NoTillageLastDate, this.NoTillageYN, this.OperateArea,
        this.AWDLastDate, this.ServiceAppGPSCamIDs, this.TransplantationIntrestedYN, this.TransplantationLastDate, this.TransplantationYN});

  Postsqllitemodel.fromMap(Map<String, dynamic> map) {
    Id = map['Id'];
    farmerName = map['farmerName'];
    MobileNumber = map['MobileNumber'];
    FatherName = map['FatherName'];
    VillageID = map['VillageID'];
    ClientID = map['ClientID'];
    OperateArea = map['OperateArea'];
    AreaUnderPaddy = map['AreaUnderPaddy'];
    AreaUnderResidueManagement = map['AreaUnderResidueManagement'];
    AreaManagerByClient = map['AreaManagerByClient'];
    Latitude = map['Latitude'];
    Longitude = map['Longitude'];
    LaserLevelingYN = map['LaserLevelingYN'];
    LaserLevelingLastDate = map['LaserLevelingLastDate'];
    LaserLevelingIntrestedYN = map['LaserLevelingIntrestedYN'];
    DSRYN = map['DSRYN'];
    DSRLastDate = map['DSRLastDate'];
    DSRIntrestedYN = map['DSRIntrestedYN'];
    TransplantationYN = map['TransplantationYN'];
    TransplantationLastDate = map['TransplantationLastDate'];
    TransplantationIntrestedYN = map['TransplantationIntrestedYN'];
    AWDYN = map['AWDYN'];
   AWDLastDate = map['AWDLastDate'];
    AWDIntrestedYN = map['AWDIntrestedYN'];
    NoTillageYN = map['NoTillageYN'];
    NoTillageLastDate = map['NoTillageLastDate'];
    NoTillageIntrestedYN = map['NoTillageIntrestedYN'];
    CRMYN = map['CRMYN'];
    CRMLastDate = map['CRMLastDate'];
    CRMIntrestedYN = map['CRMIntrestedYN'];
    ServiceAppGPSCamIDs = map['ServiceAppGPSCamIDs'].toString();
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.postfarmername: farmerName,
      DatabaseHelper.postMobileNumber: MobileNumber,
      DatabaseHelper.postFatherName: farmerName,
      DatabaseHelper.postVillageID: VillageID,
      DatabaseHelper.postClientID: ClientID,
      DatabaseHelper.postOperateArea: OperateArea,
      DatabaseHelper.postAreaUnderPaddy: AreaUnderPaddy,
      DatabaseHelper.postAreaUnderResidueManagement: AreaUnderResidueManagement,
      DatabaseHelper.postAreaManagerByClient: AreaManagerByClient,
      DatabaseHelper.postLatitude: Latitude,
      DatabaseHelper.postLongitude: Longitude,
      DatabaseHelper.postLaserLevelingYN: LaserLevelingYN,
      DatabaseHelper.postLaserLevelingLastDate: LaserLevelingLastDate,
      DatabaseHelper.PostLaserLevelingIntrestedYN: LaserLevelingIntrestedYN,
      DatabaseHelper.postDSRYN: DSRYN,
      DatabaseHelper.postDSRLastDate: DSRLastDate,
      DatabaseHelper.postDSRIntrestedYN: DSRIntrestedYN,
      DatabaseHelper.postTransplantationYN: TransplantationYN,
      DatabaseHelper.postTransplantationLastDate: TransplantationLastDate,
      DatabaseHelper.postTransplantationIntrestedYN: TransplantationIntrestedYN,
      DatabaseHelper.postAWDYN: AWDYN,
      DatabaseHelper.postAWDLastDate: AWDLastDate,
      DatabaseHelper.postAWDIntrestedYN: AWDIntrestedYN,
      DatabaseHelper.postNoTillageYN: NoTillageYN,
      DatabaseHelper.postNoTillageLastDate: NoTillageLastDate,
      DatabaseHelper.postNoTillageIntrestedYN: NoTillageIntrestedYN,
      DatabaseHelper.postCRMYN: CRMYN,
      DatabaseHelper.postCRMLastDate: CRMLastDate,
      DatabaseHelper.postCRMIntrestedYN: CRMIntrestedYN,
      DatabaseHelper.postServiceAppGPSCamIDs: ServiceAppGPSCamIDs.toString(),
    };
  }
}