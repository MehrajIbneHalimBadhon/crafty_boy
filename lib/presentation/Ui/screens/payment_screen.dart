import 'package:crafty_boy_ecommerce_app/presentation/Ui/screens/payment_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

class PaymentScreen extends StatefulWidget {
  final int totalPrice; // Total price from cart
  final List<int> productQuantities; // List of product quantities
  final double deliveryCharge; // Delivery charge

  const PaymentScreen({
    Key? key,
    required this.totalPrice,
    required this.productQuantities,
    required this.deliveryCharge,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isLoading = false;

  Future<void> _processPayment() async {
    setState(() {
      _isLoading = true;
    });

    // Initialize SSLCommerz
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        currency: SSLCurrencyType.USD, // Use USD for dollar
        product_category: 'General',
        sdkType: SSLCSdkType.TESTBOX,
        store_id: 'creni65e9a590e3764', // Replace with your store ID
        store_passwd:
        'creni65e9a590e3764@ssl', // Replace with your store password
        total_amount: (widget.totalPrice + widget.deliveryCharge)
            .toDouble(), // Total price plus delivery charge
        tran_id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(), // Unique transaction ID
      ),
    );

    try {
      // Start payment process
      SSLCTransactionInfoModel result = await sslcommerz.payNow();
      if (result.status!.toLowerCase() == 'failed') {
        Get.snackbar('Error', 'Transaction failed.');
      } else if (result.status!.toLowerCase() == 'closed') {
        Get.snackbar('Error', 'Transaction closed by user.');
      } else {
        // Successful payment
        await _confirmPayment(result.tranId!);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _confirmPayment(String transactionId) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://ecommerce-api.codesilicon.com/api/PaymentSuccess?trn_id=$transactionId'), // Replace with your actual URL
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Handle success
        Get.to(() => PaymentSuccessScreen(
          transactionId: transactionId,
          amount: widget.totalPrice.toDouble(),
        ));
      } else {
        // Handle error from the server
        Get.snackbar('Error',
            'Payment confirmation failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'Something went wrong. Please try again. Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Quantities Row
            Row(
              children: [
                Text(
                  'Product Quantities:',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text('${widget.productQuantities.join(', ')}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500))
              ],
            ),
            // Delivery Charge Row
            Row(
              children: [
                Text(
                  'Delivery Charge:',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text('\$${widget.deliveryCharge}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500))
              ],
            ),
            // Total Amount Row
            Row(
              children: [
                Text(
                  'Total Amount:',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text('\$${widget.totalPrice + widget.deliveryCharge}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500))
              ],
            ),
            const SizedBox(height: 30),
            // Payment Button
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: _processPayment,
              child: Text(
                  'Pay \$${widget.totalPrice + widget.deliveryCharge}'),
            ),
          ],
        ),
      ),
    );
  }
}
