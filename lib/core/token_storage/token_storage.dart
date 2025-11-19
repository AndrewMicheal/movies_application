import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _tokenKey = 'user_token';

  /// Save token to local storage
  static Future<bool> saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = await prefs.setString(_tokenKey, token);
      print('TokenStorage: Token saved = $result');
      return result;
    } catch (e) {
      print('TokenStorage: Error saving token: $e');
      return false;
    }
  }

  /// Get token from local storage
  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenKey);
      print('TokenStorage: Retrieved token = ${token != null ? "exists" : "null"}');
      return token;
    } catch (e) {
      print('TokenStorage: Error getting token: $e');
      return null;
    }
  }

  /// Delete token from local storage
  static Future<bool> deleteToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = await prefs.remove(_tokenKey);
      print('TokenStorage: Token deleted = $result');
      return result;
    } catch (e) {
      print('TokenStorage: Error deleting token: $e');
      return false;
    }
  }

  /// Check if token exists
  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}