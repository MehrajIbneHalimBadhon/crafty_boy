import 'package:get/get.dart';
import '../../data/models/cart_list_model.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class CartListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<CartModel> _cartList = [];
  List<CartModel> get cartList => _cartList;

  // Fetch the cart list from the server
  Future<bool> getCartList() async {
    _inProgress = true;
    update();
    bool isSuccess = false;
    final NetworkResponse response =
    await Get.find<NetworkCaller>().getRequest(url: Urls.cartListUrl);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _cartList = CartListModel.fromJson(response.responseData).cartList ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  // Update the quantity of a cart item
  void updateCartItemQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _cartList.length) {
      _cartList[index].qty = newQuantity.toString(); // Update the quantity
      update(); // Notify listeners about the change
    }
  }

  // Remove a cart item locally (from the list)
  void removeCartItem(String id) {
    _cartList.removeWhere((item) => item.id == id); // Remove item by id
    update(); // Notify listeners about the change
  }

  // Remove a cart product by making a network request
  Future<bool> removeCartProduct(int productId) async {
    _inProgress = true;
    update();
    bool isSuccess = false;

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.removeCartUrl(productId.toString())); // Pass productId as a string

    if (response.isSuccess && response.responseData['msg'] == 'success') {
      _errorMessage = null;
      isSuccess = true;
      // Remove the product from the local cart list after successful removal
      _cartList.removeWhere((item) => item.id == productId.toString());
    } else {
      _errorMessage = response.errorMessage ?? 'An error occurred';
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
