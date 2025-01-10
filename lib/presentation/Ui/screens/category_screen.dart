
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holders/bottom_nav_bar_controller.dart';
import '../../state_holders/category_list_controller.dart';
import '../widgets/category_card.dart';
import '../widgets/loding_indicator.dart';

class CaterogyListScreen extends StatefulWidget {
  const CaterogyListScreen({super.key});

  @override
  State<CaterogyListScreen> createState() => _CaterogyListScreenState();
}

class _CaterogyListScreenState extends State<CaterogyListScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.find<BottomNavBarController>().backToHome();
          return false; // Prevent the default back action
        },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Category'),
          leading: IconButton(
              onPressed: () {
                Get.find<BottomNavBarController>().backToHome();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<CategoryListController>().getCategoryList();
          },
          child: GetBuilder<CategoryListController>(
              builder: (categoryListController) {
            if (categoryListController.inProgress) {
              return const LoadingIndicator();
            } else if (categoryListController.errorMessage != null) {
              return Center(
                  child: Text(categoryListController.errorMessage.toString()));
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: categoryListController.categoryList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.75),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    categoryModel: categoryListController.categoryList[index],
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
