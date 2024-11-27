// lib/services/payment_info_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/payment_info.dart';

class PaymentInfoService {
  static const String _key = 'payment_info';

  static Future<void> savePaymentInfo(PaymentInfo info) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(info.toJson()));
  }

  static Future<PaymentInfo?> getPaymentInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);
    if (data == null) return null;
    return PaymentInfo.fromJson(jsonDecode(data));
  }
}