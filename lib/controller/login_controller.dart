import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kanha_bmc/common/api_urls.dart';
import 'package:kanha_bmc/common/shared_preferences.dart';
import 'package:kanha_bmc/database/data%20syncing/data_syncing_homepage.dart';
import 'package:kanha_bmc/pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var token = ''.obs;
  var deviceNo = ''.obs;

  // ✅ Initialize controllers properly to avoid LateInitializationError
  late final TextEditingController userNameController;
  late final TextEditingController passwordController;

  @override
  void onInit() {
    super.onInit();

    // ✅ Always initialize controllers
    userNameController = TextEditingController();
    passwordController = TextEditingController();

    _loadRememberedLogin(); // Load saved credentials (if any)
    fetchDeviceInfo();
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

  Future<void> login(String userName, String password) async {
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

          _saveRememberedLogin(data['responseData']['username'], data['responseData']['password']);

          // Save data using SharedPrefHelper
          await SharedPrefHelper.saveLoginData(
            username: data['responseData']['username'],
            password: data['responseData']['password'],
            userCode: data['responseData']['usercode'],
          );

          Get.snackbar('Success', data['responseMessage']);
          Get.off(DataSyncingHomepageScreen());
          //Get.off(DashboardScreen());
        } else {
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

  var rememberMe = false.obs; // "Remember Me" checkbox state
  final remUserid = ''.obs;   // To store the remembered username
  final remPass = ''.obs;     // To store the remembered password

  // Toggle the "Remember Me" checkbox
  void toggleRememberMe(bool value) {
    rememberMe.value = value;
    if (!value) {
      _clearRememberedLogin();
    }
  }

  // ✅ Load saved username/password if "Remember Me" was checked
  Future<void> _loadRememberedLogin() async {
    final pref = await SharedPreferences.getInstance();
    rememberMe.value = pref.getBool('rememberMe') ?? false;

    if (rememberMe.value) {
      remUserid.value = pref.getString('remUserid') ?? '';
      remPass.value = pref.getString('remPass') ?? '';

      // ✅ Update existing controllers instead of reassigning them
      userNameController.text = remUserid.value;
      passwordController.text = remPass.value;
    }
  }

  // ✅ Save login credentials if "Remember Me" is checked
  Future<void> _saveRememberedLogin(String username, String password) async {
    if (rememberMe.value) {
      final pref = await SharedPreferences.getInstance();
      await pref.setBool('rememberMe', true);
      await pref.setString('remUserid', username);
      await pref.setString('remPass', password);
    }
  }

  // ✅ Clear saved login credentials
  Future<void> _clearRememberedLogin() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('rememberMe');
    await pref.remove('remUserid');
    await pref.remove('remPass');
  }
}
