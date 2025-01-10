
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/single_product_details_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class ProductDetailsByIdController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  SingleProductDetailsModel? _singleProductDetails;
  SingleProductDetailsModel? get singleProductDetails => _singleProductDetails;

  Future<bool> getProductDetailsById({required int id}) async {
    _inProgress = true;
    update();
    bool isSuccess = false;
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.productDetailsById(productId: id));
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _singleProductDetails =
          SingleProductDetailsModel.fromJson(response.responseData['data'][0]);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
