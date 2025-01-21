import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RateMasterDBHelper {
  static final RateMasterDBHelper instance = RateMasterDBHelper._internal();
  static Database? _database;

  RateMasterDBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'rate_master.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

Future<void> _onCreate(Database db, int version) async {
  await db.execute('''
    CREATE TABLE rateMaster (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      rateCode INTEGER,
      otherCode TEXT,
      description TEXT,
      effectiveDate TEXT,
      effectiveShift TEXT,
      cId INTEGER
    )
  ''');
}

  Future<void> insertData(List<Map<String, dynamic>> rateMasterData) async {
    final db = await database;

    // Clear existing data before inserting new data
    await db.delete('rateMaster');

    for (var rateMasters in rateMasterData) {
      
      await db.insert('rateMaster', rateMasters);
    }
  }

 Future<List<Map<String, dynamic>>> fetchLocalData() async {
    final db = await database;
    return await db.query('rateMaster');
  }



  Future<int> getEntryCount() async {
    final db = await database;

    // Query to count the number of rows in the table
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) as count FROM rateMaster');

    // Return the count from the first row of the result
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> checkEntryCount() async {
    final count = await getEntryCount();
    print('Number of entries in rateMaster: $count');
  }









}
