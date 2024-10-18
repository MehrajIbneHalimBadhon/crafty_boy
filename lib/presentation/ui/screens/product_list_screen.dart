import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/product_cart.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key, required this.catagoryName});

  final String catagoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catagoryName),
      ),
      body: GridView.builder(
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8
          ),
          itemBuilder: (context, index) {
            return const FittedBox(child: ProductCard());
          }),
    );
  }
}
