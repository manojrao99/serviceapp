// import '  /Screens/farmerAccusation/model_classes/districs.dart';
import '/Screens/farmerAccusation/model_classes/village_model.dart';
// import '  /sqllite/Db_helper_model/sqllitevillagemodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model_classes/taluka_model.dart';

class VillageDatabase {
  VillageDatabase();

  final String tableName = 'Village';
  static final _databaseName = "my_database.village.db";
  static final _databaseVersion = 1;

  // Database ?_database;

  // / make this a singleton class
  VillageDatabase._privateConstructor();
  static final VillageDatabase instance = VillageDatabase._privateConstructor();

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
         VillageName TEXT,
  VillageID INTEGER,
  TalukaID INTEGER
      )''');
      List<dynamic> res = await batch.commit();
    } catch (e) {
      print("error while creating ");
    }
  }

  Future<void> insertDistrict(Village district) async {
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

  Future<List<Village>> getVillage() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(maps.length, (index) {
      return Village(
          talukaID: maps[index]['TalukaID'],
          villageID: maps[index]['VillageID'],
          villageName: maps[index]['VillageName']);
    });
  }

  Future<List<Village>> getVillagesByTalukaID(int targetTalukaID) async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(
      tableName,
      where: 'TalukaID = ?',
      whereArgs: [targetTalukaID],
    );

    return List.generate(maps.length, (index) {
      return Village(
        talukaID: maps[index]['TalukaID'],
        villageID: maps[index]['VillageID'],
        villageName: maps[index]['VillageName'],
      );
    });
  }

  Future<Village?> getVillagesByVillageID(int villageid) async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(
      tableName,
      where: 'VillageID = ?',
      whereArgs: [villageid],
    );

    if (maps.isNotEmpty) {
      return Village.fromJson(maps.first);
    } else {
      return null; // No record found with the given mobileNumber
    }
  }

  Future<void> close() async {
    await _database!.close();
  }
}
