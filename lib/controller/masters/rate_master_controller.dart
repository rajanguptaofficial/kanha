import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:kanha_bmc/model/master/rate_master.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RateMasterController extends GetxController {
  var isLoading = true.obs;
  var rateMasterData = [].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }


  Future<void> fetchData() async {
      final pref = await SharedPreferences.getInstance();
      var userCode =pref.getString('userCode');
      var user =pref.getString('username');
       isLoading.value = true;

    final url = Uri.parse(ApiUrls.profile);
    final body = {
      "deviceid": user.toString(),
      "usrcode": userCode.toString(),
      "requests": "RateHeader"
    };



    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final responseModel = RateHeaderMasterReportModel.fromJson(data);
        rateMasterData.value = responseModel.responseData!.table!;
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
