import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:kanha_bmc/model/profile_response.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profiles = <Profile>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfiles();
  }

  Future<void> fetchProfiles() async {
    isLoading.value = true;
final pref = await SharedPreferences.getInstance();




    final url = Uri.parse(ApiUrls.profile);
    final body = {
      "deviceid": "0000001111",
      "usrcode": "226",
      "requests": "Profile"
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final responseModel = ProfileResponseModel.fromJson(data);
        profiles.value = responseModel.profiles;
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






