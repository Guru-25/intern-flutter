import 'package:kathiravan_fireworks/imports.dart';
import 'package:kathiravan_fireworks/model/order_details.dart';
import 'package:kathiravan_fireworks/widgets/payment_form.dart';
import 'package:kathiravan_fireworks/services/email_service.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const AppNameWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              height: 25,
              width: 25,
              alignment: Alignment.center,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              child: TextBuilder(
                text: cart.itemCount.toString(),
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(15),
          itemCount: cart.items.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (BuildContext context, int i) {
            return CartCard(cart: cart.items[i]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10.0);
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          height: 60,
          color: cart.itemCount > 0 ? Colors.black : Colors.grey, // Disable color when empty
          minWidth: size.width,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: cart.itemCount > 0 
            ? () async {
                final result = await showDialog<OrderDetails>(
                  context: context,
                  builder: (context) => PaymentForm(
                    totalAmount: cart.totalPrice().toDouble(),
                    items: cart.items,
                  ),
                );

                if (result != null) {
                  try {
                    // Show loading indicator
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(child: CircularProgressIndicator()),
                    );
                    
                    // Send email
                    await EmailService.sendOrderConfirmation(result);
                    
                    // Close loading indicator
                    Navigator.pop(context);
                    
                    // Clear cart and show success message
                    cart.clearCart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,
                        content: Text('Order ${result.orderNumber} has been successfully placed! Email sent.'),
                      ),
                    );
                  } catch (e) {
                    // Close loading indicator
                    Navigator.pop(context);
                    
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        content: Text('Order confirmed but failed to send email: $e'),
                      ),
                    );
                  }
                }
              }
            : null, // Disable button when cart is empty
          child: cart.itemCount > 0
    ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextBuilder(
            text: '₹ ${cart.totalPrice()}',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          const SizedBox(width: 10.0),
          const TextBuilder(
            text: 'Checkout Order',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ],
      )
    : SizedBox.shrink(),
        ),
      ),
    );
  }
}
