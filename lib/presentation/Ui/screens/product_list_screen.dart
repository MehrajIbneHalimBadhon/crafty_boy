
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/category_model.dart';
import '../../state_holders/category_list_by_id_controller.dart';
import '../widgets/loding_indicator.dart';
import '../widgets/single_product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<CategoryListByIdController>()
        .getCategoryListById(id: widget.categoryModel.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryModel.categoryName as String),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<CategoryListByIdController>(
            builder: (categoryListByIdController) {
          if (categoryListByIdController.inProgress) {
            return const LoadingIndicator();
          }
          if (categoryListByIdController.errorMessage != null) {
            return Center(
              child: Text(categoryListByIdController.errorMessage.toString()),
            );
          }
          if (categoryListByIdController.productList.isEmpty) {
            return const Center(
              child: Text("No Data"),
            );
          }
          return GridView.builder(
              itemCount: categoryListByIdController.productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                return FittedBox(
                    child: SingleProductCard(
                  productModel: categoryListByIdController.productList[index],
                ));
              });
        }),
      ),
    );
  }
}
