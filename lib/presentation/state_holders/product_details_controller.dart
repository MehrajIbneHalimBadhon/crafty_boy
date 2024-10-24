import 'package:crafty_boy_ecommerce_app/data/models/network_response.dart';
import 'package:crafty_boy_ecommerce_app/data/services/network_caller.dart';
import 'package:get/get.dart';

import '../../data/models/product_details_model.dart';
import '../../data/utils/urls.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;

  ProductDetailsModel? _productModel;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  ProductDetailsModel? get product => _productModel;

  String? get errorMessage => _errorMessage;

  Future<bool> getProductDetails(int productId) async {
    bool isSuccess = false;
    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productDetailsById(productId),
    );

    if (response.isSuccess) {
      _productModel = ProductDetailsModel.fromJson(response.responseData['data'][0]);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
