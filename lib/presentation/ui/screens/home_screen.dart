import 'package:crafty_boy_ecommerce_app/presentation/state_holders/bottom_nav_bar_controller.dart';
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
        onWillPop: () async{
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
        const SizedBox(
          height: 180,
          child: HorizontalProductListView(),
        )
      ],
    );
  }

  Widget _buildNewProductsSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'New',
          onTap: () {},
        ),
        const SizedBox(
          height: 180,
          child: HorizontalProductListView(),
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
        const SizedBox(
          height: 180,
          child: HorizontalProductListView(),
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
        const SizedBox(
          height: 120,
          child: HorizontalCatagoryListView(),
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
