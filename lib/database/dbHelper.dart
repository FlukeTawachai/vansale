import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

class DBManager {
  static Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = Path.join(databasesPath, 'Local.db');

    var database = await openDatabase(dbPath, version: 2,
        onCreate: (database, version) async {
      await database.execute("CREATE TABLE blueDevice ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "address TEXT,"
          "createDT TEXT"
          ")");
    }, onUpgrade: (Database database, int oldVersion, int newVersion) async {
      if (oldVersion == 1 && newVersion == 2) {
        await database.execute("CREATE TABLE blueDevice ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "name TEXT,"
            "address TEXT,"
            "createDT TEXT"
            ")");
      }
    });

    return database;
  }

  static Future<Database> getDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = Path.join(databasesPath, 'Local.db');

    var database = await openDatabase(dbPath, version: 2,
        onUpgrade: (Database database, int oldVersion, int newVersion) async {
      if (oldVersion == 1 && newVersion == 2) {
        await database.execute("CREATE TABLE blueDevice ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "name TEXT,"
            "address TEXT,"
            "createDT TEXT"
            ")");
      }
    });
    return database;
  }
}
