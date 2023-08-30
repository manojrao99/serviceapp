import '/Screens/farmerAccusation/model_classes/districs.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DistrictDatabase {
  DistrictDatabase();

  final String tableName = 'districts';
  static final _databaseName = "my_database.distcs.db";
  static final _databaseVersion = 1;

  // Database ?_database;

  // / make this a singleton class
  DistrictDatabase._privateConstructor();
  static final DistrictDatabase instance =
      DistrictDatabase._privateConstructor();

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
            districtName TEXT,
            districtID INTEGER
      )''');
      List<dynamic> res = await batch.commit();
    } catch (e) {
      print("error while creating ");
    }
  }

  Future<void> insertDistrict(District district) async {
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

  Future<List<District>> getDistricts() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(maps.length, (index) {
      return District(
        districtName: maps[index]['districtName'],
        districtID: maps[index]['districtID'],
      );
    });
  }

  Future<int> deleteAllRows() async {
    Database? db = await instance.database;
    return await db!.delete(tableName);
  }

  Future<void> close() async {
    await _database!.close();
  }
}
