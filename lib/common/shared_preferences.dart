import 'package:get/get.dart';
import 'package:kanha_bmc/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';
   static const String _userCodeKey = 'userCode';

  // Save login data
  static Future<void> saveLoginData({
    required String username,
    required String password, 
    required userCode,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_passwordKey, password);
    await prefs.setString(_userCodeKey, userCode);
  }

  // Get login data
  static Future<Map<String, String?>> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString(_usernameKey),
      'password': prefs.getString(_passwordKey),
     'userCode': prefs.getString(_userCodeKey),
    };
  }

  // Clear all login data
  static Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_passwordKey);
     await prefs.remove(_userCodeKey);
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
    //await prefs.clear();
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.remove('userCode');
    Get.off(LoginScreen());
  }
}
