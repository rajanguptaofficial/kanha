import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RateCheckDBHelper {
  static final RateCheckDBHelper instance = RateCheckDBHelper._internal();
  static Database? _database;

  RateCheckDBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'rate_check.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE rates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fat REAL,
        snf REAL,
        rtpl REAL,
        cattletype TEXT,
        effectivedate TEXT,
        effectiveshift TEXT
      )
    ''');
  }

  Future<void> insertData(List<Map<String, dynamic>> rates) async {
    final db = await database;

    // Clear existing data before inserting new data
    await db.delete('rates');

    for (var rate in rates) {
      
      await db.insert('rates', rate);
    }
  }

  Future<List<Map<String, dynamic>>> getFilteredRates(
      double fat, double snf, String cattletype) async {
    final db = await database;

    return await db.query(
      'rates',
      where: 'fat = ? AND snf = ? AND cattletype = ?',
      whereArgs: [fat, snf, cattletype],
    );
  }

// Future<void> deleteDatabaseFile() async {
//   try {
//     // Get the database path
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'rate_check.db'); // Replace 'rate_check.db' with your database name

//     // Delete the database
//     await deleteDatabase(path);

//     print('Database deleted successfully');
//   } catch (e) {
//     print('Error deleting database: $e');
//   }
// }

}
