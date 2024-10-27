

import 'package:crafty_boy_ecommerce_app/data/models/wishlist_model.dart';

class ProductWishListWrapperModel {
  String? msg;
  List<WishListModel>? listOfWishList;

  ProductWishListWrapperModel({this.msg, this.listOfWishList});

  ProductWishListWrapperModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      listOfWishList = <WishListModel>[];
      json['data'].forEach((v) {
        listOfWishList!.add(WishListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (listOfWishList != null) {
      data['data'] = listOfWishList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}