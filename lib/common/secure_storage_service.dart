import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _rememberMeKey = 'rememberMe';
  static const String _usernameKey = 'remUserid';
  static const String _passwordKey = 'remPass';
  static const String _tokenKey = 'userToken';

  // Save values
  static Future<void> saveRememberMe(bool value) async {
    await _storage.write(key: _rememberMeKey, value: value.toString());
  }

  static Future<void> saveUsername(String username) async {
    await _storage.write(key: _usernameKey, value: username);
  }

  static Future<void> savePassword(String password) async {
    await _storage.write(key: _passwordKey, value: password);
  }

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Get values
  static Future<bool> getRememberMe() async {
    String? value = await _storage.read(key: _rememberMeKey);
    return value == 'true';
  }

  static Future<String?> getUsername() async {
    return await _storage.read(key: _usernameKey);
  }

  static Future<String?> getPassword() async {
    return await _storage.read(key: _passwordKey);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Clear values
  static Future<void> clearRememberMe() async {
    await _storage.delete(key: _rememberMeKey);
  }

  static Future<void> clearUsername() async {
    await _storage.delete(key: _usernameKey);
  }

  static Future<void> clearPassword() async {
    await _storage.delete(key: _passwordKey);
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }


   Future<bool> hasLoginData() async {
   final FlutterSecureStorage storage = const FlutterSecureStorage();
 
    String? userName = await storage.read(key: _usernameKey);
   String? password = await storage.read(key: _passwordKey);
    return userName != null && password != null;
  }

}
