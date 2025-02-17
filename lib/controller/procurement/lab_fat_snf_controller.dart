import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';
import 'package:kanha_bmc/database/kanha_db.dart';


class LabFatSnfController extends GetxController{

var clrMA1 = TextEditingController();
var fatMA1 = TextEditingController();
var snfMA1 = TextEditingController();

var clrMA2 = TextEditingController();
var fatMA2 = TextEditingController();
var snfMA2 = TextEditingController();

final controller2 = Get.put(RateCheckMasterController());
 final KanhaDBHelper _kanhaDBHelper = KanhaDBHelper.instance;
  var isForm1Visible = true.obs;
  var labFatSnfDBData = <Map<String, dynamic>>[].obs;

var currentDate =   "".obs;
var currentTime =   "".obs;
var timeShift = ''.obs;
var companyCode = ''.obs;
var routeData = <String>{}.obs; // Observable list for route dropdown
var selectedRoute = ''.obs; // Selected route value
var dockCollData = <String>{}.obs; // Use Set to prevent duplicates
var selectedDockNo = ''.obs;
var deviceIpAddress = ''.obs;

var sample1Tested ="".obs;
var sample2Tested ="".obs;

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
    await fetchLocalData(
      date: currentDate.value.toString(),
      shift: timeShiftFilter,
    );

    // Update truckArrivalDBData with the filtered results
   // labFatSnfDBData.assignAll(data);
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



final filteredData = await db.query(
  'bmcCollection',
  where: 'collectionType = ? AND dumpDate = ? AND shift = ?',
  whereArgs: ['rmrd', date, shift],
);

// Debug: Log the 'isTested' values to check if they are what you expect
filteredData.forEach((row) {
  log('Row: ${row.toString()}');
  log('isTested value: ${row['isTested']}');
});

// Handle potential string or integer 'isTested' value
final notTested = filteredData.where((row) {
  return (int.tryParse(row['isTested'].toString()) ?? -1) == 0;  // Handle both String and Integer
}).toList();

final tested = filteredData.where((row) {
  return (int.tryParse(row['isTested'].toString()) ?? -1) == 1;
}).toList();

// Combine the two lists, with 'notTested' first
final sortedData = [...notTested, ...tested];

// Assign to labFatSnfDBData
labFatSnfDBData.assignAll(sortedData);

// Log the sorted data
log(labFatSnfDBData.toString());

  Map<String, dynamic> sample1 = Map<String, dynamic>.from(labFatSnfDBData[0]);
            sample1Tested.value =     sample1['isTested'].toString();
  Map<String, dynamic> sample2 = Map<String, dynamic>.from(labFatSnfDBData[1]);
               sample2Tested.value =   sample2['isTested'].toString();

 print(labFatSnfDBData);
   return labFatSnfDBData;
 
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
    DateTime now = DateTime.now();
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


Future<void> updateAndMoveToLast(int index) async {

  // Fetch the database instance
  final db = await _kanhaDBHelper.database;
 var formNumber = index == 0 ? "MA1" : "MA2";

  // Ensure the index exists
  if (index >= labFatSnfDBData.length) {

    Get.snackbar(
      'No RMRD Data Found',
      'out of range',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return;
  }else{

  // Create a mutable copy of the record
  Map<String, dynamic> record = Map<String, dynamic>.from(labFatSnfDBData[index]);
  // Check if 'isTested' is true
  if (record['isTested'] == 1) {
    
 clrMA1.clear();
 fatMA1.clear(); 
 snfMA1.clear();
 clrMA2.clear();
 fatMA2.clear(); 
 snfMA2.clear();

    Get.snackbar(
      'Sample ID ${record['sampleId']} is already tested',
      'No Modification Allowed.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    print("Record at index $index is already tested. No modification allowed.");
    return;
  }else{

 log(record.toString());
  // Get `rawId` for database update
  int rawId = record['rawId'];
  

var fat = formNumber== "MA1" ? int.parse(fatMA1.text.trim()) : fatMA2.text.trim() ;
var snf = formNumber== "MA1" ? snfMA1.text.trim() : snfMA2.text.trim() ;
var lr  = formNumber== "MA1" ? clrMA1.text.trim() : clrMA2.text.trim() ;

log(record.toString());

  // Update the database fields
  await db.update(
    'bmcCollection',
    {
      'fat': fat,
      'snf':snf,
      'lr': lr,
      'isTested': "1",
      //'rawId':     data22
    },
    where: 'rawId = ?',
    whereArgs: [rawId],
  );
  log(record.toString());
  List<Map<String, dynamic>> data = await db.query('bmcCollection');
 log(data.toString());




// Fetch the row before deleting it
List<Map<String, dynamic>> existingRows = await db.query(
  'bmcCollection',
  where: 'rawId = ?',
  whereArgs: [rawId],
);
log(existingRows.toString());
// Ensure the row exists before proceeding
if (existingRows.isNotEmpty) {
  Map<String, dynamic> rowToInsert = Map.of(existingRows.first);
  
  // Remove 'rawId' so it doesn't get inserted again
  rowToInsert.remove('rawId');

  // Delete the existing row
  await db.delete('bmcCollection', where: 'rawId = ?', whereArgs: [rawId]);

  // Insert the row back without 'rawId'
  await db.insert('bmcCollection', rowToInsert);
}

final filteredData =  await db.query(
    'bmcCollection',
    where: 'collectionType = ? AND dumpDate = ? AND shift = ?',
    whereArgs: ['rmrd', currentDate.value.toString(), timeShift.value == "Morning" ? "M" : "E"],
  );

// Handle potential string or integer 'isTested' value
final notTested = filteredData.where((row) {
  return (int.tryParse(row['isTested'].toString()) ?? -1) == 0;  // Handle both String and Integer
}).toList();

final tested = filteredData.where((row) {
  return (int.tryParse(row['isTested'].toString()) ?? -1) == 1;
}).toList();

// Combine the two lists, with 'notTested' first
final sortedData = [...notTested, ...tested];

// Assign to labFatSnfDBData
labFatSnfDBData.assignAll(sortedData);

List<Map<String, dynamic>> data3 = await db.query('bmcCollection');
log(data3.toString());
  Map<String, dynamic> sample1 = Map<String, dynamic>.from(labFatSnfDBData[0]);
            sample1Tested.value = sample1['isTested'].toString();
  Map<String, dynamic> sample2 = Map<String, dynamic>.from(labFatSnfDBData[1]);
               sample2Tested.value  =   sample2['isTested'].toString();
}}}



}