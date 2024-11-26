import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MongoDBService {
  // Remove const and make it late
  static late String MONGO_URL;
  static const String USER_COLLECTION = "users";
  static late Db _db;

  static Future<void> connect() async {
    try {
      // Initialize MONGO_URL here
      MONGO_URL = dotenv.env['MONGO_URL'] ?? '';
      if (MONGO_URL.isEmpty) {
        throw Exception('MONGO_URL not found in environment');
      }
      _db = await Db.create(MONGO_URL);
      await _db.open();
    } catch (e) {
      print('MongoDB connection error: $e');
    }
  }

  static Future<Map<String, dynamic>?> findUserByEmail(String email) async {
    try {
      final users = _db.collection(USER_COLLECTION);
      return await users.findOne(where.eq('email', email));
    } catch (e) {
      print('Error finding user: $e');
      return null;
    }
  }

  static Future<bool> createUser(String name, String email, String password) async {
    try {
      final users = _db.collection(USER_COLLECTION);
      final hashedPassword = _hashPassword(password);
      await users.insert({
        'name': name,
        'email': email,
        'password': hashedPassword,
        'createdAt': DateTime.now(),
      });
      return true;
    } catch (e) {
      print('Error creating user: $e');
      return false;
    }
  }

  static String _hashPassword(String password) {
    // In production, use proper password hashing like bcrypt
    return password; 
  }
}