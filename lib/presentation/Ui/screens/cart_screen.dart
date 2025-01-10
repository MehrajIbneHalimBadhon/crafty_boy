import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/cart_model.dart';
import '../../state_holders/auth_controller.dart';
import '../../state_holders/bottom_nav_bar_controller.dart';
import '../../state_holders/cart_list_controller.dart';
import '../utils/app_colors.dart';
import '../utils/tost_message.dart';
import '../widgets/loding_indicator.dart';
import '../widgets/product_card.dart';
import 'email_verification_screen.dart';
import 'payment_screen.dart'; // Ensure you import your PaymentScreen

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartListController _cartListController = Get.find<CartListController>();
  late int _totalPrice;
  late List<bool> _selectedItems; // Track selected items

  @override
  void initState() {
    super.initState();
    _selectedItems = []; // Initialize selection state
    _getCartData();
  }

  Future<void> _getCartData() async {
    bool isLoggedIn = Get.find<AuthController>().isLoggedInUser();
    if (isLoggedIn) {
      await _cartListController.getCartList();
      setState(() {
        _selectedItems = List<bool>.filled(_cartListController.cartList.length, false); // Initialize selection state
        _calculateTotalPrice(); // Calculate total price after fetching cart
      });
    } else {
      Get.offAll(() => const EmailVerificationScreen());
    }
  }

  void _calculateTotalPrice() {
    _totalPrice = 0;
    for (var i = 0; i < _cartListController.cartList.length; i++) {
      if (_selectedItems[i]) { // Only add price if selected
        _totalPrice += int.parse(_cartListController.cartList[i].price!) * int.parse(_cartListController.cartList[i].qty!);
      }
    }
    setState(() {}); // Trigger a rebuild to update the UI
  }

  void _removeItem(int index) {
    int itemId = _cartListController.cartList[index].id!; // Ensure it's non-null

    _cartListController.removeCartProduct(itemId).then((isSuccess) {
      if (isSuccess) {
        toastMessage(context, 'Removed from cart');

        // Remove the item from the list locally
        setState(() {
          _cartListController.cartList.removeAt(index); // Remove item from the local list
          _selectedItems.removeAt(index); // Remove item selection state
          _calculateTotalPrice(); // Recalculate total price after removal
        });
      } else {
        toastMessage(context, 'Failed to remove item from cart');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<BottomNavBarController>().backToHome();
        return false; // Prevent default back action
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text('Cart'),
          leading: IconButton(
            onPressed: () {
              Get.find<BottomNavBarController>().backToHome();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: GetBuilder<CartListController>(
          init: _cartListController,
          builder: (cartListController) {
            if (cartListController.inProgress) {
              return const LoadingIndicator();
            }
            if (cartListController.cartList.isEmpty) {
              return const Center(child: Text('Nothing on the List'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartListController.cartList.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        cartModel: cartListController.cartList[index],
                        onQuantityChanged: (newQuantity) {
                          _cartListController.updateCartItemQuantity(index, newQuantity);
                          _calculateTotalPrice(); // Recalculate total price when quantity changes
                        },
                        onDelete: () => _removeItem(index), // Pass the delete function
                        isSelected: _selectedItems[index], // Pass selection state
                        onSelected: (isSelected) {
                          setState(() {
                            _selectedItems[index] = isSelected; // Update selection state
                            _calculateTotalPrice(); // Recalculate total price on selection change
                          });
                        },
                      );
                    },
                  ),
                ),
                _buildPriceAndAddToCartSection(_totalPrice, cartListController.cartList),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPriceAndAddToCartSection(int totalPrice, List<CartModel> cartItems) {
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
              const Text('Total Price'),
              Text(
                '\$$totalPrice',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () {
                // Prepare product quantities for checkout
                List<int> productQuantities = [];
                for (int i = 0; i < cartItems.length; i++) {
                  if (_selectedItems[i]) { // Only include selected items
                    productQuantities.add(int.parse(cartItems[i].qty!));
                  }
                }
                Get.to(() => PaymentScreen(
                  totalPrice: totalPrice,
                  productQuantities: productQuantities,
                  deliveryCharge: 150.0, // Example delivery charge
                ));
              },
              child: const Text('CHECKOUT'),
            ),
          ),
        ],
      ),
    );
  }
}
