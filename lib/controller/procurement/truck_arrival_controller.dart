import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kanha_bmc/database/kanha_db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../masters/rate_check_controller.dart';

class TruckArrivalController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
 Future.wait([
        fetchDockData(),
        fetchRoutes(),
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

 Future<void> fetchRoutes() async {
    final db = await _kanhaDBHelper.database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT routecode, rtName FROM ruteMaster');

  
    // Convert result into "routecode/rtName" format
        routeData.assignAll(result.map((row) => "${row['routecode']}/${row['rtName']}").toSet());
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
    'truckArrival', // Table name
    where: 'DumpDate = ? AND Shift = ?', // Filter condition
    whereArgs: [date, shift], // Filter values
  );
 // clearCollections();
print(filteredData);
  return filteredData;
 
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


Future<void> saveEntry() async {
  final pref = await SharedPreferences.getInstance();
    var userCode = pref.getString('userCode');

//     DateTime now = await DateTime.now();
//     int currentHour = now.hour;
//     timeShift.value = currentHour < 12 ? 'Morning' : 'Evening';

// currentDate.value = DateFormat('dd-MM-yyyy').format(DateTime.now());
// currentTime.value=   DateFormat('HH:mm:ss').format(DateTime.now());

final entry = {   
  "rtcode": selectedRoute.value.toString(),
  "dumpDate": currentDate.value.toString(),
  "shift": timeShift.value == "Morning" ? "M" : "E",
  "sampleId": "", //  1,2 
  "arrivalTime": currentTime.value.toString(),
  "truckNo": truckNumber.value.toString(),
  "schTime": "",
  "arrivalDelay": "",
  "arrivalDelayTxt": "",
  "arrivalTimeTxt": "",
  "schTimeTxt": "",
  "companyCode": companyCode.value.toString(),
  "cId": userCode.toString(),
  "cDate": currentDate.value.toString(),
  "mId": "",
  "mDate": "",
  "isUpload": "0",
  "cntCode": "",
  "collectionCode": "",
  "insertMode": "auto",
  "autoId": ""
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
      FROM truckArrival
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
       await txn.insert('truckArrival', entry);
      }
    });
      isForm1Visible.value = true;
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
  clearCollections(); 

Future.wait([
       
        fetchDockData(),
        fetchRoutes(),
        _initializeDateAndTimeShift(),
    ]).then((_) {
      // Call afterSyncing to handle post-sync actions after both fetches complete
       initializeMemberCollData();
    });

// Clear the form fields after saving


//  currentDate.value =   DateFormat('yyyy-MM-dd').format(DateTime.now());
//  currentTime.value =   DateFormat('HH:mm').format(DateTime.now());
//    fetchDockData();
//    fetchRoutes();
//     _initializeDateAndTimeShift();
 
 

  // Refresh truckArrivalDBData after saving
 // await initializeMemberCollData();
}

}