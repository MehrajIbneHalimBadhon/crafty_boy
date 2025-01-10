
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class AddToCartController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addToCart(
      {required int productId,
      required String color,
      required String size,
      required int quantity}) async {
    _inProgress = true;
    update();
    bool isSuccess = false;
    Map<String, dynamic> requestData = {
      "product_id": productId,
      "color": color,
      "size": size,
      "qty": quantity
    };
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.addToCartUrl, body: requestData);
    if (response.isSuccess && response.responseData['msg'] == 'success') {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
