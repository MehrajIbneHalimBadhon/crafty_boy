
import 'package:crafty_boy_ecommerce_app/data/models/profile_model.dart';

class ProfileDetailsModel {
  String? msg;
  ProfileModel? profileData;

  ProfileDetailsModel({this.msg, this.profileData});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    profileData =
        json['data'] != null ? ProfileModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (profileData != null) {
      data['data'] = profileData!.toJson();
    }
    return data;
  }
}
