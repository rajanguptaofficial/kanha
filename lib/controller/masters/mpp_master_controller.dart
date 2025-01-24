// import 'package:get/get.dart';
// import 'package:kanha_bmc/common/api_urls.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:kanha_bmc/model/master/mpp_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MppMasterController extends GetxController {
//   var isLoading = true.obs;
//   var mppData = [].obs;


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
//       "requests": "Mpp"
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: json.encode(body),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final responseModel = MPPMasterModel.fromJson(data);
//         mppData.value = responseModel.responseData!.table!;
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

class MppMasterController extends GetxController {
  var isLoading = true.obs;
  var mppData = <Map<String, dynamic>>[].obs;


 final KanhaDBHelper _kanhaDBHelper = KanhaDBHelper.instance;

  @override
  void onInit() {
    super.onInit();
    initializeMPPData();
  }

  Future<void> initializeMPPData() async {
    isLoading.value = true;
    try {
      final data = await fetchLocalData();
      mppData.assignAll(data);
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
      "requests": "Mpp"
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

        mppData.assignAll(await fetchLocalData());
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }




  Future<void> insertData(List<Map<String, dynamic>> mppMasterData) async {
    final db = await _kanhaDBHelper.database;

    // Clear existing data before inserting new data
    await db.delete('mppMaster');

    for (var mppMasters in mppMasterData) {
      
      await db.insert('mppMaster', mppMasters);
    }
  }

 Future<List<Map<String, dynamic>>> fetchLocalData() async {
    final db = await _kanhaDBHelper.database;
    return await db.query('mppMaster');
  }





}
