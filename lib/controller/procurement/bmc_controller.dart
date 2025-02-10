
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kanha_bmc/database/kanha_db.dart';
import '../masters/rate_check_controller.dart';

class BMCCollectionController extends GetxController {
   final controller2 = Get.put(RateCheckMasterController());
 final KanhaDBHelper _kanhaDBHelper = KanhaDBHelper.instance;

  var isLoading = true.obs;
  var mppCollData = <Map<String, dynamic>>[].obs;
  
// Perform the multiplication
// Corrected and added an observable for the calculated amountValue
var currentDate =   DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
var currentTime =   DateFormat('HH:mm').format(DateTime.now()).obs;
var timeShift = ''.obs;
var mppCode = ''.obs;
var mppName = ''.obs;
var mppBmcCode = ''.obs;
var mppSocCode = ''.obs;
var mppRouteCode = ''.obs;
var deviceIpAddress = ''.obs;
var milkType = ''.obs;
var qty = ''.obs;
var fat = ''.obs;
var snf = ''.obs;
var rate = ''.obs; // Keep rate as a string because it might be from user input
var amountValue = 0.0.obs; // Observable to hold the calculated amount value

  @override
  void onInit() {
    super.onInit();
 Future.wait([
         fetchDockNumbers(),
        _initializeDateAndTimeShift(),
        getLocalIp(),
    ]).then((_) {
      // Call afterSyncing to handle post-sync actions after both fetches complete
       initializeMemberCollData();
    });



  }

// Future<bool> doesTableExist() async {
//   final db =   await _kanhaDBHelper.database;
 
//   final result = await db.rawQuery(
//       "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
//       ["bmcCollection"]);
//    print("no  bmc collection Table: $result");


//  bool exists = result.isNotEmpty ? true : false;
//   if (!exists) {
//     final db = await _kanhaDBHelper.database;
//   } else {
//      db.execute("bmcCollection");
//     print("Table already exists, skipping creation.");
//   }

//   return result.isNotEmpty;
  
// }



// void checkAndCreateTable() async {
//   bool exists = await isTableExists("bmcCollection");
//   if (!exists) {
//     final db = await _kanhaDBHelper.database;
//     await _onCreate(db, 1);
//   } else {
//     print("Table already exists, skipping creation.");
//   }
// }




Future<void> initializeMemberCollData() async {
  //isLoading.value = true;
  try {
    // Ensure the timeShift condition is resolved
    final timeShiftFilter = timeShift.value == "Morning" ? "M" : "E";

    // Fetch data filtered by the current date and time shift
    final data = await fetchLocalData(
      date: currentDate.value.toString(),
      shift: timeShiftFilter,
    );

    // Update mppCollData with the filtered results
    mppCollData.assignAll(data);
  } catch (e) {
    print("Error while initializing member collection data: $e");
  } finally {
    //isLoading.value = false;
  }
}


Future<List<Map<String, dynamic>>> fetchLocalData({
  required String date,
  required String shift,
}) async {
  final db = await _kanhaDBHelper.database;

  // Fetch and filter data using `where` and `whereArgs`
  final filteredData = await db.query(
    'bmcCollection', // Table name
    where: 'DumpDate = ? AND Shift = ?', // Filter condition
    whereArgs: [date, shift], // Filter values
  );
  qty.value="";
 // clearCollections();
print(filteredData);
  return filteredData;
 
}

    Future<String?> getLocalIp() async {
  try {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4) {
          deviceIpAddress.value =   addr.address.toString();
          return addr.address; // Return first IPv4 address found
          
        }
      }
    }
  } catch (e) {
    print("Error getting IP: $e");
  }
  return null;
  
}





// Function to calculate and update amountValue
void calculateAmountValue() {
  double rateValue = double.tryParse(rate.value) ?? 0.0;
  double qtyValue = double.tryParse(qty.value) ?? 0.0;

  amountValue.value = rateValue * qtyValue;
}


  // Initialize the date and time shift
  Future _initializeDateAndTimeShift()async {
    DateTime now = await DateTime.now();
    // Determine Morning or Evening based on time
    int currentHour = now.hour;
    timeShift.value = currentHour < 12 ? 'Morning' : 'Evening';
  }

  // Optional: Method to refresh the date and time shift (if needed)
  void refreshDateAndTimeShift() {
    _initializeDateAndTimeShift();
  }




void fetchMemberNameDetails(String code) async {
  try {
   
    // Get the database instance
    final db = await KanhaDBHelper.instance.database;

    // Query the memberMaster table for the member name
    final result = await db.query(
      'mppMaster',
      //columns: ['firstName'], // Assuming 'mppName' is the member name column
      where: 'code = ?',
      whereArgs: [code],
    );

    if (result.isNotEmpty) {
      // Set the member name if a match is found
      mppName.value = result.first['mppName'] as String;
      mppSocCode.value =   result.first['socCode'].toString();
      mppRouteCode.value =   result.first['routecode'].toString();
      mppBmcCode.value =   result.first['bmccode'].toString();
      
 } else {
      // Clear the member name if no match is found
    mppName.value = '';
    }
  } catch (e) {
    // Handle any database or query errors
    mppName.value = 'Error fetching member details';
    print('Error fetching member details: $e');
  }}

 
Future<void> fetchOtherCodeByFirstName(String mppName) async {
  try {
    final db = await KanhaDBHelper.instance.database;

    final result = await db.query(
      'mppMaster',
     // columns: ['otherCode'], // Fetch the otherCode column
      where: 'mppName = ?',  // Match the firstName with the passed value
      whereArgs: [mppName], // Use the passed firstName (e.g., 'DEMO')
    );

    if (result.isNotEmpty) {
      // Fetch the otherCode value

   print('Other Code: $mppCode.value');
   mppCode.value = result.first['code'] as String;
   mppSocCode.value =   result.first['socCode'].toString();
   mppRouteCode.value =   result.first['routecode'].toString();
   mppBmcCode.value =   result.first['bmccode'].toString();

    } else {
      print('No record found for firstName: ${mppCode.value}');
      mppCode.value = '';
    }
  } catch (e) {
     // Handle any database or query errors
    mppCode.value = 'Error fetching code details';
    print('Error fetching member details: $e');
}
}

void clearCollections() {
  mppCode.value = '';
  mppName.value = '';
  qty.value = '';
  rate.value = '0.0';
  amountValue.value = 0.0;
  fat.value = '';
  snf.value = '';
  rate.value = '';
   // milkType.value = '';
  //initializeMemberCollData();
  // Get.to(MemberCollectionScreen());
  // Get.off(MemberCollectionScreen());
}


Future<void> saveEntry() async {
  milkType.value = await controller2.updateSelectedMilkType(milkType.value);
  
//     DateTime now = await DateTime.now();
//     int currentHour = now.hour;
//     timeShift.value = currentHour < 12 ? 'Morning' : 'Evening';

// currentDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
// currentTime.value=   DateFormat('HH:mm:ss').format(DateTime.now());

  final entry = {   
    "dumpDate" :currentDate.value.toString(), // current date 
    "shift": timeShift.value == "Morning" ? "M" : "E",// morning
    "sampleId": "", //  1,2 
    "rtCode" :mppRouteCode.value.toString(), // society code table rute code  ( "routecode": "1") mmp table 
    "soccode": mppSocCode.value.toString(), //  "socCode": 33000002,
    "socname" :  mppName.value.toString(), // mpp name
    "type" : milkType.value.toString(), // milk type
    "grade" :"good", // good  (Dropdown)
    "weight": qty.value.toString(),// qty
    "weightltr": qty.value.toString(),// qty
    "rCans" :"0",//  input type 
    "aCans" :"0", //input
    "fat": fat.value.toString(), // fat
    "rate": rate.value.toString(), // fat
    "amount": amountValue.value.toString(), // fat
    "lr" :"0",// 0
    "snf" :snf.value.toString(),// snf
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
    "mppOtherCode" :mppCode.value.toString(), // mpp code 
    "isReadyToSync" :"false" // false 
  };

  // Insert the entry into the database
  await insertData([entry]);
}

Future<void> insertData(List<Map<String, dynamic>> entries) async {
  final db = await _kanhaDBHelper.database;

  try {
    int? sampleNo;
     db.execute;
    final result = await db.rawQuery('''
      SELECT sampleId
      FROM bmcCollection
      WHERE dumpDate = ? AND shift = ?
      ORDER BY sampleId DESC
      LIMIT 1
    ''', [currentDate.value.toString(), timeShift.value == "Morning" ? "M" : "E"]);

    if (result.isNotEmpty) {
      sampleNo = (result.first['sampleId'] as int?) ?? 0;
      sampleNo++;
    } else {
      sampleNo = 1;
    }
  // Clear existing data before inserting new data
   // await db.delete('bmcCollection');
    //await db.execute('DROP TABLE IF EXISTS bmcCollection');

    await db.transaction((txn) async {
      for (var entry in entries) {
        entry['sampleId'] = sampleNo.toString(); 
       await txn.insert('bmcCollection', entry);
      }
    });
  // Show success message
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

controller2.fat.value = "";
controller2.snf.value = "";
// controller2.selectedMilkType.value = "";
// controller2.milk.value = "";
// controller2.milkTypes.value = [];
controller2.rtpl.value = "";
clearCollections(); // Clear the form fields after saving

  // Refresh mppCollData after saving
  await initializeMemberCollData();
}



Future<List<int>> fetchDockNumbers() async {
  final db = await _kanhaDBHelper.database;
  final List<Map<String, dynamic>> result =
      await db.rawQuery('SELECT DISTINCT dockNo FROM bmcCollection WHERE dockNo IS NOT NULL');

  return result.map((row) => row['dockNo'] as int).toList();
}





}