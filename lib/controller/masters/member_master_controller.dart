import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:kanha_bmc/database/master/member_master_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberMasterController extends GetxController {
  var isLoading = true.obs;
  var memberData = <Map<String, dynamic>>[].obs;

  final MemberMasterDBHelper memberMasterDB = MemberMasterDBHelper.instance;

  @override
  void onInit() {
    super.onInit();
    initializeMemberData();
  }

  Future<void> initializeMemberData() async {
    isLoading.value = true;
    try {
      final data = await memberMasterDB.fetchLocalData();
      memberData.assignAll(data);
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
      "requests": "Member"
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

        await memberMasterDB.insertData(tableData);

        memberData.assignAll(await memberMasterDB.fetchLocalData());
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
