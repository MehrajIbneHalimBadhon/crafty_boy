import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/product_cart.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/product_model.dart';

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({
    super.key, required this.productList,
  });

  final List<ProductModel> productList;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return  ProductCard(product: productList[index],);
      },
      separatorBuilder: (_, __) => const SizedBox(
        width: 8,
      ),
    );
  }
}
