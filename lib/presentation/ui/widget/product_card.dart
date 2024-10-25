import 'package:crafty_boy_ecommerce_app/data/models/product_model.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/screens/product_detatils_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/assets_path.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() =>  ProductDetailsScreen(productId: product.id!,));
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 160,
                height: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  image:  DecorationImage(
                      image: NetworkImage(product.image ?? ''),
                      fit: BoxFit.scaleDown),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black54),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('\$${product.price}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.themeColor)),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            Text(
                              '${product.star}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        Card(
                          color: AppColors.themeColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.favorite_outline,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
