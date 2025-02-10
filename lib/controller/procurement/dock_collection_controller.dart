// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:kanha_bmc/database/kanha_db.dart';

// class DockCollectionController extends GetxController {
// //final controller2 = Get.put(RateCheckMasterController());
//  final KanhaDBHelper _kanhaDBHelper = KanhaDBHelper.instance;
//  var isLoading = true.obs;
// var docDBCollData = <Map<String, dynamic>>[].obs;
// var routeData = <String>{}.obs; // Observable list for route dropdown
// var selectedRoute = ''.obs; // Selected route value
// var gradeData = ["Good","Bad","Sour"].obs; // Observable list for route dropdown
// var selectedGrade = ''.obs; 
// var currentDate =   DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
// var currentTime =   DateFormat('HH:mm').format(DateTime.now()).obs;
// var timeShift = ''.obs;
// var sampleIdNo = ''.obs; 
// var mppCode = ''.obs;
// var mppName = ''.obs;
// var mppBmcCode = ''.obs;
// var mppSocCode = ''.obs;
// var mppRouteCode = ''.obs;
// var deviceIpAddress = ''.obs;
// var milkType = ''.obs;
// var qty = ''.obs;

// var isForm1Visible = true.obs;
//   @override
//   void onInit() {
//     super.onInit();
//  Future.wait([
//        // getBmcCollectionData(),
//         getSampleNo(),
//          fetchRoutes(),
//         _initializeDateAndTimeShift(),
//         //getLocalIp(),
//     ]).then((_) {
//       // Call afterSyncing to handle post-sync actions after both fetches complete
//        initializeMemberCollData();
//     });
//   }




// Future<void> getSampleNo() async {
//   final db = await _kanhaDBHelper.database;
//   try {
//     int? sampleNo;
//      db.execute;
//     final result = await db.rawQuery('''
//       SELECT sampleId
//       FROM bmcCollection
//       WHERE dumpDate = ? AND shift = ?
//       ORDER BY sampleId DESC
//       LIMIT 1
//     ''', [currentDate.value.toString(), timeShift.value == "Morning" ? "M" : "E"]);

//     if (result.isNotEmpty) {
//       sampleNo = (result.first['sampleId'] as int?) ?? 0;
//       sampleNo++;
//     } else {
//       sampleNo = 1;
//     }
//     sampleIdNo.value = sampleNo.toString(); 
   
//   } catch (e) {
//     print('Error data: $e');
//     rethrow;
//   }
// }

//    Future<void> fetchRoutes() async {
//     final db = await _kanhaDBHelper.database;
//     final List<Map<String, dynamic>> result =
//         await db.rawQuery('SELECT rtCode FROM bmcCollection');
//     // Convert result into "routecode/rtName" format
//         routeData.assignAll(result.map((row) => "${row['rtCode']}").toSet());
//   }

// Future<void> initializeMemberCollData() async {
//   //isLoading.value = true;
//   try {
//     // Ensure the timeShift condition is resolved
//     final timeShiftFilter = timeShift.value == "Morning" ? "M" : "E";

//     // Fetch data filtered by the current date and time shift
//     final data = await fetchLocalData(
//       date: currentDate.value.toString(),
//       shift: timeShiftFilter,
//     );

//     // Update mppCollData with the filtered results
//     docDBCollData.assignAll(data);
//   } catch (e) {
//     print("Error while initializing member collection data: $e");
//   } finally {
//     //isLoading.value = false;
//   }
// }


// Future<List<Map<String, dynamic>>> fetchLocalData({
//   required String date,
//   required String shift,
// }) async {
//   final db = await _kanhaDBHelper.database;

//   // Fetch and filter data using `where` and `whereArgs`
//   final filteredData = await db.query(
//     'bmcCollection', // Table name
//     where: 'DumpDate = ? AND Shift = ?', // Filter condition
//     whereArgs: [date, shift], // Filter values
//   );
//   qty.value="";
//  // clearCollections();
//  print(filteredData);
//  return filteredData;
 
// }

//     Future<String?> getLocalIp() async {
//   try {
//     for (var interface in await NetworkInterface.list()) {
//       for (var addr in interface.addresses) {
//         if (addr.type == InternetAddressType.IPv4) {
//           deviceIpAddress.value =   addr.address.toString();
//           return addr.address; // Return first IPv4 address found
          
//         }
//       }
//     }
//   } catch (e) {
//     print("Error getting IP: $e");
//   }
//   return null;
  
// }



//   // Initialize the date and time shift
//   Future _initializeDateAndTimeShift()async {
//     DateTime now = await DateTime.now();
//     // Determine Morning or Evening based on time
//     int currentHour = now.hour;
//     timeShift.value = currentHour < 12 ? 'Morning' : 'Evening';
//   }

//   // Optional: Method to refresh the date and time shift (if needed)
//   void refreshDateAndTimeShift() {
//     _initializeDateAndTimeShift();
//   }



// void getMppMasterDetails(String code) async {
//   try {
   
//     // Get the database instance
//     final db = await KanhaDBHelper.instance.database;

//     // Query the memberMaster table for the member name
//     final result = await db.query(
//       'mppMaster',
//       //columns: ['firstName'], // Assuming 'mppName' is the member name column
//       where: 'code = ?',
//       whereArgs: [code],
//     );

//     if (result.isNotEmpty) {
//       // Set the member name if a match is found
//       mppName.value = result.first['mppName'] as String;
//       mppSocCode.value =   result.first['socCode'].toString();
//       mppRouteCode.value =   result.first['routecode'].toString();
//       mppBmcCode.value =   result.first['bmccode'].toString();
      
//  } else {
//       // Clear the member name if no match is found
//     mppName.value = '';
//     }
//   } catch (e) {
//     // Handle any database or query errors
//    // mppName.value = 'Error fetching member details';
//     print('Error fetching member details: $e');
//   }}

 
// Future<void> fetchOtherCodeByFirstName(String mppName) async {
//   try {
//     final db = await KanhaDBHelper.instance.database;

//     final result = await db.query(
//       'mppMaster',
//      // columns: ['otherCode'], // Fetch the otherCode column
//       where: 'mppName = ?',  // Match the firstName with the passed value
//       whereArgs: [mppName], // Use the passed firstName (e.g., 'DEMO')
//     );

//     if (result.isNotEmpty) {
//       // Fetch the otherCode value

//    print('Other Code: $mppCode.value');
//    mppCode.value = result.first['code'] as String;
//    mppSocCode.value =   result.first['socCode'].toString();
//    mppRouteCode.value =   result.first['routecode'].toString();
//    mppBmcCode.value =   result.first['bmccode'].toString();

//     } else {
//       print('No record found for firstName: ${mppCode.value}');
//       mppCode.value = '';
//     }
//   } catch (e) {
//      // Handle any database or query errors
//     //mppCode.value = 'Error fetching code details';
//     print('Error fetching member details: $e');
// }
// }

// void clearCollections() {
//   mppCode.value = '';
//   mppName.value = '';
//   qty.value = '';
//   sampleIdNo.value = '';
// }



// Future<void> saveEntry() async {

//   final entry = {   
//     // all fields get behalf of rute master bmc table  only  current time save time(All define variable set value of rute Master)
//     "dumpDate" :currentDate.value.toString(), // current date      behalf of rute master bmc table
//     "shift": timeShift.value == "Morning" ? "M" : "E",// morning    behalf of rute master bmc table
//     "sampleId": sampleIdNo.value.toString(), //  1,2             behalf of rute  bmc table    
//     "rtCode" :mppRouteCode.value.toString(), // society code table rute code  ("routecode": "1")   mmp table         Dropdown  form field
//     "soccode": mppSocCode.value.toString(), //  "socCode": 33000002,       behalf of rute  bmc table       
//     "socname" :  mppName.value.toString(), // mpp name                        behalf of rute master bmc table
//     "type" : milkType.value.toString(), // milk type                          input type
//     "grade" :"good", // good  (Dropdown)                                      input type Dropdown  form field
//     "weight": qty.value.toString(),// qty                                     input type
//     "weightltr": qty.value.toString(),// qty                                  input type
//     "rCans" :"0",//  input type 
//     "aCans" :"", //                  input can jayega                        input type
//     "fat": "0", // fat     ----  "0"
//     "rate": "0", // fat ----
//     "amount":"", // fat
//     "lr" :"0",// 0
//     "snf" :"0",// snf
//     "dockNo": "", // rute k behalf pe dock select
//     "dumpTime": currentTime.value.toString(), // current time
//     "testTime": currentTime.value.toString(), //  current time
//     "dId": "", // ""
//     "dDate" :"", // ""
//     "lId": "", // ""
//     "lDate": "",// ""
//     "ismanuallab": "A", // A
//     "ismanualwt":"A", // A
//     "lId1": "", // ""
//     "isUpload": "0", // 0
//     "cntcode" : mppBmcCode.value.toString(), //   "bmccode": "1", mmp table                behalf of rute master bmc table
//     "collectionCode": mppBmcCode.value.toString(), // "bmccode": "1", mmp table             behalf of rute master bmc table
//     "companyCode":  "" , // ""                    
//     "dockPublicIp" : deviceIpAddress.value.toString(), // device ip address
//     "labPublicIp": deviceIpAddress.value.toString(), // device ip address
//     "insertMode" :"A",// A
//     "mppOtherCode" :mppCode.value.toString(), // mpp code                                   behalf of rute master bmc table
//     "isReadyToSync" :"false" // false 
//   };

//   // Insert the entry into the database
//   await insertData([entry]);
// }

// Future<void> insertData(List<Map<String, dynamic>> entries) async {
//   final db = await _kanhaDBHelper.database;

//   try {
//     int? sampleNo;
//      db.execute;
//     // final result = await db.rawQuery('''
//     //   SELECT sampleId
//     //   FROM bmcCollection
//     //   WHERE dumpDate = ? AND shift = ?
//     //   ORDER BY sampleId DESC
//     //   LIMIT 1
//     // ''', [currentDate.value.toString(), timeShift.value == "Morning" ? "M" : "E"]);

//     // if (result.isNotEmpty) {
//     //   sampleNo = (result.first['sampleId'] as int?) ?? 0;
//     //   sampleNo++;
//     // } else {
//     //   sampleNo = 1;
//     // }
//   // Clear existing data before inserting new data
//    // await db.delete('bmcCollection');
//     //await db.execute('DROP TABLE IF EXISTS bmcCollection');

//     await db.transaction((txn) async {
//       for (var entry in entries) {
//       //  entry['sampleId'] = sampleNo.toString(); 
//        await txn.insert('bmcCollection', entry);
//       }
//     });
//       isForm1Visible.value = true;
//   // Show success message
//     Get.snackbar(
//       'Success',
//       'Data saved successfully!',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//     );
//     print("Data successfully inserted.");
//   } catch (e) {
//     print('Error inserting data: $e');
//     rethrow;
//   }

// clearCollections(); // Clear the form fields after saving

//   // Refresh mppCollData after saving
//   await initializeMemberCollData();
// }



// }



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kanha_bmc/database/kanha_db.dart';

class DockCollectionController extends GetxController {
  final KanhaDBHelper _kanhaDBHelper = KanhaDBHelper.instance;
  var isLoading = true.obs;
  var docDBCollData = <Map<String, dynamic>>[].obs;
  var routeData = <String>{}.obs;
  var selectedRoute = ''.obs;
  var gradeData = ["Good", "Bad", "Sour"].obs;
  var selectedGrade = ''.obs;
  var currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var currentTime = DateFormat('HH:mm').format(DateTime.now()).obs;
  var timeShift = ''.obs;
  var sampleIdNo = ''.obs;
  var mppCode = ''.obs;
  var mppName = ''.obs;
  var mppBmcCode = ''.obs;
  var mppSocCode = ''.obs;
  var mppRouteCode = ''.obs;
  var deviceIpAddress = ''.obs;
  var milkType = ''.obs;
  var can = ''.obs;
  var weight = ''.obs;
  var isForm1Visible = true.obs;

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      getSampleNo(),
      fetchRoutes(),
      _initializeDateAndTimeShift(),
    ]).then((_) {
      initializeMemberCollData();
    });
  }

  Future<void> getSampleNo() async {
    final db = await _kanhaDBHelper.database;
    try {
      final result = await db.rawQuery('''
        SELECT sampleId
        FROM bmcCollection
        WHERE dumpDate = ? AND shift = ?
        ORDER BY sampleId DESC
        LIMIT 1
      ''', [currentDate.value, timeShift.value == "Morning" ? "M" : "E"]);
      sampleIdNo.value = result.isNotEmpty
          ? ((result.first['sampleId'] as int?) ?? 0 + 1).toString()
          : '1';
    } catch (e) {
      print('Error fetching sample number: $e');
      rethrow;
    }
  }

  Future<void> fetchRoutes() async {
    final db = await _kanhaDBHelper.database;
    final result = await db.rawQuery('SELECT rtCode FROM bmcCollection');
    routeData.assignAll(result.map((row) => row['rtCode'].toString()).toSet());
  }

  Future<void> initializeMemberCollData() async {
    try {
      final data = await fetchLocalData(
        date: currentDate.value,
        shift: timeShift.value == "Morning" ? "M" : "E",
      );
      docDBCollData.assignAll(data);
    } catch (e) {
      print("Error initializing member collection data: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchLocalData({
    required String date,
    required String shift,
  }) async {
    final db = await _kanhaDBHelper.database;
    final filteredData = await db.query(
      'bmcCollection',
      where: 'DumpDate = ? AND Shift = ?',
      whereArgs: [date, shift],
    );
    print(filteredData);
    return filteredData;
  }

  Future<String?> getLocalIp() async {
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            deviceIpAddress.value = addr.address;
            return addr.address;
          }
        }
      }
    } catch (e) {
      print("Error getting IP: $e");
    }
    return null;
  }

  Future<void> _initializeDateAndTimeShift() async {
    DateTime now = DateTime.now();
    timeShift.value = now.hour < 12 ? 'Morning' : 'Evening';
  }

  void refreshDateAndTimeShift() {
    _initializeDateAndTimeShift();
  }

  void getMppMasterDetails(String code) async {
    try {
      final db = await KanhaDBHelper.instance.database;
      final result = await db.query(
        'mppMaster',
        where: 'code = ?',
        whereArgs: [code],
      );

      if (result.isNotEmpty) {
        mppName.value = result.first['mppName'] as String;
        mppSocCode.value = result.first['socCode'].toString();
        mppRouteCode.value = result.first['routecode'].toString();
        mppBmcCode.value = result.first['bmccode'].toString();
      } else {
        mppName.value = '';
      }
    } catch (e) {
      print('Error fetching member details: $e');
    }
  }

  Future<void> fetchOtherCodeByFirstName(String mppName) async {
    try {
      final db = await KanhaDBHelper.instance.database;
      final result = await db.query(
        'mppMaster',
        where: 'mppName = ?',
        whereArgs: [mppName],
      );

      if (result.isNotEmpty) {
        mppCode.value = result.first['code'] as String;
        mppSocCode.value = result.first['socCode'].toString();
        mppRouteCode.value = result.first['routecode'].toString();
        mppBmcCode.value = result.first['bmccode'].toString();
      } else {
        mppCode.value = '';
      }
    } catch (e) {
      print('Error fetching code details: $e');
    }
  }

  void clearCollections() {
    mppCode.value = '';
    mppName.value = '';
    can.value = '';
    weight.value = '';
    sampleIdNo.value = '';
  }

  Future<void> saveEntry() async {
final entry = {   
    "dumpDate" :   currentDate.value.toString(), // current date 
    "shift":       timeShift.value == "Morning" ? "M" : "E",// morning
    "sampleId":    sampleIdNo.value.toString(), //  1,2 
    "rtCode" :     mppRouteCode.value.toString(), // society code table rute code  ( "routecode": "1") mmp table 
    "soccode":     mppSocCode.value.toString(), //  "socCode": 33000002,
    "socname" :    mppName.value.toString(), // mpp name
    "type" :       milkType.value.toString(), // milk type
    "grade" :      selectedGrade.value.toString(), // good  (Dropdown)
    "weight":      weight.value.toString(),// qty
    "weightltr":   weight.value.toString(),// qty
    "rCans" :      can.value.toString(),//  input type 
    "aCans" :      can.value.toString(), //input
    "fat": "", // fat
    "rate": "", // fat
    "amount": "", // fat
    "lr" :"0",// 0
    "snf" : "",// snf
    "dockNo": "1", // 1   (Dropdown)
    "dumpTime": currentTime.value.toString(), // current time
    "testTime": currentTime.value.toString(), //  current time
    "dId": "", // ""
    "dDate" :"", // ""
    "lId": "", // ""
    "lDate": "",// ""
    "ismanuallab": "A", // A
    "ismanualwt":"A", // A
    "lId1": "", // ""
    "isUpload": "0", // 0
    "cntcode" : mppBmcCode.value.toString(), //   "bmccode": "1", mmp table
    "collectionCode": mppBmcCode.value.toString(), // "bmccode": "1", mmp table
    "companyCode":  "" , // ""
    "dockPublicIp" :  deviceIpAddress.value.toString(), // device ip address
    "labPublicIp": deviceIpAddress.value.toString(), // device ip address
    "insertMode" :"A",// A
    "mppOtherCode" : mppCode.value.toString(), // mpp code 
    "isReadyToSync" :"false" // false 
  };

  // Insert the entry into the database
  await insertData([entry]);
}

  Future<void> insertData(List<Map<String, dynamic>> entries) async {
    final db = await _kanhaDBHelper.database;

    try {
      await db.transaction((txn) async {
        for (var entry in entries) {
          await txn.insert('bmcCollection', entry);
        }
      });

      isForm1Visible.value = true;

      Get.snackbar(
        'Success',
        'Data saved successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      print("Data successfully inserted.");
    } catch (e) {
      print('Error inserting data: $e');
      rethrow;
    }

    clearCollections();
    await initializeMemberCollData();
  }
}