import '../farmerAccusation/model_classes/farmer_model_saving.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/farmeraccasationdataobject.dart';

class FarmerDatabaseHelper {
  static final _databaseName = "farmer_acusation.db";
  static final _databaseVersion = 1;

  static final table = 'farmers';

  // FarmerDatabaseHelper._privateConstructor();
  // static final FarmerDatabaseHelper instance = FarmerDatabaseHelper._privateConstructor();

  // / make this a singleton class
  FarmerDatabaseHelper._privateConstructor();

  static final FarmerDatabaseHelper instance =
      FarmerDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    Batch batch = db.batch();
    try {
      batch.execute('''
          CREATE TABLE $table(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
FarmerName  BLOB,
FatherName  BLOB,
MobileNumber  BLOB,
VillageID  BLOB,
CooperativeName  BLOB,
OwnLandAreaAcres  BLOB,
OwnLandAreaKanal  BLOB,
OwnLandAreaMarala  BLOB,
OwnLandLatitude  BLOB,
OwnLandLongitude  BLOB,
OwnLandAreaUnderTPRAcres  BLOB,
OwnLandAreaUnderTPRKanal  BLOB,
OwnLandAreaUnderTPRMarala  BLOB,
OwnLandAreaUnderTPRLatitude  BLOB,
OwnLandAreaUnderTPRLongitude  BLOB,
OwnLandAreaUnderDSRAcres  BLOB,
OwnLandAreaUnderDSRKanal  BLOB,
OwnLandAreaUnderDSRMarala  BLOB,
OwnLandAreaUnderDSRLatitude  BLOB,
OwnLandAreaUnderDSRLongitude  BLOB,
OwnLandAreaUnderResidueMgmtAcres  BLOB,
OwnLandAreaUnderResidueMgmtKanal  BLOB,
OwnLandAreaUnderResidueMgmtMarala  BLOB,
OwnLandAreaUnderResidueMgmtLatitude  BLOB,
OwnLandAreaUnderResidueMgmtLongitude  BLOB,
OwnLandLaserLevelingYN  BLOB,
OwnLandLaserLevelingLastDate  BLOB,
OwnLandLaserLevelingIntrestedYN  BLOB,
OwnLandDSRYN  BLOB,
OwnLandDSRNoOfYearsFollowed  BLOB,
OwnLandDSRSowingDateOfCurrentSeason  BLOB,
OwnLandTransplantationDate  BLOB,
OwnLandAWDYN  BLOB,
OwnLandAWDNoOfYearsFollowed  BLOB,
OwnLandAWDDeploymentDate  BLOB,
OwnLandNoTillageYN  BLOB,
OwnLandCRMBalingDate  BLOB,
OwnLandCRMMulchingDate  BLOB,
OwnLandCRMBioSprayDate  BLOB,
LeaseLandAreaAcres  BLOB,
LeaseLandAreaKanal  BLOB,
LeaseLandAreaMarala  BLOB,
LeaseLandLatitude  BLOB,
LeaseLandLongitude  BLOB,
LeaseLandAreaUnderTPRAcres  BLOB,
LeaseLandAreaUnderTPRKanal  BLOB,
LeaseLandAreaUnderTPRMarala  BLOB,
LeaseLandAreaUnderTPRLatitude  BLOB,
LeaseLandAreaUnderTPRLongitude  BLOB,
LeaseLandAreaUnderDSRAcres  BLOB,
LeaseLandAreaUnderDSRKanal  BLOB,
LeaseLandAreaUnderDSRMarala  BLOB,
LeaseLandAreaUnderDSRLatitude  BLOB,
LeaseLandAreaUnderDSRLongitude  BLOB,
LeaseLandAreaUnderResidueMgmtAcres  BLOB,
LeaseLandAreaUnderResidueMgmtKanal  BLOB,
LeaseLandAreaUnderResidueMgmtMarala  BLOB,
LeaseLandAreaUnderResidueMgmtLatitude  BLOB,
LeaseLandAreaUnderResidueMgmtLongitude  BLOB,
LeaseLandLaserLevelingYN  BLOB,
LeaseLandLaserLevelingLastDate  BLOB,
LeaseLandLaserLevelingIntrestedYN  BLOB,
LeaseLandDSRYN  BLOB,
LeaseLandDSRNoOfYearsFollowed  BLOB,
LeaseLandDSRSowingDateOfCurrentSeason  BLOB,
LeaseLandTransplantationDate  BLOB,
LeaseLandAWDYN  BLOB,
LeaseLandAWDNoOfYearsFollowed  BLOB,
LeaseLandAWDDeploymentDate  BLOB,
LeaseLandNoTillageYN  BLOB,
LeaseLandCRMBalingDate  BLOB,
LeaseLandCRMMulchingDate  BLOB,
LeaseLandCRMBioSprayDate  BLOB,
ServiceAppGPSCamIDs  BLOB,
UserMasterID  BLOB
          )
          ''');
      List<dynamic> res = await batch.commit();
    } catch (e) {
      print("error whilce creating db");
    }
  }

  Future<int> deletebyID(id) async {
    Database? db = await instance.database;
    return await db!.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<FarmerAcusationDart?> getMobileNumber(
      {required String mobileNumber}) async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(
      table,
      where: 'MobileNumber = ?',
      whereArgs: [mobileNumber],
    );

    if (maps.isNotEmpty) {
      return FarmerAcusationDart.fromJson(maps.first);
    } else {
      return null; // No record found with the given mobileNumber
    }
  }

  //   return List.generate(map.length, (index) {
  //     return FarmerAcusationDart(
  //       id:map[index]['id'] ,
  //       farmerName: map[index]['FarmerName'],
  //       fatherName: map[index]['FatherName'],
  //       mobileNumber: map[index]['MobileNumber'],
  //       villageID: map[index]['VillageID'],
  //       cooperativeName: map[index]['CooperativeName'],
  //       ownLandAreaAcres: map[index]['OwnLandAreaAcres'],
  //       ownLandAreaKanal: map[index]['OwnLandAreaKanal'],
  //       ownLandAreaMarala: map[index]['OwnLandAreaMarala'],
  //       ownLandLatitude: map[index]['OwnLandLatitude'],
  //       ownLandLongitude: map[index]['OwnLandLongitude'],
  //       ownLandAreaUnderTPRAcres: map[index]['OwnLandAreaUnderTPRAcres'],
  //       ownLandAreaUnderTPRKanal: map[index]['OwnLandAreaUnderTPRKanal'],
  //       ownLandAreaUnderTPRMarala: map[index]['OwnLandAreaUnderTPRMarala'],
  //       ownLandAreaUnderTPRLatitude: map[index]['OwnLandAreaUnderTPRLatitude'],
  //       ownLandAreaUnderTPRLongitude: map[index]['OwnLandAreaUnderTPRLongitude'],
  //       ownLandAreaUnderDSRAcres: map[index]['OwnLandAreaUnderDSRAcres'],
  //       ownLandAreaUnderDSRKanal: map[index]['OwnLandAreaUnderDSRKanal'],
  //       ownLandAreaUnderDSRMarala: map[index]['OwnLandAreaUnderDSRMarala'],
  //       ownLandAreaUnderDSRLatitude: map[index]['OwnLandAreaUnderDSRLatitude'],
  //       ownLandAreaUnderDSRLongitude: map[index]['OwnLandAreaUnderDSRLongitude'],
  //       ownLandAreaUnderResidueMgmtAcres: map[index]['OwnLandAreaUnderResidueMgmtAcres'],
  //       ownLandAreaUnderResidueMgmtKanal: map[index]['OwnLandAreaUnderResidueMgmtKanal'],
  //       ownLandAreaUnderResidueMgmtMarala: map[index]['OwnLandAreaUnderResidueMgmtMarala'],
  //       ownLandAreaUnderResidueMgmtLatitude: map[index]['OwnLandAreaUnderResidueMgmtLatitude'],
  //       ownLandAreaUnderResidueMgmtLongitude: map[index]['OwnLandAreaUnderResidueMgmtLongitude'],
  //       ownLandLaserLevelingYN: map[index]['OwnLandLaserLevelingYN'],
  //       ownLandLaserLevelingLastDate: map[index]['OwnLandLaserLevelingLastDate'],
  //       ownLandLaserLevelingIntrestedYN: map[index]['OwnLandLaserLevelingIntrestedYN'],
  //       ownLandDSRYN: map[index]['OwnLandDSRYN'],
  //       ownLandDSRNoOfYearsFollowed: map[index]['OwnLandDSRNoOfYearsFollowed'],
  //       ownLandDSRSowingDateOfCurrentSeason: map[index]['OwnLandDSRSowingDateOfCurrentSeason'],
  //       ownLandTransplantationDate: map[index]['OwnLandTransplantationDate'],
  //       ownLandAWDYN: map[index]['OwnLandAWDYN'],
  //       ownLandAWDNoOfYearsFollowed: map[index]['OwnLandAWDNoOfYearsFollowed'],
  //       ownLandAWDDeploymentDate: map[index]['OwnLandAWDDeploymentDate'],
  //       ownLandNoTillageYN: map[index]['OwnLandNoTillageYN'],
  //       ownLandCRMBalingDate: map[index]['OwnLandCRMBalingDate'],
  //       ownLandCRMMulchingDate: map[index]['OwnLandCRMMulchingDate'],
  //       ownLandCRMBioSprayDate: map[index]['OwnLandCRMBioSprayDate'],
  //       leaseLandAreaAcres: map[index]['LeaseLandAreaAcres'],
  //       leaseLandAreaKanal: map[index]['LeaseLandAreaKanal'],
  //       leaseLandAreaMarala: map[index]['LeaseLandAreaMarala'],
  //       leaseLandLatitude: map[index]['LeaseLandLatitude'],
  //       leaseLandLongitude: map[index]['LeaseLandLongitude'],
  //       leaseLandAreaUnderTPRAcres: map[index]['LeaseLandAreaUnderTPRAcres'],
  //       leaseLandAreaUnderTPRKanal: map[index]['LeaseLandAreaUnderTPRKanal'],
  //       leaseLandAreaUnderTPRMarala: map[index]['LeaseLandAreaUnderTPRMarala'],
  //       leaseLandAreaUnderTPRLatitude: map[index]['LeaseLandAreaUnderTPRLatitude'],
  //       leaseLandAreaUnderTPRLongitude: map[index]['LeaseLandAreaUnderTPRLongitude'],
  //       leaseLandAreaUnderDSRAcres: map[index]['LeaseLandAreaUnderDSRAcres'],
  //       leaseLandAreaUnderDSRKanal: map[index]['LeaseLandAreaUnderDSRKanal'],
  //       leaseLandAreaUnderDSRMarala: map[index]['LeaseLandAreaUnderDSRMarala'],
  //       leaseLandAreaUnderDSRLatitude: map[index]['LeaseLandAreaUnderDSRLatitude'],
  //       leaseLandAreaUnderDSRLongitude: map[index]['LeaseLandAreaUnderDSRLongitude'],
  //       leaseLandAreaUnderResidueMgmtAcres: map[index]['LeaseLandAreaUnderResidueMgmtAcres'],
  //       leaseLandAreaUnderResidueMgmtKanal: map[index]['LeaseLandAreaUnderResidueMgmtKanal'],
  //       leaseLandAreaUnderResidueMgmtMarala: map[index]['LeaseLandAreaUnderResidueMgmtMarala'],
  //       leaseLandAreaUnderResidueMgmtLatitude: map[index]['LeaseLandAreaUnderResidueMgmtLatitude'],
  //       leaseLandAreaUnderResidueMgmtLongitude: map[index]['LeaseLandAreaUnderResidueMgmtLongitude'],
  //       leaseLandLaserLevelingYN: map[index]['LeaseLandLaserLevelingYN'],
  //       leaseLandLaserLevelingLastDate: map[index]['LeaseLandLaserLevelingLastDate'],
  //       leaseLandLaserLevelingIntrestedYN: map[index]['LeaseLandLaserLevelingIntrestedYN'],
  //       leaseLandDSRYN: map[index]['LeaseLandDSRYN'],
  //       leaseLandDSRNoOfYearsFollowed: map[index]['LeaseLandDSRNoOfYearsFollowed'],
  //       leaseLandDSRSowingDateOfCurrentSeason: map[index]['LeaseLandDSRSowingDateOfCurrentSeason'],
  //       leaseLandTransplantationDate: map[index]['LeaseLandTransplantationDate'],
  //       leaseLandAWDYN: map[index]['LeaseLandAWDYN'],
  //       leaseLandAWDNoOfYearsFollowed: map[index]['LeaseLandAWDNoOfYearsFollowed'],
  //       leaseLandAWDDeploymentDate: map[index]['LeaseLandAWDDeploymentDate'],
  //       leaseLandNoTillageYN: map[index]['LeaseLandNoTillageYN'],
  //       leaseLandCRMBalingDate: map[index]['LeaseLandCRMBalingDate'],
  //       leaseLandCRMMulchingDate: map[index]['LeaseLandCRMMulchingDate'],
  //       leaseLandCRMBioSprayDate: map[index]['LeaseLandCRMBioSprayDate'],
  //       serviceAppGPSCamIDs: map[index]['ServiceAppGPSCamIDs'],
  //       userMasterID: map[index]['UserMasterID'],
  //     );
  //   });
  // }

  Future<List<FarmerAcusationDart>> getFarmrdata() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> map = await db!.query(table);
    return List.generate(map.length, (index) {
      return FarmerAcusationDart(
        id: map[index]['id'],
        farmerName: map[index]['FarmerName'],
        fatherName: map[index]['FatherName'],
        mobileNumber: map[index]['MobileNumber'],
        villageID: map[index]['VillageID'],
        cooperativeName: map[index]['CooperativeName'],
        ownLandAreaAcres: map[index]['OwnLandAreaAcres'],
        ownLandAreaKanal: map[index]['OwnLandAreaKanal'],
        ownLandAreaMarala: map[index]['OwnLandAreaMarala'],
        ownLandLatitude: map[index]['OwnLandLatitude'],
        ownLandLongitude: map[index]['OwnLandLongitude'],
        ownLandAreaUnderTPRAcres: map[index]['OwnLandAreaUnderTPRAcres'],
        ownLandAreaUnderTPRKanal: map[index]['OwnLandAreaUnderTPRKanal'],
        ownLandAreaUnderTPRMarala: map[index]['OwnLandAreaUnderTPRMarala'],
        ownLandAreaUnderTPRLatitude: map[index]['OwnLandAreaUnderTPRLatitude'],
        ownLandAreaUnderTPRLongitude: map[index]
            ['OwnLandAreaUnderTPRLongitude'],
        ownLandAreaUnderDSRAcres: map[index]['OwnLandAreaUnderDSRAcres'],
        ownLandAreaUnderDSRKanal: map[index]['OwnLandAreaUnderDSRKanal'],
        ownLandAreaUnderDSRMarala: map[index]['OwnLandAreaUnderDSRMarala'],
        ownLandAreaUnderDSRLatitude: map[index]['OwnLandAreaUnderDSRLatitude'],
        ownLandAreaUnderDSRLongitude: map[index]
            ['OwnLandAreaUnderDSRLongitude'],
        ownLandAreaUnderResidueMgmtAcres: map[index]
            ['OwnLandAreaUnderResidueMgmtAcres'],
        ownLandAreaUnderResidueMgmtKanal: map[index]
            ['OwnLandAreaUnderResidueMgmtKanal'],
        ownLandAreaUnderResidueMgmtMarala: map[index]
            ['OwnLandAreaUnderResidueMgmtMarala'],
        ownLandAreaUnderResidueMgmtLatitude: map[index]
            ['OwnLandAreaUnderResidueMgmtLatitude'],
        ownLandAreaUnderResidueMgmtLongitude: map[index]
            ['OwnLandAreaUnderResidueMgmtLongitude'],
        ownLandLaserLevelingYN: map[index]['OwnLandLaserLevelingYN'],
        ownLandLaserLevelingLastDate: map[index]
            ['OwnLandLaserLevelingLastDate'],
        ownLandLaserLevelingIntrestedYN: map[index]
            ['OwnLandLaserLevelingIntrestedYN'],
        ownLandDSRYN: map[index]['OwnLandDSRYN'],
        ownLandDSRNoOfYearsFollowed: map[index]['OwnLandDSRNoOfYearsFollowed'],
        ownLandDSRSowingDateOfCurrentSeason: map[index]
            ['OwnLandDSRSowingDateOfCurrentSeason'],
        ownLandTransplantationDate: map[index]['OwnLandTransplantationDate'],
        ownLandAWDYN: map[index]['OwnLandAWDYN'],
        ownLandAWDNoOfYearsFollowed: map[index]['OwnLandAWDNoOfYearsFollowed'],
        ownLandAWDDeploymentDate: map[index]['OwnLandAWDDeploymentDate'],
        ownLandNoTillageYN: map[index]['OwnLandNoTillageYN'],
        ownLandCRMBalingDate: map[index]['OwnLandCRMBalingDate'],
        ownLandCRMMulchingDate: map[index]['OwnLandCRMMulchingDate'],
        ownLandCRMBioSprayDate: map[index]['OwnLandCRMBioSprayDate'],
        leaseLandAreaAcres: map[index]['LeaseLandAreaAcres'],
        leaseLandAreaKanal: map[index]['LeaseLandAreaKanal'],
        leaseLandAreaMarala: map[index]['LeaseLandAreaMarala'],
        leaseLandLatitude: map[index]['LeaseLandLatitude'],
        leaseLandLongitude: map[index]['LeaseLandLongitude'],
        leaseLandAreaUnderTPRAcres: map[index]['LeaseLandAreaUnderTPRAcres'],
        leaseLandAreaUnderTPRKanal: map[index]['LeaseLandAreaUnderTPRKanal'],
        leaseLandAreaUnderTPRMarala: map[index]['LeaseLandAreaUnderTPRMarala'],
        leaseLandAreaUnderTPRLatitude: map[index]
            ['LeaseLandAreaUnderTPRLatitude'],
        leaseLandAreaUnderTPRLongitude: map[index]
            ['LeaseLandAreaUnderTPRLongitude'],
        leaseLandAreaUnderDSRAcres: map[index]['LeaseLandAreaUnderDSRAcres'],
        leaseLandAreaUnderDSRKanal: map[index]['LeaseLandAreaUnderDSRKanal'],
        leaseLandAreaUnderDSRMarala: map[index]['LeaseLandAreaUnderDSRMarala'],
        leaseLandAreaUnderDSRLatitude: map[index]
            ['LeaseLandAreaUnderDSRLatitude'],
        leaseLandAreaUnderDSRLongitude: map[index]
            ['LeaseLandAreaUnderDSRLongitude'],
        leaseLandAreaUnderResidueMgmtAcres: map[index]
            ['LeaseLandAreaUnderResidueMgmtAcres'],
        leaseLandAreaUnderResidueMgmtKanal: map[index]
            ['LeaseLandAreaUnderResidueMgmtKanal'],
        leaseLandAreaUnderResidueMgmtMarala: map[index]
            ['LeaseLandAreaUnderResidueMgmtMarala'],
        leaseLandAreaUnderResidueMgmtLatitude: map[index]
            ['LeaseLandAreaUnderResidueMgmtLatitude'],
        leaseLandAreaUnderResidueMgmtLongitude: map[index]
            ['LeaseLandAreaUnderResidueMgmtLongitude'],
        leaseLandLaserLevelingYN: map[index]['LeaseLandLaserLevelingYN'],
        leaseLandLaserLevelingLastDate: map[index]
            ['LeaseLandLaserLevelingLastDate'],
        leaseLandLaserLevelingIntrestedYN: map[index]
            ['LeaseLandLaserLevelingIntrestedYN'],
        leaseLandDSRYN: map[index]['LeaseLandDSRYN'],
        leaseLandDSRNoOfYearsFollowed: map[index]
            ['LeaseLandDSRNoOfYearsFollowed'],
        leaseLandDSRSowingDateOfCurrentSeason: map[index]
            ['LeaseLandDSRSowingDateOfCurrentSeason'],
        leaseLandTransplantationDate: map[index]
            ['LeaseLandTransplantationDate'],
        leaseLandAWDYN: map[index]['LeaseLandAWDYN'],
        leaseLandAWDNoOfYearsFollowed: map[index]
            ['LeaseLandAWDNoOfYearsFollowed'],
        leaseLandAWDDeploymentDate: map[index]['LeaseLandAWDDeploymentDate'],
        leaseLandNoTillageYN: map[index]['LeaseLandNoTillageYN'],
        leaseLandCRMBalingDate: map[index]['LeaseLandCRMBalingDate'],
        leaseLandCRMMulchingDate: map[index]['LeaseLandCRMMulchingDate'],
        leaseLandCRMBioSprayDate: map[index]['LeaseLandCRMBioSprayDate'],
        serviceAppGPSCamIDs: map[index]['ServiceAppGPSCamIDs'],
        userMasterID: map[index]['UserMasterID'],
      );
    });
  }

  Future<void> insertDistrict(FarmerAcusationDart district) async {
    // print("")
    // await _database.insert(tableName, district.toMap());
    try {
      Database? db = await instance.database;
      print("db path ${db!.database.path}");
      await db.insert(table, district.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print("Data Saved succesfully");
    } catch (E) {
      print("error while adding ${E}");
    }
  }
}
