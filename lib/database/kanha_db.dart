import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class KanhaDBHelper {
  static final KanhaDBHelper instance = KanhaDBHelper._internal();
  static Database? _database;

  KanhaDBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
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
 // id INTEGER PRIMARY KEY AUTOINCREMENT, -- Auto-incremented ID






  await db.execute('''
      CREATE TABLE bmcMaster (
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
      CREATE TABLE memberMaster (
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
      CREATE TABLE mppMaster (    
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
      CREATE TABLE ratesCheckMaster (
        fat REAL,
        snf REAL,
        rtpl REAL,
        cattletype TEXT,
        effectivedate TEXT,
        effectiveshift TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE rateMaster (
        rateCode INTEGER,
        otherCode TEXT,
        description TEXT,
        effectiveDate TEXT,
        effectiveShift TEXT,
        cId INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE ruteMaster (
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
    CREATE TABLE memberCollection (
    farmer_collection_main_id INTEGER NULL, 
    collection_date TEXT NULL,   --- current date
    shift_code INTEGER NULL,  --- morn(1) evening (2)
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
    CollectionType TEXT NULL,
    can INTEGER NULL
    )
  ''');
  

//  'date': formattedDate,
//     'time': formattedTime,
//     'memberCode': code.value,
//     'memberName': memberName.value,
//     'fat': fat.value,
//     'snf': snf.value,
//     'qty': qty.value,
//     'milkType': milkType.value,
//     'rate': rate.value,
//     'amount': amountValue.value,
 



  // await db.execute('''
  //   CREATE TABLE memberCollection (
  //     id INTEGER PRIMARY KEY AUTOINCREMENT, -- Auto-incremented ID
  //     rowId INTEGER,                        -- From Excel: "rowId"
  //     dumpDate TEXT,                        -- From Excel: "dumpDate" (Date format as TEXT)
  //     dumpTime TEXT,                        -- From Excel: "dumpTime" (Time format as TEXT)
  //     sampleId INTEGER,                     -- From Excel: "sampleId"
  //     shift TEXT,                           -- From Excel: "shift"
  //     farmerId INTEGER,                     -- From Excel: "farmerId"
  //     routeId INTEGER,                      -- From Excel: "routeId"
  //     socCode INTEGER,                      -- From Excel: "socCode"
  //     cntCode INTEGER,                      -- From Excel: "cntCode"
  //     mccId INTEGER,                        -- From Excel: "mccId"
  //     plantId INTEGER,                      -- From Excel: "plantId"
  //     companyId INTEGER,                    -- From Excel: "companyId"
  //     deviceId TEXT,                        -- From Excel: "deviceId"
  //     type TEXT,                            -- From Excel: "type"
  //     weight REAL,                          -- From Excel: "weight"
  //     weightLiter REAL,                     -- From Excel: "weightLiter"
  //     fat REAL,                             -- From Excel: "fat"
  //     lr REAL,                              -- From Excel: "lr"
  //     snf REAL,                             -- From Excel: "snf"
  //     protein REAL,                         -- From Excel: "protein"
  //     water REAL,                           -- From Excel: "water"
  //     rtpl REAL,                            -- From Excel: "rtpl"
  //     totalAmount REAL,                     -- From Excel: "totalAmount"
  //     isQtyAuto INTEGER,                    -- From Excel: "isQtyAuto" (0/1 for boolean-like fields)
  //     isQltyAuto INTEGER,                   -- From Excel: "isQltyAuto"
  //     remark TEXT,                          -- From Excel: "remark"
  //     qtytime TEXT,                         -- From Excel: "qtytime"
  //     qltytime TEXT,                        -- From Excel: "qltytime"
  //     kgLtrConst REAL,                      -- From Excel: "kgLtrConst"
  //     ltrKgConst REAL,                      -- From Excel: "ltrKgConst"
  //     qtyMode INTEGER,                      -- From Excel: "qtyMode"
  //     cUserId INTEGER,                      -- From Excel: "cUserId"
  //     cDateTime TEXT,                       -- From Excel: "cDateTime"
  //     mUserId INTEGER,                      -- From Excel: "mUserId"
  //     mDateTime TEXT,                       -- From Excel: "mDateTime"
  //     lastSynchronized TEXT,                -- From Excel: "lastSynchronized"
  //     insertMode TEXT,                      -- From Excel: "insertMode"
  //     isDelete INTEGER,                     -- From Excel: "isDelete"
  //     isApproved INTEGER,                   -- From Excel: "isApproved"
  //     isRejected INTEGER,                   -- From Excel: "isRejected"
  //     fkFarmerId INTEGER,                   -- From Excel: "fkFarmerId"
  //     isDownload INTEGER,                   -- From Excel: "isDownload"
  //     downloadDatetime TEXT,                -- From Excel: "downloadDatetime"
  //     smpsId TEXT,                          -- From Excel: "smpsId"
  //     PublicIp TEXT,                        -- From Excel: "PublicIp"
  //     IsRateCalculate INTEGER,              -- From Excel: "IsRateCalculate"
  //     RateCalculate TEXT,                   -- From Excel: "RateCalculate"
  //     MPP_Other_Code TEXT,                  -- From Excel: "MPP_Other_Code"
  //     member_other_code TEXT,               -- From Excel: "member_other_code"
  //     BMC_Other_Code TEXT,                  -- From Excel: "BMC_Other_Code"
  //     SyncStatus INTEGER,                   -- From Excel: "SyncStatus"
  //     SyncTime TEXT,                        -- From Excel: "SyncTime"
  //     analyzerCode TEXT,                    -- From Excel: "analyzerCode"
  //     analyzerString TEXT,                  -- From Excel: "analyzerString"
  //     CommissionPerUnit REAL,               -- From Excel: "CommissionPerUnit"
  //     CommissionAmount REAL,                -- From Excel: "CommissionAmount"
  //     IsPaymentDone INTEGER,                -- From Excel: "IsPaymentDone"
  //     clientAppRate REAL,                   -- From Excel: "clientAppRate"
  //     clientAppAmount REAL,                 -- From Excel: "clientAppAmount"
  //     ftpSync_status INTEGER,               -- From Excel: "ftpSync_statu"
  //     batch_id TEXT                         -- From Excel: "batch_id"
    
  //   )
  // ''');














  }

 

}
