import 'package:crafty_boy_ecommerce_app/data/models/network_response.dart';
import 'package:crafty_boy_ecommerce_app/data/models/product_list_model.dart';
import 'package:crafty_boy_ecommerce_app/data/models/product_model.dart';
import 'package:crafty_boy_ecommerce_app/data/services/network_caller.dart';
import 'package:get/get.dart';

import '../../data/utils/urls.dart';

class PopularProductListController extends GetxController {
  bool _inProgress = false;

  List<ProductModel> _productList = [];

  String? _errorMessage;

  bool get inProgress => _inProgress;

  List<ProductModel> get productList => _productList;

  String? get errorMessage => _errorMessage;

  Future<bool> getPopularProductList() async {
    bool isSuccess = false;
    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productListByRemark('popular'),
    );

    if (response.isSuccess) {
      _productList =
          ProductListModel.fromJson(response.responseData).productList ?? [];
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
