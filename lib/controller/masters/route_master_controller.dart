import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:kanha_bmc/database/kanha_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RuteMasterController extends GetxController {
  var isLoading = true.obs;
  var ruteData = <Map<String, dynamic>>[].obs;


 final KanhaDBHelper _kanhaDBHelper = KanhaDBHelper.instance;

  @override
  void onInit() {
    super.onInit();
    initializeRateData();
  }

  Future<void> initializeRateData() async {
    isLoading.value = true;
    try {
      final data = await fetchLocalData();
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

    final url = Uri.parse(ApiUrls.getMasterData);
    final body = {
      "deviceid": username ?? '',
      "usrcode": userCode ?? '',
      "requests": "RouteDetails"
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

        print(" Route data hai $tableData");

        await insertData(tableData);

        ruteData.assignAll(await fetchLocalData());
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> insertData(List<Map<String, dynamic>> ruteMasterData) async {
    final db = await _kanhaDBHelper.database;

    // Clear existing data before inserting new data
    await db.delete('ruteMaster');

    for (var ruteMasters in ruteMasterData) {
      
      await db.insert('ruteMaster', ruteMasters);
    }
  }

 Future<List<Map<String, dynamic>>> fetchLocalData() async {
    final db = await _kanhaDBHelper.database;
    return await db.query('ruteMaster');
  }




}
