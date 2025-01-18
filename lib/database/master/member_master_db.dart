// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class MemberMasterDBHelper {
  
//   static final MemberMasterDBHelper instance = MemberMasterDBHelper._internal();
//   static Database? _database;

//   MemberMasterDBHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'member_master.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute(
//       '''CREATE TABLE members(
//           id INTEGER PRIMARY KEY,
//           firstName TEXT,
//           otherCode TEXT,
//           socCode INTEGER,
//           code TEXT,
//           mppName TEXT,
//           status INTEGER,
//           effectiveDate TEXT,
//           socCode1 INTEGER,
//           routeCode TEXT,
//           rtName TEXT,
//           rtcCode TEXT,
//           bmccode TEXT,
//           bmcname TEXT,
//           mccCode TEXT,
//           mccName TEXT,
//           plantCode TEXT,
//           plantName TEXT,
//           companyCode INTEGER,
//           companyName TEXT,
//           effectiveDate1 TEXT,
//           add1 TEXT,
//           cntDocks INTEGER
//         )'''
// );
//   }

//   Future<void> insertData(List<Map<String, dynamic>> members) async {
//     final db = await database;

//     // Clear existing data before inserting new data
//     await db.delete('members');

//     for (var member in members) {
      
//       await db.insert('members', member);
//     }
//   }


//  Future<List<Map<String, dynamic>>> fetchLocalData() async {
//     final db = _database;
//     if (db != null) {
//       return await db.query('members');
//     }
//     return [];
//   }

// }




import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MemberMasterDBHelper {
  static final MemberMasterDBHelper instance = MemberMasterDBHelper._internal();
  static Database? _database;

  MemberMasterDBHelper._internal();

  Future<Database> get database async {
    if (_database != null) 
    return _database!;
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
      CREATE TABLE members (
        id INTEGER PRIMARY KEY,
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

    await db.delete('members');
    for (var member in members) {
      await db.insert('members', member);
    }
  }

  Future<List<Map<String, dynamic>>> fetchLocalData() async {
    final db = await database;
    return await db.query('members');
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
