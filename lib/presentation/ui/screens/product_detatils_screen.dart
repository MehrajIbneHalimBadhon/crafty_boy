import 'package:crafty_boy_ecommerce_app/presentation/state_holders/auth_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/screens/email_verification_screen.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/utils/app_colors.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/centered_circular_progress_indicator.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/product_image_slider.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

import '../../../data/models/product_details_model.dart';
import '../widget/color_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsCorntroller) {
        if (productDetailsCorntroller.inProgress) {
          return const CenteredCircularProgressIndicator();
        }
        if (productDetailsCorntroller.errorMessage != null) {
          return Center(
            child: Text(productDetailsCorntroller.errorMessage!),
          );
        }
        return Column(
          children: [
            Expanded(
              child: _buildProductDetails(productDetailsCorntroller.product!),
            ),
            _buildPriceAndAddToCartSection(productDetailsCorntroller.product!)
          ],
        );
      }),
    );
  }

  Widget _buildProductDetails(ProductDetailsModel product) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImageSlider(
            sliderUrls: [
              product.img1!,
              product.img2!,
              product.img3!,
              product.img4!
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameAndQuantitySection(product),
                const SizedBox(
                  height: 4,
                ),
                _buildRatingAndReviewSection(product),
                _buildColorAndSizePickerSection(product),
                const SizedBox(
                  height: 16,
                ),
                _buildDescriptionSection(product)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorAndSizePickerSection(ProductDetailsModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        ColorPicker(colors: const [
          Colors.red,
          Colors.blue,
          Colors.green,
          Colors.yellow,
        ], colorSelected: (color) {}),
        const SizedBox(
          height: 16,
        ),
        SizePicker(
          sizes: product.size!.split(','),
          sizeSelected: (String selectedSize) {},
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(ProductDetailsModel productDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          productDetails.product?.shortDes ?? '',
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
      ],
    );
  }

  Widget _buildNameAndQuantitySection(ProductDetailsModel productDetails) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Text(
          productDetails.product?.title ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        )),
        ItemCount(
          initialValue: 1,
          minValue: 1,
          maxValue: 20,
          decimalPlaces: 0,
          color: AppColors.themeColor,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildRatingAndReviewSection(ProductDetailsModel productDetails) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(Icons.star, size: 16, color: Colors.amber),
            Text(
              '${productDetails.product?.star ?? ''}',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Reviews',
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: AppColors.themeColor)),
        ),
        const SizedBox(
          width: 8,
        ),
        Card(
          color: AppColors.themeColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.favorite_outline,
              color: Colors.white,
              size: 16,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPriceAndAddToCartSection(ProductDetailsModel productDetails) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price'),
              Text(
                '\$${productDetails.product?.price ?? ''}',
                style: TextStyle(
                    color: AppColors.themeColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: _onTapAddToCart,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Add to Cart'),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _onTapAddToCart() async{
    bool isLoggedInUser = await Get.find<AuthController>().isLoggedInUser();
    if(isLoggedInUser){

    }
    else{
      Get.to(()=> EmailVerificationScreen());
    }
  }
}
