import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BmcMasterDBHelper {
  static final BmcMasterDBHelper instance = BmcMasterDBHelper._internal();
  static Database? _database;

  BmcMasterDBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'bmc_master.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }



Future<void> _onCreate(Database db, int version) async {
  await db.execute('''
    CREATE TABLE bmcMaster (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
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
      cntDocks INTEGER,
      cntCode INTEGER
    )
  ''');
}




  Future<void> insertData(List<Map<String, dynamic>> bmcMasterData) async {
    final db = await database;

    // Clear existing data before inserting new data
    await db.delete('bmcMaster');

    for (var bmcMasters in bmcMasterData) {
      
      await db.insert('bmcMaster', bmcMasters);
    }
  }

 Future<List<Map<String, dynamic>>> fetchLocalData() async {
    final db = await database;
    return await db.query('bmcMaster');
  }


}
