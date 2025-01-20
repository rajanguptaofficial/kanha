import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RuteMasterDBHelper {
  static final RuteMasterDBHelper instance = RuteMasterDBHelper._internal();
  static Database? _database;

  RuteMasterDBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'rute_master.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

Future<void> _onCreate(Database db, int version) async {
  await db.execute('''
    CREATE TABLE ruteMaster (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      routecode TEXT,
      rtName TEXT,
      rtcCode INTEGER,
      bmccode TEXT,
      bmcname TEXT,
      mccCode TEXT,
      mccName TEXT,
      plantCode TEXT,
      plantName TEXT,
      companyCode INTEGER,
      companyName TEXT,
      effectivedate TEXT,
      add1 TEXT,
      cntDocks INTEGER
    )
  ''');
}

  Future<void> insertData(List<Map<String, dynamic>> ruteMasterData) async {
    final db = await database;

    // Clear existing data before inserting new data
    await db.delete('ruteMaster');

    for (var ruteMasters in ruteMasterData) {
      
      await db.insert('ruteMaster', ruteMasters);
    }
  }

 Future<List<Map<String, dynamic>>> fetchLocalData() async {
    final db = await database;
    return await db.query('ruteMaster');
  }


}
