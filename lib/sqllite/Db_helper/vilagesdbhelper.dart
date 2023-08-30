import 'package:path/path.dart';
import '/sqllite/Db_helper/clintlistdbhelper.dart';
import 'package:sqflite/sqflite.dart';
import '../Db_helper_model/sqllitefarmeraquationmodel.dart';
import '../Db_helper_model/sqllitevillagemodel.dart';

class DatabaseHelper {
  static final _databaseName = "cultyvateservice1";
  static final _databaseVersion = 1;

  static final table = 'Villagestable';

  static final columnId = 'id';
  static final columnvillageid = 'villageID';
  static final columnname = 'villageName';
  static final columnTalukaID = 'TalukaID';
  static final columnTalukaName = 'TalukaName';
  static final columnDistrictName = 'DistrictName';
  static final postacqutiondata = 'acqutiondata';
  static final postinitid = 'Id';

  static final postfarmername = 'farmerName';
  static final postMobileNumber = 'MobileNumber';
  static final postFatherName = 'FatherName';
  static final postVillageID = 'VillageID';
  static final postClientID = 'ClientID';
  static final postOperateArea = 'OperateArea';
  static final postAreaUnderPaddy = 'AreaUnderPaddy';
  static final postAreaUnderResidueManagement = 'AreaUnderResidueManagement';
  static final postAreaManagerByClient = 'AreaManagerByClient';
  static final postLatitude = 'Latitude';
  static final postLongitude = 'Longitude';
  static final postLaserLevelingYN = 'LaserLevelingYN';
  static final postLaserLevelingLastDate = 'LaserLevelingLastDate';
  static final PostLaserLevelingIntrestedYN = 'LaserLevelingIntrestedYN';
  static final postDSRYN = "DSRYN";
  static final postDSRLastDate = 'DSRLastDate';
  static final postDSRIntrestedYN = 'DSRIntrestedYN';
  static final postTransplantationYN = 'TransplantationYN';
  static final postTransplantationLastDate = 'TransplantationLastDate';
  static final postTransplantationIntrestedYN = 'TransplantationIntrestedYN';
  static final postAWDYN = 'AWDYN';
  static final postAWDLastDate = 'AWDLastDate';
  static final postAWDIntrestedYN = 'AWDIntrestedYN';
  static final postNoTillageYN = 'NoTillageYN';
  static final postNoTillageLastDate = 'NoTillageLastDate';
  static final postNoTillageIntrestedYN = 'NoTillageIntrestedYN';
  static final postCRMYN = 'CRMYN';
  static final postCRMLastDate = 'CRMLastDate';
  static final postCRMIntrestedYN = 'CRMIntrestedYN';
  static final postServiceAppGPSCamIDs = 'ServiceAppGPSCamIDs';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: onCreate);
  }

  // SQL code to create the database table
  Future onCreate(Database db, int version) async {
    Batch batch = db.batch();
    try {
      batch.execute('''
          CREATE TABLE IF NOT EXISTS ${DatabaseHelper.table} (
            ${DatabaseHelper.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${DatabaseHelper.columnvillageid} INTEGER NOT NULL,
            ${DatabaseHelper.columnname} TEXT NOT NULL,
            ${DatabaseHelper.columnTalukaID} INTEGER NOT NULL,
            ${DatabaseHelper.columnTalukaName} TEXT ,
            ${DatabaseHelper.columnDistrictName} TEXT NOT NULL
          )
          ''');
      batch.execute('''
          CREATE TABLE IF NOT EXISTS ${DatabaseclintHelper.table}(
          ${DatabaseclintHelper.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
       ${DatabaseclintHelper.columnClintID} INTEGER NOT NULL,
       ${DatabaseclintHelper.columnClintName} TEXT NOT NULL
        )
          ''');
      List<dynamic> res = await batch.commit();
      print("result $res");
    } catch (e) {
      print("creating database error $e");
    }
  }

  // cratepostdatatable()async{
  //   print("manoj");
  //   Database ?db = await instance.database;
  //   Batch batch = db!.batch();
  // try{
  // print("manoj");
  //   batch.execute('''
  //         CREATE TABLE IF NOT EXISTS $postacqutiondata(
  //        $postinitid INTEGER PRIMARY KEY AUTOINCREMENT,
  //       $postfarmername   TEXT NOT NULL,
  //        $postMobileNumber TEXT NOT NULL,
  //         $postFatherName TEXT NOT NULL,
  //          $postVillageID INTEGER NOT NULL,
  //          $postClientID INTEGER NOT NULL,
  //          $postOperateArea REAL,
  //          $postAreaUnderPaddy REAL,
  //          $postAreaUnderResidueManagement REAL,
  //          $postAreaManagerByClient  REAL,
  //          $postLatitude  REAL,
  //           $postLongitude  REAL,
  //            $postLaserLevelingYN INTEGER,
  //            $postLaserLevelingLastDate TEXT,
  //            $PostLaserLevelingIntrestedYN INTEGER,
  //             $postDSRYN INTEGER,
  //            $postDSRLastDate TEXT,
  //           $postDSRIntrestedYN INTEGER,
  //           $postTransplantationYN INTEGER,
  //           $postTransplantationLastDate TEXT,
  //            $postTransplantationIntrestedYN INTEGER,
  //           $postAWDYN INTEGER,
  //            $postAWDLastDate TEXT,
  //            $postAWDIntrestedYN INTEGER,
  //             $postNoTillageYN INTEGER,
  //              $postNoTillageLastDate TEXT,
  //               $postNoTillageIntrestedYN INTEGER,
  //                $postCRMYN INTEGER,
  //               $postCRMLastDate TEXT,
  //                $postCRMIntrestedYN INTEGER,
  //                $postServiceAppGPSCamIDs TEXT
  //         )''');
  //   List<dynamic> res = await batch.commit();
  //   print("result $res");
  // }
  //   catch(e){
  //   print(e);
  //   print("databse creating error");
  //   }
  //
  // }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Village village) async {
    Database? db = await instance.database;
    return await db!.insert(table, {
      'villageID': village.villageID,
      'villageName': village.villageName,
      'TalukaID': village.TalukaID,
      'TalukaName': village.TalukaName,
      'DistrictName': village.DistrictName
    });
  }

  Future<int> insertpostdata(Postsqllitemodel postdat) async {
    print("manojincertiondata");
    Database? db = await instance.database;
    return await db!.insert(postacqutiondata, {
      'farmerName': postdat.farmerName,
      'MobileNumber': postdat.MobileNumber,
      'FatherName': postdat.FatherName,
      'VillageID': postdat.VillageID,
      'ClientID': postdat.ClientID,
      'OperateArea': postdat.OperateArea,
      'AreaUnderPaddy': postdat.AreaUnderPaddy,
      'AreaUnderResidueManagement': postdat.AreaUnderResidueManagement,
      'AreaManagerByClient': postdat.AreaManagerByClient,
      'Latitude': postdat.Latitude,
      'Longitude': postdat.Longitude,
      'LaserLevelingYN': postdat.LaserLevelingYN,
      'LaserLevelingLastDate': postdat.LaserLevelingLastDate,
      'LaserLevelingIntrestedYN': postdat.LaserLevelingIntrestedYN,
      'DSRYN': postdat.DSRYN,
      'DSRLastDate': postdat.DSRLastDate,
      'DSRIntrestedYN': postdat.DSRIntrestedYN,
      'TransplantationYN': postdat.TransplantationYN,
      'TransplantationLastDate': postdat.TransplantationLastDate,
      'TransplantationIntrestedYN': postdat.TransplantationIntrestedYN,
      'AWDYN': postdat.AWDYN,
      'AWDLastDate': postdat.AWDLastDate,
      'AWDIntrestedYN': postdat.AWDIntrestedYN,
      'NoTillageYN': postdat.NoTillageYN,
      'NoTillageLastDate': postdat.NoTillageLastDate,
      'NoTillageIntrestedYN': postdat.NoTillageIntrestedYN,
      'CRMYN': postdat.CRMYN,
      'CRMLastDate': postdat.CRMLastDate,
      'CRMIntrestedYN': postdat.CRMIntrestedYN,
      'ServiceAppGPSCamIDs': postdat.ServiceAppGPSCamIDs,
    });
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> querypostdata() async {
    Database? db = await instance.database;
    return await db!.query(postacqutiondata);
  }

  Future<int> deleteapostid(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(postacqutiondata, where: '$postinitid = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database? db = await instance.database;
    return await db!.query(table, where: "$columnname LIKE '%$name%'");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<void> deleteall() async {
    Database? db = await instance.database;
    var z = await db!.execute("delete from " + table);
    // var z= await db!.delete(table,,null);
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
