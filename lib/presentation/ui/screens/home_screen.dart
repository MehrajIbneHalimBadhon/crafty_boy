import 'package:crafty_boy_ecommerce_app/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../utils/assets_path.dart';
import '../widget/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                SearchTextField(
                  textEditingController: _searchController,
                ),
                const SizedBox(
                  height: 16,
                ),
                const HomeBannerSlider(),
                const SizedBox(
                  height: 16,
                ),
                _buildCatagoriesSection(),
                _buildPopularProductsSection(),
                const SizedBox(
                  height: 16,
                ),
                _buildNewProductsSection(),
                const SizedBox(
                  height: 16,
                ),
                _buildSpecialProductsSection(),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopularProductsSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Popular',
          onTap: () {},
        ),
        SizedBox(
          height: 180,
          child: GetBuilder<PopularProductListController>(
              builder: (popularProductListController) {
            return Visibility(
              visible: !popularProductListController.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: HorizontalProductListView(
                productList: popularProductListController.productList,
              ),
            );
          }),
        )
      ],
    );
  }

  Widget _buildNewProductsSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'New',
          onTap: () {
            Get.find<NewProductListController>().productList;
          },
        ),
        SizedBox(
          height: 180,
          child: GetBuilder<NewProductListController>(
              builder: (newProductListController) {
            return Visibility(
              visible: !newProductListController.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: HorizontalProductListView(
                productList: newProductListController.productList,
              ),
            );
          }),
        )
      ],
    );
  }

  Widget _buildSpecialProductsSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Special',
          onTap: () {},
        ),
        SizedBox(
          height: 180,
          child: GetBuilder<SpecialProductListController>(
              builder: (specialProductListController) {
            return Visibility(
              visible: !specialProductListController.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: HorizontalProductListView(
                productList: specialProductListController.productList,
              ),
            );
          }),
        )
      ],
    );
  }

  Widget _buildCatagoriesSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Catagories',
          onTap: () {
            Get.find<BottomNavBarController>().selectCategory();
          },
        ),
        SizedBox(
          height: 120,
          child: GetBuilder<CategoryListController>(
              builder: (categoryListController) {
            return Visibility(
              visible: !categoryListController.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: HorizontalCatagoryListView(
                categoryList: categoryListController.categoryList,
              ),
            );
          }),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: SvgPicture.asset(AssetsPath.appLogoNav),
      actions: [
        AppbarIconButton(
          iconData: Icons.person_outline,
          onTap: () {},
        ),
        const SizedBox(
          width: 8,
        ),
        AppbarIconButton(
          iconData: Icons.call_outlined,
          onTap: () {},
        ),
        const SizedBox(
          width: 8,
        ),
        AppbarIconButton(
          iconData: Icons.notifications_active_outlined,
          onTap: () {},
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}
