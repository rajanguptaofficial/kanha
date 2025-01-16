// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._internal();
//   static Database? _database;

//   DatabaseHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'rate_check.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }


//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE rates (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         fat REAL,
//         snf REAL,
//         rtpl REAL,
//         cattletype TEXT,
//         effectivedate TEXT,
//         effectiveshift TEXT
//       )
//     ''');
//   }

//   Future<void> insertRates(List<Map<String, dynamic>> rates) async {
//     final db = await database;

//     // Clear existing data before inserting new data
//     await db.delete('rates');

//     for (var rate in rates) {
//       await db.insert('rates', rate);
//     }
//   }





//   // Insert or Update Record
//   Future<void> upsertRates(List<Map<String, dynamic>> rates) async {
//     final db = await database;

//     for (var rate in rates) {
//       await db.insert(
//         'rates',
//         rate,
//         conflictAlgorithm: ConflictAlgorithm.replace, // Replaces if the primary key exists
//       );
//     }
//   }

//   // Delete Records Not in Server Response
//   Future<void> deleteMissingRates(List<int> serverIds) async {
//     final db = await database;

//     // Delete records not in the server response
//     await db.delete(
//       'rates',
//       where: 'id NOT IN (${serverIds.join(',')})',
//     );
//   }

//   // Retrieve All Records (for testing or debugging)
//   Future<List<Map<String, dynamic>>> getAllRates() async {
//     final db = await database;
//     return await db.query('rates');
//   }

//   // Filter Records
//   Future<List<Map<String, dynamic>>> getFilteredRates(
//       double fat, double snf, String cattletype) async {
//     final db = await database;

//     return await db.query(
//       'rates',
//       where: 'fat = ? AND snf = ? AND cattletype = ?',
//       whereArgs: [fat, snf, cattletype],
//     );
//   }



//   Future<void> deleteRatesTable() async {
//   final db = await DatabaseHelper.instance.database;
//   await db.execute('DROP TABLE IF EXISTS rates');
//   print('Table rates has been deleted.');
// }


// }






import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

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

  Future<void> insertRates(List<Map<String, dynamic>> rates) async {
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

Future<void> deleteDatabaseFile() async {
  try {
    // Get the database path
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'rate_check.db'); // Replace 'rate_check.db' with your database name

    // Delete the database
    await deleteDatabase(path);

    print('Database deleted successfully');
  } catch (e) {
    print('Error deleting database: $e');
  }
}

}
