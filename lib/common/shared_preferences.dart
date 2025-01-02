import 'package:get/get.dart';
import 'package:kanha_bmc/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';

  // Save login data
  static Future<void> saveLoginData({
    required String username,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_passwordKey, password);
  }

  // Get login data
  static Future<Map<String, String?>> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString(_usernameKey),
      'password': prefs.getString(_passwordKey),
    };
  }

  // Clear all login data
  static Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_passwordKey);
  }

  static Future<bool> hasLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_usernameKey);
    final password = prefs.getString(_passwordKey);
    return username != null && password != null;
  }

  static Future<Map<String, String?>> getLoginCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString(_usernameKey),
      'password': prefs.getString(_passwordKey),
    };
  }

  // Clear all stored data in SharedPreferences
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.off(LoginScreen());
  }
}
