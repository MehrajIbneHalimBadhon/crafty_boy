
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/review_list_model.dart';
import '../../data/models/review_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class ReviewController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ReviewModel> _reviewList = [];
  List<ReviewModel> get reviewList => _reviewList;

  Future<bool> getProductReview(int productId) async {
    _inProgress = true;
    update();
    bool isSuccess = false;
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.getReviewList(productId: productId));
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _reviewList =
          ReviewListModel.fromJson(response.responseData).reviewList ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}