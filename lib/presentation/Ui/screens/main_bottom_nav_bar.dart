import 'package:crafty_boy_ecommerce_app/presentation/Ui/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holders/bottom_nav_bar_controller.dart';
import '../../state_holders/category_list_controller.dart';
import '../../state_holders/new_product_list_controller.dart';
import '../../state_holders/popular_product_list_controller.dart';
import '../../state_holders/slider_list_controller.dart';
import '../../state_holders/special_product_list_controller.dart';
import 'cart_screen.dart';
import 'category_screen.dart';
import 'home_screen.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SliderListController>().getSliderList();
      Get.find<CategoryListController>().getCategoryList();
      Get.find<NewProductListController>().getNewProduct();
      Get.find<PopularProductListController>().getPopularProduct();
      Get.find<SpecialProductListController>().getSpecialProduct();
    });
  }

  final BottomNavBarController _navBarController =
      Get.find<BottomNavBarController>();
  final List<Widget> _screens =  [
    const HomeScreen(),
    const CaterogyListScreen(),
    const CartScreen(),
    const WishlistScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(builder: (_) {
      return Scaffold(
        body: _screens[_navBarController.selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _navBarController.selectedIndex,
          onDestinationSelected: _navBarController.changeIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
              icon: Icon(Icons.category_outlined),
              label: 'Category',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            NavigationDestination(
                icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          ],
        ),
      );
    });
  }
}
