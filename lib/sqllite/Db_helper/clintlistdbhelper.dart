import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '/sqllite/Db_helper/vilagesdbhelper.dart';
import 'package:sqflite/sqflite.dart';

import '../Db_helper_model/Clintlist.dart';

class DatabaseclintHelper {
  static final _databaseName = "cultyvateservice1";
  static final _databaseVersion = 1;

  static final table = 'clintlist';

  static final columnId = 'id';
  static final columnClintID = 'CLintId';
  static final columnClintName = 'ClintName';

  // make this a singleton class
  DatabaseclintHelper._privateConstructor();
  static final DatabaseclintHelper instance =
      DatabaseclintHelper._privateConstructor();

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
          CREATE TABLE IF NOT EXISTS $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnClintID INTEGER NOT NULL,
            $columnClintName TEXT NOT NULL
        )
          ''');
      List<dynamic> res = await batch.commit();
      print("result $res");
    } catch (e) {
      print("creating database error $e");
    }
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Clintlistsqlformate clint) async {
    Database? db = await instance.database;
    return await db!.insert(table, {
      'CLintId': clint.CLintId,
      'ClintName': clint.ClintName,
    });
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database? db = await instance.database;
    return await db!.query(table, where: "$columnClintName LIKE '%$name%'");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
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
}
