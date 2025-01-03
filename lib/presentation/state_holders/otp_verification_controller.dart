import 'package:crafty_boy_ecommerce_app/data/models/network_response.dart';
import 'package:crafty_boy_ecommerce_app/data/services/network_caller.dart';
import 'package:crafty_boy_ecommerce_app/data/utils/urls.dart';
import 'package:get/get.dart';

class OTPVerificationController extends GetxController {
  bool _inProgress = false;
  String _accessToken = "";

  String get accessToken => _accessToken;

  bool get inProgress => _inProgress;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> verifyOTP(String email, String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.verifyOTP(email, otp));

    if (response.isSuccess && response.responseData['msg'] == 'success') {
      _errorMessage = null;
      _accessToken = response.responseData['data'];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
