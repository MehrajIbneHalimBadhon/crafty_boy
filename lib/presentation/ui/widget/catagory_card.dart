import 'package:crafty_boy_ecommerce_app/data/models/category_model.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class CatagoryCard extends StatelessWidget {
  const CatagoryCard({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ProductListScreen(
            catagory: categoryModel,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.themeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Image.network(
              categoryModel.categoryImg ?? '',
              width: 48,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            categoryModel.categoryName ?? '',
            style: const TextStyle(color: AppColors.themeColor),
          )
        ],
      ),
    );
  }
}
