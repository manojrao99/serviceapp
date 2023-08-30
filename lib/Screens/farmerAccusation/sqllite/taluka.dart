import '/Screens/farmerAccusation/model_classes/districs.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model_classes/taluka_model.dart';

class TalukaDatabase {
  TalukaDatabase();

  final String tableName = 'taluk';
  static final _databaseName = "my_database.taluka.db";
  static final _databaseVersion = 1;

  // Database ?_database;

  // / make this a singleton class
  TalukaDatabase._privateConstructor();
  static final TalukaDatabase instance = TalukaDatabase._privateConstructor();

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
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY,
         TalukaName TEXT,
  TalukaID INTEGER,
  DistricID INTEGER
      )''');
      List<dynamic> res = await batch.commit();
    } catch (e) {
      print("error while creating ");
    }
  }

  Future<void> insertDistrict(Taluka district) async {
    // print("")
    // await _database.insert(tableName, district.toMap());
    try {
      Database? db = await instance.database;
      print("db path ${db!.database.path}");
      await db.insert(tableName, district.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (E) {
      print("error while adding ${E}");
    }
  }

  Future<int> deleteAllRows() async {
    Database? db = await instance.database;
    return await db!.delete(tableName);
  }

  Future<List<Taluka>> getDistricts() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(maps.length, (index) {
      return Taluka(
          talukaID: maps[index]['TalukaID'],
          talukaName: maps[index]['TalukaName'],
          districtID: maps[index]['DistricID']);
    });
  }

  Future<List<Taluka>> getDistrictsByDistrictID(int targetDistrictID) async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(
      tableName,
      where: 'DistricID = ?',
      whereArgs: [targetDistrictID],
    );

    return List.generate(maps.length, (index) {
      return Taluka(
        talukaID: maps[index]['TalukaID'],
        talukaName: maps[index]['TalukaName'],
        districtID: maps[index]['DistricID'],
      );
    });
  }

  Future<void> close() async {
    await _database!.close();
  }
}
