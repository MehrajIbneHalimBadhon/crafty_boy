
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/wishlist_model.dart';
import '../../state_holders/auth_controller.dart';
import '../../state_holders/bottom_nav_bar_controller.dart';
import '../../state_holders/product_wishlist_controller.dart';
import '../../state_holders/remove_wishlist_controller.dart';
import '../utils/app_colors.dart';
import '../utils/tost_message.dart';
import '../widgets/loding_indicator.dart';
import 'email_verification_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final ProductWishlistController wishlistController =
      Get.find<ProductWishlistController>();
  Future<void> _getWishListData() async {
    bool isLoggedIn = Get.find<AuthController>().isLoggedInUser();
    if (isLoggedIn) {
      await wishlistController.getWishList();
    } else {
      Get.offAll(() => const EmailVerificationScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    _getWishListData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.find<BottomNavBarController>().backToHome();
          return false; // Prevent the default back action
        },
        child: Scaffold(
          body: GetBuilder<ProductWishlistController>(
              builder: (prodcutWishListController) {
            if (prodcutWishListController.inProgress) {
              return const LoadingIndicator();
            }
            if (prodcutWishListController.wishList.isEmpty) {
              return const Center(
                child: Text('No data for now!\nAdd some item to wishlist'),
              );
            }
            return ListView.builder(
                itemCount: prodcutWishListController.wishList.length,
                itemBuilder: (context, index) {
                  return _buildWishListCardSection(
                      prodcutWishListController.wishList[index]);
                });
          }),
        ));
  }

  Widget _buildWishListCardSection(WishListModel wishListData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: Image.network(
            "${wishListData.product!.image}",
          ),
          title: Text(wishListData.product!.title ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${wishListData.product!.shortDes}'),
              Text('Price : \$${wishListData.product!.price}')
            ],
          ),
          trailing: IconButton(onPressed: () {
            _removeWishList(wishListData.productId!);
          }, icon: GetBuilder<RemoveWishlistController>(
              builder: (removeWishListController) {
            return Visibility(
              visible: !removeWishListController.inProgress,
              replacement: const LoadingIndicator(),
              child: const Icon(
                Icons.delete,
                color: AppColors.themeColor,
              ),
            );
          })),
        ),
      ),
    );
  }

  Future<void> _removeWishList(int id) async {
    bool res =
        await Get.find<RemoveWishlistController>().removeWishListProduct(id);
    if (res) {
      toastMessage(context, 'Removed from wishlist');
      await _getWishListData();
    } else {
      toastMessage(
          context, Get.find<RemoveWishlistController>().errorMessage!, true);
    }
  }
}
