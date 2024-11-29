import 'package:shared_preferences/shared_preferences.dart';
import 'mongodb_service.dart';

class AuthService {
  static const String TOKEN_KEY = 'auth_token';
  static const String USER_ID_KEY = 'user_id';

  static Future<bool> login(String email, String password) async {
    try {
      final user = await MongoDBService.findUserByEmail(email);
      if (user != null && user['password'] == password) {
        await _saveUserData(user['_id'].toString());
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  static Future<bool> register(String name, String email, String password) async {
    try {
      final existing = await MongoDBService.findUserByEmail(email);
      if (existing != null) return false;
      
      return await MongoDBService.createUser(name, email, password);
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  static Future<void> _saveUserData(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = _generateToken(userId);
    await prefs.setString(TOKEN_KEY, token);
    await prefs.setString(USER_ID_KEY, userId);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
    await prefs.remove(USER_ID_KEY);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(TOKEN_KEY);
  }

  static String _generateToken(String userId) {
    return '${DateTime.now().millisecondsSinceEpoch}_$userId';
  }
}