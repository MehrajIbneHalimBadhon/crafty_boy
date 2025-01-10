
import 'package:crafty_boy_ecommerce_app/data/models/slider_model.dart';

class SliderListModel {
  String? _msg;
  List<SliderModel>? _sliderList;

  SliderListModel({String? msg, List<SliderModel>? data}) {
    if (msg != null) {
      _msg = msg;
    }
    if (data != null) {
      _sliderList = data;
    }
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  List<SliderModel>? get sliderList => _sliderList;
  set sliderList(List<SliderModel>? data) => _sliderList = data;

  SliderListModel.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    if (json['data'] != null) {
      _sliderList = <SliderModel>[];
      json['data'].forEach((v) {
        _sliderList!.add(SliderModel.fromJson(v));
      });
    }
  }
}
