import 'package:get/get.dart';
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:kanha_bmc/response/master/bmc_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


class BmcMasterController extends GetxController {
  var isLoading = true.obs;
  var bmcData = [].obs;

  var apiResponse = BmcMasterResponse().obs;
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }


String formatDate(String? date) {
  if (date == null || date.isEmpty) {
    return '-';
  }
  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  } catch (e) {
    return '-';
  }
}
  // void fetchBmcData() async {
  //   try {
  //     isLoading(true);
  //     // Replace with your API call logic
  //     var response = await fetchFromServer(); // Your API call here
  //     if (response != null) {
  //       bmcData.value = response; // Assuming response is a list
  //     }
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Future<List<Map<String, dynamic>>> fetchFromServer() async {
  //   // Simulate API call
  //   await Future.delayed(Duration(seconds: 2));
  //   return [
  //     {
  //       'bmcNameCode': 'BMC-001',
  //       'mccNameCode': 'MCC001',
  //       'plantNameCode': 'Plant001',
  //       'companyNameCode': 'Company001',
  //       'effectiveDate': '2024-01-01',
  //       'address': 'Address 1',
  //       'dock': 'Dock 1',
  //     },
  //     // Add more data as needed
  //   ];
  // }


  Future<void> fetchData() async {
    isLoading.value = true;

    final url = Uri.parse(ApiUrls.profile);
    final body = {
      "deviceid": "0000001111",
      "usrcode": "226",
      "requests": "BMC"
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final responseModel = BmcMasterResponse.fromJson(data);
        bmcData.value = responseModel.responseData!.table!;
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