import 'package:crafty_boy_ecommerce_app/data/models/category_model.dart';
import 'package:crafty_boy_ecommerce_app/data/models/product_model.dart';

import 'brand_model.dart';

class ProductListModel {
  String? msg;
  List<ProductModel>? productList;

  ProductListModel({this.msg, this.productList});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productList = <ProductModel>[];
      json['data'].forEach((v) {
        productList!.add( ProductModel.fromJson(v));
      });
    }
  }


}





