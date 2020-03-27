import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE table user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbHelper.database();
    return db.query(table);
  }

//  static Future<int> deleteData(int id) async {
//    final db = await DbHelper.database();
//    await db.rawDelete('DELETE FROM user_places WHERE id = $id');
//    return await database.delete("Customer", where: 'id = ?', whereArgs: [id]);
//    print('hello');
////    return result;
//  }
//  static Future<int> deleteData(int id) async {
//    final db = await DbHelper.database();
//    print(id);
////    return await db.rawDelete('DELETE FROM user_places WHERE $id = $id');
//    return await db.rawDelete('DELETE FROM user_places WHERE id = ?', ['id']);
//  }

  static Future<int> deleteData(int id) async {
    final db = await DbHelper.database();
    return await db.rawDelete('DELETE FROM user_places WHERE $id = $id');
  }
}
