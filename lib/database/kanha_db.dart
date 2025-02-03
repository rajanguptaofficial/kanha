// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class KanhaDBHelper {
//   static final KanhaDBHelper instance = KanhaDBHelper._internal();
//   static Database? _database;

//   KanhaDBHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) {
//      //  _database!;
//     _database = await _initDatabase();
//     }
//   return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'kanha.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   Future<void> _onCreate(Database db, int version) async {
//  // id INTEGER PRIMARY KEY AUTOINCREMENT, -- Auto-incremented ID
//   await db.execute(
    
//     '''
//       CREATE TABLE bmcMaster (
//         bmccode TEXT,
//         bmcname TEXT,
//         mccCode TEXT,
//         mccName TEXT,
//         plantCode TEXT,
//         plantName TEXT,
//         companyCode INTEGER,
//         companyName TEXT,
//         effectivedate TEXT,
//         add1 TEXT,
//         cntDocks INTEGER,
//         cntCode INTEGER
//       )
//     ''');


//     await db.execute('''
//       CREATE TABLE memberMaster (
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

//     await db.execute('''
//       CREATE TABLE mppMaster (    
//         code TEXT,
//         mppName TEXT,
//         status INTEGER,
//         effectiveDate TEXT,
//         socCode INTEGER,
//         routecode TEXT,
//         rtName TEXT,
//         rtcCode INTEGER,
//         bmccode TEXT,
//         bmcname TEXT,
//         mccCode TEXT,
//         mccName TEXT,
//         plantCode TEXT,
//         plantName TEXT,
//         companyCode INTEGER,
//         companyName TEXT,
//         effectivedate1 TEXT,
//         add1 TEXT,
//         cntDocks INTEGER
//       )
//     ''');

//     await db.execute('''
//       CREATE TABLE ratesCheckMaster (
//         fat REAL,
//         snf REAL,
//         rtpl REAL,
//         cattletype TEXT,
//         effectivedate TEXT,
//         effectiveshift TEXT
//       )
//     ''');

//     await db.execute('''
//       CREATE TABLE rateMaster (
//         rateCode INTEGER,
//         otherCode TEXT,
//         description TEXT,
//         effectiveDate TEXT,
//         effectiveShift TEXT,
//         cId INTEGER
//       )
//     ''');

//     await db.execute('''
//       CREATE TABLE ruteMaster (
//         routecode TEXT,
//         rtName TEXT,
//         rtcCode INTEGER,
//         bmccode TEXT,
//         bmcname TEXT,
//         mccCode TEXT,
//         mccName TEXT,
//         plantCode TEXT,
//         plantName TEXT,
//         companyCode INTEGER,
//         companyName TEXT,
//         effectivedate TEXT,
//         add1 TEXT,
//         cntDocks INTEGER
//       )
//     ''');


//   await db.execute('''
//     CREATE TABLE memberCollection (
//     farmer_collection_main_id INTEGER NULL, 
//     collection_date TEXT NULL,   --- current date
//     shift_code INTEGER NULL,  --- morn(1) evening (2)
//     mpp_code TEXT NULL,
//     member_code TEXT NULL,
//     member_name TEXT NULL,
//     milk_type_code INTEGER NULL,
//     milk_quality_type_code INTEGER NULL,
//     sample_no INTEGER NULL,
//     fat REAL NOT NULL,
//     snf REAL NOT NULL,
//     clr REAL NULL,
//     rate REAL NULL,
//     amount REAL NULL,
//     qty REAL NOT NULL,
//     is_qty_auto BOOLEAN NULL,
//     is_quality_auto BOOLEAN NULL,
//     quality_sample_time TEXT NULL,
//     is_sync BOOLEAN NULL,
//     collectionType TEXT NULL,
//     can INTEGER NULL
//     )
//   ''');
  
// await db.execute('''
//   CREATE TABLE bmcCollection (
//     rawId INTEGER PRIMARY KEY AUTOINCREMENT, -- Auto-incremented ID
//     dumpDate TEXT,
//     shift TEXT,
//     sampleId INTEGER,
//     rtCode INTEGER,
//     soccode INTEGER,
//     socname TEXT,
//     type TEXT,
//     grade TEXT,
//     weight REAL,
//     weightltr REAL,
//     rCans INTEGER,
//     aCans INTEGER,
//     fat REAL,
//     lr REAL,
//     snf REAL,
//     dockNo INTEGER,
//     dumpTime TEXT,
//     testTime TEXT,
//     dId INTEGER,
//     dDate TEXT,
//     lId INTEGER,
//     lDate TEXT,
//     ismanuallab INTEGER,
//     ismanualwt INTEGER,
//     lId1 INTEGER,
//     isUpload INTEGER,
//     cntcode INTEGER,
//     collectionCode INTEGER,
//     companyCode INTEGER,
//     dockPublicIp TEXT,
//     labPublicIp TEXT,
//     insertMode TEXT,
//     mppOtherCode TEXT,
//     isReadyToSync INTEGER
// );
//   ''');


// //  'date': formattedDate,
// //     'time': formattedTime,
// //     'memberCode': code.value,
// //     'memberName': memberName.value,
// //     'fat': fat.value,
// //     'snf': snf.value,
// //     'qty': qty.value,
// //     'milkType': milkType.value,
// //     'rate': rate.value,
// //     'amount': amountValue.value,
 



//   // await db.execute('''
//   //   CREATE TABLE memberCollection (
//   //     id INTEGER PRIMARY KEY AUTOINCREMENT, -- Auto-incremented ID
//   //     rowId INTEGER,                        -- From Excel: "rowId"
//   //     dumpDate TEXT,                        -- From Excel: "dumpDate" (Date format as TEXT)
//   //     dumpTime TEXT,                        -- From Excel: "dumpTime" (Time format as TEXT)
//   //     sampleId INTEGER,                     -- From Excel: "sampleId"
//   //     shift TEXT,                           -- From Excel: "shift"
//   //     farmerId INTEGER,                     -- From Excel: "farmerId"
//   //     routeId INTEGER,                      -- From Excel: "routeId"
//   //     socCode INTEGER,                      -- From Excel: "socCode"
//   //     cntCode INTEGER,                      -- From Excel: "cntCode"
//   //     mccId INTEGER,                        -- From Excel: "mccId"
//   //     plantId INTEGER,                      -- From Excel: "plantId"
//   //     companyId INTEGER,                    -- From Excel: "companyId"
//   //     deviceId TEXT,                        -- From Excel: "deviceId"
//   //     type TEXT,                            -- From Excel: "type"
//   //     weight REAL,                          -- From Excel: "weight"
//   //     weightLiter REAL,                     -- From Excel: "weightLiter"
//   //     fat REAL,                             -- From Excel: "fat"
//   //     lr REAL,                              -- From Excel: "lr"
//   //     snf REAL,                             -- From Excel: "snf"
//   //     protein REAL,                         -- From Excel: "protein"
//   //     water REAL,                           -- From Excel: "water"
//   //     rtpl REAL,                            -- From Excel: "rtpl"
//   //     totalAmount REAL,                     -- From Excel: "totalAmount"
//   //     isQtyAuto INTEGER,                    -- From Excel: "isQtyAuto" (0/1 for boolean-like fields)
//   //     isQltyAuto INTEGER,                   -- From Excel: "isQltyAuto"
//   //     remark TEXT,                          -- From Excel: "remark"
//   //     qtytime TEXT,                         -- From Excel: "qtytime"
//   //     qltytime TEXT,                        -- From Excel: "qltytime"
//   //     kgLtrConst REAL,                      -- From Excel: "kgLtrConst"
//   //     ltrKgConst REAL,                      -- From Excel: "ltrKgConst"
//   //     qtyMode INTEGER,                      -- From Excel: "qtyMode"
//   //     cUserId INTEGER,                      -- From Excel: "cUserId"
//   //     cDateTime TEXT,                       -- From Excel: "cDateTime"
//   //     mUserId INTEGER,                      -- From Excel: "mUserId"
//   //     mDateTime TEXT,                       -- From Excel: "mDateTime"
//   //     lastSynchronized TEXT,                -- From Excel: "lastSynchronized"
//   //     insertMode TEXT,                      -- From Excel: "insertMode"
//   //     isDelete INTEGER,                     -- From Excel: "isDelete"
//   //     isApproved INTEGER,                   -- From Excel: "isApproved"
//   //     isRejected INTEGER,                   -- From Excel: "isRejected"
//   //     fkFarmerId INTEGER,                   -- From Excel: "fkFarmerId"
//   //     isDownload INTEGER,                   -- From Excel: "isDownload"
//   //     downloadDatetime TEXT,                -- From Excel: "downloadDatetime"
//   //     smpsId TEXT,                          -- From Excel: "smpsId"
//   //     PublicIp TEXT,                        -- From Excel: "PublicIp"
//   //     IsRateCalculate INTEGER,              -- From Excel: "IsRateCalculate"
//   //     RateCalculate TEXT,                   -- From Excel: "RateCalculate"
//   //     MPP_Other_Code TEXT,                  -- From Excel: "MPP_Other_Code"
//   //     member_other_code TEXT,               -- From Excel: "member_other_code"
//   //     BMC_Other_Code TEXT,                  -- From Excel: "BMC_Other_Code"
//   //     SyncStatus INTEGER,                   -- From Excel: "SyncStatus"
//   //     SyncTime TEXT,                        -- From Excel: "SyncTime"
//   //     analyzerCode TEXT,                    -- From Excel: "analyzerCode"
//   //     analyzerString TEXT,                  -- From Excel: "analyzerString"
//   //     CommissionPerUnit REAL,               -- From Excel: "CommissionPerUnit"
//   //     CommissionAmount REAL,                -- From Excel: "CommissionAmount"
//   //     IsPaymentDone INTEGER,                -- From Excel: "IsPaymentDone"
//   //     clientAppRate REAL,                   -- From Excel: "clientAppRate"
//   //     clientAppAmount REAL,                 -- From Excel: "clientAppAmount"
//   //     ftpSync_status INTEGER,               -- From Excel: "ftpSync_statu"
//   //     batch_id TEXT                         -- From Excel: "batch_id"
    
//   //   )
//   // ''');




//   }

 

// }














// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class KanhaDBHelper {
//   static final KanhaDBHelper instance = KanhaDBHelper._internal();
//   static Database? _database;

//   KanhaDBHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) {
//       _database = await _initDatabase();
//     }
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'kanha.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     // Execute all table creation queries in a single batch
//     final batch = db.batch();

//     batch.execute('''
//       CREATE TABLE bmcMaster (
//         bmccode TEXT,
//         bmcname TEXT,
//         mccCode TEXT,
//         mccName TEXT,
//         plantCode TEXT,
//         plantName TEXT,
//         companyCode INTEGER,
//         companyName TEXT,
//         effectivedate TEXT,
//         add1 TEXT,
//         cntDocks INTEGER,
//         cntCode INTEGER
//       )
//     ''');

//     batch.execute('''
//       CREATE TABLE memberMaster (
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

//     batch.execute('''
//       CREATE TABLE mppMaster (    
//         code TEXT,
//         mppName TEXT,
//         status INTEGER,
//         effectiveDate TEXT,
//         socCode INTEGER,
//         routecode TEXT,
//         rtName TEXT,
//         rtcCode INTEGER,
//         bmccode TEXT,
//         bmcname TEXT,
//         mccCode TEXT,
//         mccName TEXT,
//         plantCode TEXT,
//         plantName TEXT,
//         companyCode INTEGER,
//         companyName TEXT,
//         effectivedate1 TEXT,
//         add1 TEXT,
//         cntDocks INTEGER
//       )
//     ''');

//     batch.execute('''
//       CREATE TABLE ratesCheckMaster (
//         fat REAL,
//         snf REAL,
//         rtpl REAL,
//         cattletype TEXT,
//         effectivedate TEXT,
//         effectiveshift TEXT
//       )
//     ''');

//     batch.execute('''
//       CREATE TABLE rateMaster (
//         rateCode INTEGER,
//         otherCode TEXT,
//         description TEXT,
//         effectiveDate TEXT,
//         effectiveShift TEXT,
//         cId INTEGER
//       )
//     ''');

//     batch.execute('''
//       CREATE TABLE ruteMaster (
//         routecode TEXT,
//         rtName TEXT,
//         rtcCode INTEGER,
//         bmccode TEXT,
//         bmcname TEXT,
//         mccCode TEXT,
//         mccName TEXT,
//         plantCode TEXT,
//         plantName TEXT,
//         companyCode INTEGER,
//         companyName TEXT,
//         effectivedate TEXT,
//         add1 TEXT,
//         cntDocks INTEGER
//       )
//     ''');

//     batch.execute('''
//       CREATE TABLE memberCollection (
//         farmer_collection_main_id INTEGER NULL, 
//         collection_date TEXT NULL,   
//         shift_code INTEGER NULL,  
//         mpp_code TEXT NULL,
//         member_code TEXT NULL,
//         member_name TEXT NULL,
//         milk_type_code INTEGER NULL,
//         milk_quality_type_code INTEGER NULL,
//         sample_no INTEGER NULL,
//         fat REAL NOT NULL,
//         snf REAL NOT NULL,
//         clr REAL NULL,
//         rate REAL NULL,
//         amount REAL NULL,
//         qty REAL NOT NULL,
//         is_qty_auto BOOLEAN NULL,
//         is_quality_auto BOOLEAN NULL,
//         quality_sample_time TEXT NULL,
//         is_sync BOOLEAN NULL,
//         collectionType TEXT NULL,
//         can INTEGER NULL
//       )
//     ''');

//     batch.execute('''
//       CREATE TABLE bmcCollection (
//         rawId INTEGER PRIMARY KEY AUTOINCREMENT, 
//         dumpDate TEXT,
//         shift TEXT,
//         sampleId INTEGER,
//         rtCode INTEGER,
//         soccode INTEGER,
//         socname TEXT,
//         type TEXT,
//         grade TEXT,
//         weight REAL,
//         weightltr REAL,
//         rCans INTEGER,
//         aCans INTEGER,
//         fat REAL,
//         lr REAL,
//         snf REAL,
//         dockNo INTEGER,
//         dumpTime TEXT,
//         testTime TEXT,
//         dId INTEGER,
//         dDate TEXT,
//         lId INTEGER,
//         lDate TEXT,
//         ismanuallab INTEGER,
//         ismanualwt INTEGER,
//         lId1 INTEGER,
//         isUpload INTEGER,
//         cntcode INTEGER,
//         collectionCode INTEGER,
//         companyCode INTEGER,
//         dockPublicIp TEXT,
//         labPublicIp TEXT,
//         insertMode TEXT,
//         mppOtherCode TEXT,
//         isReadyToSync INTEGER
//       )
//     ''');

//     // Apply batch execution
//     await batch.commit();
    
//   }

// }





import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class KanhaDBHelper {
  static final KanhaDBHelper instance = KanhaDBHelper._internal();
  static Database? _database;

  KanhaDBHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
      // _database = await _initDatabase();
    return _database!;
    
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'kanha.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS bmcMaster (
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

    await db.execute('''
      CREATE TABLE IF NOT EXISTS memberMaster (
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

    await db.execute('''
      CREATE TABLE IF NOT EXISTS mppMaster (    
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

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ratesCheckMaster (
        fat REAL,
        snf REAL,
        rtpl REAL,
        cattletype TEXT,
        effectivedate TEXT,
        effectiveshift TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS rateMaster (
        rateCode INTEGER,
        otherCode TEXT,
        description TEXT,
        effectiveDate TEXT,
        effectiveShift TEXT,
        cId INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ruteMaster (
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

    await db.execute('''
      CREATE TABLE IF NOT EXISTS memberCollection (
        farmer_collection_main_id INTEGER NULL, 
        collection_date TEXT NULL,   
        shift_code INTEGER NULL,  
        mpp_code TEXT NULL,
        member_code TEXT NULL,
        member_name TEXT NULL,
        milk_type_code INTEGER NULL,
        milk_quality_type_code INTEGER NULL,
        sample_no INTEGER NULL,
        fat REAL NOT NULL,
        snf REAL NOT NULL,
        clr REAL NULL,
        rate REAL NULL,
        amount REAL NULL,
        qty REAL NOT NULL,
        is_qty_auto BOOLEAN NULL,
        is_quality_auto BOOLEAN NULL,
        quality_sample_time TEXT NULL,
        is_sync BOOLEAN NULL,
        collectionType TEXT NULL,
        can INTEGER NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS bmcCollection (
        rawId INTEGER PRIMARY KEY AUTOINCREMENT, 
        dumpDate TEXT,
        shift TEXT,
        sampleId INTEGER,
        rtCode INTEGER,
        soccode INTEGER,
        socname TEXT,
        type TEXT,
        grade TEXT,
        weight REAL,
        weightltr REAL,
        rCans INTEGER,
        aCans INTEGER,
        fat REAL,
        lr REAL,
        snf REAL,
        rate REAL NULL,
        amount REAL NULL,
        dockNo INTEGER,
        dumpTime TEXT,
        testTime TEXT,
        dId INTEGER,
        dDate TEXT,
        lId INTEGER,
        lDate TEXT,
        ismanuallab INTEGER,
        ismanualwt INTEGER,
        lId1 INTEGER,
        isUpload INTEGER,
        cntcode INTEGER,
        collectionCode INTEGER,
        companyCode INTEGER,
        dockPublicIp TEXT,
        labPublicIp TEXT,
        insertMode TEXT,
        mppOtherCode TEXT,
        isReadyToSync INTEGER
      )
    ''');
    

await db.execute('''
  CREATE TABLE IF NOT EXISTS truckArrival (
    rtcode INTEGER NULL,
    dumpDate TEXT NULL,
    shift TEXT NULL,
    sampleId INTEGER,
    arrivalTime TEXT NULL,
    truckNo TEXT NULL,
    schTime TEXT NULL,
    arrivalDelay INTEGER NULL,
    arrivalDelayTxt TEXT NULL,
    arrivalTimeTxt TEXT NULL,
    schTimeTxt TEXT NULL,
    companyCode INTEGER NULL,
    cId INTEGER NULL,
    cDate TEXT NULL,
    mId TEXT NULL,
    mDate TEXT NULL,
    isUpload INTEGER NULL,
    cntCode INTEGER NULL,
    collectionCode INTEGER NULL,
    insertMode TEXT NULL,
    autoId INTEGER NULL
  )
''');







  // Query and print all tables after table creation
  List<String> tables = await getTables(db);
  print("Tables in DB: $tables");  // Print out all table names

  // Alternatively, if you want to get detailed table information, you can run:
  // List<Map<String, dynamic>> result = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
  // result.forEach((row) => print(row['name']));  // This will print each table name
}

// Helper method to retrieve the table names
Future<List<String>> getTables(Database db) async {
  List<Map<String, dynamic>> result = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
   print(result.map((row) => row['name'] as String).toList());
  return result.map((row) => row['name'] as String).toList();

  }
}
