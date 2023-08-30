
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Db_helper_model/cameramodel.dart';
class Camera_sqllite_database{
  static final _databaseName = "cultyvateservice1";
  static final _databaseVersion = 1;

  static final table = 'Camerawithlocation';
  static final columnid='ID';
  static final columnfarmerID = 'farmerID';
  static final columnFieldOfficerID = 'FieldOfficerID';
  static final columnFieldmanagerID = 'FieldManagerID';
  static final columnimagenv= 'imagenv';
  static final columLatitude= 'Latitude';
  static final columLongtitude= 'Longitude';



  Camera_sqllite_database._privateConstructor();
  static final Camera_sqllite_database instance = Camera_sqllite_database._privateConstructor();
  static Database ?_database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await initDatabase();
    return _database;
  }

  cratepostdatatable()async{
    print("manoj");
    Database ?db = await instance.database;
    Batch batch = db!.batch();
    try{
      print("manoj");
      batch.execute('''

          CREATE TABLE IF NOT EXISTS ${Camera_sqllite_database.table} (
            ${columnid} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${columnfarmerID} INTEGER ,
            ${columnFieldOfficerID} INTEGER ,
            ${columnFieldmanagerID} INTEGER,
            ${columnimagenv} TEXT NOT NULL,
            ${columLatitude} REAL,
            ${columLongtitude} REAL
          )
          ''');
      List<dynamic> res = await batch.commit();
      print("result $res");
    }
    catch(e){
      print(e);
      print("databse creating error");
    }

  }
  // this opens the database (and creates it if it doesn't exist)
  initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: onCreate);
  }
  Future onCreate(Database db, int version) async {
    Batch batch = db.batch();
    try{

      batch.execute('''

          CREATE TABLE IF NOT EXISTS ${Camera_sqllite_database.table} (
            ${columnid} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${columnfarmerID} INTEGER ,
            ${columnFieldOfficerID} INTEGER ,
            ${columnFieldmanagerID} INTEGER,
            ${columnimagenv} TEXT NOT NULL,
            ${columLatitude} REAL,
            ${columLongtitude} REAL,
          )
          ''');
      List<dynamic> res = await batch.commit();
      print("result $res");
    }
    catch(e){
      print("creating database error $e");
    }
  }

  Future<int> insert( Cameramodel cameramodel) async {
    Database ?db = await instance.database;
    return await db!.insert(table, {
      'ID': cameramodel.ID,
      'farmerID' :cameramodel.farmerID,
      'FieldOfficerID':cameramodel.FieldOfficerID,
      'FieldManagerID':cameramodel.FieldManagerID,
      'imagenv':cameramodel.imagenv,
      'Latitude':cameramodel.Latitude,
      'Longitude':cameramodel.Longitude
    });
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }
  Future<List<Map<String, dynamic>>> querybyId(Id)async{
    print("database list $Id");
    Database ? db=await instance.database;
    var one =await db!.query(table, where: '$columnid = ?', whereArgs: [Id]);
      return one;
  }
  Future<int> delete(int id) async {
    Database ? db = await instance.database;
    var deleteid= await db!.delete(table, where: '$columnid = ?', whereArgs: [id]);
   print("delete sqllite id $deleteid");
    return deleteid;
  }


}