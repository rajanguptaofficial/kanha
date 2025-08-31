import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:kanha_bmc/database/data%20syncing/data_syncing_homepage.dart';
import 'package:kanha_bmc/database/kanha_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RateCheckMasterController extends GetxController {

 final KanhaDBHelper _kanhaDBHelper = KanhaDBHelper.instance;

  var fat = ''.obs;
  var snf = ''.obs;
  var selectedMilkType = ''.obs;
  RxBool isLoading = true.obs;
   var milk = ''.obs;
  var milkTypes = ["Buff", "Cow", "Mixed"].obs;
  var rtpl = ''.obs;


// Map milk type names to their codes
Future updateSelectedMilkType(String milkType) async {
  // Define a mapping of milk types to their codes
  const milkTypeMap = {
    "Buff": "B",
    "Cow": "C",
    "Mixed": "M",
  };

  // Use the map to set the milk value or default to an empty string
  milk.value = milkTypeMap[milkType] ?? "";

  return milk.value;
}

  // Fetch data from the API and save it locally
  Future<void> fetchData() async {
    final pref = await SharedPreferences.getInstance();
    var userCode = pref.getString('userCode');
    var user = pref.getString('username');
    isLoading.value = true;

    final url = Uri.parse(ApiUrls.getMasterData);
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
        await insertData(tableData);

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
      final filteredRates = await getFilteredRates(
        double.tryParse(fat.value) ?? 0,
        double.tryParse(snf.value) ?? 0,
        // selectedMilkType.value,
        milk.value
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


  Future<void> insertData(List<Map<String, dynamic>> rates) async {
    final db = await _kanhaDBHelper.database;

    // Clear existing data before inserting new data
    await db.delete('ratesCheckMaster');

    for (var rate in rates) {
      
      await db.insert('ratesCheckMaster', rate);
    }
  }

  Future<List<Map<String, dynamic>>> getFilteredRates(
      double fat, double snf, String cattletype) async {
    final db = await _kanhaDBHelper.database;

    return await db.query(
      'ratesCheckMaster',
      where: 'fat = ? AND snf = ? AND cattletype = ?',
      whereArgs: [fat, snf, cattletype],
    );
  }




}
