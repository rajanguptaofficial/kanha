import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';
import 'package:kanha_bmc/database/kanha_db.dart';


class LabFatSnfController extends GetxController{



  // // Form 1 fields
  // var selectedDock = ''.obs;
  // var selectedShift = ''.obs;
  // var savedEntries = <Map<String, String>>[].obs;
  // // Saved data for Form 2
  // var savedData = <Map<String, dynamic>>[].obs;

  //  saveData() {
  //   int sequenceNo = savedData.length + 1;
  //   savedData.add({
  //     'sequenceNo': sequenceNo,
  //     'date': selectedDate.value,
  //     'shift': selectedShift.value,
  //     'truckNumber': truckNumber.value,
  //     'arrival': arrival.value,
  //     'time': arrival.value,
  //   });
  // }



final controller2 = Get.put(RateCheckMasterController());
 final KanhaDBHelper _kanhaDBHelper = KanhaDBHelper.instance;
  var isForm1Visible = true.obs;
  var truckArrivalDBData = <Map<String, dynamic>>[].obs;
  var arrival = ''.obs;
  var truckNumber = ''.obs;

// Perform the multiplication
// Corrected and added an observable for the calculated amountValue
var currentDate =   "".obs;
var currentTime =   "".obs;
var timeShift = ''.obs;
var companyCode = ''.obs;
var routeData = <String>{}.obs; // Observable list for route dropdown
var selectedRoute = ''.obs; // Selected route value
var dockCollData = <String>{}.obs; // Use Set to prevent duplicates
var selectedDockNo = ''.obs;
var deviceIpAddress = ''.obs;



  @override
  void onInit() {
    super.onInit();
 Future.wait([
        fetchDockData(),
         getLocalIp(),
        _initializeDateAndTimeShift(),
    ]).then((_) {
      // Call afterSyncing to handle post-sync actions after both fetches complete
       initializeMemberCollData();
    });
  }
 var selectedDate = DateTime.now().obs; // Observable date

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000), // Restrict past dates
      lastDate: DateTime.now(),  // Only allow past dates
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate; // Update the selected date
    }
  }

 Future<void> selectTime(BuildContext context) async {
    TimeOfDay currentTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (pickedTime != null) {
      updateTime(pickedTime);
    }
  }




  void updateTime(TimeOfDay time) {
    final now = DateTime.now();
    // final formattedTime = DateFormat('hh:mm a').format(
        final formattedTime = DateFormat('hh:mm').format(
      DateTime(now.year, now.month, now.day, time.hour, time.minute),
    );
     currentDate.value = "";
    currentTime.value = formattedTime;
  }


Future<void> fetchDockData() async {
 currentDate.value = DateFormat('dd-MM-yyyy').format(DateTime.now());
 currentTime.value=   DateFormat('HH:mm').format(DateTime.now());
  final db = await _kanhaDBHelper.database;
  final List<Map<String, dynamic>> result =
      // await db.rawQuery('SELECT DISTINCT cntDocks FROM ruteMaster');
      await db.rawQuery('SELECT DISTINCT cntDocks FROM bmcMaster WHERE cntDocks IS NOT NULL');
 
  // Convert to unique list and update observable
  dockCollData.assignAll(result.map((row) => row['cntDocks'].toString()).toSet());
}


  void updateShift(String shift) {
    timeShift.value = shift;
  }

void selectShift(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: ["Morning", "Evening"].map((shift) {
            return ListTile(
              title: Text(shift),
              onTap: () {
                updateShift(shift);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }


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

    // Update truckArrivalDBData with the filtered results
    truckArrivalDBData.assignAll(data);
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
 // clearCollections();
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




Future<void> fetchCompnyCodeByRuteCodeName(String ruteCodeName) async {

  String input = ruteCodeName;
  List<String> parts = input.split('/'); // Splitting by "/"
  String routecode = parts[0]; // "2"
  String rtName = parts[1]; // "ROUTE2"
  print("First Value: $routecode");
  print("Second Value: $rtName");
   selectedRoute.value  = routecode.toString();


  try {
    final db = await KanhaDBHelper.instance.database;
    final result = await db.query(
    'ruteMaster',
    columns: ['companyCode'],
    where: 'routecode = ? AND rtName = ?',
    whereArgs: [routecode, rtName],
  );

    if (result.isNotEmpty) {
    // Fetch the otherCode value
           companyCode.value  = result.first['companyCode'].toString();
        

    } else {
      print('No record found for firstName: ${result}');
      companyCode.value = '';
    }
  } catch (e) {
     // Handle any database or query errors
    companyCode.value = 'Error fetching code details';
    print('Error fetching member details: $e');
}
}


void clearCollections() {
selectedDockNo.value = "";
currentDate.value = "";
currentTime.value = "";
timeShift.value = "";
selectedRoute.value = "";
selectedDockNo.value = "";
selectedDockNo.value = "";
truckNumber.value = "";
routeData.clear();
dockCollData.clear();
}


  // void clearCollections() {
  //  // mppCode.value = '';
  //  // mppName.value = '';
  //  // can.value = '';
  //  // weight.value = '';
  //  // sampleIdNo.value = '';
  //   selectedRoute.value = "";
  //   routeData.clear();
  // }

  Future<void> saveEntry() async {
    //updateSelectedMilkType(milkType.value);
final entry = {   
    "dumpDate" :   currentDate.value.toString(), // current date 
    "shift":       timeShift.value == "Morning" ? "M" : "E",// morning
    "sampleId": "", //  1,2 
    // "rtCode" :     mppRouteCode.value.toString(), // society code table rute code  ( "routecode": "1") mmp table 
    // "soccode":     mppSocCode.value.toString(), //  "socCode": 33000002,
    // "socname" :    mppName.value.toString(), // mpp name
    // "type" :       milkType.value.toString(), // milk type
    // "grade" :      selectedGrade.value.toString(), // good  (Dropdown)
    // "weight":      weight.value.toString(),// qty
    // "weightltr":   weight.value.toString(),// qty
    // "rCans" :      can.value.toString(),//  input type 
    // "aCans" :      can.value.toString(), //input
    "fat": "", // fat
    "rate": "", // fat
    "amount": "", // fat
    "lr" :"0",// 0
    "snf" : "",// snf
    "dockNo": "1", // 1   (Dropdown)
    "dumpTime": currentTime.value.toString(), // current time
    "testTime": currentTime.value.toString(), // current time
    "dId": "", // ""
    "dDate" :"", // ""
    "lId": "", // ""
    "lDate": "",// ""
    "ismanuallab": "A", // A
    "ismanualwt":"A", // A
    "lId1": "", // ""
    "isUpload": "0", // 0
    //"cntcode" : mppBmcCode.value.toString(), //   "bmccode": "1", mmp table
   // "collectionCode":mppBmcCode.value.toString(), // "bmccode": "1", mmp table
    "companyCode":  "" , // ""
    "dockPublicIp" :  deviceIpAddress.value.toString(), // device ip address
    "labPublicIp": deviceIpAddress.value.toString(), // device ip address
    "insertMode" :"A",// A
    //"mppOtherCode" : mppCode.value.toString(), // mpp code 
    "isReadyToSync" :"false", // false 
    "isTested": ""
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

    // try {
    //   await db.transaction((txn) async {
    //     for (var entry in entries) {
    //       await txn.insert('bmcCollection', entry);
    //     }
    //   });

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
   Future.wait([
      _initializeDateAndTimeShift(),
    ]).then((_) {
      initializeMemberCollData();
    });
  }
}