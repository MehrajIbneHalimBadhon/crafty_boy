
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/product_list_model.dart';
import '../../data/models/product_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class PopularProductListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;

  Future<bool> getPopularProduct() async {
    _inProgress = true;
    update();
    bool isSuccess = false;
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.productListByRemark(remark: 'popular'));
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _productList =
          ProductListModel.fromJson(response.responseData).productList ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
