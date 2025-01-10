
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class ReadProfileController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  bool _isProfileCompleted = false;
  bool get isProfileCompleted => _isProfileCompleted;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getProfileDetails(String token) async {
    _inProgress = true;
    update();
    bool isSuccess = false;
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.readUserProfileUrl, token: token);
    if (response.isSuccess) {
      if (response.responseData['data'] != null) {
        _isProfileCompleted = true;
        Get.find<AuthController>().saveAccessToken(token);
      }
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
