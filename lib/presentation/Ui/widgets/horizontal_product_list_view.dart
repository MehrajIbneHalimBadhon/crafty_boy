
import 'package:crafty_boy_ecommerce_app/presentation/Ui/widgets/single_product_card.dart';
import 'package:flutter/material.dart';

import '../../../data/models/product_model.dart';

class HorizontaProductListView extends StatelessWidget {
  const HorizontaProductListView({
    super.key,
    required this.productList,
  });
  final List<ProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SingleProductCard(
            productModel: productList[index],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
              width: 10,
            ),
        itemCount: productList.length);
  }
}
