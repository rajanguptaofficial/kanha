// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class MemberCollectionDBHelper {
//   static final MemberCollectionDBHelper instance = MemberCollectionDBHelper._internal();
//   static Database? _database;

//   MemberCollectionDBHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'member_collection.db');
//     return openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }
// Future<void> _onCreate(Database db, int version) async {
//   await db.execute('''
//     CREATE TABLE memberCollection (
//       id INTEGER PRIMARY KEY AUTOINCREMENT, -- Auto-incremented ID
//       rowId INTEGER,                        -- From Excel: "rowId"
//       dumpDate TEXT,                        -- From Excel: "dumpDate" (Date format as TEXT)
//       dumpTime TEXT,                        -- From Excel: "dumpTime" (Time format as TEXT)
//       sampleId INTEGER,                     -- From Excel: "sampleId"
//       shift TEXT,                           -- From Excel: "shift"
//       farmerId INTEGER,                     -- From Excel: "farmerId"
//       routeId INTEGER,                      -- From Excel: "routeId"
//       socCode INTEGER,                      -- From Excel: "socCode"
//       cntCode INTEGER,                      -- From Excel: "cntCode"
//       mccId INTEGER,                        -- From Excel: "mccId"
//       plantId INTEGER,                      -- From Excel: "plantId"
//       companyId INTEGER,                    -- From Excel: "companyId"
//       deviceId TEXT,                        -- From Excel: "deviceId"
//       type TEXT,                            -- From Excel: "type"
//       weight REAL,                          -- From Excel: "weight"
//       weightLiter REAL,                     -- From Excel: "weightLiter"
//       fat REAL,                             -- From Excel: "fat"
//       lr REAL,                              -- From Excel: "lr"
//       snf REAL,                             -- From Excel: "snf"
//       protein REAL,                         -- From Excel: "protein"
//       water REAL,                           -- From Excel: "water"
//       rtpl REAL,                            -- From Excel: "rtpl"
//       totalAmount REAL,                     -- From Excel: "totalAmount"
//       isQtyAuto INTEGER,                    -- From Excel: "isQtyAuto" (0/1 for boolean-like fields)
//       isQltyAuto INTEGER,                   -- From Excel: "isQltyAuto"
//       remark TEXT,                          -- From Excel: "remark"
//       qtytime TEXT,                         -- From Excel: "qtytime"
//       qltytime TEXT,                        -- From Excel: "qltytime"
//       kgLtrConst REAL,                      -- From Excel: "kgLtrConst"
//       ltrKgConst REAL,                      -- From Excel: "ltrKgConst"
//       qtyMode INTEGER,                      -- From Excel: "qtyMode"
//       cUserId INTEGER,                      -- From Excel: "cUserId"
//       cDateTime TEXT,                       -- From Excel: "cDateTime"
//       mUserId INTEGER,                      -- From Excel: "mUserId"
//       mDateTime TEXT,                       -- From Excel: "mDateTime"
//       lastSynchronized TEXT,                -- From Excel: "lastSynchronized"
//       insertMode TEXT,                      -- From Excel: "insertMode"
//       isDelete INTEGER,                     -- From Excel: "isDelete"
//       isApproved INTEGER,                   -- From Excel: "isApproved"
//       isRejected INTEGER,                   -- From Excel: "isRejected"
//       fkFarmerId INTEGER,                   -- From Excel: "fkFarmerId"
//       isDownload INTEGER,                   -- From Excel: "isDownload"
//       downloadDatetime TEXT,                -- From Excel: "downloadDatetime"
//       smpsId TEXT,                          -- From Excel: "smpsId"
//       PublicIp TEXT,                        -- From Excel: "PublicIp"
//       IsRateCalculate INTEGER,              -- From Excel: "IsRateCalculate"
//       RateCalculate TEXT,                   -- From Excel: "RateCalculate"
//       MPP_Other_Code TEXT,                  -- From Excel: "MPP_Other_Code"
//       member_other_code TEXT,               -- From Excel: "member_other_code"
//       BMC_Other_Code TEXT,                  -- From Excel: "BMC_Other_Code"
//       SyncStatus INTEGER,                   -- From Excel: "SyncStatus"
//       SyncTime TEXT,                        -- From Excel: "SyncTime"
//       analyzerCode TEXT,                    -- From Excel: "analyzerCode"
//       analyzerString TEXT,                  -- From Excel: "analyzerString"
//       CommissionPerUnit REAL,               -- From Excel: "CommissionPerUnit"
//       CommissionAmount REAL,                -- From Excel: "CommissionAmount"
//       IsPaymentDone INTEGER,                -- From Excel: "IsPaymentDone"
//       clientAppRate REAL,                   -- From Excel: "clientAppRate"
//       clientAppAmount REAL,                 -- From Excel: "clientAppAmount"
//       ftpSync_status INTEGER,               -- From Excel: "ftpSync_statu"
//       batch_id TEXT                         -- From Excel: "batch_id"
//     )
//   ''');
// }

//   Future<void> insertData(List<Map<String, dynamic>> members) async {
//     final db = await database;

//     await db.delete('memberCollection');
//     for (var member in members) {
//       await db.insert('memberCollection', member);
//     }
//   }

//   Future<List<Map<String, dynamic>>> fetchLocalData() async {
//     final db = await database;
//     return await db.query('memberCollection');
//   }
// }

