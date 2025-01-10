import 'package:crafty_boy_ecommerce_app/presentation/Ui/screens/product_list_screen.dart';
import 'package:crafty_boy_ecommerce_app/presentation/Ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';
import '../../state_holders/auth_controller.dart';
import '../../state_holders/bottom_nav_bar_controller.dart';
import '../../state_holders/category_list_controller.dart';
import '../../state_holders/new_product_list_controller.dart';
import '../../state_holders/popular_product_list_controller.dart';
import '../../state_holders/special_product_list_controller.dart';
import '../utils/assets_path.dart';
import '../widgets/app_icon_logo_button.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_card.dart';
import '../widgets/home/search_text_field.dart';
import '../widgets/home/section_header.dart';
import '../widgets/horizontal_product_list_view.dart';
import '../widgets/loding_indicator.dart';
import 'email_verification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              SearchTextField(
                textEditingController: TextEditingController(),
              ),
              const SizedBox(height: 16),
              const BannerSlider(),
              const SizedBox(height: 16),
              _buildCategorySection(),
              const SizedBox(height: 16),
              _buildPopularSection(),
              const SizedBox(height: 16),
              _buildSpecialSection(),
              const SizedBox(height: 16),
              _buildNewSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      children: [
        SectionHeader(
            onTap: () {
              Get.find<BottomNavBarController>().selectCategory();
            },
            title: 'Categories'),
        SizedBox(
          height: 110,
          child: GetBuilder<CategoryListController>(
              builder: (categoryListController) {
            return Visibility(
                visible: !categoryListController.inProgress,
                replacement: const LoadingIndicator(),
                child: _buildCategoryListView(
                    categoryListController.categoryList));
          }),
        ),
      ],
    );
  }

  Widget _buildCategoryListView(List<CategoryModel> categoryList) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryCard(
            categoryModel: categoryList[index],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
              width: 10,
            ),
        itemCount: categoryList.length);
  }

  Widget _buildPopularSection() {
    return GetBuilder<PopularProductListController>(
        builder: (popularProductListController) {
      return Visibility(
        visible: !popularProductListController.inProgress,
        replacement: const LoadingIndicator(),
        child: Column(
          children: [
            SectionHeader(
                onTap: () {
                  Get.to(() => ProductListScreen(
                        categoryModel: popularProductListController
                            .productList[0].category!,
                      ));
                },
                title: 'Popular'),
            SizedBox(
              height: 180,
              child: _buildPopularListView(
                  popularProductListController.productList),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPopularListView(List<ProductModel> productList) {
    return HorizontaProductListView(
      productList: productList,
    );
  }

  Widget _buildSpecialSection() {
    return GetBuilder<SpecialProductListController>(
        builder: (specialProductController) {
      return Visibility(
        visible: !specialProductController.inProgress,
        replacement: const LoadingIndicator(),
        child: Column(
          children: [
            SectionHeader(
                onTap: () {
                  Get.to(() => ProductListScreen(
                        categoryModel:
                            specialProductController.productList[0].category!,
                      ));
                },
                title: 'Special'),
            SizedBox(
              height: 180,
              child:
                  _buildSpecialListView(specialProductController.productList),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSpecialListView(List<ProductModel> productList) {
    return HorizontaProductListView(
      productList: productList,
    );
  }

  Widget _buildNewSection() {
    return GetBuilder<NewProductListController>(
        builder: (newProductListController) {
      return Column(
        children: [
          SectionHeader(
              onTap: () {
                Get.to(() => ProductListScreen(
                      categoryModel:
                          newProductListController.productList[0].category!,
                    ));
              },
              title: 'New'),
          SizedBox(
            height: 180,
            child: Visibility(
              visible: !newProductListController.inProgress,
              replacement: const LoadingIndicator(),
              child: _buildNewListView(newProductListController.productList),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildNewListView(List<ProductModel> productList) {
    return HorizontaProductListView(
      productList: productList,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: SvgPicture.asset(
        AssetsPath.appNavLogo,
      ),
      actions: [
        AppIconLogoButton(
          onTap: () {
            bool isLoggedIn = Get.find<AuthController>().isLoggedInUser();
            if (isLoggedIn) {
              Get.to(() => const ProfileScreen());
            } else {
              Get.to(() => const EmailVerificationScreen());
            }
          },
          iconData: Icons.person,
        ),
        const SizedBox(
          width: 8,
        ),
        AppIconLogoButton(
          onTap: () {},
          iconData: Icons.phone,
        ),
        const SizedBox(
          width: 8,
        ),
        AppIconLogoButton(
          onTap: () {},
          iconData: Icons.notifications_active_outlined,
        ),
        const SizedBox(
          width: 8,
        )
      ],
    );
  }
}
