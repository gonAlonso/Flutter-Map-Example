import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDB = await DBHelper.database(table);
    await sqlDB.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDB = await DBHelper.database(table);
    return sqlDB.query(table);
  }

  static Future<sql.Database> database(String table) async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      version: 1,
      onCreate: (db, version) => db.execute(
          "CREATE TABLE $table (id TEXT PRIMARY_KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT );"),
    );
  }
}
