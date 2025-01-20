import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MppMasterDBHelper {
  static final MppMasterDBHelper instance = MppMasterDBHelper._internal();
  static Database? _database;

  MppMasterDBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mpp_master.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }



Future<void> _onCreate(Database db, int version) async {
  await db.execute('''
    CREATE TABLE mppMaster (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      code TEXT,
      mppName TEXT,
      status INTEGER,
      effectiveDate TEXT,
      socCode INTEGER,
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
      effectivedate1 TEXT,
      add1 TEXT,
      cntDocks INTEGER
    )
  ''');
}



  Future<void> insertData(List<Map<String, dynamic>> mppMasterData) async {
    final db = await database;

    // Clear existing data before inserting new data
    await db.delete('mppMaster');

    for (var mppMasters in mppMasterData) {
      
      await db.insert('mppMaster', mppMasters);
    }
  }

 Future<List<Map<String, dynamic>>> fetchLocalData() async {
    final db = await database;
    return await db.query('mppMaster');
  }


}
