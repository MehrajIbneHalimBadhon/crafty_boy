import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import '../../../data/models/cart_model.dart';
import '../utils/app_colors.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.cartModel,
    required this.onQuantityChanged,
    required this.onDelete, // New callback for delete action
    required this.isSelected, // Track selection state
    required this.onSelected, // Callback for selection change
  });

  final CartModel cartModel;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onDelete; // Callback for delete action
  final bool isSelected; // Track if the item is selected
  final ValueChanged<bool> onSelected; // Callback for selection change

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late int _quantity;
  late int _totalSingleProductPrice;

  @override
  void initState() {
    super.initState();
    _quantity = int.tryParse(widget.cartModel.qty ?? '1') ?? 1; // Ensure quantity is valid
    _totalSingleProductPrice = int.tryParse(widget.cartModel.price ?? '0') ?? 0 * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _buildProductImage(),
          _buildProductInfo(context),
        ],
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded( // Use Expanded to prevent overflow
                child: _productTitleSizeandColor(),
              ),
              Row(
                children: [
                  _productDeleteIcon(),
                  Checkbox(
                    value: widget.isSelected,
                    onChanged: (value) {
                      widget.onSelected(value!);
                    },
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$$_totalSingleProductPrice',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.themeColor),
                overflow: TextOverflow.ellipsis, // Handle overflow
                maxLines: 1, // Limit to one line
              ),
              ItemCount(
                initialValue: _quantity,
                minValue: 1,
                maxValue: 20,
                decimalPlaces: 0,
                color: AppColors.themeColor,
                onChanged: (value) {
                  if (value != _quantity) { // Prevent unnecessary rebuilds
                    setState(() {
                      _quantity = value.toInt();
                      _totalSingleProductPrice = int.tryParse(widget.cartModel.price ?? '0') ?? 0 * _quantity;
                    });
                    widget.onQuantityChanged(_quantity);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _productTitleSizeandColor() {
    if (widget.cartModel.product == null) {
      return const Text('Product information is not available');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.cartModel.product?.title ?? "No Title Available",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Wrap(
          children: [
            Text(
              'Color : ${widget.cartModel.color ?? "No Color"}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(width: 8),
            Text(
              'Size : ${widget.cartModel.size ?? "No Size"}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _productDeleteIcon() {
    return IconButton(
      onPressed: () {
        print('Delete button pressed'); // Debugging line
        widget.onDelete(); // Call the delete callback
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Image.network(
        widget.cartModel.product?.image ?? 'https://example.com/default-image.jpg', // Fallback image URL
        height: 100,
        width: 80,
        fit: BoxFit.scaleDown,
        errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/default_image.png'), // Fallback image
      ),
    );
  }
}
