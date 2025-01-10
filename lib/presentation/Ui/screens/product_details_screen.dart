import 'package:crafty_boy_ecommerce_app/presentation/Ui/screens/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

import '../../../data/models/single_product_details_model.dart';
import '../../state_holders/add_to_cart_controller.dart';
import '../../state_holders/auth_controller.dart';
import '../../state_holders/create_wishlist_controller.dart';
import '../../state_holders/product_details_by_id_controller.dart';
import '../utils/app_colors.dart';
import '../utils/tost_message.dart';
import '../widgets/loding_indicator.dart';
import '../widgets/product_slider.dart';
import '../widgets/size_picker.dart';
import 'email_verification_screen.dart';
import 'cart_screen.dart'; // Add CartScreen import here

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _selectedColor = '';
  String _selectedSize = '';
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsByIdController>()
        .getProductDetailsById(id: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: GetBuilder<ProductDetailsByIdController>(builder: (productDetailsByIdController) {
        if (productDetailsByIdController.inProgress) {
          return const LoadingIndicator();
        }
        return Column(
          children: [
            Expanded(
                child: _buildProductDetails(
                    productDetailsByIdController.singleProductDetails!)),
            _buildPriceAndAddToCartSection(
                productDetailsByIdController.singleProductDetails!)
          ],
        );
      }),
    );
  }

  Widget _buildProductDetails(SingleProductDetailsModel productDetails) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductSlider(
            sliderImages: [
              productDetails.img1!,
              productDetails.img2!,
              productDetails.img3!,
              productDetails.img4!,
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _productNameSection(productDetails),
                const SizedBox(height: 4),
                _productReviewSection(productDetails),
                _colorPickerSection(productDetails),
                const SizedBox(height: 16),
                _sizePickerSection(productDetails),
                const SizedBox(height: 16),
                _productDescriptionSection(productDetails),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _productDescriptionSection(SingleProductDetailsModel productDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          productDetails.des!,
          style: const TextStyle(color: Colors.black45),
        ),
      ],
    );
  }

  Widget _sizePickerSection(SingleProductDetailsModel productDetails) {
    _selectedSize = productDetails.size!.split(',').first;
    return SizePicker(
      sizes: productDetails.size!.split(','),
      onSizeSelected: (String selectedSize) {
        _selectedSize = selectedSize;
      },
    );
  }

  Widget _colorPickerSection(SingleProductDetailsModel productDetails) {
    _selectedColor = productDetails.color!.split(',').first;
    return SizePicker(
      sizes: productDetails.color!.split(','),
      onSizeSelected: (String selectedColor) {
        _selectedColor = selectedColor;
      },
    );
  }

  Widget _productReviewSection(SingleProductDetailsModel productDetails) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber),
            Text(
              productDetails.product!.star.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {
            Get.to(() => ReviewScreen(
              productId: widget.productId,
            ));
          },
          child: const Text(
            'Reviews',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: AppColors.themeColor),
          ),
        ),
        const SizedBox(width: 8),
        Card(
          color: AppColors.themeColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GetBuilder<CreateWishlistController>(
                builder: (createWishListController) {
                  return InkWell(
                    onTap: () async {
                      bool isLoggedIn = Get.find<AuthController>().isLoggedInUser();
                      if (isLoggedIn) {
                        bool res = await Get.find<CreateWishlistController>()
                            .createWishListProduct(widget.productId);
                        if (res) {
                          toastMessage(context, 'Added to wishlist');
                        } else {
                          toastMessage(context, 'Failed to add into wishlist');
                        }
                      } else {
                        Get.to(() => const EmailVerificationScreen());
                      }
                    },
                    child: const Icon(
                      Icons.favorite_outline_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget _productNameSection(SingleProductDetailsModel productDetails) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            productDetails.product!.shortDes!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ItemCount(
          initialValue: _quantity,
          minValue: 1,
          maxValue: 20,
          decimalPlaces: 0,
          color: AppColors.themeColor,
          onChanged: (value) {
            _quantity = value.toInt();
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildPriceAndAddToCartSection(
      SingleProductDetailsModel productDetails) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price'),
              Text(
                '\$${productDetails.product!.price}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.themeColor),
              )
            ],
          ),
          SizedBox(
            width: 140,
            child:
            GetBuilder<AddToCartController>(builder: (addToCartController) {
              return Visibility(
                visible: !addToCartController.inProgress,
                replacement: const LoadingIndicator(),
                child: ElevatedButton(
                  onPressed: _onTapAddToCart,
                  child: const Text('Add To Cart'),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  void _onTapAddToCart() async {
    bool isLoggedIn = Get.find<AuthController>().isLoggedInUser();
    if (isLoggedIn) {
      final bool addToCartResult = await Get.find<AddToCartController>()
          .addToCart(
          productId: widget.productId,
          color: _selectedColor,
          size: _selectedSize,
          quantity: _quantity);

      if (addToCartResult) {
        toastMessage(
          context,
          'Added To Cart Successfully!',
          onTap: () {
            // Navigate to the Cart screen
            Get.to(() => const CartScreen());
          },
        );
      } else {
        toastMessage(
          context,
          Get.find<AddToCartController>().errorMessage!,
          isError: true,
        );
      }
    } else {
      Get.to(() => const EmailVerificationScreen());
    }
  }
}

void toastMessage(BuildContext context, String message, {bool isError = false, VoidCallback? onTap}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Expanded(child: Text(message)),
          if (onTap != null)
            TextButton(
              onPressed: onTap,
              child: const Text(
                'Go to Cart',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      backgroundColor: isError ? Colors.red : Colors.black45,
    ),
  );
}


