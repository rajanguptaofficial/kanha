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
 var selectedDate = DateTime.now().obs; // Observable date
  var gradeData = ["Good", "Bad", "Sour"].obs;
  var selectedGrade = ''.obs;
  // var currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  // var currentTime = DateFormat('HH:mm').format(DateTime.now()).obs;
  var currentDate =   "".obs;
  var currentTime =   "".obs;
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
      getLocalIp(),
      _initializeDateAndTimeShift(),
    ]).then((_) {
      initializeMemberCollData();
    });
  }



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



  Future<void> getSampleNo() async {
 currentDate.value = DateFormat('dd-MM-yyyy').format(DateTime.now());
 currentTime.value=   DateFormat('HH:mm').format(DateTime.now());
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
          ? (((int.parse(result.first['sampleId'].toString())) + 1)).toString()
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

  // Map milk type names to their codes
Future updateSelectedMilkType(String milk) async {
  // Define a mapping of milk types to their codes
  const milkTypeMap = {
    "Buff": "B",
    "Cow": "C",
    "Mixed": "M",
  };

  // Use the map to set the milk value or default to an empty string
  milkType.value = milkTypeMap[milk] ?? "";
  return milkType.value;
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
    selectedRoute.value = "";
    routeData.clear();
  }

  Future<void> saveEntry() async {
    updateSelectedMilkType(milkType.value);
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
    "testTime": currentTime.value.toString(), // current time
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
    "isReadyToSync" :"false", // false 
    "isTested": "0",
    "collectionType":"rmrd",
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
   Future.wait([
      getSampleNo(),
      fetchRoutes(),
      _initializeDateAndTimeShift(),
    ]).then((_) {
      initializeMemberCollData();
    });

    // await initializeMemberCollData();
  }
}