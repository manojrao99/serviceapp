import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ServiceAPPlogins {
  final int iD;
  final bool canCreateYN;
  final bool canDeleteYN;
  final bool canExportYN;
  final bool canPrintYN;
  final bool canUpdateYN;
  final bool canViewYN;
  final int companyID;
  final String optionName;
  final int userMasterID;

  ServiceAPPlogins({
    required this.iD,
    required this.canCreateYN,
    required this.canDeleteYN,
    required this.canExportYN,
    required this.canPrintYN,
    required this.canUpdateYN,
    required this.canViewYN,
    required this.companyID,
    required this.optionName,
    required this.userMasterID,
  });

  Map<String, dynamic> toMap() {
    return {
      'iD': iD,
      'canCreateYN': canCreateYN ? 1 : 0,
      'canDeleteYN': canDeleteYN ? 1 : 0,
      'canExportYN': canExportYN ? 1 : 0,
      'canPrintYN': canPrintYN ? 1 : 0,
      'canUpdateYN': canUpdateYN ? 1 : 0,
      'canViewYN': canViewYN ? 1 : 0,
      'companyID': companyID,
      'optionName': optionName,
      'userMasterID': userMasterID,
    };
  }

  factory ServiceAPPlogins.fromMap(Map<String, dynamic> map) {
    return ServiceAPPlogins(
      iD: map['iD'],
      canCreateYN: map['canCreateYN'] == 1,
      canDeleteYN: map['canDeleteYN'] == 1,
      canExportYN: map['canExportYN'] == 1,
      canPrintYN: map['canPrintYN'] == 1,
      canUpdateYN: map['canUpdateYN'] == 1,
      canViewYN: map['canViewYN'] == 1,
      companyID: map['companyID'],
      optionName: map['OptionName'],
      userMasterID: map['userMasterID'],
    );
  }
}

class DatabaseHelper {
  static final _databaseName = "my_database.db";
  static final _databaseVersion = 1;

  static final table = 'service_app_login';

  // / make this a singleton class
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
        version: _databaseVersion, onCreate: _createDB);
  }
  // Future<Database> initDatabase() async {
  //   final path = join(await getDatabasesPath(), _databaseName);
  //   return await openDatabase(path, version: 1, onCreate: _createDB);
  // }

  Future _createDB(Database db, int version) async {
    Batch batch = db.batch();
    try {
      batch.execute('''
      CREATE TABLE IF NOT EXISTS $table (
        iD INTEGER PRIMARY KEY,
        canCreateYN INTEGER,
        canDeleteYN INTEGER,
        canExportYN INTEGER,
        canPrintYN INTEGER,
        canUpdateYN INTEGER,
        canViewYN INTEGER,
        companyID INTEGER,
        OptionName TEXT,
        userMasterID INTEGER
      )
    ''');
      List<dynamic> res = await batch.commit();
    } catch (e) {
      print("while creating error $e");
    }
  }

  Future<List<ServiceAPPlogins>> getServiceAPPlogins(int id) async {
    try {
      print("id is $id");
      Database? db = await instance.database;
      // final db = await database;
      final List<Map<String, dynamic>> results =
          await db!.query(table, where: 'userMasterID = ?', whereArgs: [id]);
      print("results${results}");

      final List<ServiceAPPlogins> logins = results.map((map) {
        print("map details ${map}");
        return ServiceAPPlogins.fromMap(map);
      }).toList();
      print("result of logins  ${logins}");
      return logins;
    } catch (e) {
      print("error $e");
      return [];
    }
  }

  // Future<int> insert(ServiceAPPlogins data) async {
  //   Database db = await instance.database;
  //   return await db.insert(table, {'name': car.name, 'miles': car.miles});
  // }
  Future<void> deleteTabel() async {
    try {
      Database? db = await instance.database;
      print("db path ${db!.database.path}");
      await db.delete(table);
    } catch (E) {
      print("error while adding ${E}");
    }
  }

  Future<void> insertServiceAPPlogin(ServiceAPPlogins data) async {
    try {
      Database? db = await instance.database;
      print("db path ${db!.database.path}");
      await db.insert(table, data.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (E) {
      print("error while adding ${E}");
    }
  }

// Add other methods for updating, deleting, etc.
}
