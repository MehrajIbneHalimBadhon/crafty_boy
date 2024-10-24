import 'package:crafty_boy_ecommerce_app/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/catagory_card.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatagoryListScreen extends StatefulWidget {
  const CatagoryListScreen({super.key});

  @override
  State<CatagoryListScreen> createState() => _CatagoryListScreenState();
}

class _CatagoryListScreenState extends State<CatagoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backToHome;
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Catagories'),
            leading: IconButton(
              onPressed: backToHome,
              icon: const Icon(Icons.arrow_back_ios_outlined),
            )),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<CategoryListController>().getCategoryList();
          },
          child: GetBuilder<CategoryListController>(
              builder: (categoryListController) {
            if (categoryListController.inProgress) {
              return const CenteredCircularProgressIndicator();
            } else if (categoryListController.errorMessage != null) {
              return Center(
                child: Text(categoryListController.errorMessage!),
              );
            }
            return GridView.builder(
              itemCount: categoryListController.categoryList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                return CatagoryCard(
                  categoryModel: categoryListController.categoryList[index],
                );
              },
            );
          }),
        ),
      ),
    );
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}
