import 'package:get/get.dart';
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:kanha_bmc/model/master/mpp_model.dart';

class MppMasterController extends GetxController {
  var isLoading = true.obs;
  var mppData = [].obs;


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
      "requests": "Mpp"
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final responseModel = MPPMasterModel.fromJson(data);
        mppData.value = responseModel.responseData!.table!;
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


