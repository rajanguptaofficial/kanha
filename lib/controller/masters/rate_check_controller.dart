// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:kanha_bmc/common/api_urls.dart';
// import 'package:kanha_bmc/database/rate_check.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RateCheckController extends GetxController {
//   final DatabaseHelper dbHelper = DatabaseHelper.instance;
//   var isLoading = true.obs;
//   var fat = ''.obs;
//   var snf = ''.obs;
//   var selectedMilkType = ''.obs;

//   var milkTypes = ["B", "C", "Other"].obs;
//   var rtpl = ''.obs;



//   // Fetch and synchronize data
//   Future<void> fetchData() async {
//       final pref = await SharedPreferences.getInstance();
//       var userCode =pref.getString('userCode');
//       var user =pref.getString('username');
//        isLoading.value = true;

//     final url = Uri.parse(ApiUrls.profile);
//     final body = {
//       "deviceid": user.toString(),
//       "usrcode": userCode.toString(),
//       "requests": "RateDetails"
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: json.encode(body),
//       );

//       if (response.statusCode == 200) {
//       //await dbHelper.deleteRatesTable();




//         final responseData = json.decode(response.body);
//         final tableData = List<Map<String, dynamic>>.from(responseData['responseData']['table']);
  
//            // Save data to SQLite
//         await dbHelper.insertRates(tableData);

//         // Extract all IDs from the server response
//         //final serverIds = tableData.map((rate) => rate['id'] as int).toList();

//         // Insert or update records
//        // await dbHelper.upsertRates(tableData);

//         // Delete missing records
//        // await dbHelper.deleteMissingRates(serverIds);

//         Get.snackbar("Success", "Data synchronized successfully");
//       } else {
//         Get.snackbar("Error", "Failed to fetch data");
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Something went wrong');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Filter data from SQLite
//   Future<void> filterData() async {
//     try {
//       final filteredRates = await dbHelper.getFilteredRates(
//         double.tryParse(fat.value) ?? 0,
//         double.tryParse(snf.value) ?? 0,
//         selectedMilkType.value,
//       );

//       if (filteredRates.isNotEmpty) {
//         rtpl.value = filteredRates.first['rtpl'].toString();
//       } else {
//         rtpl.value = 'No match found';
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred while filtering: $e");
//     }
//   }
// }






import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:kanha_bmc/database/rate_check.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RateCheckController extends GetxController {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  var fat = ''.obs;
  var snf = ''.obs;
  var selectedMilkType = ''.obs;
  var isLoading = true.obs;
  var milkTypes = ["B", "C", "Other"].obs;
  var rtpl = ''.obs;

@override
  void onInit() {
    fetchData();
    super.onInit();
  }



  // Fetch data from server
  // Future<void> fetchData() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('https://your-api-endpoint.com/data'), // Replace with your endpoint
  //     );

  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       final tableData = List<Map<String, dynamic>>.from(responseData['responseData']['table']);


  Future<void> fetchData() async {
      final pref = await SharedPreferences.getInstance();
      var userCode =pref.getString('userCode');
      var user =pref.getString('username');
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
          //await dbHelper.deleteDatabaseFile();
        final responseData = json.decode(response.body);
        final tableData = List<Map<String, dynamic>>.from(responseData['responseData']['table']);
        // Save data to SQLite
        await dbHelper.insertRates(tableData);

        Get.snackbar("Success", "Data fetched and saved locally");
      } else {
        Get.snackbar("Error", "Failed to fetch data");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
    isLoading.value = false;
  }

  // Filter data from SQLite
  Future<void> filterData() async {
    isLoading.value = true;
    try {
      final filteredRates = await dbHelper.getFilteredRates(
        double.tryParse(fat.value) ?? 0,
        double.tryParse(snf.value) ?? 0,
        selectedMilkType.value,
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


