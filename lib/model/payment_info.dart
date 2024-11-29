class PaymentInfo {
  final String name;
  final String address;
  final String city;
  final String state;
  final String zip;
  final String mobile;
  final String email;

  PaymentInfo({
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.mobile,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'city': city,
    'state': state,
    'zip': zip,
    'mobile': mobile,
    'email': email,
  };

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
    name: json['name'] ?? '',
    address: json['address'] ?? '',
    city: json['city'] ?? '',
    state: json['state'] ?? '',
    zip: json['zip'] ?? '',
    mobile: json['mobile'] ?? '',
    email: json['email'] ?? '',
  );
}