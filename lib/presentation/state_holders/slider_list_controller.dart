
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/slider_list_model.dart';
import '../../data/models/slider_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class SliderListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<SliderModel> _sliderList = [];
  List<SliderModel> get sliderList => _sliderList;

  Future<bool> getSliderList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(url: Urls.homeSliderListUrl);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _sliderList =
          SliderListModel.fromJson(response.responseData).sliderList ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
