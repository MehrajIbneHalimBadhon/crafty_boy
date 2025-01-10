
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/profile_details_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class ProfileDetailsController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late ProfileDetailsModel _profileData;
  ProfileDetailsModel get profileData => _profileData;

  Future<bool> getUserProfileDetails() async {
    _inProgress = true;
    update();
    bool isSuccess = false;

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.readUserProfileUrl);

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      _profileData = ProfileDetailsModel.fromJson(response.responseData);
    } else {
      _errorMessage = response.errorMessage!;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
