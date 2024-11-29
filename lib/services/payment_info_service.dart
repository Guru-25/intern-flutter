
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/payment_info.dart';

class PaymentInfoService {
  static const String _key = 'payment_info';

  static Future<void> savePaymentInfo(PaymentInfo info) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = jsonEncode(info.toJson());
      final result = await prefs.setString(_key, jsonData);
      print('Saving payment info: $jsonData');
      print('Save successful: $result');
    } catch (e) {
      print('Error saving payment info: $e');
    }
  }

  static Future<PaymentInfo?> getPaymentInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? data = prefs.getString(_key);
      print('Retrieved payment info: $data');
      if (data == null) return null;
      return PaymentInfo.fromJson(jsonDecode(data));
    } catch (e) {
      print('Error getting payment info: $e');
      return null;
    }
  }
}