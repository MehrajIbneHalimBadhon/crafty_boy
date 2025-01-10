
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/auth_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/category_list_by_id_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/create_profile_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/create_wishlist_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/logout_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/otp_verification_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/product_details_by_id_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/product_wishlist_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/profile_details_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/read_profile_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/remove_wishlist_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/review_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/review_post_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/slider_list_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/verify_email_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'data/services/network_caller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavBarController());
    Get.put(AuthController());
    Get.put(Logger());
    Get.put(NetworkCaller(
        logger: Get.find<Logger>(),
        authController: Get.find<AuthController>()));
    Get.put(SliderListController());
    Get.put(CategoryListController());
    Get.put(NewProductListController());
    Get.put(PopularProductListController());
    Get.put(SpecialProductListController());
    Get.put(CategoryListByIdController());
    Get.put(ProductDetailsByIdController());
    Get.put(AuthController());
    Get.put(VerifyEmailController());
    Get.put(OtpVerificationController());
    Get.put(ReadProfileController());
    Get.put(AddToCartController());
    Get.put(CartListController());
    Get.put(CreateProfileController());
    Get.put(ReviewController());
    Get.put(ReviewPostController());
    Get.put(ProfileDetailsController());
    Get.put(LogoutController());
    Get.put(ProductWishlistController());
    Get.put(RemoveWishlistController());
    Get.put(CreateWishlistController());
  }
}
