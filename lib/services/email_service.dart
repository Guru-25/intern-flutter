
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:kathiravan_fireworks/model/order_details.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmailService {
  static Future<void> sendOrderConfirmation(OrderDetails order) async {
    final smtpServer = SmtpServer(
      dotenv.env['EMAIL_SERVER'] ?? '',
      port: 587,
      username: dotenv.env['EMAIL_USERNAME'] ?? '',
      password: dotenv.env['EMAIL_PASSWORD'] ?? '',
      ignoreBadCertificate: true,
      ssl: false,
      allowInsecure: true,
    );

    final message = Message()
      ..from = Address(dotenv.env['EMAIL_USERNAME'] ?? '', 'Kathiravan Fireworks')
      ..recipients.add(order.email)
      ..subject = 'Order Success #${order.orderNumber}'
      ..html = '''
        <h2>Thank You for Your Order!</h2>
        <p>Dear ${order.name},</p>
        <p>We're excited to let you know that we've received your order #${order.orderNumber}</p>
        <p>Total Amount: ₹${order.totalAmount}</p>
        <p>To proceed with the payment for your order, please click on the following link: https://kathiravanfireworks.com/Order/Track?orderno=INV-241112094301</p>
        <p>Once your payment is processed, we will proceed with preparing your order for shipment.</p>
        <p>If you have any questions, feel free to contact our customer support.</p>
        <p>Thank you for shopping with us!</p>
        <p>Kathiravan Fireworks</p>
      ''';

    try {
      print('Attempting to send email...');
      final sendReport = await send(message, smtpServer);
      print('Email sent: ${sendReport.toString()}');
    } catch (e) {
      print('Detailed error: $e');
      throw Exception('Failed to send email: ${e.toString()}');
    }
  }
}