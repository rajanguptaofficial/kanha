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

//     final url = Uri.parse(ApiUrls.profile);
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
import 'package:kanha_bmc/database/master/rate_master_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RateMasterController extends GetxController {
  var isLoading = true.obs;
  var rateData = <Map<String, dynamic>>[].obs;

  final RateMasterDBHelper rateMasterDB = RateMasterDBHelper.instance;

  @override
  void onInit() {
    super.onInit();
    initializeRateData();
    rateMasterDB.checkEntryCount();
    super.onInit();
  }
  

  Future<void> initializeRateData() async {
    isLoading.value = true;
    try {
      final data = await rateMasterDB.fetchLocalData();
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

    final url = Uri.parse(ApiUrls.profile);
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

        await rateMasterDB.insertData(tableData);

        rateData.assignAll(await rateMasterDB.fetchLocalData());
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }
}
