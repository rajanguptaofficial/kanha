// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'package:kanha_bmc/common/api_urls.dart';
// import 'package:kanha_bmc/model/master/rate_master.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RateMasterController extends GetxController {
//   var isLoading = true.obs;
//   var rateMasterData = [].obs;

//   @override
//   void onInit() {
//     fetchData();
//     super.onInit();
//   }


//   Future<void> fetchData() async {
//       final pref = await SharedPreferences.getInstance();
//       var userCode =pref.getString('userCode');
//       var user =pref.getString('username');
//        isLoading.value = true;

//     final url = Uri.parse(ApiUrls.getMasterData);
//     final body = {
//       "deviceid": user.toString(),
//       "usrcode": userCode.toString(),
//       "requests": "RateHeader"
//     };



//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: json.encode(body),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final responseModel = RateHeaderMasterReportModel.fromJson(data);
//         rateMasterData.value = responseModel.responseData!.table!;
//       } else {
//         Get.snackbar('Error', 'Failed to fetch data');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Something went wrong');
//     } finally {
//       isLoading.value = false;
//     }
//   }

// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:kanha_bmc/database/kanha_db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class RateMasterController extends GetxController {
  var isLoading = true.obs;
  var rateData = <Map<String, dynamic>>[].obs;


 final KanhaDBHelper _kanhaDBHelper = KanhaDBHelper.instance;

  @override
  void onInit() {
    super.onInit();
    initializeRateData();
    checkEntryCount();
    super.onInit();
  }
  

  Future<void> initializeRateData() async {
    isLoading.value = true;
    try {
      final data = await fetchLocalData();
      rateData.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchData() async {
    final pref = await SharedPreferences.getInstance();
    var userCode = pref.getString('userCode');
    var username = pref.getString('username');

    isLoading.value = true;

    final url = Uri.parse(ApiUrls.getMasterData);
    final body = {
      "deviceid": username ?? '',
      "usrcode": userCode ?? '',
      "requests": "RateHeader"
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final tableData = List<Map<String, dynamic>>.from(
          responseData['responseData']['table'],
        );

        await insertData(tableData);
        rateData.assignAll(await fetchLocalData());

      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> insertData(List<Map<String, dynamic>> rateMasterData) async {
    final db = await _kanhaDBHelper.database;

    // Clear existing data before inserting new data
    await db.delete('rateMaster');

    for (var rateMasters in rateMasterData) {
      
      await db.insert('rateMaster', rateMasters);
    }
  }

 Future<List<Map<String, dynamic>>> fetchLocalData() async {
    final db = await _kanhaDBHelper.database;
    return await db.query('rateMaster');
  }



  Future<int> getEntryCount() async {
    final db = await _kanhaDBHelper.database;

    // Query to count the number of rows in the table
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) as count FROM rateMaster');

    // Return the count from the first row of the result
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> checkEntryCount() async {
    final count = await getEntryCount();
    print('Number of entries in rateMaster: $count');
  }







}
