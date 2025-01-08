import 'package:get/get.dart';
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:kanha_bmc/model/master/bmc_model.dart';
import 'package:kanha_bmc/model/master/member_model.dart';


class MemberMasterController extends GetxController {
  var isLoading = true.obs;
  var memberData = [].obs;

  void fetchMemberData() async {
    try {
      isLoading(true);
      // Replace with your API call logic
      var response = await fetchFromServer(); // Your API call here
      if (response != null) {
        memberData.value = response; // Assuming response is a list
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<List<Map<String, dynamic>>> fetchFromServer() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    return [
      {
        'societyCodeName': 'SuuC001',
        'memberCodeName': 'MCC001',
        'membShortCode': 'Plant001',
        'farmerName': 'Pawan',
        'mobNo': '9454826162',
        'Status': ' 1',
      },
      // Add more data as needed
    ];
  }


 var apiResponse = BmcMasterModel().obs;
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

  Future<void> fetchData() async {
    isLoading.value = true;

    final url = Uri.parse(ApiUrls.profile);
    final body = {
      "deviceid": "0000001111",
      "usrcode": "226",
      "requests": "Member"
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final responseModel = MemberMasterModel.fromJson(data);
        memberData.value = responseModel.responseData.table;
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
