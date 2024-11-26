import 'package:kathiravan_fireworks/model/cart_model.dart';

class OrderDetails {
  final String name;
  final String address;
  final String city;
  final String state;
  final String zip;
  final String mobile;
  final String email;
  final String orderNumber;
  final double totalAmount;
  final List<CartModel> items;

  OrderDetails({
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.mobile,
    required this.email,
    required this.orderNumber,
    required this.totalAmount,
    required this.items,
  });
}