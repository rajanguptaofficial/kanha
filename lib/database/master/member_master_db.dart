import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MemberMasterDBHelper {
  static final MemberMasterDBHelper instance = MemberMasterDBHelper._internal();
  static Database? _database;

  MemberMasterDBHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'member_master.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE memberMaster (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        otherCode TEXT,
        socCode INTEGER,
        code TEXT,
        mppName TEXT,
        status INTEGER,
        effectiveDate TEXT,
        socCode1 INTEGER,
        routeCode TEXT,
        rtName TEXT,
        rtcCode TEXT,
        bmccode TEXT,
        bmcname TEXT,
        mccCode TEXT,
        mccName TEXT,
        plantCode TEXT,
        plantName TEXT,
        companyCode INTEGER,
        companyName TEXT,
        effectiveDate1 TEXT,
        add1 TEXT,
        cntDocks INTEGER
      )
    ''');
  }

  Future<void> insertData(List<Map<String, dynamic>> members) async {
    final db = await database;

    await db.delete('memberMaster');
    for (var member in members) {
      await db.insert('memberMaster', member);
    }
  }

  Future<List<Map<String, dynamic>>> fetchLocalData() async {
    final db = await database;
    return await db.query('memberMaster');
  }
}


// Future<void> saveDataToLocalDb(List<dynamic> members) async {
//   final db = _database;
//   if (db != null) {
//     await db.delete('members'); // Clear existing data
//     for (var member in members) {
//       await db.insert(
//         'members',
//         {
//           'firstName': member['firstName'],
//           'otherCode': member['otherCode'],
//           'socCode': member['socCode'],
//           'code': member['code'],
//           'mppName': member['mppName'],
//           'status': member['status'] ? 1 : 0, // Convert boolean to integer
//           'effectiveDate': member['effectiveDate'],
//           'socCode1': member['socCode1'],
//           'routeCode': member['routecode'],
//           'rtName': member['rtName'],
//           'rtcCode': member['rtcCode'],
//           'bmccode': member['bmccode'],
//           'bmcname': member['bmcname'],
//           'mccCode': member['mccCode'],
//           'mccName': member['mccName'],
//           'plantCode': member['plantCode'],
//           'plantName': member['plantName'],
//           'companyCode': member['companyCode'],
//           'companyName': member['companyName'],
//           'effectiveDate1': member['effectivedate1'],
//           'add1': member['add1'],
//           'cntDocks': member['cntDocks'],
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
//       );
//     }
//   }
// }




// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class MemberMasterDBHelper {
//   static final MemberMasterDBHelper instance = MemberMasterDBHelper._internal();
//   static Database? _database;

//   MemberMasterDBHelper._internal();

//   /// Returns the database instance, initializing it if necessary
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     _database = await _initDatabase();
//     return _database!;
//   }

//   /// Initializes the database
//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'member_master.db');

//     return openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//       onUpgrade: _onUpgrade,
//     );
//   }

//   /// Creates the `memberMaster` table
//   Future<void> _onCreate(Database db, int version) async {
//     print('Creating memberMaster table...');
//     await db.execute('''
//       CREATE TABLE memberMaster (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         firstName TEXT,
//         otherCode TEXT,
//         socCode INTEGER,
//         code TEXT,
//         mppName TEXT,
//         status INTEGER,
//         effectiveDate TEXT,
//         socCode1 INTEGER,
//         routeCode TEXT,
//         rtName TEXT,
//         rtcCode TEXT,
//         bmccode TEXT,
//         bmcname TEXT,
//         mccCode TEXT,
//         mccName TEXT,
//         plantCode TEXT,
//         plantName TEXT,
//         companyCode INTEGER,
//         companyName TEXT,
//         effectiveDate1 TEXT,
//         add1 TEXT,
//         cntDocks INTEGER
//       )
//     ''');
//     print('Table created successfully!');
//   }

//   /// Handles database upgrades if needed
//   Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     print('Upgrading database from $oldVersion to $newVersion...');
//     // Add upgrade logic here if needed
//   }

//   /// Inserts a list of members into the database
//   Future<void> insertData(List<Map<String, dynamic>> members) async {
//     final db = await database;
//     final batch = db.batch(); // Use batch for better performance
//     try {
//       await db.delete('memberMaster'); // Clear existing data
//       for (var member in members) {
//         batch.insert('memberMaster', member, conflictAlgorithm: ConflictAlgorithm.replace);
//       }
//       await batch.commit(noResult: true);
//       print('Data inserted successfully!');
//     } catch (e) {
//       print('Error inserting data: $e');
//     }
//   }

//   /// Fetches all data from the `memberMaster` table
//   Future<List<Map<String, dynamic>>> fetchLocalData() async {
//     final db = await database;
//     try {
//       return await db.query('memberMaster');
//     } catch (e) {
//       print('Error fetching data: $e');
//       return [];
//     }
//   }

//   /// Deletes the database file (useful during development)
//   Future<void> deleteDatabaseFile() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'member_master.db');
//     await deleteDatabase(path);
//     print('Database deleted successfully!');
//   }

//   /// Utility function to check if the `memberMaster` table exists
//   Future<bool> doesTableExist() async {
//     final db = await database;
//     final result = await db.rawQuery(
//       "SELECT name FROM sqlite_master WHERE type='table' AND name='memberMaster'"
//     );
//     return result.isNotEmpty;
//   }
// }
