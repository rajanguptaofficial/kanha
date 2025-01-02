
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:kanha_bmc/common/shared_preferences.dart';
import 'package:kanha_bmc/pages/login.dart';
import 'package:kanha_bmc/pages/dashboard.dart';


class LoginController extends GetxController {
  var isLoading = false.obs;
  var token = ''.obs;
  var deviceNo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDeviceInfo();
     _attemptAutoLogin();
  }

 // Variable to control password visibility
  var isPasswordVisible = false.obs;

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }


  Future<void> fetchDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (GetPlatform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceNo.value = androidInfo.id; // Unique ID for Android
      } else if (GetPlatform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceNo.value = iosInfo.identifierForVendor ?? "Unknown"; // Unique ID for iOS
      } else {
        deviceNo.value = "Unsupported Platform";
      }
    } catch (e) {
      deviceNo.value = "Error fetching device info: $e";
    }
  }
   
   
    Future<void> _attemptAutoLogin() async {
    if (await SharedPrefHelper.hasLoginData()) {

          Get.off(DashboardScreen());
    }
    else{

    Get.off(LoginScreen());

    }
  }


  Future<void> login(String userName, String password, 
 // String deviceNo
  ) async {
    isLoading(true);
    final url = Uri.parse(ApiUrls.login);

    final body = {
      "user_name": userName,
      "password": password,
      "device_no": deviceNo.value,
      "old_password": ""
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['responseStatus'] == 200) {
          token.value = data['responseData']['Token'];
 
     // Save data using SharedPrefHelper
          await SharedPrefHelper.saveLoginData(
            username: data['responseData']['username'],
            password: data['responseData']['password'],
          );

          Get.snackbar('Success', data['responseMessage']);
          print(response.body);
            Get.off(DashboardScreen());
        } else {
           print(response.body);
          Get.snackbar('Error', data['responseMessage']);
        }
        
      } else {
        Get.snackbar('Error', 'Failed to connect to server');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }
}