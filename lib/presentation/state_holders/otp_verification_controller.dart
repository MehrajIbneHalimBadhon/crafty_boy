
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class OtpVerificationController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _accessToken = '';
  String get accessToken => _accessToken;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> verifyOTP({required String email, required String otp}) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.verifyOTP(email: email, otp: otp));

    if (response.isSuccess && response.responseData['msg'] == 'success') {
      _errorMessage = null;
      _accessToken = response.responseData['data'];
      AuthController.accessToken = _accessToken;
      await Get.find<AuthController>().saveAccessToken(_accessToken);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
