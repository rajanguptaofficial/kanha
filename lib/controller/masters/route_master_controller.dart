import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:kanha_bmc/database/master/rute_master_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RuteMasterController extends GetxController {
  var isLoading = true.obs;
  var ruteData = <Map<String, dynamic>>[].obs;

  final RuteMasterDBHelper ruteMasterDB = RuteMasterDBHelper.instance;

  @override
  void onInit() {
    super.onInit();
    initializeRateData();
  }

  Future<void> initializeRateData() async {
    isLoading.value = true;
    try {
      final data = await ruteMasterDB.fetchLocalData();
      ruteData.assignAll(data);
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
      "requests": "Route"
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

        await ruteMasterDB.insertData(tableData);

        ruteData.assignAll(await ruteMasterDB.fetchLocalData());
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
