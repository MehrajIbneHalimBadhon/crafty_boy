
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

  void updateCartItemQuantity(int index, int newQuantity) {
    cartList[index].qty = newQuantity.toString();
    update();
  }
}