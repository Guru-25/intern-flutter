import 'package:flutter/material.dart';
import 'package:kathiravan_fireworks/model/order_details.dart';
import 'package:kathiravan_fireworks/model/cart_model.dart';
import 'package:kathiravan_fireworks/services/payment_info_service.dart';
import 'package:kathiravan_fireworks/model/payment_info.dart';

class PaymentForm extends StatefulWidget {
  final double totalAmount;
  final List<CartModel> items;

  const PaymentForm({
    super.key,
    required this.totalAmount,
    required this.items,
  });

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedInfo();
  }

  Future<void> _loadSavedInfo() async {
    try {
      final savedInfo = await PaymentInfoService.getPaymentInfo();
      if (savedInfo != null && mounted) {
        setState(() {
          _nameController.text = savedInfo.name;
          _addressController.text = savedInfo.address;
          _cityController.text = savedInfo.city;
          _stateController.text = savedInfo.state;
          _zipController.text = savedInfo.zip;
          _mobileController.text = savedInfo.mobile;
          _emailController.text = savedInfo.email;
        });
        print('Loaded saved info successfully');
      }
    } catch (e) {
      print('Error loading saved info: $e');
    }
  }

  Future<void> _saveFormData() async {
    final info = PaymentInfo(
      name: _nameController.text,
      address: _addressController.text,
      city: _cityController.text,
      state: _stateController.text,
      zip: _zipController.text,
      mobile: _mobileController.text,
      email: _emailController.text,
    );
    await PaymentInfoService.savePaymentInfo(info);
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    return null;
  }

  String? validateState(String? value) {
    if (value == null || value.isEmpty) {
      return 'State is required';
    }
    return null;
  }

  String? validateZip(String? value) {
    if (value == null || value.isEmpty) {
      return 'ZIP code is required';
    }
    if (value.length != 6) {
      return 'ZIP code must be 6 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'ZIP code must contain only numbers';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number must contain only numbers';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        'Product Checkout',
        style: TextStyle(
          color: const Color.fromARGB(255, 255, 0, 0),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: 400,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        validator: validateName,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: const TextStyle(color: Colors.black87),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 2),
                          ),
                          prefixIcon: const Icon(Icons.person, color: Colors.black54),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  validator: validateAddress,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: const TextStyle(color: Colors.black87),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 2),
                    ),
                    prefixIcon: const Icon(Icons.home, color: Colors.black54),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _cityController,
                        validator: validateCity,
                        decoration: InputDecoration(
                          labelText: 'City',
                          labelStyle: const TextStyle(color: Colors.black87),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _stateController,
                        validator: validateState,
                        decoration: InputDecoration(
                          labelText: 'State',
                          labelStyle: const TextStyle(color: Colors.black87),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _zipController,
                  validator: validateZip,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: 'ZIP Code',
                    labelStyle: const TextStyle(color: Colors.black87),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 2),
                    ),
                    prefixIcon: const Icon(Icons.location_on, color: Colors.black54),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _mobileController,
                  validator: validateMobile,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    labelStyle: const TextStyle(color: Colors.black87),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 2),
                    ),
                    prefixIcon: const Icon(Icons.phone, color: Colors.black54),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.black87),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 2),
                    ),
                    prefixIcon: const Icon(Icons.email, color: Colors.black54),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _saveFormData();
                        
                        final verified = await PaymentInfoService.getPaymentInfo();
                        print('Verification after save: ${verified?.toJson()}');
                        
                        final orderNumber = 'ORD${DateTime.now().millisecondsSinceEpoch}';
                        Navigator.pop(
                          context,
                          OrderDetails(
                            name: _nameController.text,
                            address: _addressController.text,
                            city: _cityController.text,
                            state: _stateController.text,
                            zip: _zipController.text,
                            mobile: _mobileController.text,
                            email: _emailController.text,
                            orderNumber: orderNumber,
                            totalAmount: widget.totalAmount,
                            items: widget.items,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Place Order',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}