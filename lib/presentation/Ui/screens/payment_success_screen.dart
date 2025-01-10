import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String transactionId;
  final double amount;

  const PaymentSuccessScreen({
    Key? key,
    required this.transactionId,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Successful')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Payment Successful!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Transaction ID: $transactionId',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Amount Paid: \$${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to home or order details
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}