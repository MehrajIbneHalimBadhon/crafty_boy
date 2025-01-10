
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/category_model.dart';
import '../screens/product_list_screen.dart';
import '../utils/app_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoryModel,
  });
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductListScreen(
          categoryModel: categoryModel,
        ));
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.themeColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Image.network(
                  categoryModel.categoryImg!,
                  height: 70,
                  width: 70,
                  fit: BoxFit.scaleDown,
                )),
          ),
          const SizedBox(height: 4),
          Text(
            categoryModel.categoryName ?? '',
            style: const TextStyle(color: AppColors.themeColor),
          )
        ],
      ),
    );
  }
}
