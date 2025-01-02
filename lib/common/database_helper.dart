import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'kanha_bmc.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE collections (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sampleNo TEXT,
            code TEXT,
            qty TEXT,
            fat TEXT,
            snf TEXT,
            rate TEXT,
            amount TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertCollection(Map<String, dynamic> collection) async {
    final db = await database;
    return await db.insert('collections', collection);
  }

  Future<List<Map<String, dynamic>>> getCollections() async {
    final db = await database;
    return await db.query('collections');
  }


  // Method to delete all rows in the collections table
  Future<void> clearCollections() async {
    final db = await database;
    await db.delete('collections');
  }


}
