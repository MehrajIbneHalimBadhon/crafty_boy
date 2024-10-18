import 'package:crafty_boy_ecommerce_app/presentation/ui/utils/app_colors.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/product_image_slider.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

import '../widget/color_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildProductDetails(context),
          ),
          _buildPriceAndAddToCartSection()
        ],
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProductImageSlider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameAndQuantitySection(context),
                const SizedBox(
                  height: 4,
                ),
                _buildRatingAndReviewSection(),
                _buildColorAndSizePickerSection(),
                const SizedBox(
                  height: 16,
                ),
                _buildDescriptionSection(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorAndSizePickerSection() {
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
          sizes: const [
            'S',
            'M',
            'L',
            'XL',
            'XXL',
          ],
          sizeSelected: (String selectedSize) {},
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
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
        const Text(
          '''Item count number as a flutter package that allows you to easily implement a customable item count widget with increment and decrement buttons.Item count number as a flutter package that allows you to easily implement a customable item count widget with increment and decrement buttons.''',
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
      ],
    );
  }

  Widget _buildNameAndQuantitySection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Text(
          "Nike show 2024 latest model - New Year Special Deal 10% discount",
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

  Widget _buildRatingAndReviewSection() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(Icons.star, size: 16, color: Colors.amber),
            Text(
              '3',
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

  Widget _buildPriceAndAddToCartSection() {
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price'),
              Text(
                '\$100',
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
              onPressed: () {},
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
}
