import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:kanha_bmc/database/data%20syncing/data_syncing_homepage.dart';

import 'package:kanha_bmc/database/master/rate_check_db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class RateCheckMasterController extends GetxController {
  final RateCheckMasterDBHelper rateCheckDB = RateCheckMasterDBHelper.instance;

  var fat = ''.obs;
  var snf = ''.obs;
  var selectedMilkType = ''.obs;
  RxBool isLoading = true.obs;
   var milk;
  var milkTypes = ["Buff", "Cow", "Mixed"].obs;
  var rtpl = ''.obs;






  // Map milk type names to their codes
  void updateSelectedMilkType(String milkType) {
    if (milkType == "Buff") {
      milk = "B";
    } else if (milkType == "Cow") {
      milk = "C";
    } else if (milkType == "Mixed") {
      milk = "M";
    } else {
      milk = ""; // Fallback if invalid type
    }
  }

  // Fetch data from the API and save it locally
  Future<void> fetchData() async {
    final pref = await SharedPreferences.getInstance();
    var userCode = pref.getString('userCode');
    var user = pref.getString('username');
    isLoading.value = true;

    final url = Uri.parse(ApiUrls.profile);
    final body = {
      "deviceid": user.toString(),
      "usrcode": userCode.toString(),
      "requests": "RateDetails"
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final tableData =
            List<Map<String, dynamic>>.from(responseData['responseData']['table']);
        // Save data to SQLite
        await rateCheckDB.insertData(tableData);

        Get.snackbar("Success", "Data fetched and saved locally");
      } else {
        Get.snackbar("Error", "Failed to fetch data");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
    isLoading.value = false;
     Get.to(() =>  DataSyncingHomepageScreen());
  }

  // Filter data from SQLite based on inputs
  Future<void> filterData() async {
    updateSelectedMilkType(selectedMilkType.value); 
    isLoading.value = true;
    try {
      final filteredRates = await rateCheckDB.getFilteredRates(
        double.tryParse(fat.value) ?? 0,
        double.tryParse(snf.value) ?? 0,
        // selectedMilkType.value,
        milk
      );

      if (filteredRates.isNotEmpty) {
        rtpl.value = filteredRates.first['rtpl'].toString();
      } else {
        rtpl.value = 'No match found';
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while filtering: $e");
    }
    isLoading.value = false;
  }
}
