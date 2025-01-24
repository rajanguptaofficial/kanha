// import 'package:get/get.dart';
// import 'package:kanha_bmc/common/api_urls.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:kanha_bmc/model/master/bmc_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';




// class BmcMasterController extends GetxController {
//   var isLoading = true.obs;
//   var bmcData = [].obs;

//   var apiResponse = BmcMasterModel().obs;
//   @override
//   void onInit() {
//     fetchData();
//     super.onInit();
//   }


// String formatDate(String? date) {
//   if (date == null || date.isEmpty) {
//     return '-';
//   }
//   try {
//     DateTime parsedDate = DateTime.parse(date);
//     return DateFormat('yyyy-MM-dd').format(parsedDate);
//   } catch (e) {
//     return '-';
//   }
// }

//   Future<void> fetchData() async {
//       final pref = await SharedPreferences.getInstance();
//       var userCode =pref.getString('userCode');
//       var user =pref.getString('username');
//        isLoading.value = true;

//     final url = Uri.parse(ApiUrls.profile);
//     final body = {
//       "deviceid": user.toString(),
//       "usrcode": userCode.toString(),
//       "requests": "BMC"
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: json.encode(body),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final responseModel = BmcMasterModel.fromJson(data);
//         bmcData.value = responseModel.responseData!.table!;
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

class BmcMasterController extends GetxController {
  var isLoading = true.obs;
  var bmcData = <Map<String, dynamic>>[].obs;

  final KanhaDBHelper _kanhaDBHelper = KanhaDBHelper.instance;

  @override
  void onInit() {
    super.onInit();
    initializeBMCData();
  }

  Future<void> initializeBMCData() async {
    isLoading.value = true;
    try {
      final data = await fetchLocalData();
      bmcData.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchData() async {
    final pref = await SharedPreferences.getInstance();
    var userCode = pref.getString('userCode');
    var username = pref.getString('username');

    isLoading.value = true;

    final url = Uri.parse(ApiUrls.profile);
    final body = {
      "deviceid": username ?? '',
      "usrcode": userCode ?? '',
      "requests": "BMC"
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

        bmcData.assignAll(await fetchLocalData());
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> insertData(List<Map<String, dynamic>> bmcMasterData) async {
    final db = await _kanhaDBHelper.database;

    // Clear existing data before inserting new data
    await db.delete('bmcMaster');

    for (var bmcMasters in bmcMasterData) {
      
      await db.insert('bmcMaster', bmcMasters);
    }
  }

 Future<List<Map<String, dynamic>>> fetchLocalData() async {
    final db = await _kanhaDBHelper.database;
    return await db.query('bmcMaster');
  }





}
